-- Criação da tabela Usuario
CREATE TABLE Usuario (
  username VARCHAR(50) PRIMARY KEY, -- Identificador único do usuário
  nome VARCHAR(100) NOT NULL, -- Nome completo do usuário
  email VARCHAR(100) NOT NULL UNIQUE, -- Endereço de email único
  telefone VARCHAR(15) NOT NULL, -- Número de telefone no formato (XX) XXXXX-XXXX
  tipo VARCHAR(8) NOT NULL, -- Tipo do usuário: 'aluno' ou 'atletica'
  num_seguidores INTEGER DEFAULT 0, -- Número de seguidores
  num_seguindo INTEGER DEFAULT 0, -- Número de seguindo
  CONSTRAINT chk_email CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'), -- Validação do formato do email
  CONSTRAINT chk_telefone CHECK (telefone ~ '^\(\d{2}\) \d{5}-\d{4}$'), -- Validação do formato do telefone
  CONSTRAINT chk_tipo CHECK (tipo IN ('aluno', 'atletica')), -- Restringe os tipos para 'aluno' ou 'atletica'
  CONSTRAINT chk_seguidores CHECK (num_seguidores >= 0), -- Garante que num_seguidores não seja negativo
  CONSTRAINT chk_seguindo CHECK (num_seguindo >= 0) -- Garante que num_seguindo não seja negativo
);

-- Criação da tabela Endereco
CREATE TABLE Endereco (
  username VARCHAR(50) PRIMARY KEY, -- Identificador do usuário, chave estrangeira para Usuario
  rua VARCHAR(50) NOT NULL, -- Nome da rua
  numero INTEGER NOT NULL, -- Número da residência
  bairro VARCHAR(50) NOT NULL, -- Bairro
  cep VARCHAR(9) NOT NULL, -- Código postal no formato 12345-678
  complemento VARCHAR(50), -- Complemento do endereço (opcional)
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE, -- Relação com a tabela Usuario
  CONSTRAINT chk_cep CHECK (cep ~ '^\d{5}-\d{3}$'), -- Validação do formato do CEP
  CONSTRAINT chk_numero CHECK (numero > 0) -- Garante que o número seja positivo
);

-- Criação da tabela Seguir
CREATE TABLE Seguir (
  username1 VARCHAR(50) NOT NULL, -- Usuário que deseja seguir, chave estrangeira para Usuario
  username2 VARCHAR(50) NOT NULL, -- Usuário a ser seguido, chave estrangeira para Usuario
  data_hora TIMESTAMP NOT NULL, -- Data e hora da ação de seguir
  PRIMARY KEY (username1, username2), -- Chave primária composta
  FOREIGN KEY (username1) REFERENCES Usuario(username) ON DELETE CASCADE, -- Relação com a tabela Usuario para username1
  FOREIGN KEY (username2) REFERENCES Usuario(username) ON DELETE CASCADE, -- Relação com a tabela Usuario para username2
  CHECK (username1 <> username2) -- Garante que um usuário não possa seguir a si mesmo
);

-- Criação da tabela Interacao
CREATE TABLE Interacao (
  username1 VARCHAR(50) NOT NULL, -- Usuário que realiza a interação
  username2 VARCHAR(50) NOT NULL, -- Autor da postagem que está sendo interagida
  data_hora_post TIMESTAMP NOT NULL, -- Data e hora da postagem original
  data_hora_interacao TIMESTAMP NOT NULL, -- Data e hora da interação
  tipo VARCHAR(20) NOT NULL, -- Tipo de interação: 'curtir', 'compartilhar', 'comentario'
  PRIMARY KEY (username1, username2, data_hora_post, data_hora_interacao), -- Chave primária composta
  FOREIGN KEY (username1) REFERENCES Usuario(username) ON DELETE CASCADE, -- Relação com a tabela Usuario para quem interage
  FOREIGN KEY (username2) REFERENCES Usuario(username) ON DELETE CASCADE, -- Relação com a tabela Usuario para autor da postagem
  CHECK (username1 <> username2), -- Previne interações próprias
  CHECK (tipo IN ('curtir', 'compartilhar', 'comentario')) -- Define tipos válidos de interação
);

