-- 1
SELECT nombre,nombre_entrenador,nombre_campo_futbol,poblacion,anio_fundacion 
FROM equipos;

-- 2
SELECT nombre, nombre_entrenador, nombre_campo_futbol, poblacion, anio_fundacion
FROM equipos
WHERE equipos.registro NOT IN ( -- busca donde los id  no están presentes en la lista de identificadores de equipos que han participado en algún partido  
    SELECT DISTINCT id_equipo1 -- Busca id que han participado en los partidos  
    FROM partidos
    UNION
    SELECT DISTINCT id_equipo2
    FROM partidos
);

-- 3 
DELETE equipos
FROM equipos
LEFT JOIN partidos AS p1 ON equipos.registro = p1.id_equipo1
LEFT JOIN partidos AS p2 ON equipos.registro = p2.id_equipo2
WHERE p1.registro IS NULL AND p2.registro IS NULL;
-- 4
SELECT nombre,nombre_entrenador,nombre_campo_futbol,poblacion,anio_fundacion
FROM equipos;

-- 5
DROP TABLE partidos;
DROP TABLE equipos;

-- 6
DROP DATABASE liga_futbol;
