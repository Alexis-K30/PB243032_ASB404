CREATE DATABASE GUIA7;

USE GUIA7;

CREATE TABLE MAQUINA(
    cod_maquina smallint(5) CHECK (cod_maquina > 0),
    descripcion text, 
    marca varchar(12), 
    modelo varchar(15), 
    fechaIngreso date NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_maquina PRIMARY KEY(cod_Maquina)
);

CREATE TABLE EMPLEADO(
    id tinyint(3), 
    nombre varchar(30), 
    apellidos varchar(30), 
    edad tinyint(3), 
    fechaInicio date NOT NULL DEFAULT NOW(), 
    CONSTRAINT pk_id PRIMARY KEY(id)
);

CREATE TABLE BITACORA(
    correlativo tinyint(3), 
    id tinyint(3) UNIQUE, 
    cod_maquina smallint(5) UNIQUE CHECK (cod_maquina > 0), 
    tiempouso tinyint(3), 
    lugar varchar(50), 
    CONSTRAINT pk_correlativo PRIMARY KEY(correlativo)
);

ALTER TABLE BITACORA
ADD
CONSTRAINT fk_idBitacora FOREIGN KEY (id) REFERENCES EMPLEADO(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE BITACORA
ADD
CONSTRAINT fk_codMaquinaBitacora FOREIGN KEY (cod_maquina) REFERENCES MAQUINA(cod_maquina)
ON UPDATE CASCADE
ON DELETE CASCADE;

/*
 * Me di cuenta que el campo del codigo de la maquina tiene una letra por entonces no puede ser int
 * por lo que elimine la llave foranea para poder cambiar el tipo de dato tanto en maquina como en bitacora 😭😭😭
 */

ALTER TABLE BITACORA DROP CONSTRAINT fk_codMaquinaBitacora; 
ALTER TABLE maquina MODIFY cod_maquina varchar(6);
ALTER TABLE bitacora MODIFY cod_maquina varchar(6);

/* Volvemos a crear la llave foranea*/
ALTER TABLE BITACORA
ADD
CONSTRAINT fk_codMaquina FOREIGN KEY (cod_maquina) REFERENCES MAQUINA(cod_maquina)
ON UPDATE CASCADE
ON DELETE CASCADE;

/*
 * Me paso el mismo problema que antes con el id de los empleado 😭😭😭 asi que para cambiar el tipo de dato
 * Vuelvo a eliminar la llave foranea, cambiar el tipo en ambas tablas y crear la FK de nuevo
 */
ALTER TABLE BITACORA DROP CONSTRAINT fk_idBitacora;
ALTER TABLE empleado MODIFY id varchar(10);
ALTER TABLE bitacora MODIFY id varchar(10);

/*
 * Insertando datos en la tabla emplados. Se me fue el enter y añadi tres sin querer en lugar de los 5 de un solo
 * por eso aca solo salen dos personas
 */
 INSERT INTO `empleado` (`id`, `nombre`, `apellidos`, `edad`, `fechaInicio`) 
 VALUES ('89012345-6', 'MIGUEL EDUARDO', 'MORALES CLAROS', '26', '2010-08-21'), 
        ('90123456-7', 'FABRICIO DAVID', 'ALAS FLORES', '30', '2008-12-01');

/* 
 * Insertando datos en la tabla maquinas
 */
 INSERT INTO `maquina` (`cod_maquina`, `descripcion`, `marca`, `modelo`, `fechaIngreso`) 
 VALUES ('M00001', 'TALADORA DE ELEMENTOS VARIOS', 'CATERPILLAR', 'EVO2000', '2006-01-31'), 
        ('M00002', 'APLANADORA DE SUELOS Y OTROS', 'CATERPILLAR', 'FLU5000', '2006-01-31'), 
        ('M00003', 'PULVERIZADORA DE ELEMENTOS', 'CATERPILLAR', 'ASD2001', '2006-01-31'), 
        ('M00004', 'CONCRETERA', 'MG', 'EDS', '2006-05-31'), 
        ('M00005', 'MAQUINA ESPECIAL PARA PROYECTO 10', 'MG', 'SFD', '2006-05-31'), 
        ('M00006', 'MAQUINA ESPECIAL PARA PROYECTO 30', 'MG', 'SFD', '2010-12-01');

/*Lo cambio porque en tiny int solo llega a 127 😭😭*/
ALTER TABLE BITACORA MODIFY tiempouso SMALLINT(3);

/* Borro la llave foraneas porque no me di cuenta (otra vez) que si se van a repetir datos en esta tabla
 * entonces para borrar el bendito UNIQUE que puse al crear la tabla quito la FK y luego la vuelvo a poner
 * lo mismo haré con cod_maquina que tambien le puse UNIQUE*/
ALTER TABLE BITACORA DROP CONSTRAINT fk_idBitacora;
ALTER TABLE BITACORA DROP INDEX id;
ALTER TABLE BITACORA
ADD
CONSTRAINT fk_idBitacora FOREIGN KEY (id) REFERENCES empleado(id)
ON UPDATE CASCADE 
ON DELETE CASCADE
ALTER TABLE BITACORA DROP CONSTRAINT fk_codMaquina
ALTER TABLE BITACORA DROP INDEX cod_maquina;

/*Ahora si agregamos los datos a la tabla bitacora*/
INSERT INTO `bitacora` (`correlativo`, `id`, `cod_maquina`, `tiempouso`, `lugar`) 
VALUES  ('1', '12345678-9', 'M00001', '250', 'SANTIAGO NONUALCO'), 
        ('2', '01234567-8', 'M00002', '300', 'SANTIAGO NONUALCO'), 
        ('3', '90123456-7', 'M00003', '500', 'ALEGRIA, USULUTAN'), 
        ('4', '89012345-6', 'M00004', '300', 'ALEGRIA. USULUTAN'), 
        ('5', '90123456-7', 'M00005', '250', 'SANTIAGO NONUALCO'), 
        ('6', '01234567-8', 'M00002', '125', 'SANTIAGO NONUALCO'), 
        ('7', '12345678-9', 'M00003', '375', 'ALEGRIA, USULUTAN'), 
        ('8', '12345678-9', 'M00004', '200', 'ALEGRIA, USULUTAN');

/* Primera peticion */
SELECT e.nombre, m.marca, m.modelo, m.descripcion
FROM empleado e
INNER JOIN bitacora b ON e.id = b.id
INNER JOIN maquina m ON b.cod_maquina = m.cod_maquina;

/* Seguna peticion */
SELECT e.nombre AS nombres, e.apellidos, m.cod_maquina AS Codigo
FROM empleado e 
LEFT JOIN bitacora b ON e.id = b.id
LEFT JOIN maquina m ON b.cod_maquina = m.cod_maquina WHERE b.cod_maquina IS NULL;

/* Seguna peticion */
SELECT e.nombre AS nombres, e.apellidos, m.descripcion
FROM empleado e 
RIGHT JOIN bitacora b ON e.id = b.id
RIGHT JOIN maquina m ON b.cod_maquina = m.cod_maquina WHERE (e.nombre IS NULL AND e.apellidos IS NULL);