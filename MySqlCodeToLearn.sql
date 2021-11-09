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
-- crear
ALTER TABLE `tienda`.`producto` 
ADD INDEX `IX_PRODUCTO_NOMBRE` (`nombre` ASC) VISIBLE;
;
-- eliminar
ALTER TABLE `tienda`.`producto` 
DROP INDEX `IX_PRODUCTO_NOMBRE` ;
;
-------------------------------------------------------------------
-- getion de ususarios
-------------------------------------------------------------------
-- crear usuario
use mysql;
select * from user;
-- crear usuario con nombre@tipo con contraseña
create user admin2@localhost identified by '123abc';

-- otorgar permisos
grant select, insert, update, delete on tienda.* to admin2@localhost;

-- mostrar los permisos otorgados
show grants for admin2@localhost;

-- remover el privilegio de cargar y eliminar en la tabla tiendad.todo(*) de nombre@dirrecion

revoke update, delete
on tienda.*
from admin2@localhost;

-- eliminar usuario
drop user admin2@localhost;
-------------------------------------------------------------------------
-- crear  roles
create role 'rl_lectura', 'rl_escritura';

-- asignamos privilegios a los roles
grant select on tienda.* to 'rl_lectura';
grant insert, update, delete on tienda.* to 'rl_escritura';

-- verificamos mostrando los privilegios de los roles
show grants for 'rl_escritura';
show grants for 'rl_lectura';

-------------------------------------------------------------------------
-- asignar roles a admin1@'%'
-- % significa cualquier direccion IP 
grant 'rl_lectura', 'rl_escritura' to admin1@'%';
show grants for admin1@'%';

-- eliminar rol
revoke 'rl_escritura' from admin1@'%';

-- eliminar un privilegio desntro del rol
revoke delete on tienda.* from 'rl_escritura';
show grants for 'rl_escritura';

-- eliminar rol
drop role 'rl_escritura';



-------------------------------------------------------------------------
-- into cual es la tab-- la de hacer la inserrcion de valores de 
-- no incertamos nada en el ID porque es acumulador acendente
insert into categoria (nombre, descripcion) values ('Cereales', 'Productos como maiz, trigo avena, arroz, etc');
-------------------------------------------------------------------------


-------------------------------------------------------------------
-- manipulacion de datos
-------------------------------------------------------------------
-- INSERT
-- into dice en que tabla
insert into categoria(nombre, descripcion) values('cereales', 'Productos como mais, trigo, arroz, etc')

-------------------------------------------------------------------
-- SELECT
select 5 +2;
select 5 + 5 from dual;
select * from producto; -- todas las columnas de tabla producto
select nombre, precioUnitario from producto;-- 2 columnas de producto
select nombre as 'Nombre de producto' from producto;-- cambiar nombre de a nombre de producto

-------------------------------------------------------------------
--WHERE
select * from  empleado where salario > 500;
select * from empleado where idEmpleado = 2;
select * from cliente where pais = 'Canada';
select * from producto where IdCategoria = 5;
-------------------------------------------------------------------

-- update
-- cambiar un elemento
update empleado
SET email = 'alicecosta@ejemplo.com'
where IdEmpleado = 3;


--cambiar varios elementos
update empleado 
set
apellido = 'morales', 
email = 'alicemorales@ejrmplo.com'
where IdEmpelado = 3;
-------------------------------------------------------------------
-- delete

delete from empleado where idEmpleado = 5;

--tener cuidado, puedes eliminar tanto un registro como una tabla si no le pones el 'where'


-------------------------------------------------------------------
-- operadores
-------------------------------------------------------------------
-- and, &&
select idProducto, nombre
from producto
where precioUnitario < 2.30 and idCategoria = 1;

select idProducto, nombre
from producto
where precioUnitario < 2.30 && idCategoria = 2;

--or, ||
select idProducto,nombre
from producto
where precioUnitario < 2.30 || idCategoria = 2

--not !=
select * 
from producto
where idCateforia != 2;

--null
select *
from producto
where idCategoria is not null

--xor
select* 
where producto
where precioUnitario < 2.30 xor idCategoria = 2

-------------------------------------------------------------------
-- rango
select * from empleado
where fechaIngreso between '2018-12-3' and '2018-01-31'

-------------------------------------------------------------------
-- multiples valores


select * from factura 
where idFactura = 1 or
idFactura = 3 or 
idFactura = 5 or
idFactura = 7;

select * from factura
where idFactura in(1,3,5,7);

select * from factura 
where idFactura != 1 and
idFactura != 3 and 
idFactura != 5 and
idFactura = 7;

select * from factura
where idFactura not in(1,3,5,7);
-------------------------------------------------------------------
-- valores nulos 

select * from cliente
where telefono is null;


select * from cliente
where isnull(telefono)

-------------------------------------------------------------------
--  busqueda de patrones

select * from producto
where nombre like 'avena';

select * from producto
where nombre like 'acena_';-- el guin bajo 'avena_'representa un espacio

select * from producto
where nombre like '%A%e%a';-- cualquier palabra que tenga A#e#a (Avena)

select * from producto
where nombre like 'a%'; -- cualquier producto que compieze con a
-------------------------------------------------------------------
-- operadores aritmeticos
select idProducto, 
(precioUnitario * cantidad) + (presioUnitario * cantidad * 0.10) as 'Precio con impuesto' 
from detalle_factura;

-------------------------------------------------------------------
-- funciones de decha y hora
-------------------------------------------------------------------

select curdate();

select now();

select localtime();

select localtimestamp();

select str_to_date('09 Agu, 2019', '%d %M, %Y');


-------------------------------------------------------------------
select date('2019-09-07 23:21:35') as fecha;

select now();

select date(now()) as fecha;

-- diferencia de fechas

select datedff('2022-08-06', '2021-08-06'); -- retorna la diferencia de los calores ingresados

select nombre, floor(datediff(now(), fechaNacimiento)/ 365) as años -- flor() retorna la parte entera
from empleado;

-------------------------------------------------------------------
select now();

select date_add(now(), interval -10 year) as fecha; -- date_add() retorna 

select extract(year from now()) as año; -- extract() estrae algun valor

select extract(day from now())as dia;

select extract(month from now()) as mes;

select nombre, date_format(sechaNacimiento, '%a, %b %Y') as 'Fecha de nacimiento'-- date_format(fecha, string)
where empleados


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