WITH src_cotacao AS (
    SELECT DISTINCT 
        tipo_titulo AS TITULO, 
        YEAR(DATA_VENCIMENTO) AS ANO 
    FROM {{ ref('src_cotacao') }}
)

SELECT 
    ROW_NUMBER() OVER (ORDER BY TITULO) AS ID_TITULO,
    TITULO,
    ANO AS VENCIMENTO
FROM src_cotacao