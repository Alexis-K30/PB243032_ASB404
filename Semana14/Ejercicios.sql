---- EJERCICIO COMPLEMENTARIO ----
CREATE USER 'king'@'%' IDENTIFIED BY 'Sivar';

GRANT SELECT ON sakila. * TO 
'king'@'%';

GRANT CREATE ON sakila. * TO 
'king'@'%';

GRANT CREATE VIEW ON sakila. * TO
'king'@'%';

FLUSH PRIVILEGES

---- TAREA DE INVESTIGACIÓN ----
CREATE DATABASE gestion_pedidos;

USE gestion_pedidos;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY, 
    nomb_cliente VARCHAR(90) NOT NULL, 
    direccion TEXT NOT NULL, 
    telefono VARCHAR(20) NOT NULL, 
    tipo_cliente VARCHAR(30) NOT NULL
);

CREATE TABLE transporte (
    num_transporte INT AUTO_INCREMENT PRIMARY KEY, 
    nomb_conductor VARCHAR(50) NOT NULL
);

CREATE TABLE ciudad (
    nomb_ciudad VARCHAR(100) PRIMARY KEY, 
    departamento VARCHAR(60) NOT NULL
);

CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY, 
    id_cliente INT NOT NULL, 
    num_transporte INT NOT NULL, 
    peso VARCHAR(50) NOT NULL, 
    destino VARCHAR(100) NOT NULL, 
    fecha_pedido DATE NOT NULL DEFAULT CURDATE()
);

ALTER TABLE pedido
ADD
CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE pedido
ADD
CONSTRAINT fk_transporte FOREIGN KEY (num_transporte) REFERENCES transporte(num_transporte)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE pedido
ADD 
CONSTRAINT fk_destino FOREIGN KEY (destino) REFERENCES ciudad(nomb_ciudad)
ON DELETE CASCADE
ON UPDATE CASCADE;

--Literal 3A
CREATE USER 'primero'@'%' IDENTIFIED BY 'Sivar';

GRANT SELECT, INSERT, UPDATE, DELETE ON gestion_pedidos.cliente TO
'primero'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE ON gestion_pedidos.ciudad TO
'primero'@'%';

FLUSH PRIVILEGES

--Literal 3B
CREATE USER 'segundo'@'%' IDENTIFIED BY '503';

GRANT SELECT ON gestion_pedidos.pedido TO
'segundo'@'%';

FLUSH PRIVILEGES

--Literal 3C
CREATE USER 'tercero'@'%' IDENTIFIED BY 'Sivar503';

GRANT SELECT, UPDATE, INSERT, DELETE ON gestion_pedidos.pedido TO 'tercero'@'%';

GRANT SELECT, UPDATE, INSERT, DELETE ON gestion_pedidos.transporte TO 'tercero'@'%';

FLUSH PRIVILEGES