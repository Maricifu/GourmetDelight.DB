CREATE DATABASE GourmetDelight;
USE GourmetDelight;

-- se crea la tabla para los clientes
CREATE TABLE gourmetclientes (
id_cliente INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
correo_electronico VARCHAR(100) NOT NULL,
telefono VARCHAR(15) NOT NULL,
fecha_registro DATE NOT NULL
);

-- se crea la tabla para el menu
CREATE TABLE gourmetmenus (
id_menu INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion TEXT,
precio DECIMAL(10,2) NOT NULL
);

-- se crea la tabla para los pedidos
CREATE TABLE gourmetpedidos (
id_pedido INT PRIMARY KEY,
id_cliente INT NOT NULL,
fecha DATE NOT NULL,
total DECIMAL(10,2) NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES gourmetclientes(id_cliente)
);

-- se crea la tabla para el detalle de los pedidos, que reune a menu y a pedidos
CREATE TABLE gourmetdetallespedidos (
id_pedido INT NOT NULL,
id_menu INT NOT NULL,
cantidad INT NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL, 
PRIMARY KEY (id_pedido, id_menu),
FOREIGN KEY (id_pedido) REFERENCES gourmetpedidos(id_pedido),
FOREIGN KEY (id_menu) REFERENCES gourmetmenus(id_menu)
);

