import os
from pydantic_settings import BaseSettings
from dotenv import load_dotenv

load_dotenv()

class Settings(BaseSettings):
    app_name: str = "USPort"
    debug: bool = True

    # Configurações do banco
    db_name: str = os.getenv("DB_NAME", "seu_banco")
    db_user: str = os.getenv("DB_USER", "seu_usuario")
    db_password: str = os.getenv("DB_PASSWORD", "sua_senha")
    db_host: str = os.getenv("DB_HOST", "localhost")
    db_port: int = int(os.getenv("DB_PORT", 5432))

    class Config:
        env_file = ".env"

settings = Settings()