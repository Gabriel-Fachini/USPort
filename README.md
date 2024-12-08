# USPort
Projeto de Esportes da Disciplina de Bases de Dados.

# Instalação

### 1. Clone o repositório:
```bash
git clone https://github.com/Gabriel-Fachini/USPort
```

### 2. Entre na pasta do projeto
cd projeto-esportes-bd

### 3. Em seguida, abra um terminal na pasta do repositório e execute para instalar as dependências:

```bash
pip install -r requirements.txt
```

### 4. Crie e configure o arquivo `.env`:
* Existe um arquivo `.env.example` onde as variáveis já estão definidas. Apenas é necessário substituir pelos valores que irá utilizar.

## Configuração
A aplicação é configurada nos arquivos:

* Arquivo `.env` com variáveis de ambiente
* Valores padrão em `config.py`

## Tecnologias Utilizadas

- Python 3.x
- Pydantic # Validação de dados
- pydantic_settings # Gerenciamento de configurações
- pydantic[email] # Validação de email
- colorama # Output colorido
- InquirerPy # CLI Interativo
- psycopg2 # Para conexão com banco de dados

## Pré-requisitos

1. Python 3.x instalado
2. Banco de dados PostgreSQL

## Rodando a Aplicação
Execute o comando na pasta raiz do projeto:

```bash
python main.py
```

## Estrutura do projeto

```
.
├── main.py         # Arquivo principal com a lógica da aplicação e menu interativo
├── app/
│   ├── __init__.py # Inicialização do módulo app
│   ├── config.py   # Configurações da aplicação, incluindo variáveis de ambiente
│   ├── database.py # Configuração e conexão com o banco de dados PostgreSQL
│   ├── schemas.py  # Definição dos modelos de dados utilizando Pydantic
│   ├── funcionalidades/
│   │   ├── __init__.py                     # Inicialização do módulo funcionalidades
│   │   ├── criar_aluno.py                  # Função para criar um novo aluno
│   │   ├── criar_atletica.py               # Função para criar uma nova atlética
│   │   ├── criar_usuario.py                # Função para criar um novo usuário
│   │   ├── feed_personalizado.py           # Função para obter o feed personalizado
│   │   ├── inscrever_usuario_evento.py     # Função para inscrever um usuário em um evento
│   │   ├── listar_estatisticas.py          # Função para listar estatísticas de engajamento
│   │   ├── listar_eventos_atletica.py      # Função para listar eventos de uma atlética
│   │   ├── listar_participacoes_comuns.py  # Função para listar participações comuns entre usuários
├── printers.py     # Funções para exibir dados formatados no terminal
├── requirements.txt # Dependências do projeto
├── scripts/
│   ├── dados.sql   # Script SQL para popular o banco de dados com dados iniciais
│   ├── esquema.sql # Script SQL para criar as tabelas do banco de dados
├── .env            # Variáveis de ambiente
├── .env.example    # Exemplo de arquivo de variáveis de ambiente
├── .gitignore      # Arquivo para ignorar arquivos e pastas no Git
└── README.md       # Documentação do projeto
```

## Observações:
1. A aplicação usa conexão com PostgreSQL via `psycopg2`
2. Todas as operações incluem tratamento de erros

## Segurança
- Utiliza queries parametrizadas para prevenir SQL injection
- Credenciais sensíveis são gerenciadas via variáveis de ambiente
- Validação de dados com Pydantic
- Conexões são fechadas automaticamente com context manager