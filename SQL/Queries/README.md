# Consultas para la base de datos GourmetDelight

```mysql
        +--------------------------+
        | Tables_in_GourmetDelight |
        +--------------------------+
        | gourmetclientes          |
        | gourmetdetallespedidos   |
        | gourmetmenus             |
        | gourmetpedidos           |
        +--------------------------+
```

- Obtener la lista de todos los menús con sus precios

```sql
SELECT gm.id_menu, gm.nombre, gm.precio 
FROM gourmetmenus gm;
```

```mysql
+---------+-----------------+--------+
| id_menu | nombre          | precio |
+---------+-----------------+--------+
|       1 | Ensalada César  |  12.50 |
|       2 | Sopa de Tomate  |   8.75 |
|       3 | Filete de Res   |  25.00 |
|       4 | Pasta Alfredo   |  15.00 |
|       5 | Tarta de Queso  |   7.50 |
|       6 | Café Americano  |   3.00 |
+---------+-----------------+--------+
```

- Encontrar todos los pedidos realizados por el cliente 'Juan Perez'

```sql
SELECT p.id_pedido, p.fecha, p.total
FROM gourmetpedidos p
JOIN gourmetclientes c ON p.id_cliente = c.id_cliente
WHERE c.nombre = 'Juan Perez';
```

```mysql
+-----------+------------+-------+
| id_pedido | fecha      | total |
+-----------+------------+-------+
|         1 | 2024-05-15 | 40.00 |
|         2 | 2024-06-01 | 25.50 |
+-----------+------------+-------+
```

- Listar los detalles de todos los pedidos, incluyendo el nombre del menú, cantidad y precio unitario

```sql
SELECT dp.id_pedido, m.nombre AS nombre_menu, dp.cantidad, dp.precio_unitario
FROM gourmetdetallespedidos dp
JOIN gourmetmenus m ON dp.id_menu = m.id_menu;
```

```mysql
+-----------+-----------------+----------+-----------------+
| id_pedido | nombre_menu     | cantidad | precio_unitario |
+-----------+-----------------+----------+-----------------+
|         1 | Ensalada César  |        1 |           12.50 |
|         3 | Ensalada César  |        1 |           12.50 |
|         5 | Ensalada César  |        2 |           12.50 |
|         7 | Ensalada César  |        2 |           12.50 |
|        10 | Ensalada César  |        1 |           12.50 |
|        13 | Ensalada César  |        2 |           12.50 |
|        16 | Ensalada César  |        1 |           12.50 |
|         2 | Sopa de Tomate  |        1 |            8.75 |
|         6 | Sopa de Tomate  |        1 |            8.75 |
|         8 | Sopa de Tomate  |        1 |            8.75 |
|        12 | Sopa de Tomate  |        1 |            8.75 |
|        14 | Sopa de Tomate  |        1 |            8.75 |
|        18 | Sopa de Tomate  |        1 |            8.75 |
|         1 | Filete de Res   |        1 |           25.00 |
|         4 | Filete de Res   |        1 |           25.00 |
|         9 | Filete de Res   |        1 |           25.00 |
|        10 | Filete de Res   |        1 |           25.00 |
|        15 | Filete de Res   |        1 |           25.00 |
|        16 | Filete de Res   |        1 |           25.00 |
|         2 | Pasta Alfredo   |        1 |           15.00 |
|         3 | Pasta Alfredo   |        1 |           15.00 |
|         7 | Pasta Alfredo   |        1 |           15.00 |
|        11 | Pasta Alfredo   |        1 |           15.00 |
|        12 | Pasta Alfredo   |        1 |           15.00 |
|        13 | Pasta Alfredo   |        1 |           15.00 |
|        17 | Pasta Alfredo   |        1 |           15.00 |
|        18 | Pasta Alfredo   |        1 |           15.00 |
|         2 | Tarta de Queso  |        1 |            7.50 |
|         5 | Tarta de Queso  |        2 |            7.50 |
|         8 | Tarta de Queso  |        2 |            7.50 |
|        11 | Tarta de Queso  |        1 |            7.50 |
|        12 | Tarta de Queso  |        1 |            7.50 |
|        14 | Tarta de Queso  |        2 |            7.50 |
|        17 | Tarta de Queso  |        1 |            7.50 |
|        18 | Tarta de Queso  |        1 |            7.50 |
|         1 | Café Americano  |        3 |            3.00 |
|         3 | Café Americano  |        2 |            3.00 |
|         4 | Café Americano  |        1 |            3.00 |
|         6 | Café Americano  |        3 |            3.00 |
|         9 | Café Americano  |        3 |            3.00 |
|        11 | Café Americano  |        2 |            3.00 |
|        15 | Café Americano  |        3 |            3.00 |
|        17 | Café Americano  |        2 |            3.00 |
+-----------+-----------------+----------+-----------------+
```

- Calcular el total gastado por cada cliente en todos sus pedidos

```sql
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
```

```mysql
+------------+-------------------+---------------+
| id_cliente | nombre_cliente    | total_gastado |
+------------+-------------------+---------------+
|          7 | Fernando Garcia   |         97.00 |
|          8 | Isabel Fernandez  |         84.25 |
|          2 | Maria Lopez       |         83.75 |
|          1 | Juan Perez        |         65.50 |
|          4 | Ana Gonzalez      |         61.00 |
|          6 | Laura Rivera      |         56.25 |
|         10 | Lucía Martínez    |         55.75 |
|          3 | Carlos Mendoza    |         55.00 |
|         11 | Santiago Jiménez  |         52.00 |
|         12 | Patricia Romero   |         46.25 |
|          5 | Luis Torres       |         45.00 |
|          9 | Ricardo Morales   |         41.00 |
+------------+-------------------+---------------+
```

