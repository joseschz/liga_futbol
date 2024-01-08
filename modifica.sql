-- 1
SELECT * FROM equipos;
SELECT * FROM partidos;
-- 2
-- Esto cambiara los resultados de las poblaciones en los registros 6,7,8
UPDATE equipos
SET poblacion = 'sustituto' 
WHERE registro IN (6, 7, 8);

-- 3
SELECT * FROM equipos;
SELECT * FROM partidos;

-- 4.1
SELECT registro, nombre, poblacion, anio_fundacion
FROM equipos
WHERE anio_fundacion > 1940;

-- 4.2
SELECT registro, id_equipo1, id_equipo2, 
    ROUND(AVG(resultado_equipo1 + resultado_equipo2), 2) AS media_puntos
FROM partidos
GROUP BY registro, id_equipo1, id_equipo2;

-- 4.3
SELECT nombre,ROUND(AVG(goles)) AS media_goles
FROM (
    SELECT id_equipo1 AS id_equipo, resultado_equipo1 AS goles FROM partidos
    UNION ALL
    SELECT id_equipo2 AS id_equipo, resultado_equipo2 AS goles FROM partidos
) AS goles_equipo
JOIN equipos ON goles_equipo.id_equipo = equipos.registro
GROUP BY nombre
ORDER BY media_goles DESC;

-- 4.4
SELECT e1.nombre AS Equipo1,e2.nombre AS Equipo2,ABS(resultado_equipo1 - resultado_equipo2) AS diferencia_puntos
FROM partidos
JOIN equipos e1 ON partidos.id_equipo1 = e1.registro
JOIN equipos e2 ON partidos.id_equipo2 = e2.registro
ORDER BY diferencia_puntos DESC;

-- 4.5
SELECT nombre, MAX(partidos_ganados) AS max_partidos_ganados
FROM (
    SELECT id_equipo1 AS id_equipo, COUNT(*) AS partidos_ganados FROM partidos WHERE resultado_equipo1 > resultado_equipo2 GROUP BY id_equipo1
    UNION ALL
    SELECT id_equipo2 AS id_equipo, COUNT(*) AS partidos_ganados FROM partidos WHERE resultado_equipo2 > resultado_equipo1 GROUP BY id_equipo2
) AS partidos_ganados_equipo
JOIN equipos ON partidos_ganados_equipo.id_equipo = equipos.registro
GROUP BY nombre
ORDER BY max_partidos_ganados DESC;