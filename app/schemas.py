from pydantic import BaseModel, EmailStr, Field, constr, field_validator
from typing import Optional
from datetime import date, datetime

class Usuario(BaseModel):
    username: str = constr(max_length=50)
    nome: str =constr(max_length=100)
    email: str = EmailStr
    telefone: str = constr(max_length=15, pattern=r'^\(\d{2}\) \d{5}-\d{4}$')
    tipo: str = constr(max_length=8)
    num_seguidores: int = Field(default=0, ge=0)
    num_seguindo: int = Field(default=0, ge=0)

    @field_validator('tipo')
    def tipo_valido(cls, v):
        if v not in ('aluno', 'atletica'):
            raise ValueError("O tipo deve ser 'aluno' ou 'atletica'")
        return v

class Endereco(BaseModel):
    username: str = constr(max_length=50)
    rua: str = constr(max_length=50)
    numero: int = Field(..., gt=0)
    bairro: str = constr(max_length=50)
    cep: str = constr(max_length=9, pattern=r'^\d{5}-\d{3}$')
    complemento: Optional[str] = Field(None, max_length=50)

class Seguir(BaseModel):
    username1: str = constr(max_length=50)
    username2: str = constr(max_length=50)
    data_hora: datetime

    @field_validator('username1')
    def usernames_diferentes(cls, v, values):
        if 'username2' in values and v == values['username2']:
            raise ValueError("username1 e username2 devem ser diferentes")
        return v

class Interacao(BaseModel):
    username1: str = constr(max_length=50)
    username2: str = constr(max_length=50)
    data_hora_post: datetime
    data_hora_interacao: datetime
    tipo: str = constr(max_length=20)

    @field_validator('tipo')
    def tipo_valido(cls, v):
        if v not in ('curtir', 'compartilhar', 'comentar'):
            raise ValueError("O tipo deve ser 'curtir', 'compartilhar' ou 'comentar'")
        return v

    @field_validator('username1')
    def usernames_diferentes(cls, v, values):
        if 'username2' in values and v == values['username2']:
            raise ValueError("username1 e username2 devem ser diferentes")
        return v

class Comentario(BaseModel):
    username1: str = constr(max_length=50)
    username2: str = constr(max_length=50)
    data_hora_post: datetime
    data_hora_interacao: datetime
    comentario: str = constr(max_length=1000)

    @field_validator('username1')
    def usernames_diferentes(cls, v, values):
        if 'username2' in values and v == values['username2']:
            raise ValueError("username1 e username2 devem ser diferentes")
        return v

class Aluno(BaseModel):
    username: str = constr(max_length=50)
    nusp: int = Field(..., ge=0, le=99999999)

class Atletica(BaseModel):
    username: str = constr(max_length=50)
    atletica: str = constr(max_length=50)
    cnpj: str = constr(max_length=20, pattern=r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$')
    razao_social: str = constr(max_length=100)
    nome_fantasia: str = constr(max_length=100)

class MembrosAtletica(BaseModel):
    username1: str = constr(max_length=50)
    username2: str = constr(max_length=50)
    data_entrada: date
    data_saida: Optional[date] = None

    @field_validator('data_saida')
    def check_data_saida(cls, v, values):
        if v and 'data_entrada' in values and v <= values['data_entrada']:
            raise ValueError('data_saida deve ser maior que data_entrada')
        return v

    @field_validator('username1')
    def usernames_diferentes(cls, v, values):
        if 'username2' in values and v == values['username2']:
            raise ValueError("username1 e username2 devem ser diferentes")
        return v

class Evento(BaseModel):
    nome: str = constr(max_length=100)
    data: date
    username: str = constr(max_length=50)
    data_inicio: Optional[date] = None
    data_fim: Optional[date] = None
    descricao: str = constr(max_length=500)
    arquivo: Optional[str] = constr(max_length=200)
    ativo: int = Field(default=0)

    @field_validator('data_fim')
    def data_fim_valida(cls, v, values):
        if v and 'data_inicio' in values and v < values['data_inicio']:
            raise ValueError('data_fim deve ser maior ou igual a data_inicio')
        return v

    @field_validator('data_inicio')
    def data_inicio_valida(cls, v, values):
        if v and 'data' in values and v < values['data']:
            raise ValueError('data_inicio deve ser maior ou igual a data')
        return v

    @field_validator('ativo')
    def ativo_valido(cls, v):
        if v not in (0, 1):
            raise ValueError('ativo deve ser 0 ou 1')
        return v

class Participacao(BaseModel):
    username: str = constr(max_length=50)
    nome_evento: str = constr(max_length=100)
    data: date

class Trofeu(BaseModel):
    nome_evento: str = constr(max_length=100)
    data_evento: date
    data_trofeu: date
    nome_trofeu: str = constr(max_length=100)
    icone: str = constr(max_length=200)

    @field_validator('data_trofeu')
    def data_trofeu_valida(cls, v, values):
        if 'data_evento' in values and v < values['data_evento']:
            raise ValueError('data_trofeu deve ser maior ou igual a data_evento')
        return v

class Atividade(BaseModel):
    nome_evento: str = constr(max_length=100)
    data_evento: date
    nome_atividade: str = constr(max_length=100)
    descricao: str = constr(max_length=500)
    esporte: str = constr(max_length=50)
    arquivo: Optional[str] = constr(max_length=200)

class Selo(BaseModel):
    nome_evento: str = constr(max_length=100)
    data_evento: date
    nome_atividade: str = constr(max_length=100)
    data_selo: date
    imagem: str = constr(max_length=200)

    @field_validator('data_selo')
    def data_selo_valida(cls, v, values):
        if 'data_evento' in values and v < values['data_evento']:
            raise ValueError('data_selo deve ser maior ou igual a data_evento')
        return v

class Post(BaseModel):
    username: str = constr(max_length=50)
    data_hora: datetime
    descricao: str = constr(max_length=500)
    anexo: Optional[str] = constr(max_length=200)