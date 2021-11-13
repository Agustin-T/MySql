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

select nombre, date_format(fechaNacimiento, '%a, %b %Y') as 'Fecha de nacimiento'-- date_format(fecha, string)
where empleados


-------------------------------------------------------------------
-- otras funciones
-------------------------------------------------------------------
-- funciones matematicas

select abs(6);-- retorna el valor absoluto

select cell(8.5); -- redonder hacia arriba

select floor(9.95);-- redondear si ndecimales

select mod(10,5);

select pi();

select power(3,2); -- etorna x elevado a la y

select rand(); -- retorna valor aleatorio

select round(6.5);-- redondea hacia arriba

select truncate(5.422, 2); -- retorna el valor x con y decimales




-------------------------------------------------------------------
-- concatenar, insertar y medir longitud de una cadena

-- concatenar
select concat(nombre, ' ', apellido) as nombre from empleado; -- sin espacio concatena nombre y apellido juntos

select concat_ws(' ', nombre, apellido) as nombre from empleado;

-- retonna el numero de indice que es igual a 'N' en variable 'nombre'
select instr(nombre, 'N') as posicion
from producto
where idProducto = 1;

-- retorna el ancho de variable 'nombre'
select nombre, lenght(nombre) as longitud
from producto;


-------------------------------------------------------------------
--remplazar, repetir y medir la longitud de una cadena

-- cambiar valor jugo por extracto, en la tabla producto donde columna id = 11
select replace(nombre, 'Jugo', 'Extracto') as nombre
from producto
where idproducto = 11;


select concat(nombre, repeat('0', 3), year(now())) as codigo
from empleado;

-- revertica cadena de texto
select reverse(nombre) as inverso from producto;

-- extraer 
select substring(nombre, 9, 3) as subcadena
from producto
where idProducto = 11;


-------------------------------------------------------------------
--formato de cadenas de caracteres 

-- para usar un buscador de datos no debe tener espacios ni al final ni al inicio de una variable
select ltrim('     Texto con espacios');-- quita al principio

select rtrim('Texto con espacio       ');-- quita al final

select trim('   Texto con espaicos     ');-- quita espacios

-- retorna todos los valores de nombre en minusculas
select lower(nombre)
from producto;

-- todos los datos maysculas
select upper(nombre)
from producto;


-------------------------------------------------------------------
-- conversion de tipos de tados

-- conversion de datos
-- convertir fecha a datetime
select nombre, cast(fechaIngreso as datetime)
from empleado;

-- de datetime a date
select cast(now() as date);

-- int a char
select nommbre, cast(salario as char) as texto
from empleado;

-- string a date
select convert('20181201', date) as date;


-------------------------------------------------------------------
-- funciones en encriptacion

-- incriptacion
-- aes_encriiypt(string a cifrar, llave)
select aes_encrypt('micontraseña','key');

-- desencriptar
select aes_decrypt(aes_encrypt('micontraseña', 'key'), 'key');

select md5('micontraseña'); -- retorna encriptacion de 32 digitos hexadecimal

select sha('micontraseña');-- retorna encriptacion de 40 digitos hexadecimal

select sha2('miconstraseña','224');-- longitud  de bits (224 256 384 512 0)


-------------------------------------------------------------------
-- funciones de informacion

elect database(); -- retorn base de dato

select user();-- retorna usuario

select version();-- retorn version workbech

select * from cliente;
select found_rows(); -- filas afectas/cambiadas

insert into producto(nombre, idCategoria, precioUnitario)
values('Arroz','2','4');-- valor, 'categoria','precio';
select last_insert_id(); -- iltimo valor agregado

insert into producto(nombre, idCategoria, precioUnitario)
values('Ciruela','6','2');
select row_count(); -- retorna el ultimo elemento modificado



-------------------------------------------------------------------
-- Agrupacion, ordenamiento y limites
-------------------------------------------------------------------
-- suma y conteo de valores

select sum(cantidad) as total 
from detalle_factura
where idProducto = 2; -- usar si me quiero limitar

-- cuenta todos los productos
select count(*) as productos
from productos
where idCategoria = 2;-- sumar la categoria tipo 2

-- conteo distinto de IdCategoria
select count(distinct IdCategoria)
from producto;

-------------------------------------------------------------------
-- promedio, maximos y minimos

-- promedio
select avg(precioUnitario)
from producto;

-- valor minimo de precioUnitario
select min(precioUnitario)
from producto;

-- valor maximo
select max(precioUnitario)
from producto;

-- el valor mas pequeño de una lista de valores
select least(3,5,7,9,11) as resultado;

-------------------------------------------------------------------
-- agrupando datos con la clausula Group GROUP by

-- retona valores unicos
select pais from cliente
group by pais;

select idFactura, sum(presioUnitario * cantidad) as total
from detalle_factura
group by idFactura; -- total de facturas con respectivos totales


select idCliente, count(idFactura) as facturas
from factura
group by idCliente;-- total de facturas por cada cliente


-------------------------------------------------------------------
--opciones para el agrupamineto

-- sacar todas las facturas de cada unos de los clientes
-- with rollup retorn en la ultima fila el total
select idCliente, count(idfactura) as facturas
from factura
group by idCliente with rollup;


-- para que la celda no deiga null, so no total
select idCliente,
-- si se cumple grouping(idCliente), 'poner total', variable asignada 
if(grouping(idCliente), 'Total', idCliente) as cliente,
count(idfactura) as facturas
from factura
group by idCliente with rollup;

-- cuenta y agrupa los elementos de idProducto
select idCategoria, group_concat(idProducto) as producto
from producto
group by idCategoria;

-- facturas mayor a 14 dolares
select idFactura, sum(precioUnitario * cantidad) as total 
from detalle_factura
group by idfactura
having total > 14


-------------------------------------------------------------------
-- ordenamiento de datos por medio de ORDER BY

-- ordenamiento de datos
-- ASC asendente, DESC desendente
select nombre, apellido
from cliente
order by apellido desc;
-- order by rand() ordena de froma aleatoria

-------------------------------------------------------------------
-- limitar el número de filas con LIMIT y OFFSET

select * from empleado
order by fechaIngreso
limit 2;

select *
from producto
order by idProducto
limit 3, 4;

-- offset: contar a partir de n
select *
from producto
order by idProducto
limit 4 offset 3;


-------------------------------------------------------------------
-- uniones de tablas
-------------------------------------------------------------------
-- union de tablas

-------------------------------------------------------------------
-- vinculo de tablas por medio de LEFT JOIN


-------------------------------------------------------------------
--unio de tablas con la sentencia RIGHT JOIN 



-------------------------------------------------------------------
--relacion de tablas con el mismo nombre de columnas



-------------------------------------------------------------------
-- opciones de ON y USING en la union de tablas






-------------------------------------------------------------------
-- importar y exportar bases de datos
-------------------------------------------------------------------
-- respaldos utilizando mysqldump




-------------------------------------------------------------------
-- respaldo utilizando export mysql



-------------------------------------------------------------------
--restaurar la base de datos 