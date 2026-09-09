CREATE DATABASE IF NOT EXISTS techstore;
USE techstore;

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    ciudad VARCHAR(60) NOT NULL
);

CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    fecha_venta DATE NOT NULL,
    CONSTRAINT fk_ventas_cliente FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ventas_producto FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

ALTER TABLE clientes
    ADD COLUMN telefono VARCHAR(20) NULL;

ALTER TABLE productos
    MODIFY COLUMN nombre VARCHAR(150) NOT NULL;

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Laptop HP Pavilion 15 Core i5', 'Computadores', 2850000.00, 12),
('Monitor Gamer LG 27 UltraGear IPS 144Hz', 'Monitores', 1150000.00, 8),
('Monitor Samsung 24 FHD Plano', 'Monitores', 620000.00, 15),
('Teclado Mecanico Redragon Kumara K552', 'Perifericos', 185000.00, 25),
('Mouse Inalambrico Logitech G203 Lightsync', 'Perifericos', 95000.00, 30),
('Disco Solido SSD Kingston 1TB NVMe M.2', 'Almacenamiento', 320000.00, 20),
('Memoria RAM Corsair Vengeance 16GB DDR4', 'Componentes', 210000.00, 18),
('Audifonos Gamer HyperX Cloud II Red', 'Audio', 380000.00, 10),
('Parlante Bluetooth JBL Flip 6 Waterproof', 'Audio', 520000.00, 14),
('Hub Adaptador USB-C 7 en 1 Multifuncion', 'Accesorios', 140000.00, 22),
('Producto Temporal Para Test De Borrado', 'Perifericos', 45000.00, 3);

INSERT INTO clientes (nombre, email, ciudad, telefono) VALUES
('Carlos Perez', 'carlos.perez@email.com', 'Bogota', '3101234567'),
('Ana Gomez', 'ana.gomez@email.com', 'Medellin', '3159876543'),
('Juan Martinez', 'juan.martinez@email.com', 'Bogota', '3124567890'),
('Luisa Fernandez', 'luisa.fernandez@email.com', 'Cali', '3176543210'),
('David Rodriguez', 'david.rodriguez@email.com', 'Cucuta', '3181122334'),
('Maria Torres', 'maria.torres@email.com', 'Bucaramanga', '3165544332'),
('Andres Morales', 'andres.morales@email.com', 'Medellin', '3119988776');

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
(1, 1, 1, '2026-02-01'),
(1, 5, 2, '2026-02-03'),
(2, 2, 1, '2026-02-05'),
(3, 4, 1, '2026-02-08'),
(3, 5, 1, '2026-02-08'),
(4, 6, 2, '2026-02-10'),
(5, 8, 1, '2026-02-12'),
(6, 3, 1, '2026-02-15'),
(2, 7, 2, '2026-02-18'),
(7, 9, 1, '2026-02-20'),
(4, 10, 1, '2026-02-22'),
(1, 6, 1, '2026-02-25'),
(5, 4, 1, '2026-02-28');

SELECT id_producto, nombre, precio FROM productos WHERE id_producto = 4;

UPDATE productos
SET precio = 175000.00
WHERE id_producto = 4;

SELECT id_producto, nombre, precio FROM productos WHERE id_producto = 4;

SELECT id_producto, nombre, stock FROM productos WHERE id_producto = 1;

UPDATE productos
SET stock = stock - 1
WHERE id_producto = 1;

SELECT id_producto, nombre, stock FROM productos WHERE id_producto = 1;

SELECT * FROM productos WHERE id_producto = 11;

DELETE FROM productos
WHERE id_producto = 11;

SELECT * FROM productos WHERE id_producto = 11;

SELECT *
FROM productos;

SELECT nombre, precio
FROM productos;

SELECT
    nombre AS producto,
    precio AS precio_venta_cop
FROM productos;

SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE precio > 500000.00;

SELECT id_cliente, nombre, email, ciudad, telefono
FROM clientes
WHERE ciudad = 'Bogota';

SELECT id_producto, nombre, categoria, precio, stock
FROM productos
WHERE categoria = 'Audio';

SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE categoria = 'Monitores'
  AND precio < 1000000.00;

SELECT id_cliente, nombre, ciudad, email
FROM clientes
WHERE ciudad = 'Bogota' OR ciudad = 'Medellin';

SELECT id_cliente, nombre, ciudad, email
FROM clientes
WHERE ciudad IN ('Bogota', 'Medellin');

SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE precio BETWEEN 200000.00 AND 1000000.00;

SELECT id_producto, nombre, categoria, precio, stock
FROM productos
WHERE categoria IN ('Perifericos', 'Audio', 'Almacenamiento');

SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE nombre LIKE '%Logitech%';

SELECT id_producto, nombre, categoria, precio
FROM productos
ORDER BY precio ASC;

SELECT id_producto, nombre, stock
FROM productos
ORDER BY stock DESC;

SELECT id_producto, nombre, categoria, precio, stock
FROM productos
WHERE precio >= 300000.00
ORDER BY precio DESC;
