INSERT INTO Usuario (username, nome, email, telefone, tipo, num_seguidores, num_seguindo)
VALUES
('user1', 'João Silva', 'joao.silva@example.com', '(11) 91234-5678', 'aluno', 0, 0),
('user2', 'Maria Santos', 'maria.santos@example.com', '(21) 92345-6789', 'atletica', 0, 0),
('user3', 'Roberto Junior', 'roberto.junior@example.com', '(31) 93456-7890', 'aluno', 0, 0),
('user4', 'Alice Oliveira', 'alice.oliveira@example.com', '(41) 94567-8901', 'atletica', 0, 0),
('user5', 'Tiago Dias', 'tiago.dias@example.com', '(51) 95678-9012', 'aluno', 0, 0),
('user6', 'USP Caaso', 'caaso@example.com', '(51) 95678-9012', 'atletica', 0, 0);

INSERT INTO Aluno (username, nusp)
VALUES
('user1', 12345678),
('user3', 23456789),
('user5', 34567890);

INSERT INTO Atletica (username, cnpj, razao_social, nome_fantasia)
VALUES
('user2', '98.765.432/0001-54', 'Atlética B Associação', 'Atlética B'),
('user6', '98.777.432/0001-54', 'Caaso USP LTDA', 'Caaso'),
('user4', '43.210.987/0001-65', 'Atlética D Fundação', 'Atlética D');

INSERT INTO Endereco (username, rua, numero, bairro, cep, complemento)
VALUES
('user1', 'Rua Principal', 101, 'Centro', '12345-678', 'Apto 1A'),
('user2', 'Rua Carvalho', 202, 'Vila Nova', '98765-432', 'Unidade 2B'),
('user3', 'Rua das Flores', 303, 'Jardim América', '54321-098', 'Casa'),
('user4', 'Avenida Pinheiros', 404, 'Zona Leste', '67890-123', 'Condomínio'),
('user5', 'Avenida das Árvores', 505, 'Zona Oeste', '43210-987', 'Sobrado');

INSERT INTO Seguir (username1, username2, data_hora)
VALUES
('user1', 'user2', NOW()),
('user2', 'user3', NOW() - INTERVAL '2 days'),
('user3', 'user4', NOW() - INTERVAL '5 days'),
('user4', 'user5', NOW() - INTERVAL '10 days'),
('user5', 'user1', NOW() - INTERVAL '15 days');

