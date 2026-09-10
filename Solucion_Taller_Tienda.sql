CREATE DATABASE IF NOT EXISTS taller_tienda;
USE taller_tienda;

DROP TABLE IF EXISTS Venta;
DROP TABLE IF EXISTS Producto;

CREATE TABLE Producto (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    categoria VARCHAR(50)
);

CREATE TABLE Venta (
    id INT PRIMARY KEY,
    id_producto INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id)
);

INSERT INTO Producto (id, nombre, precio, categoria) VALUES
(1,  'Televisor LED 50 pulgadas',       1850000.00, 'Electrodomesticos'),
(2,  'Licuadora Oster',                   145000.00, 'Electrodomesticos'),
(3,  'Camiseta deportiva Nike',            89000.00, 'Ropa'),
(4,  'Jean clasico Levis',                159000.00, 'Ropa'),
(5,  'Zapatillas running Adidas',         320000.00, 'Calzado'),
(6,  'Sandalias de playa',                 45000.00, 'Calzado'),
(7,  'Portatil HP 15 pulgadas',          2350000.00, 'Tecnologia'),
(8,  'Mouse inalambrico Logitech',         65000.00, 'Tecnologia'),
(9,  'Audifonos Bluetooth JBL',           189000.00, 'Tecnologia'),
(10, 'Cafetera electrica',               120000.00, 'Electrodomesticos'),
(11, 'Silla de oficina ergonomica',       480000.00, 'Hogar'),
(12, 'Lampara de escritorio LED',          38000.00, 'Hogar'),
(13, 'Mochila para portatil',              95000.00, 'Accesorios'),
(14, 'Reloj inteligente Xiaomi',          210000.00, 'Tecnologia'),
(15, 'Set de ollas antiadherentes',       310000.00, 'Hogar');

INSERT INTO Venta (id, id_producto, cantidad, fecha) VALUES
(1,  1,  1, '2026-01-15'),
(2,  2,  4, '2026-01-18'),
(3,  3,  6, '2026-02-02'),
(4,  4,  2, '2026-02-10'),
(5,  5,  3, '2026-02-14'),
(6,  6,  8, '2026-03-01'),
(7,  7,  1, '2026-03-05'),
(8,  8,  5, '2026-03-09'),
(9,  9,  2, '2026-03-20'),
(10, 10, 4, '2026-04-01'),
(11, 11, 1, '2026-04-08'),
(12, 12, 7, '2026-04-15'),
(13, 13, 3, '2026-05-02'),
(14, 14, 2, '2026-05-10'),
(15, 15, 1, '2026-05-18'),
(16, 3,  2, '2026-05-22'),
(17, 8,  6, '2026-06-01'),
(18, 5,  1, '2026-06-05'),
(19, 9,  4, '2026-06-12'),
(20, 2,  1, '2026-06-19');

SELECT 
    id,
    nombre,
    categoria,
    precio
FROM Producto
ORDER BY categoria ASC, nombre ASC;

SELECT 
    id,
    nombre,
    categoria,
    precio
FROM Producto
WHERE precio BETWEEN 100000.00 AND 500000.00
ORDER BY precio ASC;

SELECT 
    id,
    nombre,
    categoria,
    precio
FROM Producto
WHERE categoria IN ('Tecnologia', 'Electrodomesticos')
  AND (nombre LIKE '%LED%' OR nombre LIKE '%Bluetooth%');

SELECT 
    COUNT(*) AS total_productos,
    ROUND(AVG(precio), 2) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo
FROM Producto;

SELECT 
    v.id AS id_venta,
    v.fecha,
    p.nombre AS producto,
    p.categoria,
    p.precio AS precio_unitario,
    v.cantidad,
    (v.cantidad * p.precio) AS subtotal
FROM Venta v
INNER JOIN Producto p ON v.id_producto = p.id
ORDER BY v.fecha ASC;

SELECT 
    COUNT(v.id) AS total_transacciones,
    SUM(v.cantidad) AS total_unidades_vendidas,
    SUM(v.cantidad * p.precio) AS total_ingresos_tienda
FROM Venta v
INNER JOIN Producto p ON v.id_producto = p.id;

SELECT 
    p.categoria,
    COUNT(v.id) AS num_ventas,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio) AS total_recaudado
FROM Producto p
INNER JOIN Venta v ON p.id = v.id_producto
GROUP BY p.categoria
ORDER BY total_recaudado DESC;

SELECT 
    p.id,
    p.nombre,
    p.categoria,
    p.precio,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio) AS total_generado
FROM Producto p
INNER JOIN Venta v ON p.id = v.id_producto
GROUP BY p.id, p.nombre, p.categoria, p.precio
ORDER BY total_generado DESC;

SELECT 
    p.categoria,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio) AS facturacion_total
FROM Producto p
INNER JOIN Venta v ON p.id = v.id_producto
GROUP BY p.categoria
HAVING SUM(v.cantidad * p.precio) > 1500000.00
ORDER BY facturacion_total DESC;

SELECT 
    p.nombre,
    p.categoria,
    SUM(v.cantidad) AS total_unidades
FROM Producto p
INNER JOIN Venta v ON p.id = v.id_producto
GROUP BY p.id, p.nombre, p.categoria
HAVING SUM(v.cantidad) > 4
ORDER BY total_unidades DESC;

SELECT 
    MONTH(v.fecha) AS mes,
    MONTHNAME(v.fecha) AS nombre_mes,
    COUNT(v.id) AS total_operaciones,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio) AS total_mes
FROM Venta v
INNER JOIN Producto p ON v.id_producto = p.id
GROUP BY MONTH(v.fecha), MONTHNAME(v.fecha)
ORDER BY mes ASC;

SELECT 
    p.nombre,
    p.categoria,
    SUM(v.cantidad) AS unidades_vendidas
FROM Producto p
INNER JOIN Venta v ON p.id = v.id_producto
GROUP BY p.id, p.nombre, p.categoria
ORDER BY unidades_vendidas DESC
LIMIT 3;

SELECT 
    p.id,
    p.nombre,
    p.categoria,
    p.precio
FROM Producto p
LEFT JOIN Venta v ON p.id = v.id_producto
WHERE v.id IS NULL;
