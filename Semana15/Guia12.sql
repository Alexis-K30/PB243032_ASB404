----------- EJERCICIO COMPLEMENTARIO -----------
-- Ingresar Alumnos
DELIMITER $$

CREATE PROCEDURE ingresar_alumnos(
    IN p_nombre VARCHAR(100), 
    IN p_correo VARCHAR(100)
)
BEGIN
	INSERT INTO alumnos(nombre, correo)
    	VALUES (p_nombre, p_correo);
END$$

-- Ingresar clases
DELIMITER $$

CREATE PROCEDURE ingresar_clases(
    IN p_nombre_clase VARCHAR(100)
)
BEGIN
	INSERT INTO clases(nombre_clase)
    	VALUES (p_nombre_clase);
END$$

----------- TAREA DE INVESTIGACION -----------
-- PASO 1
CREATE DATABASE sistema_academico;
USE sistema_academico;

-- PASO 2
CREATE TABLE profesores(
    id_profesor INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100)
);

CREATE TABLE materias(
    id_materia INT AUTO_INCREMENT PRIMARY KEY, 
    nombre_materia VARCHAR(100)
);

CREATE TABLE profesor_materias(
    id_profesor INT,
    id_materia INT, 
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor), 
    FOREIGN KEY (id_materia) REFERENCES materias(id_materias)
);

-- PASO 3, 4 y 5
CREATE USER 'creador'@'localhost' IDENTIFIED BY 'sjrp?Jh$Xf^=uqY!5FU3H*bEn/~>(V;}';
GRANT CREATE ROUTINE ON sistema_academico.* TO 'creador'@'localhost';
GRANT INSERT ON sistema_academico.* TO 'creador'@'localhost';
FLUSH PRIVILEGES

CREATE USER 'ejecutor'@'localhost' IDENTIFIED BY 'V!~:a_PH@S=v,$pwk`7jzBeR;{Wc3"M>';
GRANT EXECUTE ON sistema_academico.* TO 'ejecutor'@'localhost';
GRANT SELECT ON sistema_academico.* TO 'ejecutor'@'localhost';
FLUSH PRIVILEGES

-- Paso 6
SHOW GRANTS FOR 'creador'@'localhost';
SHOW GRANTS FOR 'ejecutor'@'localhost';