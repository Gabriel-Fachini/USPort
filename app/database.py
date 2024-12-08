"""
Módulo de configuração e conexão com o banco de dados PostgreSQL.

Este módulo contém funções para configurar a conexão com o banco de dados,
testar a conexão e lidar com erros de conexão. Ele utiliza a biblioteca
`psycopg2` para se conectar ao PostgreSQL.

Classes:
    ConexaoErro: Exceção personalizada para erros de conexão com o banco de dados.

Funções:
    get_connection(): Estabelece uma conexão com o banco de dados PostgreSQL.
    test_connection(): Testa a conexão com o banco de dados PostgreSQL.
"""

import psycopg2
from psycopg2 import DatabaseError
from app.config import settings

# Configuração do banco
DB_CONFIG = {
    'dbname': settings.db_name,
    'user': settings.db_user,
    'password': settings.db_password,
    'host': settings.db_host,
    'port': settings.db_port
}

class ConexaoErro(Exception):
    """
    Exceção personalizada para erros de conexão com o banco de dados.

    Attributes:
        status_code (int): Código de status do erro.
        detail (str): Detalhes do erro.
    """
    def __init__(self, status_code, detail):
        """
        Inicializa a exceção ConexaoErro com código de status e detalhes do erro.

        Args:
            status_code (int): Código de status do erro.
            detail (str): Detalhes do erro.
        """
        self.status_code = status_code
        self.detail = detail
        super().__init__(self.detail)

def get_connection():
    """
    Estabelece uma conexão com o banco de dados PostgreSQL.

    Esta função utiliza as configurações definidas em `DB_CONFIG` para
    estabelecer uma conexão com o banco de dados PostgreSQL. A codificação
    do cliente é definida como UTF-8.

    Returns:
        connection: Objeto de conexão do `psycopg2`.

    Raises:
        ConexaoErro: Se ocorrer um erro ao tentar se conectar ao banco de dados.
    """
    try:
        connection = psycopg2.connect(**DB_CONFIG)
        connection.set_client_encoding('UTF8')
        return connection
    except DatabaseError as e:
        raise ConexaoErro(status_code=500, detail=f"Erro de conexão: {str(e)}")

def test_connection():
    """
    Testa a conexão com o banco de dados PostgreSQL.

    Esta função tenta estabelecer uma conexão com o banco de dados e executar
    uma consulta simples (`SELECT 1`). Se a conexão for bem-sucedida, a função
    retorna True. Caso contrário, imprime o erro e retorna False.

    Returns:
        bool: True se a conexão for bem-sucedida, False caso contrário.
    """
    try:
        with get_connection() as conn:
            with conn.cursor() as cur:
                cur.execute('SELECT 1')
                return True
    except Exception as e:
        print(f"Erro ao testar conexão: {str(e)}")
        return False