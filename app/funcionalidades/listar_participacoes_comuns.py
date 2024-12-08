from typing import Dict
from app.database import get_connection, ConexaoErro
from asyncio import run
from colorama import init, Fore

# Inicializa o colorama
init(autoreset=True)

async def listar_participacoes_comuns(username: str) -> Dict:
    """
    Lista usuários que têm participações comuns em eventos com o usuário fornecido.
    
    Args:
      username (str): Username do usuário
    
    Returns:
      Dict: Resposta com status e lista de usuários com participações comuns
    """
    try:
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute('''
                    SELECT u.username, u.nome
                    FROM Usuario u
                    WHERE NOT EXISTS (
                      SELECT 1
                      FROM Participacao p1
                      WHERE p1.username = %s
                      AND NOT EXISTS (
                        SELECT 1
                        FROM Participacao p2
                        WHERE p2.username = u.username
                        AND p2.nome_evento = p1.nome_evento
                        AND p2.data_evento = p1.data_evento
                      )
                    );
                ''', (username,))
                
                participacoes_comuns = cursor.fetchall()
                
                # Formatar os resultados
                participacoes_formatadas = []
                for participacao in participacoes_comuns:
                    participacoes_formatadas.append({
                        "username": participacao[0],
                        "nome": participacao[1]
                    })
                
                return {
                    "status": "success",
                    "data": participacoes_formatadas
                }

    except ConexaoErro as ce:
        print(Fore.RED + f"Erro de conexão: {ce}")
        raise ce
    except Exception as e:
        print(Fore.RED + f"Erro ao listar participações comuns: {e}")
        raise e

if __name__ == "__main__":
    # Exemplo de uso
    username = "user1"
    resultado = run(listar_participacoes_comuns(username))
    print(resultado)