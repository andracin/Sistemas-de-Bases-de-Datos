-- Script para creacion del esquema BD-Movies
-- Por: Maria Constanza Pabon


--------------------------------------------
-- borrado de tablas
--------------------------------------------

DROP TABLE categoria CASCADE CONSTRAINT;
DROP TABLE producto CASCADE CONSTRAINT;
DROP TABLE ciudad CASCADE CONSTRAINT;
DROP TABLE cliente CASCADE CONSTRAINT;
DROP TABLE orden CASCADE CONSTRAINT;
DROP TABLE productosOrden CASCADE CONSTRAINT;
DROP TABLE factura CASCADE CONSTRAINT;
DROP TABLE entidad CASCADE CONSTRAINT;

COMMIT;


--------------------------------------------
-- creacion de tablas
--------------------------------------------

CREATE TABLE categoria 
(	
	idCategoria SMALLINT PRIMARY KEY, 
	descripcion VARCHAR(20)
);

CREATE TABLE producto 
(
	idProducto SMALLINT PRIMARY KEY, 
	idCategoria SMALLINT NOT NULL, 
	nombre VARCHAR(15), 
	descripcion VARCHAR(30), 
	noPiezas SMALLINT DEFAULT 1, 
	pesoKg NUMERIC(3,1) CHECK (pesoKg > 0),
	precio NUMERIC(12,0) CHECK (precio > 0),
	cantidadDisp SMALLINT CHECK (cantidadDisp > 0)
); 

CREATE TABLE ciudad 
(
	codCiudad SMALLINT PRIMARY KEY, 
	nombre VARCHAR(12) NOT NULL
);


CREATE TABLE cliente
(
	idCliente SMALLINT PRIMARY KEY, 
	nombre VARCHAR(15),
	direccion VARCHAR(20), 
	codCiudad SMALLINT REFERENCES ciudad,
	email VARCHAR(20), 
    nombreDeUsuario VARCHAR(10), 
    contrasena VARCHAR(10)
);

CREATE TABLE orden
(
	nroOrden SMALLINT PRIMARY KEY, 
	idCliente SMALLINT REFERENCES cliente NOT NULL,
	fecha DATE NOT NULL,
	estado CHAR(10) CHECK (estado IN ('EnProceso','Facturada','ParaEnvio','Finalizada','Cancelada')) 
);

CREATE TABLE productosOrden 
(
	nroOrden SMALLINT REFERENCES orden,
	idProducto SMALLINT REFERENCES producto,
	cantidad SMALLINT,
	PRIMARY KEY (nroOrden, idProducto)
);

CREATE TABLE entidad
(
	idEntidad SMALLINT PRIMARY KEY,
	nombre VARCHAR(15) NOT NULL
);

CREATE TABLE factura
(
	nroFactura SMALLINT PRIMARY KEY, 
	fecha DATE NOT NULL,
	noTarjeta NUMERIC(18) NOT NULL,
	tipoTarjeta CHAR(7) CHECK (tipoTarjeta IN ('CREDITO','DEBITO')),
	noAprobacion NUMERIC(6) NOT NULL,
	idEntidad SMALLINT REFERENCES entidad NOT NULL,
	nroOrden SMALLINT REFERENCES orden NOT NULL
);

COMMIT;

--------------------------------------------
-- insertar ciudad
--------------------------------------------
INSERT INTO ciudad VALUES (7601, 'Cali');
INSERT INTO ciudad VALUES (1101, 'Bogota');
INSERT INTO ciudad VALUES (0501, 'Medellin');
INSERT INTO ciudad VALUES (0801, 'Barranquilla');

COMMIT;

--------------------------------------------
-- insertar categoria
--------------------------------------------
insert into categoria values (100, 'Electrodomesticos');
insert into categoria values (200, 'Aseo Hogar');
insert into categoria values (300, 'Ropa Dama');
insert into categoria values (400, 'Ropa Caballero');
insert into categoria values (500, 'Herramientas');
insert into categoria values (600, 'Computadores');
insert into categoria values (700, 'Jardineria');
insert into categoria values (800, 'Deportes');
insert into categoria values (900, 'Mascotas');

COMMIT;

--------------------------------------------
-- insertar entidad
--------------------------------------------
INSERT INTO entidad VALUES (1, 'VISA');
INSERT INTO entidad VALUES (2, 'MasterCard');
INSERT INTO entidad VALUES (3, 'Diners');
INSERT INTO entidad VALUES (4, 'AmericanExpress');

COMMIT;

--------------------------------------------
-- cargar datos
--------------------------------------------

accept myuser char prompt 'Enter user name:'
accept mypsw char prompt 'Enter password (escape $ and !, ex. \$bd08\!):'

HO sqlldr userid=&myuser/&mypsw control=loadProducto.ctl
HO sqlldr userid=&myuser/&mypsw control=loadCliente.ctl
HO sqlldr userid=&myuser/&mypsw control=loadOrden.ctl
HO sqlldr userid=&myuser/&mypsw control=loadProductosOrden.ctl
HO sqlldr userid=&myuser/&mypsw control=loadFactura.ctl


--------------------------------------------
-- verificar creacion
--------------------------------------------

select count(*) from categoria;
select count(*) from producto;
select count(*) from ciudad;
select count(*) from cliente;
select count(*) from orden;
select count(*) from productosOrden;
select count(*) from factura;
select count(*) from entidad;
