from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import cx_Oracle
from typing import Optional
from config import settings

# Modelo de dados
class Item(BaseModel):
    id: Optional[int] = None
    nome: str
    descricao: str

# Configuração da API
app = FastAPI(
    title=settings.app_name,
    debug=settings.debug
)

# Configuração do banco
DB_CONFIG = {
    'user': settings.db_user,
    'password': settings.db_password,
    'dsn': settings.db_dsn
}

# Função para conectar ao banco
def get_connection():
    try:
        connection = cx_Oracle.connect(**DB_CONFIG)
        return connection
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro de conexão: {str(e)}")

# CRUD Endpoints
@app.get("/items/{item_id}")
def read_item(item_id: int):
    with get_connection() as conn:
        cursor = conn.cursor()
        query = "SELECT id, nome, descricao FROM items WHERE id = :1"
        cursor.execute(query, [item_id])
        result = cursor.fetchone()
        
        if result:
            return {"id": result[0], "nome": result[1], "descricao": result[2]}
        raise HTTPException(status_code=404, detail="Item não encontrado")

@app.post("/items/")
def create_item(item: Item):
    with get_connection() as conn:
        cursor = conn.cursor()
        query = "INSERT INTO items (nome, descricao) VALUES (:1, :2) RETURNING id INTO :3"
        id_var = cursor.var(cx_Oracle.NUMBER)
        cursor.execute(query, [item.nome, item.descricao, id_var])
        conn.commit()
        
        return {"id": id_var.getvalue()[0], "nome": item.nome, "descricao": item.descricao}

@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    with get_connection() as conn:
        cursor = conn.cursor()
        query = "UPDATE items SET nome = :1, descricao = :2 WHERE id = :3"
        cursor.execute(query, [item.nome, item.descricao, item_id])
        
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Item não encontrado")
        conn.commit()
        return {"id": item_id, "nome": item.nome, "descricao": item.descricao}

@app.delete("/items/{item_id}")
def delete_item(item_id: int):
    with get_connection() as conn:
        cursor = conn.cursor()
        query = "DELETE FROM items WHERE id = :1"
        cursor.execute(query, [item_id])
        
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Item não encontrado")
        conn.commit()
        return {"message": "Item deletado com sucesso"}

#USUÁRIO
@APP.post