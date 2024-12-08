from InquirerPy import inquirer
from InquirerPy.validator import EmptyInputValidator
from app.funcionalidades import (
    criar_aluno,
    criar_atletica,
    listar_estatisticas,
    criar_usuario,
    feed_personalizado,
    listar_eventos_atletica,
    inscrever_usuario_evento,
    listar_participacoes_comuns
)
from pydantic import ValidationError
from asyncio import run
from colorama import Fore, Style
from printers import (
    exibir_feed, 
    exibir_eventos, 
    exibir_estatisticas, 
    exibir_participacoes_comuns
)
from app.schemas import Aluno, Atletica, Usuario
from app.database import ConexaoErro


def main():
    while True:
        # Definir as opções do menu
        options = [
            "Cadastrar Novo Usuário ➕", # Simples
            "Obter Feed Personalizado 📰", # Mediana
            "Inscrever-se em um evento 🗓️", # Mediana - Listar Eventos de Uma Atlética
            "Listar Estatísticas de Engajamento 📊", # Difícil
            "Listar Usuario com Participacoes Comuns 🌐", # Difícil com divisão relacional
            "Sair"
        ]

        # Criar o prompt de seleção
        result = inquirer.select(
            message="Selecione uma opção:",
            choices=options,
            default=None,
            instruction="Use as setas do teclado para navegar e pressione Enter para selecionar.",
        ).execute()

        if result == "Sair":
            print("Encerrando a aplicação...")
            break
        elif result == "Cadastrar Novo Usuário ➕":
            print("\n--- Cadastro de Novo Usuário ---\n")
            try:
                # Perguntar o tipo de usuário
                tipo = inquirer.select(
                    message="Selecione o tipo de usuário:",
                    choices=["aluno", "atletica"],
                    default="aluno",
                    instruction="Use as setas do teclado para navegar e pressione Enter para selecionar.",
                ).execute()

                # Coletar dados comuns do usuário
                username = inquirer.text(
                    message="Digite o username:",
                    validate=EmptyInputValidator(),
                ).execute()
                
                nome = inquirer.text(
                    message="Digite seu nome:",
                    validate=EmptyInputValidator(),
                ).execute()
                
                email = inquirer.text(
                    message="Digite seu email:",
                    validate=EmptyInputValidator(),
                ).execute()
                
                telefone = inquirer.text(
                    message="Digite seu telefone (formato: (XX) XXXXX-XXXX):",
                    validate=EmptyInputValidator(),
                ).execute()

                # Criar instância da atlética
                usuario = Usuario(
                    username=username,
                    nome=nome,
                    email=email,
                    telefone=telefone,
                    tipo=tipo,
                    num_seguidores=0,  # Padrão
                    num_seguindo=0      # Padrão
                )

                # Criar usuário
                resposta = run(criar_usuario(usuario))

                # Coletar dados específicos com base no tipo de usuário
                if tipo == "aluno":
                    nusp = inquirer.text(
                        message="Digite o nusp:",
                        validate=EmptyInputValidator(),
                    ).execute()
                    
                    # Criar instância do aluno
                    aluno = Aluno(
                        username=username,
                        nusp=nusp
                    )

                    # Insere o aluno no banco de dados
                    resposta = run(criar_aluno(aluno))
                
                elif tipo == "atletica":
                    nome_atletica = inquirer.text(
                        message="Digite o nome da atlética:",
                        validate=EmptyInputValidator(),
                    ).execute()
                    
                    cnpj = inquirer.text(
                        message="Digite o CNPJ:",
                        validate=EmptyInputValidator(),
                    ).execute()
                    
                    razao_social = inquirer.text(
                        message="Digite a razão social:",
                        validate=EmptyInputValidator(),
                    ).execute()
                    
                    nome_fantasia = inquirer.text(
                        message="Digite o nome social:",
                        validate=EmptyInputValidator(),
                    ).execute()

                    # Criar instância da atlética
                    atletica = Atletica(
                        username=username,
                        atletica=nome_atletica,
                        cnpj=cnpj,
                        razao_social=razao_social,
                        nome_fantasia=nome_fantasia
                    )

                    # Insere a atlética no banco de dados
                    resposta = run(criar_atletica(atletica))

                print(Fore.GREEN + f"\n{resposta['message']}\n")

            except ValidationError as ve:
                # Erros de validação do Pydantic
                print("\nErro de validação:")
                for erro in ve.errors():
                    print(f"{erro['loc'][0]}: {erro['msg']}\n")
            except ValueError as ve:
                # Erros de negócios, como username ou email duplicados
                print(Fore.RED + str(ve) + Style.RESET_ALL)
            except Exception as e:
                # Erros gerais
                print(Fore.RED + f"\nOcorreu um erro ao criar o usuário: {e}" + Style.RESET_ALL)
        # -----------------------------------------------------------------------------------------
        elif result == "Obter Feed Personalizado 📰":
            # Obter Feed Personalizado
            print("\nVocê selecionou a Obter Feed Personalizado.\n")

            # Coletar dados do usuário
            username = inquirer.text(
                message="Digite o username:",
                validate=EmptyInputValidator(),
            ).execute()

            resposta = run(feed_personalizado(username))
            exibir_feed(resposta)
        # -----------------------------------------------------------------------------------------
        elif result == "Inscrever-se em um evento 🗓️":
            print("\nInscrever-se em um evento 🗓️\n")
            try:
                # Implemente a funcionalidade 3 aqui
                atletica = inquirer.text(
                    message="Digite o nome da Atlética:",
                    validate=EmptyInputValidator(),
                ).execute()

                # Obter eventos da atlética
                eventos = run(listar_eventos_atletica(atletica))
                print(Fore.BLUE + f"{atletica} tem {eventos['data']['total_membros']} membros.")
                exibir_eventos(eventos)

                # Criar uma lista de opções para o usuário escolher
                opcoes_eventos = [f"{evento['nome']} ({evento['data']})" for evento in eventos['data']['eventos']]
                opcoes_eventos.append("Voltar ao Menu Principal")
                
                # Criar o prompt de seleção
                escolha = inquirer.select(
                    message="Selecione um evento para se inscrever ou volte ao menu principal:",
                    choices=opcoes_eventos,
                    default=None,
                    instruction="Use as setas do teclado para navegar e pressione Enter para selecionar.",
                ).execute()
                
                if escolha == "Voltar ao Menu Principal":
                    continue
                else:
                    username = inquirer.text(
                        message="Digite seu username:",
                        validate=EmptyInputValidator()
                    ).execute()
                    nome_evento, data_evento = escolha.rsplit(" (", 1)
                    data_evento = data_evento.rstrip(")")
                    resposta = run(inscrever_usuario_evento(nome_evento, data_evento, username))
                    if resposta["status"] == "success":
                        print(Fore.GREEN + f"\n{resposta['message']}\n")
                    else:
                        print(Fore.RED + f"\nErro: {resposta['message']}\n")
            except ConexaoErro as ce:
                print(Fore.RED + f"Erro de conexão: {ce}")
            except Exception as e:
                print(Fore.RED + f"Erro ao processar a inscrição: {e}")
            except ValueError as e:
                print(Fore.RED + e)
        # -----------------------------------------------------------------------------------------
        elif result == "Listar Estatísticas de Engajamento 📊":
            print("\nVocê selecionou Listar Estatísticas de Engajamento 📊\n")
            exibir_estatisticas(run(listar_estatisticas()))
        # -----------------------------------------------------------------------------------------
        elif result == "Listar Usuario com Participacoes Comuns 🌐":
            print("\nVocê selecionou Listar Usuario com Participacoes Comuns 🌐\n")
            # Coletar dados do usuário
            username = inquirer.text(
                message="Digite o username:",
                validate=EmptyInputValidator(),
            ).execute()

            resposta = run(listar_participacoes_comuns(username))
            exibir_participacoes_comuns(resposta)
        # -----------------------------------------------------------------------------------------
            

if __name__ == "__main__":
    main()