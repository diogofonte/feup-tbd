-- Compare the two execution plans and index sizes for the query
-- B-tree index on the columns "TIPO" and "ANO_LETIVO" of the table "ZTIPOSAULA"
-- Bitmap index on the columns "TIPO" and "ANO_LETIVO" of the table "ZTIPOSAULA"

SELECT ztiposaula.codigo, ztiposaula.ano_letivo, ztiposaula.periodo, ztiposaula.horas_turno
FROM ztiposaula
WHERE ztiposaula.tipo = 'OT' AND (ztiposaula.ano_letivo = '2002/2003' OR ztiposaula.ano_letivo = '2003/2004')