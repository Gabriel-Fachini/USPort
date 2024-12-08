CREATE TABLE Usuario (
  username VARCHAR(50) PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  telefone VARCHAR(15) NOT NULL,
  tipo VARCHAR(8) NOT NULL, -- 'aluno' ou 'atletica'
  num_seguidores INTEGER DEFAULT 0,
  num_seguindo INTEGER DEFAULT 0,
  CONSTRAINT chk_email CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
  CONSTRAINT chk_telefone CHECK (telefone ~ '^\(\d{2}\) \d{5}-\d{4}$'),
  CONSTRAINT chk_tipo CHECK (tipo IN ('aluno', 'atletica')),
  CONSTRAINT chk_seguidores CHECK (num_seguidores >= 0),
  CONSTRAINT chk_seguindo CHECK (num_seguindo >= 0)
);

CREATE TABLE Endereco (
  username VARCHAR(50) PRIMARY KEY,
  rua VARCHAR(50) NOT NULL,
  numero INTEGER NOT NULL,
  bairro VARCHAR(50) NOT NULL,
  cep VARCHAR(9) NOT NULL, -- 12345-678
  complemento VARCHAR(50),
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE,
  CONSTRAINT chk_cep CHECK (cep ~ '^\d{5}-\d{3}$'),
  CONSTRAINT chk_numero CHECK (numero > 0)
);

CREATE TABLE Seguir (
  username1 VARCHAR(50) NOT NULL,
  username2 VARCHAR(50) NOT NULL,
  data_hora TIMESTAMP NOT NULL,
  PRIMARY KEY (username1, username2),
  FOREIGN KEY (username1) REFERENCES Usuario(username) ON DELETE CASCADE,
  FOREIGN KEY (username2) REFERENCES Usuario(username) ON DELETE CASCADE,
  CHECK (username1 <> username2)
);

CREATE TABLE Interacao (
  username1 VARCHAR(50) NOT NULL,
  username2 VARCHAR(50) NOT NULL,
  data_hora_post TIMESTAMP NOT NULL,
  data_hora_interacao TIMESTAMP NOT NULL,
  tipo VARCHAR(20) NOT NULL,
  -- comentario VARCHAR(1000) NOT NULL, -- Comentários removidos conforme necessário
  PRIMARY KEY (username1, username2, data_hora_post, data_hora_interacao),
  FOREIGN KEY (username1) REFERENCES Usuario(username) ON DELETE CASCADE,
  FOREIGN KEY (username2) REFERENCES Usuario(username) ON DELETE CASCADE,
  CHECK (username1 <> username2),
  CHECK (tipo IN ('curtir', 'compartilhar', 'comentar'))
);

CREATE TABLE Comentario (
  username1 VARCHAR(50) NOT NULL,
  username2 VARCHAR(50) NOT NULL,
  data_hora_post TIMESTAMP NOT NULL,
  data_hora_interacao TIMESTAMP NOT NULL,
  comentario TEXT NOT NULL,
  PRIMARY KEY (username1, username2, data_hora_post, data_hora_interacao),
  FOREIGN KEY (username1, username2, data_hora_post, data_hora_interacao) 
    REFERENCES Interacao(username1, username2, data_hora_post, data_hora_interacao) 
    ON DELETE CASCADE,
  CHECK (username1 <> username2)
);

CREATE TABLE Aluno (
  username VARCHAR(50) PRIMARY KEY,
  nusp INTEGER NOT NULL UNIQUE,
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE
);

CREATE TABLE Atletica (
  username VARCHAR(50) PRIMARY KEY,
  nusp INTEGER NOT NULL UNIQUE, -- secondary key
  atletica VARCHAR(50) NOT NULL, -- nome da atlética
  cnpj VARCHAR(20) NOT NULL UNIQUE, -- tertiary key
  razao_social VARCHAR(100) NOT NULL,
  nome_fantasia VARCHAR(100) NOT NULL,
  CONSTRAINT chk_cnpj CHECK (cnpj ~ '^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$'),
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE
);

