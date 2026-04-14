# USPort
CLI de rede esportiva universitária criada para a disciplina de Bases de Dados. Permite cadastrar alunos e atléticas, acompanhar feed, inscrever-se em eventos e visualizar estatísticas de engajamento.

## Funcionalidades
- Cadastro de usuários (aluno ou atlética) com validação de dados
- Feed personalizado com os 10 posts mais recentes de quem você segue
- Inscrição em eventos de atléticas e confirmação direta no terminal
- Estatísticas de engajamento (curtidas, compartilhamentos, comentários por usuário)
- Participações em comum entre usuários para descobrir conexões

## Stack
- Python 3.12+, PostgreSQL 14+
- psycopg2 para acesso ao banco
- Pydantic + pydantic_settings para validação e configuração
- InquirerPy + Colorama para a experiência CLI

## Pré-requisitos
- Python 3.12+ com `pip`
- Servidor PostgreSQL acessível e um banco criado

## Como rodar
1) Clone e entre no diretório
```bash
git clone https://github.com/Gabriel-Fachini/USPort.git
cd USPort
```
2) (Opcional) Crie um ambiente virtual  
`python -m venv .venv && source .venv/bin/activate`

3) Instale as dependências  
`python -m pip install -r requirements.txt`

4) Copie e preencha o `.env`
```bash
cp .env.example .env
# Edite com seus valores
DB_NAME=nome_do_banco
DB_USER=usuario
DB_PASSWORD=senha
DB_HOST=localhost
DB_PORT=5432
```

5) Crie o schema e carregue os dados de exemplo
```bash
psql -U $DB_USER -h $DB_HOST -p $DB_PORT -d $DB_NAME -f scripts/esquema.sql
psql -U $DB_USER -h $DB_HOST -p $DB_PORT -d $DB_NAME -f scripts/dados.sql
```

6) Inicie o CLI  
`python main.py`

## Fluxo principal do CLI
- Cadastrar aluno ou atlética
- Obter feed personalizado
- Inscrever-se em eventos de uma atlética
- Listar estatísticas de engajamento
- Encontrar participações em comum entre usuários

## Estrutura do projeto
```
main.py
app/
  config.py
  database.py
  schemas.py
  funcionalidades/
scripts/
  esquema.sql
  dados.sql
funcionalidades.sql
printers.py
requirements.txt
README.md
```

## Observações rápidas
- Conexão ao PostgreSQL via `psycopg2` com queries parametrizadas
- Variáveis sensíveis permanecem no `.env`
