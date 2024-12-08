from colorama import init, Fore, Style
from InquirerPy import inquirer

def exibir_feed(feed_data):
    if feed_data["status"] == "success":
        posts = feed_data["data"]
        if not posts:
            print(Fore.YELLOW + "Nenhum post encontrado.")
            return
        
        print(Fore.GREEN + "Feed Personalizado:")
        for post in posts:
            print(Fore.CYAN + f"\nUsername: {post['username']}")
            print(Fore.CYAN + f"Data/Hora: {post['data_hora']}")
            print(Fore.CYAN + f"Descrição: {post['descricao']}")
            print(Fore.CYAN + f"Anexo: {post['anexo'] if post['anexo'] else 'Nenhum'}")
            print(Fore.CYAN + "-" * 50)
    else:
        print(Fore.RED + "Erro ao obter o feed personalizado.")

def exibir_eventos(eventos_data):
    if eventos_data["status"] == "success":
        eventos = eventos_data["data"]
        if not eventos:
            print(Fore.YELLOW + "Nenhum evento encontrado.")
            return
        
        print(Fore.GREEN + "Eventos da Atlética:")
        for evento in eventos:
            print(Fore.CYAN + f"\nNome: {evento['nome']}")
            print(Fore.CYAN + f"Data: {evento['data']}")
            print(Fore.CYAN + f"Data de Início: {evento['data_inicio']}")
            print(Fore.CYAN + f"Data de Fim: {evento['data_fim']}")
            print(Fore.CYAN + f"Descrição: {evento['descricao']}")
            print(Fore.CYAN + f"Arquivo: {evento['arquivo']}")
            print(Fore.CYAN + f"Ativo: {'Sim' if evento['ativo'] else 'Não'}")
            print(Fore.CYAN + "-" * 50)
        
    else:
        print(Fore.RED + "Erro ao listar eventos da atlética.")

def exibir_estatisticas(estatisticas_data):
    if estatisticas_data["status"] == "success":
        estatisticas = estatisticas_data["data"]
        if not estatisticas:
            print(Fore.YELLOW + "Nenhuma estatística encontrada.")
            return
        
        print(Fore.GREEN + "Estatísticas de Engajamento:")
        for estatistica in estatisticas:
            print(Fore.CYAN + f"\nUsername: {estatistica['username']}")
            print(Fore.CYAN + f"Nome: {estatistica['nome']}")
            print(Fore.CYAN + f"Tipo: {estatistica['tipo']}")
            print(Fore.CYAN + f"Total de Interações: {estatistica['total_interacoes']}")
            print(Fore.CYAN + f"Curtidas: {estatistica['curtidas']}")
            print(Fore.CYAN + f"Compartilhamentos: {estatistica['compartilhamentos']}")
            print(Fore.CYAN + f"Comentários: {estatistica['comentarios']}")
            print(Fore.CYAN + f"Total de Comentários: {estatistica['total_comentarios']}")
            print(Fore.CYAN + "-" * 50)
    else:
        print(Fore.RED + "Erro ao listar estatísticas de engajamento.")

def exibir_participacoes_comuns(participacoes_data):
    if participacoes_data["status"] == "success":
        participacoes = participacoes_data["data"]
        if not participacoes:
            print(Fore.YELLOW + "Nenhuma participação comum encontrada.")
            return
        
        print(Fore.GREEN + "Participações Comuns:")
        for participacao in participacoes:
            print(Fore.CYAN + f"\nUsername: {participacao['username']}")
            print(Fore.CYAN + f"Nome: {participacao['nome']}")
            print(Fore.CYAN + "-" * 50)
    else:
        print(Fore.RED + "Erro ao listar participações comuns.")