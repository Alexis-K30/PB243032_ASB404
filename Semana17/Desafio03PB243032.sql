------------------------------ PUNTO 1 ------------------------------

--------------- LITERAL A

CREATE DATABASE Veterinaria;

USE Veterinaria;

CREATE TABLE Mascotas(
    id_mascota INT AUTO_INCREMENT PRIMARY KEY, 
    especie VARCHAR(70) NOT NULL, 
    raza VARCHAR(70) NOT NULL, 
    edad TINYINT UNSIGNED NOT NULL, 
    estado_salud VARCHAR(50) NOT NULL, 
    estado_adopcion VARCHAR(60) NOT NULL
);

CREATE TABLE Adoptantes(
    dui CHAR(10) PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    edad TINYINT UNSIGNED NOT NULL, 
    direccion VARCHAR(80) NOT NULL
);

CREATE TABLE Empleados(
    id_empleado INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL, 
    dui CHAR(10) NOT NULL UNIQUE,
    edad TINYINT UNSIGNED NOT NULL,
    puesto VARCHAR(30) NOT NULL, 
    jefe_superior INT NOT NULL,
    CONSTRAINT fk_jefe FOREIGN KEY (jefe_superior) REFERENCES empleados(id_empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Adopciones(
    id_adopcion INT AUTO_INCREMENT PRIMARY KEY,
    id_mascota INT NOT NULL UNIQUE, 
    dui_adoptante CHAR(10) NOT NULL, 
    id_empleado INT NOT NULL,
    fecha_adopcion DATE NOT NULL,
    CONSTRAINT fk_mascotas FOREIGN KEY (id_mascota) REFERENCES Mascotas(id_mascota)
    ON DELETE CASCADE
    ON UPDATE CASCADE, 
    CONSTRAINT fk_adoptante FOREIGN KEY (dui_adoptante) REFERENCES Adoptantes(dui)
    ON DELETE CASCADE
    ON UPDATE CASCADE, 
    CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Controles_PostAdopcion(
    id_control INT AUTO_INCREMENT PRIMARY KEY, 
    id_adopcion INT NOT NULL UNIQUE, 
    sanidad CHAR(2) NOT NULL, 
    ambiente_sano CHAR(2) NOT NULL, 
    visitas_periodicas CHAR(2) NOT NULL, 
    alimentacion_adecuada CHAR(2) NOT NULL, 
    revisiones_medicas CHAR(2) NOT NULL, 
    estado_exitoso CHAR(2) NOT NULL, 
    CONSTRAINT fk_adopcion FOREIGN KEY (id_adopcion) REFERENCES adopciones(id_adopcion)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



------------------------------ PUNTO 2 ------------------------------

--------------- LITERAL A

INSERT INTO Mascotas (especie, raza, edad, estado_salud, estado_adopcion) VALUES
('Perro', 'Border Collie', 3, 'Saludable', 'No adoptado'),
('Gato', 'Abisinio', 2, 'Saludable', 'Adoptado'),
('Conejo', 'Angora Inglés', 1, 'En tratamiento', 'No adoptado'),
('Loro', 'Amazonas de frente azul', 5, 'Saludable', 'Adoptado'),
('Tortuga', 'Tortuga de orejas rojas', 12, 'Saludable', 'No adoptado'),
('Pez', 'Betta Splendens', 1, 'Saludable', 'No adoptado'),
('Hámster', 'Roborowski', 1, 'Saludable', 'Adoptado'),
('Perico', 'Australiano', 2, 'Saludable', 'Adoptado'),
('Erizo', 'Erizo pigmeo africano', 3, 'En tratamiento', 'No adoptado'),
('Gato', 'Himalayo', 4, 'Saludable', 'Adoptado'),
('Iguana', 'Iguana verde', 6, 'Con problemas crónicos', 'No adoptado'),
('Hurón', 'Hurón estándar', 2, 'Saludable', 'Adoptado'),
('Cuy', 'Cuy abisinio', 2, 'Saludable', 'Adoptado'),
('Pez', 'Goldfish', 2, 'Saludable', 'No adoptado'),
('Perro', 'Shih Tzu', 4, 'Saludable', 'Adoptado'),
('Gato', 'Oriental de pelo corto', 3, 'En tratamiento', 'No adoptado'),
('Tortuga', 'Tortuga rusa', 8, 'Saludable', 'Adoptado'),
('Ave', 'Canario', 2, 'Saludable', 'Adoptado'),
('Conejo', 'Cabeza de león', 1, 'Con problemas crónicos', 'No adoptado'),
('Hurón', 'Hurón albino', 3, 'Saludable', 'Adoptado');

INSERT INTO Adoptantes (dui, nombre, edad, direccion) VALUES
('78129403-5', 'Carlos Ramírez', 34, 'Colonia Escalón, San Salvador'),
('09231784-2', 'María López', 29, 'Residencial Santa Elena, Antiguo Cuscatlán'),
('61478392-7', 'Luis Torres', 41, 'Centro de San Miguel, San Miguel'),
('34718265-1', 'Sofía Martínez', 25, 'Colonia Miramonte, San Salvador'),
('23847109-9', 'Javier Castillo', 38, 'Colonia América, Santa Ana'),
('49601723-3', 'Ana Mejía', 31, 'Urbanización Altavista, Ilopango'),
('12039874-4', 'Esteban Pineda', 44, 'Barrio El Centro, Ahuachapán'),
('89372451-0', 'Claudia García', 27, 'Colonia La Sultana, Santa Tecla'),
('58021763-6', 'René Aguilar', 36, 'Reparto Las Cañas, Soyapango'),
('73649185-8', 'Patricia Herrera', 30, 'Residencial San Andrés, Ciudad Delgado');

INSERT INTO Empleados (nombre, dui, edad, puesto, jefe_superior) VALUES
('Dr. Andrés Velásquez', '18392047-5', 62, 'Veterinario en jefe', 1);
INSERT INTO Empleados (nombre, dui, edad, puesto, jefe_superior) VALUES
('Dra. Carolina Gómez', '50918372-1', 47, 'Veterinario', 1),
('Dr. Mario Cárcamo', '79813042-7', 53, 'Veterinario', 1),
('Dra. Silvia Morán', '62184731-9', 44, 'Veterinario', 1),
('Carlos Mendoza', '34019876-2', 39, 'Enfermero', 2),
('Pamela Ruiz', '29014387-0', 41, 'Enfermera', 4),
('Óscar Hernández', '61529873-4', 56, 'Enfermero', 3),
('Ana de López', '90231456-6', 63, 'Administrativo', 1),
('Marcos Rivera', '11293745-9', 59, 'Administrativo', 1),
('Cecilia Sánchez', '78912346-8', 38, 'Administrativo', 1);

INSERT INTO Adopciones (id_mascota, dui_adoptante, id_empleado, fecha_adopcion) VALUES
(42, '09231784-2', 8, '2023-10-15'),
(44, '23847109-9', 9, '2023-11-02'),
(47, '58021763-6', 10, '2023-12-10'),
(48, '12039874-4', 8, '2024-01-05'),
(50, '78129403-5', 9, '2024-02-20'),
(52, '89372451-0', 10, '2024-04-18'),
(53, '58021763-6', 8, '2024-06-07'),
(55, '73649185-8', 9, '2024-09-25'),
(57, '49601723-3', 10, '2025-01-13'),
(58, '78129403-5', 8, '2025-03-22');

INSERT INTO Controles_PostAdopcion (
    id_adopcion, sanidad, ambiente_sano, visitas_periodicas, alimentacion_adecuada, revisiones_medicas, estado_exitoso
) VALUES
(1, 'SI', 'SI', 'SI', 'SI', 'SI', 'SI'),
(2, 'SI', 'SI', 'SI', 'SI', 'SI', 'SI'),
(3, 'SI', 'SI', 'SI', 'SI', 'SI', 'SI'),
(4, 'SI', 'SI', 'SI', 'SI', 'SI', 'SI'),
(5, 'SI', 'SI', 'SI', 'SI', 'SI', 'SI'),
(6, 'SI', 'NO', 'SI', 'SI', 'SI', 'NO'),
(7, 'NO', 'SI', 'SI', 'SI', 'SI', 'NO'),
(8, 'SI', 'SI', 'NO', 'SI', 'SI', 'NO'),
(9, 'SI', 'SI', 'SI', 'NO', 'SI', 'NO'),
(10, 'SI', 'SI', 'SI', 'SI', 'NO', 'NO');



------------------------------ PUNTO 3 ------------------------------

--------------- LITERAL A
SELECT especie, edad, estado_salud FROM mascotas
WHERE estado_adopcion = 'No adoptado';

--------------- LITERAL B
SELECT a.nombre, GROUP_CONCAT(m.especie SEPARATOR ", ") AS Animales_adoptados, ad.fecha_adopcion
FROM adopciones ad 
INNER JOIN adoptantes a ON ad.dui_adoptante = a.dui
INNER JOIN mascotas m ON ad.id_mascota = m.id_mascota
WHERE a.nombre = 'René Aguilar';

--------------- LITERAL C
--- POR EMPLEADO
SELECT e.nombre AS AdministrativoACargo, c.sanidad, c.ambiente_sano, c.visitas_periodicas, c.alimentacion_adecuada, c.revisiones_medicas, c.estado_exitoso
FROM controles_postadopcion c
INNER JOIN adopciones ad ON c.id_adopcion = ad.id_adopcion
INNER JOIN empleados e ON ad.id_empleado = e.id_empleado;

--- POR MASCOTA
SELECT m.especie AS Animal_adoptado, c.sanidad, c.ambiente_sano, c.visitas_periodicas, c.alimentacion_adecuada, c.revisiones_medicas, c.estado_exitoso
FROM controles_postadopcion c
INNER JOIN adopciones ad ON c.id_adopcion = ad.id_adopcion
INNER JOIN mascotas m ON ad.id_mascota = m.id_mascota;



------------------------------ PUNTO 4 ------------------------------
CREATE VIEW adopciones_hechas AS
SELECT a.nombre, m.especie, m.raza, m.edad, m.estado_salud, m.estado_adopcion, ad.fecha_adopcion
FROM mascotas m
INNER JOIN adopciones ad ON m.id_mascota = ad.id_mascota
INNER JOIN adoptantes a ON ad.dui_adoptante = a.dui;



------------------------------ PUNTO 5 ------------------------------
DELIMITER $$

CREATE PROCEDURE Registro_adopcion(
    IN IdMascota INT, 
    IN DuiAdoptante CHAR(10), 
    IN IdEmpleado INT
)
BEGIN
	INSERT INTO adopciones (id_mascota, dui_adoptante, id_empleado, fecha_adopcion)
    VALUES (IdMascota, DuiAdoptante, IdEmpleado, NOW());
    
    UPDATE mascotas SET estado_adopcion = 'Adoptado' WHERE id_mascota = IdMascota;
END$$

--- ¡¡¡¡¡ESTE EJEMPLO YA FUE UTILIZADO PERO SE DESHICIERON LOS CAMBIOS, ASI QUE LO PUEDE USAR DE PRUEBA!!!!!
SET @IdMascota = 41;
SET @DuiAdoptante = '12039874-4';
SET @IdEmpleado = 10;

CALL Registro_adopcion(@IdMascota, @DuiAdoptante, @IdEmpleado);



------------------------------ PUNTO 6 ------------------------------

--------------- LITERAL A (Se hizo por año ya que tiene mas variedad, ademas que por los meses no se diferenciaría de que año es)
CREATE VIEW adopcionesXYear AS
SELECT 
    YEAR(fecha_adopcion) AS year,
    COUNT(*) AS total_adopciones
FROM adopciones
GROUP BY year
ORDER BY year;

--------------- LITERAL B
CREATE VIEW mascotaMasAdoptada AS
SELECT
	especie, 
    COUNT(especie) AS Tipo
FROM mascotas 
WHERE estado_adopcion = 'Adoptado'
GROUP BY especie;

--------------- LITERAL C
CREATE VIEW estado_actual AS
SELECT 
    estado_adopcion AS estado,
    COUNT(*) AS total_mascotas
FROM Mascotas
GROUP BY estado_adopcion;

--------------- LITERAL D (Se ocupo DAX en PoweBI)