-- Criação da tabela Comentario
CREATE TABLE Comentario (
  username1 VARCHAR(50) NOT NULL, -- Usuário que faz o comentário
  username2 VARCHAR(50) NOT NULL, -- Autor da postagem comentada
  data_hora_post TIMESTAMP NOT NULL, -- Data e hora da postagem original
  data_hora_interacao TIMESTAMP NOT NULL, -- Data e hora da interação (comentário)
  comentario TEXT NOT NULL, -- Conteúdo do comentário
  PRIMARY KEY (username1, username2, data_hora_post, data_hora_interacao), -- Chave primária composta
  FOREIGN KEY (username1, username2, data_hora_post, data_hora_interacao) 
    REFERENCES Interacao(username1, username2, data_hora_post, data_hora_interacao) 
    ON DELETE CASCADE, -- Relação com a tabela Interacao
);

-- Criação da tabela Aluno
CREATE TABLE Aluno (
  username VARCHAR(50) PRIMARY KEY, -- Identificador do aluno, chave estrangeira para Usuario
  nusp INTEGER NOT NULL UNIQUE, -- Número USP único do aluno
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE -- Relação com a tabela Usuario
);

-- Criação da tabela Atletica
CREATE TABLE Atletica (
  username VARCHAR(50) PRIMARY KEY, -- Identificador da atlética, chave estrangeira para Usuario
  cnpj VARCHAR(20) NOT NULL UNIQUE, -- CNPJ único no formato 00.000.000/0000-00
  razao_social VARCHAR(100) NOT NULL, -- Razão social da atlética
  nome_fantasia VARCHAR(100) NOT NULL, -- Nome fantasia da atlética
  CONSTRAINT chk_cnpj CHECK (cnpj ~ '^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$'), -- Validação do formato do CNPJ
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE -- Relação com a tabela Usuario
);

-- Criação da tabela Membros_Atletica
CREATE TABLE Membros_Atletica (
  username1 VARCHAR(50) NOT NULL, -- Identificador do aluno, chave estrangeira para Aluno
  username2 VARCHAR(50) NOT NULL, -- Identificador da atlética, chave estrangeira para Atletica
  data_entrada DATE NOT NULL, -- Data de entrada na atlética
  data_saida DATE, -- Data de saída da atlética (opcional)
  PRIMARY KEY (username1, username2, data_entrada), -- Chave primária composta
  FOREIGN KEY (username1) REFERENCES Aluno(username) ON DELETE CASCADE, -- Relação com a tabela Aluno
  FOREIGN KEY (username2) REFERENCES Atletica(username) ON DELETE CASCADE, -- Relação com a tabela Atletica
  CHECK (username1 <> username2), -- Previne relações entre o mesmo usuário
  CONSTRAINT chk_data_saida CHECK (data_saida IS NULL OR data_entrada < data_saida) -- Valida a sequência das datas
);

-- Executar este bloco junto 
-- Criação da tabela Evento
CREATE TABLE Evento (
  nome VARCHAR(100) NOT NULL, -- Nome do evento
  data_evento DATE NOT NULL, -- Data de criação do evento no banco de dados
  username VARCHAR(50) NOT NULL, -- Identificador do criador do evento, chave estrangeira para Usuario
  data_inicio DATE, -- Data de início do evento (opcional)
  data_fim DATE, -- Data de término do evento (opcional)
  descricao TEXT NOT NULL, -- Descrição detalhada do evento
  arquivo VARCHAR(200), -- Link para arquivo relacionado ao evento (opcional)
  ativo BOOLEAN DEFAULT FALSE, -- Status do evento: ativo ou inativo
  PRIMARY KEY (nome, data_evento), -- Chave primária composta
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE, -- Relação com a tabela Usuario
  CONSTRAINT chk_data_fim CHECK (data_fim IS NULL OR data_inicio <= data_fim), -- Valida que data_fim seja posterior a data_inicio
  CONSTRAINT chk_data_inicio CHECK (data_inicio IS NULL OR data_inicio >= data_evento), -- Valida que data_inicio seja posterior ou igual à data de criação
);

