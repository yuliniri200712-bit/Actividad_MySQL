CREATE TABLE categoria (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    nombre      VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE producto (
    id           INT PRIMARY KEY AUTO_INCREMENT,
    nombre       VARCHAR(100) NOT NULL,
    precio       DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    existencia   INT NOT NULL DEFAULT 0 CHECK (existencia >= 0),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

CREATE TABLE cliente (
    id      INT PRIMARY KEY AUTO_INCREMENT,
    nombre  VARCHAR(100) NOT NULL,
    correo  VARCHAR(150) UNIQUE
);

CREATE TABLE venta (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    fecha      DATE DEFAULT (CURRENT_DATE),
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE detalle_venta (
    id           INT PRIMARY KEY AUTO_INCREMENT,
    venta_id     INT NOT NULL,
    producto_id  INT NOT NULL,
    cantidad     INT NOT NULL CHECK (cantidad > 0),
    FOREIGN KEY (venta_id) REFERENCES venta(id),
    FOREIGN KEY (producto_id) REFERENCES producto(id)
);
