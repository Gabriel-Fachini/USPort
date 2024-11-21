# USPort
Projeto de Esportes da Disciplina de Bases de Dados.


# Instalação
Primeiramente, é necessário que o usuário tenha <a href="https://visualstudio.microsoft.com/visual-cpp-build-tools/">Microsoft C++ Build Tools</a> instalado para que a biblioteca que realiza a conexão com o banco de dados funcionar.

### 1. Clone o repositório:
```bash
git clone [URL_DO_REPOSITORIO]
```

### 2. Em seguida, abra um terminal na pasta do repositório e execute para instalar as dependências:

```bash
pip install -r requirements.txt
```

### 3. Crie e configure o arquivo `.env`:
* Existe um arquivo `.env.example` onde as variáveis já estão definidas. Apenas é necessário substituir pelos valores que irá utilizar.

## Configuração
A API pode ser configurada de três maneiras:

* Arquivo `.env`
* Valores padrão em `config.py`

## Tecnologias Utilizadas

- Python 3.x
- FastAPI
- cx_Oracle
- Oracle Database
- Pydantic

## Pré-requisitos

1. Python 3.x instalado
2. Microsoft Visual C++ Build Tools

## Rodando a Aplicação
Execute o comando:

```bash
uvicorn main:app --reload
```

A API estará disponível em `http://localhost:8000`

## Endpoints
### GET /items/{item_id}
* Retorna um item específico pelo ID

### POST /items/
* Cria um novo item
* Corpo da requisição:
```json
{
    "nome": "string",
    "descricao": "string"
}
```

### PUT /items/{item_id}
* Atualiza um item existente
* Mesmo formato do POST

### DELETE /items/{item_id}
* Remove um item específico

## Estrutura do projeto

```
.
├── main.py         # Arquivo principal com os endpoints
├── config.py       # Configurações da aplicação
├── run.py         # Script para execução da API
├── .env           # Variáveis de ambiente
└── requirements.txt # Dependências do projeto
```
  
## Observações:
1. A API usa conexão com Oracle Database via `cx_Oracle`
2. Todas as operações incluem tratamento de erros
3. Os endpoints seguem o padrão REST
4. A documentação é gerada automaticamente pelo FastAPIObservações

## Segurança
- Utiliza queries parametrizadas para prevenir SQL injection
- Credenciais sensíveis são gerenciadas via variáveis de ambiente
- Validação de dados com Pydantic
- Conexões são fechadas automaticamente com context manager