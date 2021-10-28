CREATE TABLE `person`(
	`id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(45) NULL,
    `fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`));	


-- fecha como dato
SELECT fechar FROM p;
SELECT CAST(fecha AS DATE) FROM d;

-- dato en formato json

insert into tbjson (informacion) values ('{"nombre": " luis","edad" : 31,"cuidad": "San Jose"}');

-- create new databases from code
CREATE DATABASE name1 DEFAULT CHARACTER SET utf8mb4;
-- OR   
CREATE SCHEMA tienda3 DEFAULT CHARACTER SET utf8mb4;


-- modiicacion de datos
-- modo query
ALTER SCHEMA tienda DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;

-- crear una tabla con script
CREATE TABLE producto (idProducto INT NOT NULL) Engine = InnoDB DEFAULT CHARSET = utf8mb4;

-- alteracion de nombre de una tabla
-- cambiar una a la vez
ALTER TABLE categorias RENAME categoria;
-- cambiar todas al mismo tiempo
RENAME TABLE categorias TO categorias, producto TO producto;

-- crear una columna 
alter table producto
add column nombre varchar(45) null after idproducto;

-- cambiar el nombre de la columna
alter table producto
change column nombre descripcion longtext null default null;

-- eliminar una columna
alter table producto
DROP column descripcion;

-- crear llave forania
ALTER TABLE `tienda`.`producto` 
ADD INDEX `FK_PRODUCTO_CATEGORIA_idx` (`idCategoria` ASC) VISIBLE;
;
ALTER TABLE `tienda`.`producto` 
ADD CONSTRAINT `FK_PRODUCTO_CATEGORIA`
  FOREIGN KEY (`idCategoria`)
  REFERENCES `tienda`.`categoria` (`idCategoria`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


-- crar y eliminar indices en mysql
ALTER TABLE `tienda`.`producto` 
ADD INDEX `IX_PRODUCTO_NOMBRE` (`nombre` ASC) VISIBLE;
;
-------------------------------------------------------------------
-- getion de ususarios
-------------------------------------------------------------------

-------------------------------------------------------------------
-- manipulacion de datos
-------------------------------------------------------------------

-------------------------------------------------------------------
-- operadores
-------------------------------------------------------------------

-------------------------------------------------------------------
-- funciones de decha y hora
-------------------------------------------------------------------

-------------------------------------------------------------------
-- otras funciones
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Agrupacion, ordenamiento y limites
-------------------------------------------------------------------

-------------------------------------------------------------------
-- uniones de tablas
-------------------------------------------------------------------

-------------------------------------------------------------------
-- importar y exportar bases de datos
-------------------------------------------------------------------