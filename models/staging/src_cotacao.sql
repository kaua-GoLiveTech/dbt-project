WITH raw_cotacao AS (
    SELECT * FROM {{ source('confine', 'r_cotacao') }}
)
SELECT 
    TIPOTITULO AS tipo_titulo,
    TO_DATE(DATAVENCIMENTO, 'DD/MM/YYYY') AS data_vencimento,
    TO_DATE(DATABASE, 'DD/MM/YYYY') as data_base,
    TO_NUMBER(REPLACE(REPLACE(TAXACOMPRAMANHA, '.', ''), ',', '.'), 38, 2) AS taxa_compra,
    TO_NUMBER(REPLACE(REPLACE(TAXAVENDAMANHA, '.', ''), ',', '.'), 38, 2) AS taxa_venda,
    TO_NUMBER(REPLACE(REPLACE(PUCOMPRAMANHA, '.', ''), ',', '.'), 38, 2) AS pu_compra,
    TO_NUMBER(REPLACE(REPLACE(PUVENDAMANHA, '.', ''), ',', '.'), 38, 2) AS pu_venda,
    TO_NUMBER(REPLACE(REPLACE(PUBASEMANHA, '.', ''), ',', '.'), 38, 2) AS pu_base
FROM raw_cotacao