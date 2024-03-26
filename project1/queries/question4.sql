-- x scenario: 

SELECT MAX(Horas) AS Horas, MAX(NumeroProfessor) AS NumeroProfessor, MAX(NomeProfessor) AS NomeProfessor, Tipo
FROM (
    SELECT SUM(xdsd.horas) * xdsd.fator AS Horas, xtiposaula.tipo AS Tipo, xdocentes.NR AS NumeroProfessor, xdocentes.nome AS NomeProfessor
    --SELECT xdsd.horas, xtiposaula.tipo, xocorrencias.codigo, xocorrencias.ano_letivo, xocorrencias.periodo, xucs.curso
    FROM xdsd
    LEFT JOIN xtiposaula ON xdsd.ID = xtiposaula.ID
    LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
    LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
    LEFT JOIN xdocentes ON xdsd.NR = xdocentes.NR
    WHERE xocorrencias.ano_letivo = '2003/2004' AND xdsd.horas IS NOT NULL AND xdsd.fator IS NOT NULL
    GROUP BY xdsd.fator, xtiposaula.tipo, xdocentes.NR, xdocentes.nome
    ORDER BY Horas DESC
)
GROUP BY Tipo

-- y scenario:

SELECT MAX(Horas) AS Horas, MAX(NumeroProfessor) AS NumeroProfessor, MAX(NomeProfessor) AS NomeProfessor, Tipo
FROM (
    SELECT SUM(ydsd.horas) * ydsd.fator AS Horas, ytiposaula.tipo AS Tipo, ydocentes.NR AS NumeroProfessor, ydocentes.nome AS NomeProfessor
    --SELECT ydsd.horas, ytiposaula.tipo, yocorrencias.codigo, yocorrencias.ano_letivo, yocorrencias.periodo, yucs.curso
    FROM ydsd
    LEFT JOIN ytiposaula ON ydsd.ID = ytiposaula.ID
    LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
    LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
    LEFT JOIN ydocentes ON ydsd.NR = ydocentes.NR
    WHERE yocorrencias.ano_letivo = '2003/2004' AND ydsd.horas IS NOT NULL AND ydsd.fator IS NOT NULL
    GROUP BY ydsd.fator, ytiposaula.tipo, ydocentes.NR, ydocentes.nome
    ORDER BY Horas DESC
)
GROUP BY Tipo

-- z scenario:

SELECT MAX(Horas) AS Horas, MAX(NumeroProfessor) AS NumeroProfessor, MAX(NomeProfessor) AS NomeProfessor, Tipo
FROM (
    SELECT SUM(zdsd.horas) * zdsd.fator AS Horas, ztiposaula.tipo AS Tipo, zdocentes.NR AS NumeroProfessor, zdocentes.nome AS NomeProfessor
    --SELECT zdsd.horas, ztiposaula.tipo, zocorrencias.codigo, zocorrencias.ano_letivo, zocorrencias.periodo, zucs.curso
    FROM zdsd
    LEFT JOIN ztiposaula ON zdsd.ID = ztiposaula.ID
    LEFT JOIN zocorrencias ON ztiposaula.codigo = zocorrencias.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
    LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
    LEFT JOIN zdocentes ON zdsd.NR = zdocentes.NR
    WHERE zocorrencias.ano_letivo = '2003/2004' AND zdsd.horas IS NOT NULL AND zdsd.fator IS NOT NULL
    GROUP BY zdsd.fator, ztiposaula.tipo, zdocentes.NR, zdocentes.nome
    ORDER BY Horas DESC
)
GROUP BY Tipo