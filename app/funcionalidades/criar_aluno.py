from app.schemas import Aluno
from typing import Dict
from app.database import get_connection, ConexaoErro
from asyncio import run
from colorama import init

# Inicializa o colorama
init(autoreset=True)

async def criar_aluno(aluno: Aluno) -> Dict:
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
          INSERT INTO Aluno (username, nusp)
          VALUES
          (%s, %s)''',
          (aluno.username, aluno.nusp)
        )
        connection.commit()
        return {"message": "Aluno criado com sucesso!", "user": aluno.model_dump()}
  except ValueError as ve:
    # Erros de validação (username ou email já registrados)
    raise ve
  except ConexaoErro as ce:
    # Erros de conexão
    raise ce
  except Exception as e:
    # Outros erros
    raise e