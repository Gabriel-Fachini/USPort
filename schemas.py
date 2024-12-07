from pydantic import BaseModel, EmailStr, Field, constr, field_validator
from typing import Optional, List
from datetime import date

class Usuario(BaseModel):
    username: str
    nome: str
    email: EmailStr
    telefone: str
    tipo: str
    num_seguidores: Optional[int] = 0
    num_seguindo: Optional[int] = 0
    nusp: int = None

class Atletica(BaseModel):
    username: str = constr(max_length=50)
    nusp: int = Field(..., ge=0, le=99999999)
    atletica: str = constr(max_length=50)
    cnpj: str = constr(pattern=r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$')
    razao_social: str = constr(max_length=100)
    nome_fantasia: str = constr(max_length=100)

class MembrosAtletica(BaseModel):
    username1: str = constr(max_length=50)
    username2: str =constr(max_length=50)
    data_entrada: date
    data_saida: Optional[date] = None
    descricao: str = constr(max_length=500)

    @field_validator('data_saida')
    def check_data_saida(cls, v, values):
        if v and 'data_entrada' in values and v <= values['data_entrada']:
            raise ValueError('data_saida deve ser maior que data_entrada')
        return v

class Participacao(BaseModel):
    username: str = constr(max_length=50)
    nome_evento: str = constr(max_length=100)
    data: date
    