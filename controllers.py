from schemas import Usuario
from typing import Dict
from database import get_connection, ConexaoErro

async def criar_usuario(user: Usuario) -> Dict:
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
        # Verifica se o username já existe
        cursor.execute("SELECT username FROM Usuario WHERE username = %s", (user.username,))
        if cursor.fetchone():
            raise ValueError("Username já registrado")
        
        # Verifica se o email já existe
        cursor.execute("SELECT email FROM Usuario WHERE email = %s", (user.email,))
        if cursor.fetchone():
            raise ValueError("Email já registrado")
        
        # Insere o novo usuário
        cursor.execute(
            "INSERT INTO Usuario (username, nome, email, telefone, tipo, num_seguidores, num_seguindo) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (
                user.username,
                user.nome,
                user.email,
                user.telefone,
                user.tipo,
                user.num_seguidores,
                user.num_seguindo
            )
        )
        connection.commit()
        return {"message": "Usuário criado com sucesso!", "user": user.model_dump()}
  except ValueError as ve:
    # Erros de validação (username ou email já registrados)
    return {"status": "error", "detail": str(ve)}
  except ConexaoErro as ce:
    # Erros de conexão
    return {"status": "error", "detail": ce.detail}
  except Exception as e:
    # Outros erros
    return {"status": "error", "detail": f"Erro ao criar usuário: {str(e)}"}