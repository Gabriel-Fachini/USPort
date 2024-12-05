CREATE TABLE Usuario (
  username VARCHAR2(50) PRIMARY KEY,
  nome VARCHAR2(100) NOT NULL,
  email VARCHAR2(100) NOT NULL UNIQUE,
  telefone VARCHAR2(15) NOT NULL,
  CONSTRAINT chk_email CHECK (REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')),
  CONSTRAINT chk_telefone CHECK (REGEXP_LIKE(telefone, '^\(\d{2}\) \d{5}-\d{4}$')),
);

CREATE TABLE Endereco (
  username VARCHAR2(50) PRIMARY KEY,
  rua VARCHAR2(50) NOT NULL,
  numero NUMBER(10) NOT NULL,
  bairro VARCHAR2(50) NOT NULL,
  cep VARCHAR2(9) NOT NULL, -- 12345-678
  complemento VARCHAR2(50),
  referencia VARCHAR2(50),
  FOREIGN KEY (username) REFERENCES Usuario(username),
  CONSTRAINT chk_cep CHECK (REGEXP_LIKE(cep, '^\d{5}-\d{3}$'))
)

CREATE TABLE Seguir (
  username1 VARCHAR2(50) NOT NULL,
  username2 VARCHAR2(50) NOT NULL,
  data_hora DATE NOT NULL,
  PRIMARY KEY (username1, username2),
  FOREIGN KEY (username1) REFERENCES Usuario(username),
  FOREIGN KEY (username2) REFERENCES Usuario(username),
  CHECK (username1 <> username2)
)

CREATE TABLE Interacao_Comentario (
  username1 VARCHAR2(50) NOT NULL,
  username2 VARCHAR2(50) NOT NULL,
  data_hora DATE NOT NULL,
  data_hora_interacao DATE NOT NULL,
  comentario VARCHAR2(1000) NOT NULL,
  PRIMARY KEY (username1, username2, data_hora),
  FOREIGN KEY (username1) REFERENCES Usuario(username),
  FOREIGN KEY (username2) REFERENCES Usuario(username),
  CHECK (username1 <> username2)
);

CREATE TABLE Interacao_Curtir_Compartilhar (
  username1 VARCHAR2(50) NOT NULL,
  username2 VARCHAR2(50) NOT NULL,
  data_hora DATE NOT NULL,
  data_hora_interacao DATE NOT NULL,
  tipo VARCHAR2(20) NOT NULL,
  PRIMARY KEY (username1, username2, data_hora),
  FOREIGN KEY (username1) REFERENCES Usuario(username),
  FOREIGN KEY (username2) REFERENCES Usuario(username),
  CHECK (username1 <> username2),
  CHECK (tipo IN ('curtir', 'compartilhar'))
);

CREATE TABLE Aluno (
  username VARCHAR2(50) PRIMARY KEY,
  nusp NUMBER(8) NOT NULL UNIQUE,
  FOREIGN KEY (username) REFERENCES Usuario(username)
);

CREATE TABLE Atletica (
  username VARCHAR2(50) PRIMARY KEY,
  nusp NUMBER(8) NOT NULL UNIQUE,
  atletica VARCHAR2(50) NOT NULL,
  cnpj VARCHAR2(20) NOT NULL UNIQUE,
  razao_social VARCHAR2(100) NOT NULL,
  nome_fantasia VARCHAR2(100) NOT NULL,
  CONSTRAINT chk_cnpj CHECK (REGEXP_LIKE(cnpj, '^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$')),
  FOREIGN KEY (username) REFERENCES Usuario(username)
)

CREATE TABLE Membros_Atletica (
  username1 VARCHAR2(50) NOT NULL,
  username2 VARCHAR2(50) NOT NULL,
  data_entrada DATE NOT NULL,
  data_saida DATE,
  descricao VARCHAR2(500) NOT NULL,
  PRIMARY KEY (username1, username2, data_entrada),
  FOREIGN KEY (username1) REFERENCES Aluno(username),
  FOREIGN KEY (username2) REFERENCES Aluno(username),
  CHECK (username1 <> username2),
  CONSTRAINT chk_data_saida CHECK (data_saida IS NULL OR data_entrada < data_saida)
);

CREATE TABLE Participacao (
  username VARCHAR2(50) NOT NULL,
  nome_evento VARCHAR2(100) NOT NULL,
  data DATE NOT NULL,
  PRIMARY KEY (username, nome_evento), -- aqui teria mais um atributo data
  FOREIGN KEY (username) REFERENCES Usuario(username),
  FOREIGN KEY (nome_evento, data) REFERENCES Evento(nome, data)
);

CREATE TABLE Evento (
  nome VARCHAR2(100) NOT NULL,
  data DATE NOT NULL,
  username VARCHAR2(50) NOT NULL,
  descricao VARCHAR2(500) NOT NULL,
  esporte VARCHAR2(50) NOT NULL,
  arquivo VARCHAR2(200), -- link para arquivo
  PRIMARY KEY (nome, data),
  FOREIGN KEY (username) REFERENCES Usuario(username)
);

CREATE TABLE Trofeu (
  nome VARCHAR2(100) NOT NULL,
  data DATE NOT NULL,
  data_trofeu DATE NOT NULL,
  icone VARCHAR2(200) NOT NULL, -- link para arquivo
  PRIMARY KEY (nome, data, data_trofeu),
  FOREIGN KEY (nome, data) REFERENCES Evento(nome, data),
  CHECK (data_trofeu >= data)
);

CREATE TABLE Atividade (
  nome VARCHAR2(100) NOT NULL,
  data DATE NOT NULL,
  nome_atividade VARCHAR2(100) NOT NULL,
  descricao VARCHAR2(500) NOT NULL,
  esporte VARCHAR2(50) NOT NULL,
  arquivo VARCHAR2(200),
  PRIMARY KEY (nome, data, nome_atividade),
  FOREIGN KEY (nome, data) REFERENCES Evento(nome, data)
);

CREATE TABLE Selo (
  nome VARCHAR2(100) NOT NULL,
  data DATE NOT NULL,
  nome_atividade VARCHAR2(100) NOT NULL,
  data_selo DATE NOT NULL,
  imagem VARCHAR2(200) NOT NULL,
  PRIMARY KEY (nome, data, nome_atividade),
  FOREIGN KEY (nome, data, nome_atividade) REFERENCES Atividade(nome, data, nome_atividade),
  CHECK (data_selo >= data)
);

CREATE TABLE Post (
  username VARCHAR2(50) NOT NULL,
  data_hora DATE NOT NULL,
  descricao VARCHAR2(500) NOT NULL,
  anexo VARCHAR2(200), -- link para arquivo
  PRIMARY KEY (username, data_hora),
  FOREIGN KEY (username) REFERENCES Usuario(username)
);