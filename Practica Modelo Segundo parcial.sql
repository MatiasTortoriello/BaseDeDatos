CREATE DATABASE ModeloParcial2;
USE ModeloParcial2;

CREATE TABLE BICICLETA (
	id INT PRIMARY KEY, 
    rodado INT NOT NULL, 
    marca VARCHAR(20) NULL);
CREATE TABLE CASCO (
	idBici INT REFERENCES BICICLETA(id), 
    nro_casco INT NOT NULL, 
    talle VARCHAR(3) NOT NULL,
    PRIMARY KEY(idBici, nro_casco));

CREATE TABLE ACCESORIO (
	cod INT PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    personalizado VARCHAR(50) NULL);

CREATE TABLE ESTACION (
	cod INT PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    horario VARCHAR(10) NOT NULL, 
    ubicación VARCHAR(50) NOT NULL);
    
CREATE TABLE VECINO (
	tipodoc VARCHAR(3), 
    nro_doc INT,
    nombre VARCHAR(50) NOT NULL, 
    direccion VARCHAR(50) NULL, 
    foto BLOB NULL,
    PRIMARY KEY(tipodoc, nro_doc));

CREATE TABLE TIENE (
	idBici INT REFERENCES BICICLETA(id), 
    codAcc INT REFERENCES ACCESORIO(codAcc),
    PRIMARY KEY(idBici, codAcc));
    
CREATE TABLE OPERACION (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    fecha_hora DATETIME NOT NULL, 
    codEstacion INT NOT NULL REFERENCES ESTACION(cod), 
    idBici INT NOT NULL REFERENCES BICICLETA(id), 
    tipo CHAR(1) NOT NULL, 
    tipodoc VARCHAR(3) NOT NULL, 
    nrodoc INT NOT NULL,
    CONSTRAINT FK_Operacion_Vecino FOREIGN KEY (tipodoc, nrodoc) REFERENCES VECINO(tipodoc, nro_doc));

-- ALTER TABLE OPERACION DROP
-- CONSTRAINT FK_Operacion_Vecino
/*
BICICLETA (id, rodado, marca) PK=id
ACCESORIO (cod, nombre, personalizado) PK=cod
ESTACION (cod, nombre, horario, ubicación) PK=cod
VECINO (tipodoc, nro_doc, nombre, direccion, foto) PK=(tipodoc, nrodoc)
TIENE (idBici, codAcc) PK=(idBici, codAcc)
OPERACION (id, fecha_hora, codEstacion, idBici, tipo, tipodoc, nrodoc) PK=id
Lista de Claves Foráneas
CASCO.idBici --> BICICLETA.id
TIENE.idBici --> BICICLETA.id
TIENE.codAcc --> ACCESORIO.cod
OPERACION.CodEstacion --> ESTACION.cod
OPERACION.IdBici --> BICICLETA.id
OPERACION.tipodoc + nrodoc --> VECINO.tipodoc + nrodoc
*/
/* 1. DDL */
-- Construir la tabla OPERACION en el modelo físico y las necesarias para ésta, en AnsiSQL.
-- CREATE TABLE BICICLETA, VECINO, ESTACION, OPERACION

/* 2. ABM */
-- a. Insertar dos registros para una tabla a elección, que tengan más de 2 campos.
INSERT INTO VECINO
	(tipodoc, nro_doc, nombre, direccion)
VALUES
	('DNI', 33459054, 'Juan Sebastian Quevedo', 'Florencio Varela 1903'),
    ('DNI', 13245678, 'Eliana Pardeux', 'Florencio Varela 1903');

-- b. Eliminar todos los cascos del rango de bicicletas con id=101 a id=123, que sean talle P.
DELETE FROM BICICLETA
WHERE id BETWEEN 101 AND 123 AND talle LIKE 'P';

-- c. Actualizar todos los accesorios que contengan personalizado ‘MVK-’ a ‘ECO RRR’.
UPDATE ACCESORIO
SET personlizado = 'ECO RRR'
WHERE perzonalizado LIKE 'MVK-%'

/* 3. DML */
-- a. Listar las bicis que tienen asiento para niño y cuántos cascos tienen asociados.
-- b. Mostrar código y rodado de las bicicletas que tienen todos los accesorios.
-- c. ¿Cuál es la cantidad de operaciones en el primer trimestre del año?
-- d. ¿Cuál es la cantidad de bicis no devueltas en el último mes, en el día a día? ¿Y desde que empezó a funcionar el sistema? Se puede suponer que arrancó el 1/04/2022.
-- e. ¿Cuáles son las bicis con más cantidad de accesorios?
-- f. Listar nombre y ubicación de las estaciones preferidas de los vecinos, entendiendo preferidas como las que concentran más préstamos.
-- g. Listar los nombres de vecinos alfabéticamente de U a W (Ulises Bueno, Vicente López, Will Smith) junto a la cantidad de estaciones distintas que uso en la última semana, aún si no se prestó bicicleta (0 estaciones esa semana).
-- h. Mostrar el ránking de vecinos que han usado el sistema con más de 3 bicis distintas y que las devolvieron según las reglas.
-- i. ¿Cómo medirías el éxito del programa de Eco Transporte? Armar una consulta que lo resuelva.