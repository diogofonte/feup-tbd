-- x scenario: 

SELECT xucs.codigo, xucs.designacao, xocorrencias.ano_letivo, xocorrencias.inscritos, xtiposaula.tipo, xtiposaula.turnos
FROM xucs
JOIN xocorrencias ON xocorrencias.codigo = xucs.codigo
JOIN xtiposaula ON xtiposaula.codigo = xucs.codigo
WHERE xucs.curso = 275 AND xucs.designacao = 'Bases de Dados'

-- y scenario:

SELECT yucs.codigo, yucs.designacao, yocorrencias.ano_letivo, yocorrencias.inscritos, ytiposaula.tipo, ytiposaula.turnos
FROM yucs
JOIN yocorrencias ON yocorrencias.codigo = yucs.codigo
JOIN ytiposaula ON ytiposaula.codigo = yucs.codigo
WHERE yucs.curso = 275 AND yucs.designacao = 'Bases de Dados'

-- z scenario:

SELECT zucs.codigo, zucs.designacao, zocorrencias.ano_letivo, zocorrencias.inscritos, ztiposaula.tipo, ztiposaula.turnos
FROM zucs
JOIN zocorrencias ON zocorrencias.codigo = zucs.codigo
JOIN ztiposaula ON ztiposaula.codigo = zucs.codigo
WHERE zucs.curso = 275 AND zucs.designacao = 'Bases de Dados'