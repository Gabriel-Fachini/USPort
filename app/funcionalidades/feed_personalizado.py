from app.schemas import Usuario
from typing import Dict
from app.database import get_connection, ConexaoErro
from asyncio import run
from colorama import init

# Inicializa o colorama
init(autoreset=True)

async def feed_personalizado(username: str) -> Dict:
  """
    Obtém o feed personalizado com os 10 posts mais recentes dos usuários seguidos.
    
    Args:
      username (str): Username do usuário que deseja ver o feed
    
    Returns:
      Dict: Resposta com status e lista de posts
  """
  try:
    with get_connection() as connection:
      with connection.cursor() as cursor:
        cursor.execute('''
          SELECT p.username, p.data_hora, p.descricao, p.anexo
          FROM Post p
          JOIN Seguir s ON p.username = s.username2
          WHERE s.username1 = %s
          ORDER BY p.data_hora DESC
          LIMIT 10;
        ''', (username,))

        posts = cursor.fetchall()
                
        # Formata os resultados
        posts_formatados = []
        for post in posts:
            posts_formatados.append({
              "username": post[0],
              "data_hora": post[1].strftime("%Y-%m-%d %H:%M:%S"),
              "descricao": post[2],
              "anexo": post[3]
            })
        
        return {
          "status": "success",
          "data": posts_formatados
        }

  except ValueError as ve:
    # Erros de validação (username ou email já registrados)
    raise ve
  except ConexaoErro as ce:
    # Erros de conexão
    raise ce
  except Exception as e:
    # Outros erros
    raise e