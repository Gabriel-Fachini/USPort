-- Consulta para obter os posts mais recentes dos usuários que um determinado usuário segue:
SELECT p.username, p.data_hora, p.descricao, p.anexo
FROM Post p
JOIN Seguir s ON p.username = s.username2
WHERE s.username1 = 'user1'
ORDER BY p.data_hora DESC
LIMIT 10;

-- Consulta para listar os eventos em que um usuário participou junto com os troféus ganhos nesses eventos:
-- SELECT e.nome, e.data, t.nome_trofeu, t.data_trofeu
-- FROM Participacao p
-- JOIN Evento e ON p.nome_evento = e.nome AND p.data = e.data
-- JOIN Trofeu t ON e.nome = t.nome_evento AND e.data = t.data_evento
-- WHERE p.username = 'user1';

-- Listar numero de participantes de um evento
SELECT
e.nome,
count(distinct(p.username))
from evento e
join participacao p on e.nome = p.nome_evento
where ativo = 1
and e.nome= 'nome_do_evento'
group by 1

-- Consulta para obter a lista de usuários que participaram de todos os eventos em que um determinado usuário participou:
SELECT u.username, u.nome
FROM Usuario u
WHERE NOT EXISTS (
  SELECT 1
  FROM Participacao p1
  WHERE p1.username = 'user1'
  AND NOT EXISTS (
    SELECT 1
    FROM Participacao p2
    WHERE p2.username = u.username
    AND p2.nome_evento = p1.nome_evento
    AND p2.data = p1.data
  )
);

-- Consulta para obter a lista de eventos e atividades em que um usuário participou, incluindo detalhes dos troféus e selos ganhos:
SELECT e.nome AS evento, e.data AS data_evento, a.nome_atividade, a.descricao AS descricao_atividade, 
       t.nome_trofeu, t.data_trofeu, s.nome_atividade AS atividade_selo, s.data_selo, s.imagem AS imagem_selo
FROM Participacao p
JOIN Evento e ON p.nome_evento = e.nome AND p.data = e.data
LEFT JOIN Atividade a ON e.nome = a.nome_evento AND e.data = a.data_evento
LEFT JOIN Trofeu t ON e.nome = t.nome_evento AND e.data = t.data_evento
LEFT JOIN Selo s ON a.nome_atividade = s.nome_atividade AND a.data_evento = s.data_evento
WHERE p.username = 'user1';

-- Consulta com divisão relacional para encontrar usuários que participaram de todos os eventos que um determinado usuário participou:
SELECT u.username, u.nome
FROM Usuario u
WHERE NOT EXISTS (
  SELECT 1
  FROM Participacao p1
  WHERE p1.username = 'user1'
  AND NOT EXISTS (
    SELECT 1
    FROM Participacao p2
    WHERE p2.username = u.username
    AND p2.nome_evento = p1.nome_evento
    AND p2.data = p1.data
  )
);