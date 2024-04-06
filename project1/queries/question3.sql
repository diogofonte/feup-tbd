-- x scenario:
-- using NOT IN
SELECT DISTINCT xocorrencias.codigo
FROM xocorrencias
WHERE xocorrencias.ano_letivo = '2003/2004' 
AND xocorrencias.codigo NOT IN (
    SELECT DISTINCT xocorrencias.codigo
    FROM xdsd
    LEFT JOIN xtiposaula ON xdsd.ID = xtiposaula.ID
    LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
    WHERE xocorrencias.ano_letivo = '2003/2004'
)

-- using External Join
SELECT DISTINCT xocorrencias.codigo
FROM xocorrencias
LEFT JOIN (
    SELECT DISTINCT xocorrencias.codigo AS code
    FROM xdsd
    LEFT JOIN xtiposaula ON xdsd.ID = xtiposaula.ID
    LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
    WHERE xocorrencias.ano_letivo = '2003/2004'
) ON xocorrencias.codigo = code
WHERE xocorrencias.ano_letivo = '2003/2004' and code IS NULL

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- y scenario:
-- Using NOT IN
SELECT DISTINCT yocorrencias.codigo
FROM yocorrencias
WHERE yocorrencias.ano_letivo = '2003/2004' 
AND yocorrencias.codigo NOT IN (
    SELECT DISTINCT yocorrencias.codigo
    FROM ydsd
    LEFT JOIN ytiposaula ON ydsd.ID = ytiposaula.ID
    LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
    WHERE yocorrencias.ano_letivo = '2003/2004'
)

-- Using External Join
SELECT DISTINCT yocorrencias.codigo
FROM yocorrencias
LEFT JOIN (
    SELECT DISTINCT yocorrencias.codigo AS code
    FROM ydsd
    LEFT JOIN ytiposaula ON ydsd.ID = ytiposaula.ID
    LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
    WHERE yocorrencias.ano_letivo = '2003/2004'
) ON yocorrencias.codigo = code
WHERE yocorrencias.ano_letivo = '2003/2004' AND code IS NULL

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- z scenario:
-- Using NOT IN
SELECT DISTINCT zocorrencias.codigo
FROM zocorrencias
WHERE zocorrencias.ano_letivo = '2003/2004' 
AND zocorrencias.codigo NOT IN (
    SELECT DISTINCT zocorrencias.codigo
    FROM zdsd
    LEFT JOIN ztiposaula ON zdsd.ID = ztiposaula.ID
    LEFT JOIN zocorrencias ON ztiposaula.codigo = zocorrencias.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
    WHERE zocorrencias.ano_letivo = '2003/2004'
)

-- Using External Join
SELECT DISTINCT zocorrencias.codigo
FROM zocorrencias
LEFT JOIN (
    SELECT DISTINCT zocorrencias.codigo AS code
    FROM zdsd
    LEFT JOIN ztiposaula ON zdsd.ID = ztiposaula.ID
    LEFT JOIN zocorrencias ON ztiposaula.codigo = zocorrencias.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
    WHERE zocorrencias.ano_letivo = '2003/2004'
) ON zocorrencias.codigo = code
WHERE zocorrencias.ano_letivo = '2003/2004' AND code IS NULL
