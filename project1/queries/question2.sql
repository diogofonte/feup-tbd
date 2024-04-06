-- x scenario: 

SELECT xtiposaula.tipo AS TIPO, SUM(xtiposaula.horas_turno * xtiposaula.turnos) AS HORAS
FROM xtiposaula
LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
WHERE xucs.curso = 233 AND xocorrencias.ano_letivo = '2004/2005'
GROUP BY xtiposaula.tipo;


-- y scenario: 

SELECT ytiposaula.tipo AS TIPO, SUM(ytiposaula.horas_turno * ytiposaula.turnos) AS HORAS
FROM ytiposaula
LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
WHERE yucs.curso = 233 AND yocorrencias.ano_letivo = '2004/2005'
GROUP BY ytiposaula.tipo;

-- z scenario:

SELECT ztiposaula.tipo AS TIPO, SUM(ztiposaula.horas_turno * ztiposaula.turnos) AS HORAS
FROM ztiposaula
LEFT JOIN zocorrencias ON ztiposaula.codigo = yocorrencizocorrenciasas.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
WHERE zucs.curso = 233 AND zocorrencias.ano_letivo = '2004/2005'
GROUP BY ztiposaula.tipo;