-- x scenario:

SELECT Curso
FROM (
    SELECT COUNT(DISTINCT xtiposaula.tipo) AS NumeroTipoAulas, xucs.curso AS Curso
    FROM xtiposaula
    LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
    LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
    GROUP BY xucs.curso
)
WHERE NumeroTipoAulas = (
    SELECT COUNT (DISTINCT xtiposaula.tipo)
    FROM xtiposaula
)

-- y scenario:

SELECT Curso
FROM (
    SELECT COUNT(DISTINCT ytiposaula.tipo) AS NumeroTipoAulas, yucs.curso AS Curso
    FROM ytiposaula
    LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
    LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
    GROUP BY yucs.curso
)
WHERE NumeroTipoAulas = (
    SELECT COUNT (DISTINCT ytiposaula.tipo)
    FROM ytiposaula
)

-- z scenario:

SELECT Curso
FROM (
    SELECT COUNT(DISTINCT ztiposaula.tipo) AS NumeroTipoAulas, zucs.curso AS Curso
    FROM ztiposaula
    LEFT JOIN zocorrencias ON ztiposaula.codigo = zocorrencias.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
    LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
    GROUP BY zucs.curso
)
WHERE NumeroTipoAulas = (
    SELECT COUNT (DISTINCT ztiposaula.tipo)
    FROM ztiposaula
)