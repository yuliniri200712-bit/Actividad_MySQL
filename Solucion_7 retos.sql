CREATE DATABASE IF NOT EXISTS electrohogar;
USE electrohogar;

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente          INT,
    nombre              VARCHAR(100),
    email               VARCHAR(150),
    ciudad              VARCHAR(60),
    fecha_registro      DATE,
    acepta_promociones  BOOLEAN
);

CREATE TABLE IF NOT EXISTS departamentos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre          VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS empleados (
    id_empleado         INT PRIMARY KEY AUTO_INCREMENT,
    nombre              VARCHAR(100) NOT NULL,
    email               VARCHAR(150) UNIQUE,
    salario             DECIMAL(10,2) CHECK (salario >= 0),
    id_departamento     INT,
    fecha_contratacion  DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_departamento)
        REFERENCES departamentos(id_departamento)
);

CREATE TABLE IF NOT EXISTS productos_prueba (
    id INT,
    nombre VARCHAR(50)
);

DROP TABLE IF EXISTS productos_prueba;

ALTER TABLE clientes
    ADD COLUMN telefono VARCHAR(20);

CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS productos (
    id_producto    INT PRIMARY KEY AUTO_INCREMENT,
    nombre         VARCHAR(100) NOT NULL,
    precio         DECIMAL(10,2) NOT NULL,
    stock          INT NOT NULL DEFAULT 0,
    id_categoria   INT,
    categoria      VARCHAR(50),
    fecha_registro DATE DEFAULT (CURRENT_DATE)
);

INSERT IGNORE INTO productos (id_producto, nombre, precio, stock, categoria)
VALUES
(310, 'Licuadora Potente Smart 700W', 45.90, 20, 'Electrodomésticos'),
(118, 'Radio Reloj Descontinuado Vintage', 35.00, 0, 'Tecnología');

SELECT id_producto, nombre, precio FROM productos WHERE id_producto = 310;

UPDATE productos
SET precio = 549.00
WHERE id_producto = 310;

SELECT id_producto, nombre, precio FROM productos WHERE id_producto = 310;

SELECT id_producto, nombre FROM productos WHERE id_producto = 118;

DELETE FROM productos
WHERE id_producto = 118;

SELECT id_producto, nombre FROM productos WHERE id_producto = 118;

INSERT INTO clientes (nombre, email, ciudad, fecha_registro, acepta_promociones, telefono) VALUES
('Laura Gómez', 'laura.g@email.com', 'Bogotá', '2026-03-01', TRUE, '3101112233'),
('Felipe Ruiz', 'felipe.r@email.com', 'Bogotá', '2026-03-03', TRUE, '3102223344'),
('Diana Moreno', 'diana.m@email.com', 'Bogotá', '2026-03-05', FALSE, '3103334455'),
('Andrés Castro', 'andres.c@email.com', 'Bogotá', '2026-03-08', TRUE, '3104445566'),
('Sofía Romero', 'sofia.r@email.com', 'Bogotá', '2026-03-10', FALSE, '3105556677'),
('Camilo Ospina', 'camilo.o@email.com', 'Bogotá', '2026-02-15', TRUE, '3106667788'),
('Mariana Ortiz', 'mariana.o@email.com', 'Medellín', '2026-03-12', TRUE, '3107778899');

SELECT nombre, fecha_registro
FROM clientes
WHERE ciudad = 'Bogotá'
ORDER BY fecha_registro DESC
LIMIT 5;

INSERT INTO productos (nombre, precio, stock, categoria) VALUES
('Televisor Smart TV 55 Pulgadas 4K', 1850000.00, 15, 'Tecnología'),
('Horno Microondas Smart Grill', 420000.00, 8, 'Electrodomésticos'),
('Lavadora Carga Frontal 18Kg Inverter', 2300000.00, 6, 'Electrodomésticos'),
('Reloj Smartwatch Deportivo Bluetooth', 280000.00, 25, 'Tecnología'),
('Aspiradora Robot Smart Clean', 950000.00, 10, 'Electrodomésticos'),
('Licuadora Convencional 2 Velocidades', 120000.00, 30, 'Electrodomésticos');

SELECT nombre, precio, categoria
FROM productos
WHERE categoria IN ('Electrodomésticos', 'Tecnología')
  AND nombre LIKE '%Smart%';

UPDATE productos SET id_categoria = 1 WHERE categoria = 'Electrodomésticos';
UPDATE productos SET id_categoria = 2 WHERE categoria = 'Tecnología';

SELECT
    id_categoria,
    AVG(precio) AS precio_promedio
FROM productos
GROUP BY id_categoria
HAVING AVG(precio) > 300000;
