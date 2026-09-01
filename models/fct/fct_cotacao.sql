WITH 
    src_cotacao AS (
        SELECT * FROM {{ ref('src_cotacao') }}
    ),

    dim_data AS (
        SELECT ID_DATA, DATA FROM {{ ref('dim_data') }}
    ),

    dim_titulo AS (
        SELECT * FROM {{ ref('dim_titulo') }}
    )

SELECT 
    t.ID_TITULO, 
    d.ID_DATA,
    s.PU_COMPRA AS VALOR
FROM src_cotacao s
INNER JOIN dim_data d 
    ON d.DATA = s.DATA_BASE
LEFT JOIN dim_titulo t
    ON t.VENCIMENTO = YEAR(s.DATA_VENCIMENTO)
    AND UPPER(t.TITULO) = UPPER(s.TIPO_TITULO)