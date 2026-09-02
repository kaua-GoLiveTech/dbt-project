WITH src_movimentacao AS (
    SELECT * FROM {{ source('confine', 'r_movimentacao') }}
)

SELECT 
    ENTRADASAIDA AS TIPO_OPERACAO,
    TO_DATE(DATA, 'DD/MM/YYYY') AS DATA,
    MOVIMENTACAO,
    PRODUTO,
    INSTITUICAO,
    TO_NUMBER(REPLACE(REPLACE(QUANTIDADE, '.', ''), ',', '.'), 38, 2) AS QUANTIDADE,
    TO_NUMBER(REPLACE(REPLACE(REPLACE(PRECOUNITARIO, 'R$', ''), '.', ''), ',', '.'), 38, 2) AS PRECO_UNITARIO,
    TO_NUMBER(REPLACE(REPLACE(REPLACE(VALOROPERACAO, 'R$', ''), '.', ''), ',', '.'), 38, 2) AS VALOR_OPERACAO,
FROM src_movimentacao