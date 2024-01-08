create database liga_futbol;
use liga_futbol;
CREATE TABLE equipos(
    registro int NOT NULL AUTO_INCREMENT,
    nombre varchar(30) UNIQUE,
    nombre_entrenador varchar(35),
    nombre_campo_futbol varchar(30),
    poblacion varchar(25),
    anio_fundacion int(4),
    anotaciones blob,
    PRIMARY KEY (registro)
);
CREATE TABLE partidos(
    registro int NOT NULL AUTO_INCREMENT,
    id_equipo1 int,
    resultado_equipo1 int,
    id_equipo2 int,
    resultado_equipo2 int,
    PRIMARY KEY (registro)
    FOREIGN KEY (id_equipo1) REFERENCES equipos(registro),
    FOREIGN KEY (id_equipo2) REFERENCES equipos(registro)
);

INSERT INTO equipos (nombre, nombre_entrenador, nombre_campo_futbol, poblacion, anio_fundacion, anotaciones) VALUES
('Real Madrid', 'Carlo Ancelotti', 'Santiago Bernabéu', 'Madrid', 1902, 'Anotaciones sobre el equipo1'),
('FC Barcelona', 'Ronald Koeman', 'Camp Nou', 'Barcelona', 1899, 'Anotaciones sobre el equipo2'),
('Atlético de Madrid', 'Diego Simeone', 'Wanda Metropolitano', 'Madrid', 1903, 'Anotaciones sobre el equipo3'),
('Sevilla FC', 'Julen Lopetegui', 'Ramón SánchezPizjuán', 'Sevilla', 1890, 'Anotaciones sobre el equipo4'),
('Valencia CF', 'Javi Gracia', 'Mestalla', 'Valencia', 1919, 'Anotaciones sobre el equipo5'),
('Real Betis', 'Manuel Pellegrini', 'Benito Villamarín', 'Sevilla', 1907, 'Anotaciones sobre el equipo6'),
('Athletic Club', 'Marcelino García Toral', 'San Mamés', 'Bilbao', 1898, 'Anotaciones sobre el equipo7'),
('Real Sociedad', 'Imanol Alguacil', 'Anoeta', 'San Sebastián', 1909, 'Anotaciones sobre el equipo8');

INSERT INTO partidos (id_equipo1, resultado_equipo1, id_equipo2, resultado_equipo2) VALUES
(1, 2, 2, 1),
(3, 3, 4, 0),
(5, 1, 6, 1),
(7, 2, 8, 2),
(2, 4, 3, 2),
(4, 0, 1, 3),
(6, 1, 7, 1),
(8, 3, 5, 0);
-- 1
SELECT * FROM equipos ;
-- 2
SELECT * FROM equipos WHERE poblacion LIKE 'Madrid';
-- 3
SELECT nombre ,poblacion,anotaciones FROM equipos WHERE nombre LIKE 'B%'; -- no hay registros con campo B
-- 4
SELECT poblacion, COUNT(*) AS num_equipos
FROM equipos
GROUP BY poblacion
ORDER BY num_equipos DESC;
-- 5
SELECT anio_fundacion
FROM equipos
ORDER BY anio_fundacion ASC -- ordena ascendente  
LIMIT 1; -- LIMIT DEVUELVE EL VALOR DE LA PRIMERA FILA POR LO CUAL DEVUELVE SOLA 1
-- 6
SELECT e1.nombre AS equipo1, e2.nombre AS equipo2, p.resultado_equipo1, p.resultado_equipo2
FROM partidos p
JOIN equipos e1 ON p.id_equipo1 = e1.registro
JOIN equipos e2 ON p.id_equipo2 = e2.registro
ORDER BY equipo1;
-- 7
SELECT equipo, SUM(num_partidos) AS total_partidos_jugados
FROM (
    SELECT e.nombre AS equipo, COUNT(*) AS num_partidos
    FROM partidos p
    JOIN equipos e ON p.id_equipo1 = e.registro
    GROUP BY equipo
    UNION ALL
    SELECT e.nombre AS equipo, COUNT(*) AS num_partidos
    FROM partidos p
    JOIN equipos e ON p.id_equipo2 = e.registro
    GROUP BY equipo
) AS partidos_equipo
GROUP BY equipo
ORDER BY total_partidos_jugados DESC;