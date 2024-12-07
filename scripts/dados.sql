INSERT INTO Usuario (username, nome, email, telefone, tipo, num_seguidores, num_seguindo)
VALUES
('user1', 'João Silva', 'joao.silva@example.com', '(11) 91234-5678', 'aluno', 0, 0),
('user2', 'Maria Santos', 'maria.santos@example.com', '(21) 92345-6789', 'atletica', 0, 0),
('user3', 'Roberto Junior', 'roberto.junior@example.com', '(31) 93456-7890', 'aluno', 0, 0),
('user4', 'Alice Oliveira', 'alice.oliveira@example.com', '(41) 94567-8901', 'atletica', 0, 0),
('user5', 'Tiago Dias', 'tiago.dias@example.com', '(51) 95678-9012', 'aluno', 0, 0);

INSERT INTO Aluno (username, nusp)
VALUES
('user1', 12345678),
('user3', 23456789),
('user5', 34567890);

INSERT INTO Atletica (username, nusp, atletica, cnpj, razao_social, nome_fantasia)
VALUES
('user2', 87654321, 'Atlética B', '98.765.432/0001-54', 'Atlética B Associação', 'Atlética B'),
('user4', 56789012, 'Atlética D', '43.210.987/0001-65', 'Atlética D Fundação', 'Atlética D');

INSERT INTO Endereco (username, rua, numero, bairro, cep, complemento)
VALUES
('user1', 'Rua Principal', 101, 'Centro', '12345-678', 'Apto 1A'),
('user2', 'Rua Carvalho', 202, 'Vila Nova', '98765-432', 'Unidade 2B'),
('user3', 'Rua das Flores', 303, 'Jardim América', '54321-098', 'Casa'),
('user4', 'Avenida Pinheiros', 404, 'Zona Leste', '67890-123', 'Condomínio'),
('user5', 'Avenida das Árvores', 505, 'Zona Oeste', '43210-987', 'Sobrado');

INSERT INTO Seguir (username1, username2, data_hora)
VALUES
('user1', 'user2', SYSDATE),
('user2', 'user3', SYSDATE - 2),
('user3', 'user4', SYSDATE - 5),
('user4', 'user5', SYSDATE - 10),
('user5', 'user1', SYSDATE - 15);

INSERT INTO Interacao (username1, username2, data_hora_post, data_hora_interacao, tipo)
VALUES
('user1', 'user2', SYSDATE, SYSDATE, 'comentar'),
('user2', 'user3', SYSDATE - 2, SYSDATE - 2, 'curtir'),
('user3', 'user4', SYSDATE - 5, SYSDATE - 5, 'compartilhar'),
('user4', 'user5', SYSDATE - 10, SYSDATE - 10, 'curtir'),
('user5', 'user1', SYSDATE - 15, SYSDATE - 15, 'compartilhar');

INSERT INTO Comentario (username1, username2, data_hora_post, data_hora_interacao, comentario)
VALUES
('user1', 'user2', SYSDATE, SYSDATE, 'Ótimo evento!'),
('user2', 'user3', SYSDATE - 2, SYSDATE - 2, 'Atividade interessante.'),
('user3', 'user4', SYSDATE - 5, SYSDATE - 5, 'Trabalho incrível!'),
('user4', 'user5', SYSDATE - 10, SYSDATE - 10, 'Parabéns!'),
('user5', 'user1', SYSDATE - 15, SYSDATE - 15, 'Bom trabalho pessoal.');

INSERT INTO Membros_Atletica (username1, username2, data_entrada, data_saida, descricao)
VALUES
('user1', 'user2', SYSDATE - 365, NULL),
('user2', 'user3', SYSDATE - 180, NULL),
('user3', 'user4', SYSDATE - 90, SYSDATE - 30),
('user4', 'user5', SYSDATE - 270, NULL),
('user5', 'user1', SYSDATE - 450, SYSDATE - 180);