-- Criação da tabela Participacao
CREATE TABLE Participacao (
  username VARCHAR(50) NOT NULL, -- Identificador do usuário participante, chave estrangeira para Usuario
  nome_evento VARCHAR(100) NOT NULL, -- Nome do evento, parte da chave estrangeira composta para Evento
  data_evento DATE NOT NULL, -- Data do evento, parte da chave estrangeira composta para Evento
  PRIMARY KEY (username, nome_evento, data_evento), -- Chave primária composta
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE, -- Relação com a tabela Usuario
  FOREIGN KEY (nome_evento, data_evento) REFERENCES Evento(nome, data_evento) ON DELETE CASCADE -- Relação composta com a tabela Evento
);

-- Criação da tabela Trofeu
CREATE TABLE Trofeu (
  nome_evento VARCHAR(100) NOT NULL, -- Nome do evento, parte da chave estrangeira composta para Evento
  data_evento DATE NOT NULL, -- Data do evento, parte da chave estrangeira composta para Evento
  data_trofeu DATE NOT NULL, -- Data de atribuição do troféu
  nome_trofeu VARCHAR(100) NOT NULL, -- Nome do troféu
  icone VARCHAR(200) NOT NULL, -- Link para o ícone do troféu
  PRIMARY KEY (nome_evento, data_evento, data_trofeu), -- Chave primária composta
  FOREIGN KEY (nome_evento, data_evento) REFERENCES Evento(nome, data_evento) ON DELETE CASCADE, -- Relação com a tabela Evento
  CHECK (data_trofeu >= data_evento) -- Valida que data_trofeu seja posterior ou igual a data_evento
);

-- Criação da tabela Atividade
CREATE TABLE Atividade (
  nome_evento VARCHAR(100) NOT NULL, -- Nome do evento, parte da chave estrangeira composta para Evento
  data_evento DATE NOT NULL, -- Data do evento, parte da chave estrangeira composta para Evento
  nome_atividade VARCHAR(100) NOT NULL, -- Nome da atividade
  descricao TEXT NOT NULL, -- Descrição detalhada da atividade
  esporte VARCHAR(50) NOT NULL, -- Esporte relacionado à atividade
  arquivo VARCHAR(200), -- Link para arquivo relacionado à atividade (opcional)
  PRIMARY KEY (nome_evento, data_evento, nome_atividade), -- Chave primária composta
  FOREIGN KEY (nome_evento, data_evento) REFERENCES Evento(nome, data_evento) ON DELETE CASCADE -- Relação com a tabela Evento
);

-- Criação da tabela Selo
CREATE TABLE Selo (
  nome_evento VARCHAR(100) NOT NULL, -- Nome do evento, parte da chave estrangeira composta para Atividade
  data_evento DATE NOT NULL, -- Data do evento, parte da chave estrangeira composta para Atividade
  nome_atividade VARCHAR(100) NOT NULL, -- Nome da atividade, parte da chave estrangeira composta para Atividade
  data_selo DATE NOT NULL, -- Data de obtenção do selo
  imagem VARCHAR(200) NOT NULL, -- Link para a imagem do selo
  PRIMARY KEY (nome_evento, data_evento, nome_atividade, data_selo), -- Chave primária composta
  FOREIGN KEY (nome_evento, data_evento, nome_atividade) 
    REFERENCES Atividade(nome_evento, data_evento, nome_atividade) 
    ON DELETE CASCADE, -- Relação com a tabela Atividade
  CHECK (data_selo >= data_evento) -- Valida que data_selo seja posterior ou igual a data_evento
);

-- Executar este bloco junto até aqui

-- Criação da tabela Post
CREATE TABLE Post (
  username VARCHAR(50) NOT NULL, -- Identificador do usuário que realizou a postagem, chave estrangeira para Usuario
  data_hora TIMESTAMP NOT NULL, -- Data e hora da postagem
  descricao TEXT NOT NULL, -- Conteúdo da postagem
  anexo VARCHAR(200), -- Link para anexo da postagem (opcional)
  PRIMARY KEY (username, data_hora), -- Chave primária composta
  FOREIGN KEY (username) REFERENCES Usuario(username) ON DELETE CASCADE -- Relação com a tabela Usuario
);