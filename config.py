from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    app_name: str = "API de Itens"
    port: int = 8080
    host: str = "0.0.0.0"
    debug: bool = True

    # Configurações do banco
    db_user: str = "seu_usuario"
    db_password: str = "sua_senha"
    db_dsn: str = "localhost:1521/xe"

    class Config:
        env_file = ".env"

settings = Settings()