-- executar junto os inserts interacao e comentario
-- Primeiro, inserir as interações (incluindo tipo 'comentario' onde necessário)
INSERT INTO Interacao (username1, username2, data_hora_post, data_hora_interacao, tipo)
VALUES
('user1', 'user2', NOW(), NOW(), 'comentario'),
('user2', 'user3', NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days', 'comentario'),
('user3', 'user4', NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days', 'comentario'),
('user4', 'user5', NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days', 'comentario'),
('user5', 'user1', NOW() - INTERVAL '15 days', NOW() - INTERVAL '15 days', 'comentario'),
-- Adicionando outras interações de diferentes tipos
('user1', 'user3', NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day', 'curtir'),
('user2', 'user4', NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days', 'compartilhar'),
('user3', 'user5', NOW() - INTERVAL '6 days', NOW() - INTERVAL '6 days', 'curtir'),
('user4', 'user1', NOW() - INTERVAL '8 days', NOW() - INTERVAL '8 days', 'compartilhar'),
('user5', 'user2', NOW() - INTERVAL '12 days', NOW() - INTERVAL '12 days', 'curtir');

-- Depois, inserir os comentários correspondentes
INSERT INTO Comentario (username1, username2, data_hora_post, data_hora_interacao, comentario)
VALUES
('user1', 'user2', NOW(), NOW(), 'Ótimo evento!'),
('user2', 'user3', NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days', 'Atividade interessante.'),
('user3', 'user4', NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days', 'Trabalho incrível!'),
('user4', 'user5', NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days', 'Parabéns!'),
('user5', 'user1', NOW() - INTERVAL '15 days', NOW() - INTERVAL '15 days', 'Bom trabalho pessoal.');

--

INSERT INTO Membros_Atletica (username1, username2, data_entrada, data_saida)
VALUES
('user1', 'user2', NOW() - INTERVAL '365 days', NULL),
('user2', 'user3', NOW() - INTERVAL '180 days', NULL),
('user3', 'user4', NOW() - INTERVAL '90 days', NOW() - INTERVAL '30 days'), -- esse
('user4', 'user5', NOW() - INTERVAL '270 days', NULL),
('user5', 'user1', NOW() - INTERVAL '450 days', NOW() - INTERVAL '180 days'); -- esse

-- Executar estes inserts juntos para não dar problema
-- daqui até o próximo comentário

INSERT INTO Evento (nome, data_evento, username, descricao, arquivo)
VALUES
('Evento A', NOW() - INTERVAL '30 days', 'user1', 'Competição esportiva anual', 'event_a.pdf'),
('Evento B', NOW() - INTERVAL '60 days', 'user2', 'Arrecadação de fundos de caridade', 'event_b.jpg'),
('Evento C', NOW() - INTERVAL '90 days', 'user3', 'Reunião da organização estudantil', 'event_c.docx'),
('Evento D', NOW() - INTERVAL '120 days', 'user4', 'Viagem de atividade ao ar livre', 'event_d.zip'),
('Evento E', NOW() - INTERVAL '150 days', 'user5', 'Evento social do clube', 'event_e.mp4'),
('Evento D', NOW() + INTERVAL '120 days', 'user6', 'Campeonato de handball na quadra', 'event_d.zip'),
('Evento D', NOW() + INTERVAL '90 days', 'user6', 'Comemoração da vitória do caaso tusca na piscina', 'event_d.zip');

INSERT INTO Participacao (username, nome_evento, data_evento)
VALUES
('user1', 'Evento A', NOW() - INTERVAL '30 days'),
('user2', 'Evento B', NOW() - INTERVAL '60 days'),
('user3', 'Evento C', NOW() - INTERVAL '90 days'),
('user4', 'Evento D', NOW() - INTERVAL '120 days'),
('user5', 'Evento E', NOW() - INTERVAL '150 days');

INSERT INTO Trofeu (nome_evento, data_evento, data_trofeu, nome_trofeu, icone)
VALUES
('Evento A', NOW() - INTERVAL '30 days', NOW() - INTERVAL '28 days', 'Trofeu Ouro', 'trophy_a.jpg'),
('Evento B', NOW() - INTERVAL '60 days', NOW() - INTERVAL '58 days', 'Trofeu Prata', 'trophy_b.jpg'),
('Evento C', NOW() - INTERVAL '90 days', NOW() - INTERVAL '88 days', 'Trofeu Bronze', 'trophy_c.jpg'),
('Evento D', NOW() - INTERVAL '120 days', NOW() - INTERVAL '118 days', 'Trofeu Especial', 'trophy_d.jpg'),
('Evento E', NOW() - INTERVAL '150 days', NOW() - INTERVAL '148 days', 'Trofeu Confraternização', 'trophy_e.jpg');

INSERT INTO Atividade (nome_evento, data_evento, nome_atividade, descricao, esporte, arquivo)
VALUES
('Evento A', NOW() - INTERVAL '30 days', 'Atividade 1', 'Torneio de basquete', 'Basquete', 'activity_a1.jpg'),
('Evento B', NOW() - INTERVAL '60 days', 'Atividade 2', 'Clínica de habilidades de vôlei', 'Voleibol', 'activity_b2.jpg'),
('Evento C', NOW() - INTERVAL '90 days', 'Atividade 3', 'Oficina de xadrez', 'Xadrez', 'activity_c3.jpg'),
('Evento D', NOW() - INTERVAL '120 days', 'Atividade 4', 'Exploração de trilhas de caminhada', 'Caminhada', 'activity_d4.jpg'),
('Evento E', NOW() - INTERVAL '150 days', 'Atividade 5', 'Torneio de boliche', 'Boliche', 'activity_e5.jpg');

INSERT INTO Selo (nome_evento, data_evento, nome_atividade, data_selo, imagem)
VALUES
('Evento A', NOW() - INTERVAL '30 days', 'Atividade 1', NOW() - INTERVAL '28 days', 'selo_a1.png'),
('Evento B', NOW() - INTERVAL '60 days', 'Atividade 2', NOW() - INTERVAL '58 days', 'selo_b2.svg'),
('Evento C', NOW() - INTERVAL '90 days', 'Atividade 3', NOW() - INTERVAL '88 days', 'selo_c3.jpg'),
('Evento D', NOW() - INTERVAL '120 days', 'Atividade 4', NOW() - INTERVAL '118 days', 'selo_d4.ico'),
('Evento E', NOW() - INTERVAL '150 days', 'Atividade 5', NOW() - INTERVAL '148 days', 'selo_e5.gif');

-- comentário de fim de bloco

INSERT INTO Post (username, data_hora, descricao, anexo)
VALUES
('user1', NOW() - INTERVAL '10 days', 'Tive um ótimo tempo no evento!', 'photo_a.jpg'),
('user2', NOW() - INTERVAL '20 days', 'Animado para a próxima atividade', NULL),
('user3', NOW() - INTERVAL '30 days', 'Trabalho incrível dos organizadores', 'document_c.docx'),
('user4', NOW() - INTERVAL '40 days', 'Mal posso esperar para ganhar novos selos', 'image_d.png'),
('user5', NOW() - INTERVAL '50 days', 'Ansioso por mais eventos como este!', 'video_e.mp4');