-- x scenario: 

SELECT xucs.codigo, xucs.designacao, xocorrencias.ano_letivo, xocorrencias.inscritos, xtiposaula.tipo, xtiposaula.turnos
FROM xtiposaula
LEFT JOIN xocorrencias ON xtiposaula.codigo = xocorrencias.codigo AND xtiposaula.ano_letivo = xocorrencias.ano_letivo AND xtiposaula.periodo = xocorrencias.periodo
LEFT JOIN xucs ON xocorrencias.codigo = xucs.codigo
WHERE xucs.curso = 275 AND xucs.designacao = 'Bases de Dados'

-- y scenario:

SELECT yucs.codigo, yucs.designacao, yocorrencias.ano_letivo, yocorrencias.inscritos, ytiposaula.tipo, ytiposaula.turnos
FROM ytiposaula
LEFT JOIN yocorrencias ON ytiposaula.codigo = yocorrencias.codigo AND ytiposaula.ano_letivo = yocorrencias.ano_letivo AND ytiposaula.periodo = yocorrencias.periodo
LEFT JOIN yucs ON yocorrencias.codigo = yucs.codigo
WHERE yucs.curso = 275 AND yucs.designacao = 'Bases de Dados'

-- z scenario:

SELECT zucs.codigo, zucs.designacao, zocorrencias.ano_letivo, zocorrencias.inscritos, ztiposaula.tipo, ztiposaula.turnos
FROM ztiposaula
LEFT JOIN zocorrencias ON ztiposaula.codigo = zocorrencias.codigo AND ztiposaula.ano_letivo = zocorrencias.ano_letivo AND ztiposaula.periodo = zocorrencias.periodo
LEFT JOIN zucs ON zocorrencias.codigo = zucs.codigo
WHERE zucs.curso = 275 AND zucs.designacao = 'Bases de Dados'
