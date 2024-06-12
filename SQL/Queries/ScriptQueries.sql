/* SQL de consultas */

-- 1
SELECT gm.id_menu, gm.nombre, gm.precio 
FROM gourmetmenus gm;

-- 2

SELECT p.id_pedido, p.fecha, p.total
FROM gourmetpedidos p
JOIN gourmetclientes c ON p.id_cliente = c.id_cliente
WHERE c.nombre = 'Juan Perez';


-- 3
SELECT dp.id_pedido, m.nombre AS nombre_menu, dp.cantidad, dp.precio_unitario
FROM gourmetdetallespedidos dp
JOIN gourmetmenus m ON dp.id_menu = m.id_menu;

-- 4
SELECT
    c.id_cliente,
    c.nombre AS nombre_cliente,
    SUM(p.total) AS total_gastado
FROM
    gourmetclientes c
    JOIN gourmetpedidos p ON c.id_cliente = p.id_cliente
GROUP BY
    c.id_cliente, c.nombre
ORDER BY
    total_gastado DESC;

-- 5

SELECT
    id_menu,
    nombre,
    descripcion,
    precio
FROM
    gourmetmenus
WHERE
    precio > 10.00;
   
-- 6
SELECT
    m.id_menu,
    m.nombre,
    m.descripcion,
    m.precio
FROM
    gourmetmenus m
    JOIN gourmetdetallespedidos dp ON m.id_menu = dp.id_menu
GROUP BY
    m.id_menu, m.nombre, m.descripcion, m.precio
ORDER BY
    m.precio DESC
LIMIT 1;

-- 7
SELECT
    c.id_cliente,
    c.nombre,
    c.correo_electronico,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM
    gourmetclientes c
    JOIN gourmetpedidos p ON c.id_cliente = p.id_cliente
GROUP BY
    c.id_cliente, c.nombre
HAVING
    COUNT(p.id_pedido) > 1;
   
   
-- 8
SELECT
    c.id_cliente,
    c.nombre,
    SUM(p.total) AS total_gastado
FROM
    gourmetclientes c
    JOIN gourmetpedidos p ON c.id_cliente = p.id_cliente
GROUP BY
    c.id_cliente, c.nombre
ORDER BY
    total_gastado DESC
LIMIT 1;

-- 9
SELECT
    gc.id_cliente,
    gc.nombre,
    gp.id_pedido,
    gp.fecha,
    gp.total
FROM
    gourmetclientes gc
    JOIN gourmetpedidos gp ON gc.id_cliente = gp.id_cliente
WHERE
    gp.fecha = (
        SELECT MAX(gp2.fecha)
        FROM gourmetpedidos gp2
        WHERE gp2.id_cliente = gc.id_cliente
    )
ORDER BY
    gc.id_cliente;


-- 10
SELECT
	gdp.id_pedido,
    gm.nombre,
    gdp.cantidad,
    gdp.precio_unitario
FROM
    gourmetclientes gc
    JOIN gourmetpedidos gp ON gc.id_cliente = gp.id_cliente
    JOIN gourmetdetallespedidos gdp ON gp.id_pedido = gdp.id_pedido
    JOIN gourmetmenus gm ON gdp.id_menu = gm.id_menu
WHERE
    gc.nombre = 'Juan Perez';

   
/* Procedimientos almacenados */


-- 1
DELIMITER $$
DROP PROCEDURE IF EXISTS AgregarCliente;

CREATE PROCEDURE AgregarCliente(
    IN p_nombre VARCHAR(100),
    IN p_correo_electronico VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_fecha_registro DATE
)
BEGIN
    INSERT INTO gourmetclientes (nombre, correo_electronico, telefono, fecha_registro)
    VALUES (p_nombre, p_correo_electronico, p_telefono, p_fecha_registro);
END$$
DELIMITER ;

CALL GourmetDelight.AgregarCliente('Mari Cifu', 'mari@example.com', '1234567890', '2024-06-30');




-- 2
DELIMITER $$
DROP PROCEDURE IF EXISTS ObtenerDetallesPedido;

CREATE PROCEDURE ObtenerDetallesPedido(
    IN p_id_pedido INT
)
BEGIN
    SELECT gm.nombre AS nombre_menu, gdp.cantidad, gdp.precio_unitario
    FROM gourmetdetallespedidos gdp
    INNER JOIN gourmetmenus gm ON gdp.id_menu = gm.id_menu
    WHERE gdp.id_pedido = p_id_pedido;
END$$

DELIMITER ;

CALL ObtenerDetallesPedido(1);



-- 3
DELIMITER $$
DROP PROCEDURE IF EXISTS ActualizarPrecioMenu;

CREATE PROCEDURE ActualizarPrecioMenu(
    IN p_id_menu INT,
    IN p_nuevo_precio DECIMAL(10,2)
)
BEGIN
    UPDATE gourmetmenus
    SET precio = p_nuevo_precio
    WHERE id_menu = p_id_menu;
END$$

DELIMITER ;

CALL ActualizarPrecioMenu(1, 15.99);



-- 4
DELIMITER $$
DROP PROCEDURE IF EXISTS EliminarCliente;

CREATE PROCEDURE EliminarCliente(
    IN p_id_cliente INT
)
BEGIN
    DECLARE v_id_pedido INT;
    
    DECLARE cur_pedidos CURSOR FOR
        SELECT id_pedido
        FROM gourmetpedidos
        WHERE id_cliente = p_id_cliente;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @finished = TRUE;
    
    OPEN cur_pedidos;
    FETCH cur_pedidos INTO v_id_pedido;
    
    @finished = FALSE;
    WHILE NOT @finished DO
        DELETE FROM gourmetdetallespedidos
        WHERE id_pedido = v_id_pedido;
        
        FETCH cur_pedidos INTO v_id_pedido;
    END WHILE;
    
    CLOSE cur_pedidos;
    
    DELETE FROM gourmetpedidos
    WHERE id_cliente = p_id_cliente;
    
    DELETE FROM gourmetclientes
    WHERE id_cliente = p_id_cliente;
    
END$$

DELIMITER ;

CALL EliminarCliente(1);


-- 5
DELIMITER $$
DROP PROCEDURE IF EXISTS TotalGastadoPorCliente;

CREATE PROCEDURE TotalGastadoPorCliente(
    IN p_id_cliente INT,
    OUT p_total_gastado DECIMAL(10,2)
)
BEGIN
    SELECT SUM(gp.total)
    INTO p_total_gastado
    FROM gourmetpedidos gp
    WHERE gp.id_cliente = p_id_cliente;
    
    IF p_total_gastado IS NULL THEN
        SET p_total_gastado = 0;
    END IF;
    
END$$

DELIMITER ;

-- almacena el total gastado
SET @total_gastado := 0;

-- llama el procedimiento
CALL TotalGastadoPorCliente(1, @total_gastado);

-- muestra el resultado
SELECT @total_gastado AS total_gastado;