- Encontrar los menús con un precio mayor a $10

```sql
SELECT
    id_menu,
    nombre,
    descripcion,
    precio
FROM
    gourmetmenus
WHERE
    precio > 10.00;
```

```mysql
+---------+-----------------+--------------------------------------------------------+--------+
| id_menu | nombre          | descripcion                                            | precio |
+---------+-----------------+--------------------------------------------------------+--------+
|       1 | Ensalada César  | Ensalada con lechuga romana, crutones y aderezo César  |  12.50 |
|       3 | Filete de Res   | Filete de res a la parrilla con papas y vegetales      |  25.00 |
|       4 | Pasta Alfredo   | Pasta con salsa Alfredo y pollo                        |  15.00 |
+---------+-----------------+--------------------------------------------------------+--------+
```

- Obtener el menú más caro pedido al menos una vez

```sql
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
```

```mysql
+---------+---------------+---------------------------------------------------+--------+
| id_menu | nombre        | descripcion                                       | precio |
+---------+---------------+---------------------------------------------------+--------+
|       3 | Filete de Res | Filete de res a la parrilla con papas y vegetales |  25.00 |
+---------+---------------+---------------------------------------------------+--------+
```

- Listar los clientes que han realizado más de un pedido

```sql
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
```

```mysql
+------------+------------------+------------------------------+------------------+
| id_cliente | nombre           | correo_electronico           | cantidad_pedidos |
+------------+------------------+------------------------------+------------------+
|          1 | Juan Perez       | juan.perez@example.com       |                2 |
|          2 | Maria Lopez      | maria.lopez@example.com      |                2 |
|          4 | Ana Gonzalez     | ana.gonzalez@example.com     |                2 |
|          6 | Laura Rivera     | laura.rivera@example.com     |                2 |
|          7 | Fernando Garcia  | fernando.garcia@example.com  |                2 |
|          8 | Isabel Fernandez | isabel.fernandez@example.com |                2 |
+------------+------------------+------------------------------+------------------+

```

- Obtener el cliente con el mayor gasto total

```sql
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
```

```mysql
+------------+-----------------+---------------+
| id_cliente | nombre          | total_gastado |
+------------+-----------------+---------------+
|          7 | Fernando Garcia |         97.00 |
+------------+-----------------+---------------+
```

- Mostrar el pedido más reciente de cada cliente

```sql
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
```

```mysql
+------------+-------------------+-----------+------------+-------+
| id_cliente | nombre            | id_pedido | fecha      | total |
+------------+-------------------+-----------+------------+-------+
|          1 | Juan Perez        |         2 | 2024-06-01 | 25.50 |
|          2 | Maria Lopez       |         4 | 2024-06-05 | 48.00 |
|          3 | Carlos Mendoza    |         5 | 2024-06-10 | 55.00 |
|          4 | Ana Gonzalez      |         7 | 2024-06-15 | 28.25 |
|          5 | Luis Torres       |         8 | 2024-06-20 | 45.00 |
|          6 | Laura Rivera      |        10 | 2024-06-10 | 33.75 |
|          7 | Fernando Garcia   |        12 | 2024-06-25 | 47.00 |
|          8 | Isabel Fernandez  |        14 | 2024-05-30 | 39.50 |
|          9 | Ricardo Morales   |        15 | 2024-05-25 | 41.00 |
|         10 | Lucía Martínez    |        16 | 2024-06-04 | 55.75 |
|         11 | Santiago Jiménez  |        17 | 2024-06-09 | 52.00 |
|         12 | Patricia Romero   |        18 | 2024-06-15 | 46.25 |
+------------+-------------------+-----------+------------+-------+
```

- Obtener el detalle de pedidos (menús y cantidades) para el cliente 'Juan Perez'.

```sql
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
```

```mysql
+-----------+-----------------+----------+-----------------+
| id_pedido | nombre          | cantidad | precio_unitario |
+-----------+-----------------+----------+-----------------+
|         1 | Ensalada César  |        1 |           12.50 |
|         1 | Filete de Res   |        1 |           25.00 |
|         1 | Café Americano  |        3 |            3.00 |
|         2 | Sopa de Tomate  |        1 |            8.75 |
|         2 | Pasta Alfredo   |        1 |           15.00 |
|         2 | Tarta de Queso  |        1 |            7.50 |
+-----------+-----------------+----------+-----------------+
```

# Procedimientos Almacenados

### Crear un procedimiento almacenado para agregar un nuevo cliente
- Enunciado: Crea un procedimiento almacenado llamado AgregarCliente que reciba como parámetros el nombre, correo electrónico, teléfono y fecha de registro de un nuevo cliente y lo inserte en la tabla Clientes .

### Crear un procedimiento almacenado para obtener los detalles de un pedido
- Enunciado: Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del menú, cantidad y precio unitario.

### Crear un procedimiento almacenado para actualizar el precio de un menú
- Enunciado: Crea un procedimiento almacenado llamado ActualizarPrecioMenu que reciba como parámetros el ID del menú y el nuevo precio, y actualice el precio del menú en la tabla Menus .

### Crear un procedimiento almacenado para eliminar un cliente y sus pedidos
- Enunciado: Crea un procedimiento almacenado llamado EliminarCliente que reciba como parámetro el ID del cliente y elimine el cliente junto con todos sus pedidos y los detalles de los pedidos.

### Crear un procedimiento almacenado para obtener el total gastado por un cliente
- Enunciado: Crea un procedimiento almacenado llamado TotalGastadoPorCliente que reciba como parámetro el ID del cliente y devuelva el total gastado por ese cliente en todos sus pedidos.