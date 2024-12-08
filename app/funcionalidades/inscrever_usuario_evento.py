from multiprocessing import Value
from typing import Dict
from app.database import get_connection, ConexaoErro
from asyncio import run
from colorama import init, Fore, Style
from datetime import date

# Inicializa o colorama
init(autoreset=True)

async def inscrever_usuario_evento(nome_evento: str, data_evento: str, username: str) -> Dict:
    """
    Inscreve um usuário em um evento.
    
    Args:
      nome_evento (str): Nome do evento
      username (str): Username do usuário
    
    Returns:
      Dict: Resposta com status e mensagem
    """
    try:
        with get_connection() as connection:
            with connection.cursor() as cursor:
                # Verificar se o usuário já está inscrito no evento
                cursor.execute('''
                    SELECT COUNT(*)
                    FROM Participacao
                    WHERE username = %s AND nome_evento = %s AND data_evento = %s;
                ''', (username, nome_evento, data_evento))
                
                if cursor.fetchone()[0] > 0:
                    raise ValueError(f"Usuário {username} já está inscrito no evento {nome_evento}.")

                # Inserir registro na tabela Participacao
                cursor.execute('''
                    INSERT INTO Participacao (username, nome_evento, data_evento)
                    VALUES (%s, %s, %s);
                ''', (username, nome_evento, data_evento))
                
                connection.commit()
                
                return {
                  "status": "success",
                  "message": f"Usuário {username} inscrito com sucesso no evento {nome_evento}."
                }

    except ConexaoErro as ce:
        raise ce
    except Exception as e:
        raise e

if __name__ == "__main__":
    try:
        # Exemplo de uso
        nome_evento = "Evento Exemplo"
        username = "user1"
        resultado = run(inscrever_usuario_evento(nome_evento, username))
        print(resultado)
    except Exception as e:
        print(Fore.RED + f"\nErro ao inscrever usuário no evento: {e}")