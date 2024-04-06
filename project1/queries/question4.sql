-- x scenario: 

SELECT MAX(Horas) AS Horas, MAX(NumeroProfessor) AS NumeroProfessor, MAX(NomeProfessor) AS NomeProfessor, Tipo
FROM (
    SELECT SUM(xdsd.horas) * xdsd.fator AS Horas, xtiposaula.tipo AS Tipo, xdocentes.NR AS NumeroProfessor, xdocentes.nome AS NomeProfessor
    FROM xdsd
    LEFT JOIN xtiposaula ON xdsd.ID = xtiposaula.ID
    LEFT JOIN xdocentes ON xdsd.NR = xdocentes.NR
    WHERE xtiposaula.ano_letivo = '2003/2004' AND xdsd.horas IS NOT NULL AND xdsd.fator IS NOT NULL
    GROUP BY xdsd.fator, xtiposaula.tipo, xdocentes.NR, xdocentes.nome
    ORDER BY Horas DESC
)
GROUP BY Tipo

-- y scenario:

SELECT MAX(Horas) AS Horas, MAX(NumeroProfessor) AS NumeroProfessor, MAX(NomeProfessor) AS NomeProfessor, Tipo
FROM (
    SELECT SUM(ydsd.horas) * ydsd.fator AS Horas, ytiposaula.tipo AS Tipo, ydocentes.NR AS NumeroProfessor, ydocentes.nome AS NomeProfessor
    FROM ydsd
    LEFT JOIN ytiposaula ON ydsd.ID = ytiposaula.ID
    LEFT JOIN ydocentes ON ydsd.NR = ydocentes.NR
    WHERE ytiposaula.ano_letivo = '2003/2004' AND ydsd.horas IS NOT NULL AND ydsd.fator IS NOT NULL
    GROUP BY ydsd.fator, ytiposaula.tipo, ydocentes.NR, ydocentes.nome
    ORDER BY Horas DESC
)
GROUP BY Tipo

-- z scenario:

SELECT MAX(Horas) AS Horas, MAX(NumeroProfessor) AS NumeroProfessor, MAX(NomeProfessor) AS NomeProfessor, Tipo
FROM (
    SELECT SUM(zdsd.horas) * zdsd.fator AS Horas, ztiposaula.tipo AS Tipo, zdocentes.NR AS NumeroProfessor, zdocentes.nome AS NomeProfessor
    FROM zdsd
    LEFT JOIN ztiposaula ON zdsd.ID = ztiposaula.ID
    LEFT JOIN zdocentes ON zdsd.NR = zdocentes.NR
    WHERE ztiposaula.ano_letivo = '2003/2004' AND zdsd.horas IS NOT NULL AND zdsd.fator IS NOT NULL
    GROUP BY zdsd.fator, ztiposaula.tipo, zdocentes.NR, zdocentes.nome
    ORDER BY Horas DESC
)
GROUP BY Tipo