CREATE TABLE Membros_Atletica (
  username1 VARCHAR(50) NOT NULL,
  username2 VARCHAR(50) NOT NULL,
  data_entrada DATE NOT NULL,
  data_saida DATE,
  PRIMARY KEY (username1, username2, data_entrada),
  FOREIGN KEY (username1) REFERENCES Aluno(username) ON DELETE CASCADE,
  FOREIGN KEY (username2) REFERENCES Atletica(username) ON DELETE CASCADE,
  CHECK (username1 <> username2),
  CONSTRAINT chk_data_saida CHECK (data_saida IS NULL OR data_entrada < data_saida)
);

CREATE TABLE Evento (
  nome VARCHAR(100) NOT NULL,
  data DATE NOT NULL, -- criação do evento no banco de dados
  username VARCHAR(50) NOT NULL,
  data_inicio DATE, -- data que está valendo o evento
  data_fim DATE, -- data que o evento acaba
  descricao TEXT NOT NULL,
  arquivo VARCHAR(200), -- link para arquivo
  ativo BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (nome, data),
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE,
  CONSTRAINT chk_data_fim CHECK (data_fim IS NULL OR data_inicio <= data_fim),
  CONSTRAINT chk_data_inicio CHECK (data_inicio IS NULL OR data_inicio >= data),
  CONSTRAINT chk_ativo CHECK (ativo IN (FALSE, TRUE))
);

CREATE TABLE Participacao (
  username VARCHAR(50) NOT NULL,
  nome_evento VARCHAR(100) NOT NULL,
  data DATE NOT NULL,
  PRIMARY KEY (username, nome_evento, data),
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE,
  FOREIGN KEY (nome_evento, data) REFERENCES Evento(nome, data) ON DELETE CASCADE
);

CREATE TABLE Trofeu (
  nome_evento VARCHAR(100) NOT NULL,
  data_evento DATE NOT NULL,
  data_trofeu DATE NOT NULL,
  nome_trofeu VARCHAR(100) NOT NULL,
  icone VARCHAR(200) NOT NULL, -- link para arquivo
  PRIMARY KEY (nome_evento, data_evento, data_trofeu),
  FOREIGN KEY (nome_evento, data_evento) REFERENCES Evento(nome, data) ON DELETE CASCADE,
  CHECK (data_trofeu >= data_evento)
);

CREATE TABLE Atividade (
  nome_evento VARCHAR(100) NOT NULL,
  data_evento DATE NOT NULL,
  nome_atividade VARCHAR(100) NOT NULL,
  descricao TEXT NOT NULL,
  esporte VARCHAR(50) NOT NULL,
  arquivo VARCHAR(200),
  PRIMARY KEY (nome_evento, data_evento, nome_atividade),
  FOREIGN KEY (nome_evento, data_evento) REFERENCES Evento(nome, data) ON DELETE CASCADE
);

CREATE TABLE Selo (
  nome_evento VARCHAR(100) NOT NULL,
  data_evento DATE NOT NULL,
  nome_atividade VARCHAR(100) NOT NULL,
  data_selo DATE NOT NULL,
  imagem VARCHAR(200) NOT NULL,
  PRIMARY KEY (nome_evento, data_evento, nome_atividade, data_selo),
  FOREIGN KEY (nome_evento, data_evento, nome_atividade) 
    REFERENCES Atividade(nome_evento, data_evento, nome_atividade) 
    ON DELETE CASCADE,
  CHECK (data_selo >= data_evento)
);

CREATE TABLE Post (
  username VARCHAR(50) NOT NULL,
  data_hora TIMESTAMP NOT NULL,
  descricao TEXT NOT NULL,
  anexo VARCHAR(200), -- link para arquivo
  PRIMARY KEY (username, data_hora),
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE
);