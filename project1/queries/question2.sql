-- x scenario: 

SELECT SUM(xdsd.horas) AS Horas, xtiposaula.tipo
--SELECT xdsd.horas, xtiposaula.tipo, xocorrencias.codigo, xocorrencias.ano_letivo, xocorrencias.periodo, xucs.curso
FROM xdsd
LEFT JOIN xtiposaula ON xdsd.ID = xtiposaula.ID
LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
WHERE xucs.curso = 233 AND xocorrencias.ano_letivo = '2004/2005'
GROUP BY xtiposaula.tipo

-- y scenario: 

SELECT SUM(ydsd.horas) AS Horas, ytiposaula.tipo
--SELECT ydsd.horas, ytiposaula.tipo, yocorrencias.codigo, yocorrencias.ano_letivo, yocorrencias.periodo, xucs.curso
FROM ydsd
LEFT JOIN ytiposaula ON ydsd.ID = ytiposaula.ID
LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
WHERE yucs.curso = 233 AND yocorrencias.ano_letivo = '2004/2005'
GROUP BY ytiposaula.tipo

-- z scenario:

SELECT SUM(zdsd.horas) AS Horas, ztiposaula.tipo
--SELECT zdsd.horas, ztiposaula.tipo, zocorrencias.codigo, zocorrencias.ano_letivo, zocorrencias.periodo, zucs.curso
FROM zdsd
LEFT JOIN ztiposaula ON zdsd.ID = ztiposaula.ID
LEFT JOIN zocorrencias ON ztiposaula.codigo = zocorrencias.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
WHERE zucs.curso = 233 AND zocorrencias.ano_letivo = '2004/2005'
GROUP BY ztiposaula.tipo