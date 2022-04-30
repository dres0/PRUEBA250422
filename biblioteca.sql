\c dres0
DROP DATABASE biblioteca;
CREATE DATABASE biblioteca;
\c biblioteca

CREATE TABLE socios(
    rut VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    direccion VARCHAR(100),
    telefono INT
);

INSERT INTO socios (nombre, apellido, rut, direccion, telefono)
VALUES  ('JUAN', 'SOTO', '11111111-1', 'AVENIDA 1, SANTIAGO', 911111111);
INSERT INTO socios (nombre, apellido, rut, direccion, telefono)
VALUES  ('ANA', 'PEREZ', '22222222-2', 'PASAJE 2, SANTIAGO', 922222222);
INSERT INTO socios (nombre, apellido, rut, direccion, telefono)
VALUES  ('SANDRA', 'AGUILAR', '33333333-3', 'AVENIDA 2, SANTIAGO', 933333333);
INSERT INTO socios (nombre, apellido, rut, direccion, telefono)
VALUES  ('ESTEBAN', 'JEREZ', '44444444-4', 'AVENIDA 3, SANTIAGO', 944444444);
INSERT INTO socios (nombre, apellido, rut, direccion, telefono)
VALUES  ('SILVANA', 'MUÑOZ', '55555555-5', 'PASAJE 3, SANTIAGO', 955555555);
SELECT * FROM socios;

CREATE TABLE libros(
    id_libros SERIAL PRIMARY KEY,
    isbn VARCHAR(15),
    titulo VARCHAR(50),
    paginas INT,
    cod_autor INT
);

INSERT INTO libros (isbn, titulo, paginas, cod_autor)
VALUES  ('111-1111111-111', 'CUENTOS DE TERROR', 344, 3);
INSERT INTO libros (isbn, titulo, paginas, cod_autor)
VALUES  ('111-1111111-111', 'CUENTOS DE TERROR', 344, 4);
INSERT INTO libros (isbn, titulo, paginas, cod_autor)
VALUES  ('222-2222222-222', 'POESÍAS CONTEMPORANEAS', 167, 1);
INSERT INTO libros (isbn, titulo, paginas, cod_autor)
VALUES  ('333-3333333-333', 'HISTORIA DE ASIA', 511, 2);
INSERT INTO libros (isbn, titulo, paginas, cod_autor)
VALUES  ('444-4444444-444', 'MANUAL DE MECÁNICA', 298, 5);
SELECT * FROM libros;

CREATE TABLE autores(
    cod_autor INT PRIMARY KEY,
    nombre_autor VARCHAR(20),
    apellido_autor VARCHAR(20),
    anio_nacimiento INT,
    anio_muerte INT,
    tipo_autor VARCHAR(20)
);

INSERT INTO autores (cod_autor, nombre_autor, apellido_autor, anio_nacimiento, anio_muerte, tipo_autor)
VALUES  (3, 'JOSE', 'SALGADO', 1968, 2020, 'PRINCIPAL');
INSERT INTO autores (cod_autor, nombre_autor, apellido_autor, anio_nacimiento, anio_muerte, tipo_autor)
VALUES  (4, 'ANA', 'SALGADO', 1972, null, 'COAUTOR');
INSERT INTO autores (cod_autor, nombre_autor, apellido_autor, anio_nacimiento, anio_muerte, tipo_autor)
VALUES  (1, 'ANDRÉS', 'ULLOA', 1982, null, 'PRINCIPAL');
INSERT INTO autores (cod_autor, nombre_autor, apellido_autor, anio_nacimiento, anio_muerte, tipo_autor)
VALUES  (2, 'SERGIO', 'MARDONES', 1950, 2012, 'PRINCIPAL');
INSERT INTO autores (cod_autor, nombre_autor, apellido_autor, anio_nacimiento, anio_muerte, tipo_autor)
VALUES  (5, 'MARTIN', 'PORTA', 1976, null, 'PRINCIPAL');
SELECT * FROM autores;

CREATE TABLE historialPrestamos(
    id_prestamo SERIAL PRIMARY KEY,
    socio VARCHAR(20),
    libro VARCHAR(50),
    fecha_prestamo DATE,
    fecha_devolucion DATE
);

INSERT INTO historialPrestamos (socio, libro, fecha_prestamo, fecha_devolucion)
VALUES  ('JUAN SOTO', 'CUENTOS DE TERROR', '2020-01-20', '2020-01-27');
INSERT INTO historialPrestamos (socio, libro, fecha_prestamo, fecha_devolucion)
VALUES  ('SILVANA MUÑOS', 'POESÍAS CONTEMPORANEAS', '2020-01-20', '2020-01-30');
INSERT INTO historialPrestamos (socio, libro, fecha_prestamo, fecha_devolucion)
VALUES  ('SANDRA AGUILAR', 'HISTORIA DE ASIA', '2020-01-22', '2020-01-30');
INSERT INTO historialPrestamos (socio, libro, fecha_prestamo, fecha_devolucion)
VALUES  ('ESTEBAN JEREZ', 'MANUAL DE MECÁNICA', '2020-01-23', '2020-01-30');
INSERT INTO historialPrestamos (socio, libro, fecha_prestamo, fecha_devolucion)
VALUES  ('ANA PÉREZ', 'CUENTOS DE TERROR', '2020-01-27', '2020-02-04');
INSERT INTO historialPrestamos (socio, libro, fecha_prestamo, fecha_devolucion)
VALUES  ('JUAN SOTO', 'MANUAL DE MECÁNICA', '2020-01-31', '2020-02-12');
INSERT INTO historialPrestamos (socio, libro, fecha_prestamo, fecha_devolucion)
VALUES  ('SANDRA AGUILAR', 'POESÍAS CONTEMPORANEAS', '2020-01-31', '2020-02-12');
SELECT * FROM historialPrestamos;


-- MOSTRAR TODOS LOS LIBROS QUE TIENEN MENOS DE 300 PAGINAS
SELECT titulo, paginas FROM libros WHERE paginas < 300;

-- Mostrar todos los autores que hayan nacido después del 01-01-1970
SELECT * FROM autores WHERE anio_nacimiento > 1969;

-- ¿Cuál es el libro más solicitado?
SELECT libro, COUNT(libro) AS total FROM historialPrestamos
GROUP BY libro ORDER BY total DESC;

--  Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto
-- debería pagar cada usuario que entregue el préstamo después de 7 días.
SELECT socio, (fecha_devolucion - fecha_prestamo) AS days, (((fecha_devolucion - fecha_prestamo) - 7)* 100) AS multa
FROM historialPrestamos
WHERE (fecha_devolucion - fecha_prestamo) > 7;