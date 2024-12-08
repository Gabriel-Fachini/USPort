from InquirerPy import inquirer
from InquirerPy.validator import EmptyInputValidator
from schemas import Usuario
from controllers import criar_usuario
from pydantic import ValidationError

def main():
    while True:
        # Definir as opções do menu
        options = [
            "Cadastrar Novo Usuário",
            "Funcionalidade 2",
            "Funcionalidade 3",
            "Funcionalidade 4",
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
        elif result == "Cadastrar Novo Usuário":
            print("\n--- Cadastro de Novo Usuário ---\n")
            try:
                # Coletar dados do usuário
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
                
                tipo = inquirer.select(
                    message="Selecione o tipo de usuário:",
                    choices=["aluno", "atletica"],
                    default="aluno",
                    instruction="Use as setas do teclado para navegar e pressione Enter para selecionar.",
                ).execute()

                # Criar instância do usuário com validação
                usuario = Usuario(
                    username=username,
                    nome=nome,
                    email=email,
                    telefone=telefone,
                    tipo=tipo,
                    num_seguidores=0,  # Padrão
                    num_seguindo=0      # Padrão
                )

                # Chamar a função para criar usuário no banco de dados
                resposta = criar_usuario(usuario)
                print(f"\n{resposta['mensagem']}\n")

            except ValidationError as ve:
                # Erros de validação do Pydantic
                print("\nErro de validação:")
                for erro in ve.errors():
                    print(f"{erro['loc'][0]}: {erro['msg']}")
            except ValueError as ve:
                # Erros de negócios, como username ou email duplicados
                print(f"\nErro: {ve}")
            except Exception as e:
                # Erros gerais
                print(f"\nOcorreu um erro ao criar o usuário: {e}")
        elif result == "Funcionalidade 2":
            print("\nVocê selecionou a Funcionalidade 2.\n")
            # Implemente a funcionalidade 2 aqui
        elif result == "Funcionalidade 3":
            print("\nVocê selecionou a Funcionalidade 3.\n")
            # Implemente a funcionalidade 3 aqui
        elif result == "Funcionalidade 4":
            print("\nVocê selecionou a Funcionalidade 4.\n")
            # Implemente a funcionalidade 4 aqui

if __name__ == "__main__":
    main()