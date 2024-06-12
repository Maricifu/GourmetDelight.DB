USE GourmetDelight;

-- inserciones de datos para la DB gourmetDelight

-- insercion de datos en la tabla clientes
INSERT INTO gourmetclientes (id_cliente, nombre, correo_electronico, telefono, fecha_registro) VALUES
(1, 'Juan Perez', 'juan.perez@example.com', '123-456-7890', '2024-01-01'),
(2, 'Maria Lopez', 'maria.lopez@example.com', '123-456-7891', '2024-01-05'),
(3, 'Carlos Mendoza', 'carlos.mendoza@example.com', '123-456-7892', '2024-02-10'),
(4, 'Ana Gonzalez', 'ana.gonzalez@example.com', '123-456-7893', '2024-03-01'),
(5, 'Luis Torres', 'luis.torres@example.com', '123-456-7894', '2024-03-05'),
(6, 'Laura Rivera', 'laura.rivera@example.com', '123-456-7895', '2024-04-01'),
(7, 'Fernando Garcia', 'fernando.garcia@example.com', '123-456-7896', '2024-04-20'),
(8, 'Isabel Fernandez', 'isabel.fernandez@example.com', '123-456-7897', '2024-04-25'),
(9, 'Ricardo Morales', 'ricardo.morales@example.com', '123-456-7898', '2024-05-01'),
(10, 'Lucía Martínez', 'lucia.martinez@example.com', '123-456-7899', '2024-05-05'),
(11, 'Santiago Jiménez', 'santiago.jimenez@example.com', '123-456-7900', '2024-05-10'),
(12, 'Patricia Romero', 'patricia.romero@example.com', '123-456-7901', '2024-05-15');


-- insercion de datos en la tabla Menus
INSERT INTO gourmetmenus (id_menu, nombre, descripcion, precio) VALUES
(1, 'Ensalada César', 'Ensalada con lechuga romana, crutones y aderezo César', 12.50),
(2, 'Sopa de Tomate', 'Sopa cremosa de tomate con albahaca', 8.75),
(3, 'Filete de Res', 'Filete de res a la parrilla con papas y vegetales', 25.00),
(4, 'Pasta Alfredo', 'Pasta con salsa Alfredo y pollo', 15.00),
(5, 'Tarta de Queso', 'Tarta de queso con salsa de frambuesa', 7.50),
(6, 'Café Americano', 'Café americano recién preparado', 3.00);


-- insercion de datos en la tabla Pedidos para clientes 
INSERT INTO gourmetpedidos (id_pedido, id_cliente, fecha, total) VALUES
(1, 1, '2024-05-15', 40.00),
(2, 1, '2024-06-01', 25.50),
(3, 2, '2024-05-20', 35.75),
(4, 2, '2024-06-05', 48.00),
(5, 3, '2024-06-10', 55.00),
(6, 4, '2024-05-30', 32.75),
(7, 4, '2024-06-15', 28.25),
(8, 5, '2024-06-20', 45.00),
(9, 6, '2024-05-25', 22.50),
(10, 6, '2024-06-10', 33.75),
(11, 7, '2024-05-15', 50.00),
(12, 7, '2024-06-25', 47.00),
(13, 8, '2024-05-20', 44.75),
(14, 8, '2024-05-30', 39.50),
(15, 9, '2024-05-25', 41.00),
(16, 10, '2024-06-04', 55.75),
(17, 11, '2024-06-09', 52.00),
(18, 12, '2024-06-15', 46.25);


-- insercion de datos en detallePedidos donde se reune pedido con menu
INSERT INTO gourmetdetallespedidos (id_pedido, id_menu, cantidad, precio_unitario) VALUES
(1, 1, 1, 12.50),
(1, 3, 1, 25.00),
(1, 6, 3, 3.00),
(2, 2, 1, 8.75),
(2, 4, 1, 15.00),
(2, 5, 1, 7.50),
(3, 1, 1, 12.50),
(3, 4, 1, 15.00),
(3, 6, 2, 3.00),
(4, 3, 1, 25.00),
(4, 6, 1, 3.00),
(5, 1, 2, 12.50),
(5, 5, 2, 7.50),
(6, 2, 1, 8.75),
(6, 6, 3, 3.00),
(7, 1, 2, 12.50),
(7, 4, 1, 15.00),
(8, 2, 1, 8.75),
(8, 5, 2, 7.50),
(9, 3, 1, 25.00),
(9, 6, 3, 3.00),
(10, 1, 1, 12.50),
(10, 3, 1, 25.00),
(11, 4, 1, 15.00),
(11, 5, 1, 7.50),
(11, 6, 2, 3.00),
(12, 2, 1, 8.75),
(12, 4, 1, 15.00),
(12, 5, 1, 7.50),
(13, 1, 2, 12.50),
(13, 4, 1, 15.00),
(14, 2, 1, 8.75),
(14, 5, 2, 7.50),
(15, 3, 1, 25.00),
(15, 6, 3, 3.00),
(16, 1, 1, 12.50),
(16, 3, 1, 25.00),
(17, 4, 1, 15.00),
(17, 5, 1, 7.50),
(17, 6, 2, 3.00),
(18, 2, 1, 8.75),
(18, 4, 1, 15.00),
(18, 5, 1, 7.50);
