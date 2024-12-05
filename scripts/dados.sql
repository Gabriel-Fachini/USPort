INSERT INTO Usuario (username, nome, email, telefone, rua, numero, bairro, cep, complemento, referencia)
VALUES
('user1', 'João Silva', 'joao.silva@example.com', '(11) 91234-5678', 'Rua Principal', '101', 'Centro', '12345-678', 'Apto 1A', 'Próximo ao parque'),
('user2', 'Maria Santos', 'maria.santos@example.com', '(21) 92345-6789', 'Rua Carvalho', '202', 'Vila Nova', '98765-432', 'Unidade 2B', 'Perto do supermercado'),
('user3', 'Roberto Junior', 'roberto.junior@example.com', '(31) 93456-7890', 'Rua das Flores', '303', 'Jardim América', '54321-098', 'Casa', 'Em frente à biblioteca'),
('user4', 'Alice Oliveira', 'alice.oliveira@example.com', '(41) 94567-8901', 'Avenida Pinheiros', '404', 'Zona Leste', '67890-123', 'Condomínio', 'Próximo ao ponto de ônibus'),
('user5', 'Tiago Dias', 'tiago.dias@example.com', '(51) 95678-9012', 'Avenida das Árvores', '505', 'Zona Oeste', '43210-987', 'Sobrado', 'Ao lado do parque');

INSERT INTO Aluno (username, nusps, atletica, cnpj, razao_social, nome_fantasia)
VALUES
('user1', 'A123456', 'Atlética A', '12.345.678/0001-90', 'Atlética A Ltda', 'Atlética A'),
('user2', 'B987654', 'Atlética B', '98.765.432/0001-54', 'Atlética B Associação', 'Atlética B'),
('user3', 'C456789', 'Atlética C', '56.789.012/0001-21', 'Atlética C Corporação', 'Atlética C'),
('user4', 'D321654', 'Atlética D', '43.210.987/0001-65', 'Atlética D Fundação', 'Atlética D'),
('user5', 'E789456', 'Atlética E', '78.945.612/0001-30', 'Atlética E Instituto', 'Atlética E');

INSERT INTO Interacao_Comentario (username1, username2, data_hora, data_hora_interacao, comentario)
VALUES
('user1', 'user2', SYSDATE, SYSDATE, 'Ótimo evento!'),
('user2', 'user3', SYSDATE - 2, SYSDATE - 2, 'Atividade interessante.'),
('user3', 'user4', SYSDATE - 5, SYSDATE - 5, 'Trabalho incrível!'),
('user4', 'user5', SYSDATE - 10, SYSDATE - 10, 'Parabéns!'),
('user5', 'user1', SYSDATE - 15, SYSDATE - 15, 'Bom trabalho pessoal.');

INSERT INTO Membros_Atletica (username1, username2, data_entrada, data_saida, descricao)
VALUES
('user1', 'user2', SYSDATE - 365, NULL, 'Membro desde o ano passado'),
('user2', 'user3', SYSDATE - 180, NULL, 'Novo membro neste semestre'),
('user3', 'user4', SYSDATE - 90, SYSDATE - 30, 'Renunciou no mês passado'),
('user4', 'user5', SYSDATE - 270, NULL, 'Membro ativo'),
('user5', 'user1', SYSDATE - 450, SYSDATE - 180, 'Ex-membro');

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

INSERT INTO Interacao_Curtir_Compartilhar (username1, username2, data_hora, data_hora_interacao, tipo)
VALUES
('user1', 'user2', SYSDATE, SYSDATE, 'curtir'),
('user2', 'user3', SYSDATE - 1, SYSDATE - 1, 'compartilhar'),
('user3', 'user4', SYSDATE - 3, SYSDATE - 3, 'curtir'),
('user4', 'user5', SYSDATE - 7, SYSDATE - 7, 'compartilhar'),
('user5', 'user1', SYSDATE - 12, SYSDATE - 12, 'curtir');

INSERT INTO Trofeu (nome, data, data_trofeu, icone)
VALUES
('Evento A', SYSDATE - 30, SYSDATE - 28, 'trophy_a.png'),
('Evento B', SYSDATE - 60, SYSDATE - 58, 'trophy_b.svg'),
('Evento C', SYSDATE - 90, SYSDATE - 88, 'trophy_c.jpg'),
('Evento D', SYSDATE - 120, SYSDATE - 118, 'trophy_d.ico'),
('Evento E', SYSDATE - 150, SYSDATE - 148, 'trophy_e.gif');

INSERT INTO Atividade (nome, data, nome_atividade, descricao, esporte, arquivo)
VALUES
('Evento A', SYSDATE - 30, 'Atividade 1', 'Torneio de basquete', 'Basquete', 'activity_a1.pdf'),
('Evento B', SYSDATE - 60, 'Atividade 2', 'Clínica de habilidades de vôlei', 'Voleibol', 'activity_b2.jpg'),
('Evento C', SYSDATE - 90, 'Atividade 3', 'Oficina de xadrez', 'Xadrez', 'activity_c3.docx'),
('Evento D', SYSDATE - 120, 'Atividade 4', 'Exploração de trilhas de caminhada', 'Caminhada', 'activity_d4.zip'),
('Evento E', SYSDATE - 150, 'Atividade 5', 'Torneio de boliche', 'Boliche', 'activity_e5.mp4');

INSERT INTO Selo (nome, data, nome_atividade, data_selo, imagem)
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