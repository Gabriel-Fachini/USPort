from app.schemas import Atletica
from typing import Dict
from app.database import get_connection, ConexaoErro
from colorama import init

# Inicializa o colorama
init(autoreset=True)

async def criar_atletica(atletica: Atletica) -> Dict:
  """
    Cria um novo usuário no banco de dados.
    
    Args:
        user (Usuario): Dados do usuário conforme o schema Usuario
    
    Returns:
        Dict: Resposta com status e dados do usuário
  """
  try:
    with get_connection() as connection:
      with connection.cursor() as cursor:
        # Insere o novo aluno
        cursor.execute('''
          INSERT INTO Atletica (username, atletica, cnpj, razao_social, nome_fantasia)
          VALUES
          (%s, %s, %s, %s, %s)''',
          (atletica.username, atletica.atletica, atletica.cnpj, atletica.razao_social, atletica.nome_fantasia)
        )
        connection.commit()
        return {"message": "Atlética criada com sucesso!", "user": atletica.model_dump()}
  except ValueError as ve:
    # Erros de validação (username ou email já registrados)
    raise ve
  except ConexaoErro as ce:
    # Erros de conexão
    raise ce
  except Exception as e:
    # Outros erros
    raise e