/*-----------------PROCEDIMIENTO-------------*/

--Ejercicio 1
DELIMITER $$

CREATE TRIGGER after_update_film
AFTER UPDATE ON film
FOR EACH ROW
BEGIN
	INSERT INTO film_update_log(film_id, update_date)
    VALUES(
        NEW.film_id, 
        CURDATE());
END$$

--Ejercicio 2
DELIMITER $$

CREATE TRIGGER before_insert_film
BEFORE INSERT ON film
FOR EACH ROW
BEGIN
	IF NEW.rental_rate < 0 THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'rental_rate no puede ser negativo';
    END IF;
END$$

--Ejercicio 3
DELIMITER $$

CREATE TRIGGER update_date_customer
BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
    SET NEW.last_update = NOW();
END$$

/*-----------------EJERCICIO COMPLEMENTARIO-------------*/

--Ejercicio 1
DELIMITER $$

CREATE TRIGGER insert_payment
AFTER INSERT ON payment
FOR EACH ROW
BEGIN
	INSERT INTO payment_audit(payment_id, customer_id, amount, audit_date)
    VALUES(NEW.payment_id, NEW.customer_id, NEW.amount, CURDATE());
END$$

/*-----------------ANÁLISIS DE RESULTADOS-------------*/

--Ejercicio 1
CREATE DATABASE clinica;
USE clinica;

CREATE TABLE pacientes(
    id_paciente INT AUTO_INCREMENT() PRIMARY KEY, 
    nombre VARCHAR(60), 
    correo VARCHAR(100), 
    fecha_nac DATE
);

CREATE TABLE medicos(
    id_medico INT AUTO_INCREMENT() PRIMARY KEY, 
    nombre VARCHAR(60), 
    especialidad VARCHAR(50)
);

CREATE TABLE citas_medicas(
    id_cita INT AUTO_INCREMENT() PRIMARY KEY, 
    id_paciente INT, 
    id_medico INT, 
    fecha_cita DATE DEFAULT CURDATE(), 
    hora_cita TIME DEFAULT CURTIME(), 
    estado_cita TINYINT(1) DEFAULT 1
);

ALTER TABLE citas_medicas
ADD
CONSTRAINT fk_paciente FOREIGN KEY id_paciente REFERENCES pacientes(id_paciente)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE citas_medicas
ADD
CONSTRAINT fk_medico FOREIGN KEY id_medico REFERENCES medicos(id_medico)
ON UPDATE CASCADE
ON DELETE CASCADE;

CREATE TABLE audit_citas(
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    Id_cita INT, 
    tipo_operacion VARCHAR(20), 
    fecha_operacion DATE, 
    user_activity VARCHAR(40)
);

DELIMITER $$

CREATE TRIGGER inserta_cita
AFTER INSERT ON citas_medicas
FOR EACH ROW 
BEGIN
	INSERT INTO audit_citas(Id_cita, tipo_operacion, fecha_operacion, user_activity)
    VALUES(
        NEW.id_cita, 
        "INSERCION", 
        CURDATE(), 
        USER()
    );
END$$

DELIMITER $$

CREATE TRIGGER actualizar_cita
AFTER UPDATE ON citas_medicas
FOR EACH ROW 
BEGIN
	INSERT INTO audit_citas(Id_cita, tipo_operacion, fecha_operacion, user_activity)
    VALUES(
        NEW.id_cita, 
        "ACTUALIZACION", 
        CURDATE(), 
        USER()
    );
END$$