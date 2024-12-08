from typing import Dict
from app.database import get_connection, ConexaoErro
from colorama import init, Fore

# Inicializa o colorama
init(autoreset=True)

async def listar_eventos_atletica(nome_atletica: str) -> Dict:
  """
    Lista todos os eventos de uma determinada atlética.
    
    Args:
      nome_atletica (str): Nome da atlética cujos eventos serão listados
    
    Returns:
      Dict: Resposta com status e lista de eventos
  """
  try:
    with get_connection() as connection:
      with connection.cursor() as cursor:
          cursor.execute('''
              SELECT e.nome, e.data, e.data_inicio, e.data_fim, e.descricao, e.arquivo, e.ativo
              FROM Evento e
              JOIN Atletica a ON u.username = a.username
              WHERE a.atletica ILIKE %s;
          ''', (f'%{nome_atletica}%',))
          
          eventos = cursor.fetchall()
          
          # Formata os resultados
          eventos_formatados = []
          for evento in eventos:
              eventos_formatados.append({
                "nome": evento[0],
                "data": evento[1].strftime("%Y-%m-%d"),
                "data_inicio": evento[2].strftime("%Y-%m-%d") if evento[2] else None,
                "data_fim": evento[3].strftime("%Y-%m-%d") if evento[3] else None,
                "descricao": evento[4],
                "arquivo": evento[5],
                "ativo": evento[6]
              })
          
          # Obter número de membros da atlética
          cursor.execute('''
            SELECT a.username AS atletica, COUNT(DISTINCT m.username1) AS total_membros
            FROM Atletica a
            LEFT JOIN Membros_Atletica m ON a.username = m.username2
            WHERE a.username ILIKE %s
            GROUP BY a.username
          ''', (f'%{nome_atletica}%',))
          
          num_membros = cursor.fetchone()
          if num_membros is None:
            num_membros = 0
          else:
            num_membros = num_membros[0]

          return {
              "status": "success",
              "data": {
                "eventos": eventos_formatados,
                "total_membros": 1
              }
          }

  except ConexaoErro as ce:
    print(Fore.RED + f"Erro de conexão: {ce}")
    raise ce
  except Exception as e:
    print(Fore.RED + f"Erro ao listar eventos: {e}")
    raise e
  except ValueError as e:
    print(Fore.RED + e)
    raise e