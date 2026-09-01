WITH 
    src_movimentacao AS (
        SELECT DATA FROM {{ ref('src_movimentacao') }}
    ),

    data_info AS (
        SELECT 
            DATE_FROM_PARTS(YEAR(MIN(DATA)), 1, 1) AS data_min,
            DATE_FROM_PARTS(YEAR(CURRENT_DATE()), 12, 31) data_max
        FROM src_movimentacao 
    ),

    total_dias AS (
        SELECT DATEDIFF(DAY, data_min, data_max) AS total FROM data_info
    ),

    dias(SEQ) AS (
        SELECT 0 AS SEQ

        UNION ALL

        SELECT SEQ+1 FROM dias
        WHERE SEQ < (SELECT total FROM total_dias)
    ),

    date_spine AS (
        SELECT 
            g.seq AS id_data,
            DATEADD(DAY, g.seq, i.data_min) AS data
        FROM dias g, data_info i
    )

SELECT
    ID_DATA,
    DATA,
    YEAR(DATA) AS ANO,
    MONTH(DATA) AS MES,
    DAY(DATA) AS DIA,
    QUARTER(DATA) AS PERIODO,
    MONTHNAME(DATA) AS NOME_MES,
    DAYNAME(DATA) AS DIA_SEMANA
FROM date_spine