INSERT INTO Participacao (username, nome_evento, data)
VALUES
('user1', 'Evento A', SYSDATE - 30),
('user2', 'Evento B', SYSDATE - 60),
('user3', 'Evento C', SYSDATE - 90),
('user4', 'Evento D', SYSDATE - 120),
('user5', 'Evento E', SYSDATE - 150);

INSERT INTO Evento (nome, data, username, descricao, esporte, arquivo)
VALUES
('Evento A', SYSDATE - 30, 'user1', 'Competição esportiva anual', 'Basquete', 'event_a.pdf'),
('Evento B', SYSDATE - 60, 'user2', 'Arrecadação de fundos de caridade', 'Voleibol', 'event_b.jpg'),
('Evento C', SYSDATE - 90, 'user3', 'Reunião da organização estudantil', 'Xadrez', 'event_c.docx'),
('Evento D', SYSDATE - 120, 'user4', 'Viagem de atividade ao ar livre', 'Caminhada', 'event_d.zip'),
('Evento E', SYSDATE - 150, 'user5', 'Evento social do clube', 'Boliche', 'event_e.mp4');

INSERT INTO Trofeu (nome_evento, data_evento, data_trofeu, nome_trofeu, icone)
VALUES
('Evento A', SYSDATE - 30, SYSDATE - 28, 'Trofeu Ouro', 'trophy_a.png'),
('Evento B', SYSDATE - 60, SYSDATE - 58, 'Trofeu Prata', 'trophy_b.svg'),
('Evento C', SYSDATE - 90, SYSDATE - 88, 'Trofeu Bronze', 'trophy_c.jpg'),
('Evento D', SYSDATE - 120, SYSDATE - 118, 'Trofeu Especial', 'trophy_d.ico'),
('Evento E', SYSDATE - 150, SYSDATE - 148, 'Trofeu Confraternização', 'trophy_e.gif');

INSERT INTO Atividade (nome_evento, data_evento, nome_atividade, descricao, esporte, arquivo)
VALUES
('Evento A', SYSDATE - 30, 'Atividade 1', 'Torneio de basquete', 'Basquete', 'activity_a1.jpg'),
('Evento B', SYSDATE - 60, 'Atividade 2', 'Clínica de habilidades de vôlei', 'Voleibol', 'activity_b2.jpg'),
('Evento C', SYSDATE - 90, 'Atividade 3', 'Oficina de xadrez', 'Xadrez', 'activity_c3.jpg'),
('Evento D', SYSDATE - 120, 'Atividade 4', 'Exploração de trilhas de caminhada', 'Caminhada', 'activity_d4.jpg'),
('Evento E', SYSDATE - 150, 'Atividade 5', 'Torneio de boliche', 'Boliche', 'activity_e5.jpg');

INSERT INTO Selo (nome_evento, data_evento, nome_atividade, data_selo, imagem)
VALUES
('Evento A', SYSDATE - 30, 'Atividade 1', SYSDATE - 28, 'selo_a1.png'),
('Evento B', SYSDATE - 60, 'Atividade 2', SYSDATE - 58, 'selo_b2.svg'),
('Evento C', SYSDATE - 90, 'Atividade 3', SYSDATE - 88, 'selo_c3.jpg'),
('Evento D', SYSDATE - 120, 'Atividade 4', SYSDATE - 118, 'selo_d4.ico'),
('Evento E', SYSDATE - 150, 'Atividade 5', SYSDATE - 148, 'selo_e5.gif');

INSERT INTO Post (username, data_hora, descricao, anexo)
VALUES
('user1', SYSDATE - 10, 'Tive um ótimo tempo no evento!', 'photo_a.jpg'),
('user2', SYSDATE - 20, 'Animado para a próxima atividade', NULL),
('user3', SYSDATE - 30, 'Trabalho incrível dos organizadores', 'document_c.docx'),
('user4', SYSDATE - 40, 'Mal posso esperar para ganhar novos selos', 'image_d.png'),
('user5', SYSDATE - 50, 'Ansioso por mais eventos como este!', 'video_e.mp4');