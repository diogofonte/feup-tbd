-- x scenario:
-- using NOT IN
SELECT xucs.codigo
FROM xocorrencias
LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
WHERE xocorrencias.ano_letivo = '2003/2004' 
AND xucs.codigo NOT IN (
    SELECT DISTINCT xucs.codigo
    FROM xdsd
    LEFT JOIN xtiposaula ON xdsd.ID = xtiposaula.ID
    LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
    LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
    WHERE xocorrencias.ano_letivo = '2003/2004'
)

-- using External Join
SELECT DISTINCT xucs.codigo
FROM xocorrencias
LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
LEFT JOIN (
    SELECT DISTINCT xucs.codigo AS code
    FROM xdsd
    LEFT JOIN xtiposaula ON xdsd.ID = xtiposaula.ID
    LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
    LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
    WHERE xocorrencias.ano_letivo = '2003/2004'
) ON xucs.codigo = code
WHERE xocorrencias.ano_letivo = '2003/2004' and code IS NULL

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- y scenario:
-- using NOT IN
SELECT DISTINCT yucs.codigo
FROM yocorrencias
LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
WHERE yocorrencias.ano_letivo = '2003/2004' 
AND yucs.codigo NOT IN (
    SELECT DISTINCT yucs.codigo
    FROM ydsd
    LEFT JOIN ytiposaula ON ydsd.ID = ytiposaula.ID
    LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
    LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
    WHERE yocorrencias.ano_letivo = '2003/2004'
)

-- using External Join
SELECT DISTINCT yucs.codigo
FROM yocorrencias
LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
LEFT JOIN (
    SELECT DISTINCT yucs.codigo AS code
    FROM ydsd
    LEFT JOIN ytiposaula ON ydsd.ID = ytiposaula.ID
    LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
    LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
    WHERE yocorrencias.ano_letivo = '2003/2004'
) ON yucs.codigo = code
WHERE yocorrencias.ano_letivo = '2003/2004' and code IS NULL

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- z scenario:
-- using NOT IN
SELECT DISTINCT zucs.codigo
FROM zocorrencias
LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
WHERE zocorrencias.ano_letivo = '2003/2004' 
AND zucs.codigo NOT IN (
    SELECT DISTINCT zucs.codigo
    FROM zdsd
    LEFT JOIN ztiposaula ON zdsd.ID = ztiposaula.ID
    LEFT JOIN zocorrencias ON ztiposaula.codigo = zocorrencias.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
    LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
    WHERE zocorrencias.ano_letivo = '2003/2004'
)

-- using External Join
SELECT DISTINCT zucs.codigo
FROM zocorrencias
LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
LEFT JOIN (
    SELECT DISTINCT zucs.codigo AS code
    FROM zdsd
    LEFT JOIN ztiposaula ON zdsd.ID = ztiposaula.ID
    LEFT JOIN zocorrencias ON ztiposaula.codigo = zocorrencias.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
    LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
    WHERE zocorrencias.ano_letivo = '2003/2004'
) ON zucs.codigo = code
WHERE zocorrencias.ano_letivo = '2003/2004' and code IS NULL