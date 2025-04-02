-- Literal A de Analisis. Creacion del procedimiento
DELIMITER $$

CREATE PROCEDURE GetCustomerEmail(
    IN customerId INT, 
    OUT correo VARCHAR(100)
)
BEGIN
	SELECT email FROM customer WHERE customer_id = customerId;
    SET correo = email;
END $$
-- Llamada al procedimeinto
SET @correo = " ";

CALL GetCustomerEmail(30, @correo);

SELECT @correo;



-- Literal B de Analisis. Creacion del procedimiento
DELIMITER $$

CREATE PROCEDURE CountCustomer(
	OUT TotalCustomers INT
)
BEGIN
	SELECT COUNT(*) AS TotalCus FROM customer;
    SET TotalCustomers = TotalCus;
END $$
--Llamada del procedimiento
SET @total = 0;

CALL CountCustomer(@total);

SELECT @total;



--Literal C de Analisis. Creacion del procedimiento
DELIMITER $$

CREATE PROCEDURE UpdateCustomerEmail(
    IN customerId INT, 
    IN newEmail VARCHAR(100)
)
BEGIN
	UPDATE customer
    SET email = newEmail
    WHERE customer_id = customerId;
END $$
--Llamada al procedimiento
SET @newCorreo = "Hola.mundo@gmail.com";

CALL UpdateCustomerEmail(26, @newCorreo);