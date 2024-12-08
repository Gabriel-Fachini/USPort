from typing import Dict
from app.database import get_connection, ConexaoErro
from asyncio import run
from colorama import init

# Inicializa o colorama
init(autoreset=True)

async def listar_estatisticas() -> Dict:
    """
    Lista estatísticas gerais do sistema.
    
    Returns:
      Dict: Resposta com status e estatísticas
    """
    try:
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute('''
                    WITH interacoes_por_usuario AS (
                    SELECT 
                      username1,
                      COUNT(*) AS total_interacoes,
                      SUM(CASE WHEN tipo = 'curtir' THEN 1 ELSE 0 END) AS curtidas,
                      SUM(CASE WHEN tipo = 'compartilhar' THEN 1 ELSE 0 END) AS compartilhamentos,
                      SUM(CASE WHEN tipo = 'comentar' THEN 1 ELSE 0 END) AS comentarios
                    FROM 
                      interacao
                    GROUP BY 
                      username1
                  ),
                  comentarios_por_usuario AS (
                    SELECT 
                      username1,
                      COUNT(*) AS total_comentarios
                    FROM 
                      Comentario
                    GROUP BY 
                      username1
                  )
                  SELECT 
                    u.username,
                    u.nome,
                    u.tipo,
                    COALESCE(i.total_interacoes, 0) AS total_interacoes,
                    COALESCE(i.curtidas, 0) AS curtidas,
                    COALESCE(i.compartilhamentos, 0) AS compartilhamentos,
                    COALESCE(i.comentarios, 0) AS comentarios,
                    COALESCE(c.total_comentarios, 0) AS total_comentarios
                  FROM 
                    usuario u
                  LEFT JOIN 
                    interacoes_por_usuario i ON u.username = i.username1
                  LEFT JOIN 
                    comentarios_por_usuario c ON u.username = c.username1
                  ORDER BY 
                    total_interacoes DESC, total_comentarios DESC;
                ''')
                
                estatisticas = cursor.fetchall()
                
                # Formatar os resultados
                estatisticas_formatadas = []
                for estatistica in estatisticas:
                    estatisticas_formatadas.append({
                        "username": estatistica[0],
                        "nome": estatistica[1],
                        "tipo": estatistica[2],
                        "total_interacoes": estatistica[3],
                        "curtidas": estatistica[4],
                        "compartilhamentos": estatistica[5],
                        "comentarios": estatistica[6],
                        "total_comentarios": estatistica[7]
                    })
                
                return {
                    "status": "success",
                    "data": estatisticas_formatadas
                }

    except ConexaoErro as ce:
        raise ce
    except Exception as e:
        raise e