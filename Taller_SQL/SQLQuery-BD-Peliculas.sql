/* 1-Asignacion de Alias a las tablas y Columnas resultantes de la consulta : se puede usar AS o simplemente con espacio.*/
   /*Ejemplo1*/ Select * From cliente C 
   /*Ejemplo2*/   Select  C.idCliente AS CODIGO , C.nombre  AS CLIENTE_NOMBRE      from cliente C
/* 2- Consultas agrupadas (GROUP BY)*/
   /*Ejemplo1 Obtener el numero Total de registros*/ select COUNT(*) FROM cliente C
   /*Ejemplo2 Obtener numero total de pedidos con una misma Orden de compra*/ 
   Select PD.nroOrden, COUNT(*) AS CANTIDAD From productosOrden PD GROUP BY nroOrden
   /*Ejemplo3 Obtener la suma de las cantidades de */
   Select PD.nroOrden, SUM(PD.cantidad) AS SUMA_UNIDADES  From productosOrden PD GROUP BY nroOrden
   /*Ejemplo4 Obtener el promedio de las Cantidades*/
   Select PD.nroOrden, AVG(PD.cantidad) AS PROMEDIO  From productosOrden PD GROUP BY nroOrden
   Select PD.nroOrden, ROUND(AVG(PD.cantidad),4) AS PROMEDIO  From productosOrden PD GROUP BY nroOrden
/* 3 Consultas entre dos o mas tablas JOIN*/
   /*Ejemplo1 : Obtener de la tablas clientes y ordenes  el nombre del cliente y numero de ordenes que posee */
   select O.nroOrden, C.nombre FROM  cliente C , orden O where C.idCliente=O.idCliente  
   /*Ejemplo2 : Obtener de las tablas Clientes , Odenes y productos Ordenes la cantidades de cada orden*/
   Select   PD.nroOrden,  SUM(PD.cantidad) AS SUMA_CANTIDAD 
   from  cliente C , orden O , productosOrden PD where C.idCliente=O.idCliente AND O.nroOrden = PD.nroOrden GROUP BY PD.nroOrden
   /*Ejemplo3 : Obtener de las tablas clientes , ordenes , productosOrdenes y productos , idcliente, nombre Orden, cantidad
   descripcion del producto*/
   Select   C.idCliente , C.nombre, PD.nroOrden, PD.cantidad, P.descripcion, P.precio
   from  cliente C , orden O , productosOrden PD, producto P  where C.idCliente=O.idCliente AND O.nroOrden = PD.nroOrden
   AND PD.idProducto = P.idProducto 
   /*Ejemplo 4 : Obtener la suma del precio por difentes nroOrden de un mismo cliente*/  
   Select   C.idCliente, SUM(P.precio) AS SUMA_PRECIO
   from  cliente C , orden O , productosOrden PD, producto P  where C.idCliente=O.idCliente AND O.nroOrden = PD.nroOrden
   AND PD.idProducto = P.idProducto GROUP By C.idCliente
   /*Ejemplo 5 : Obtener idcliente nroOrden cantidad y precio de cliente  261*/
   Select   C.idCliente, PD.nroOrden, PD.cantidad, P.precio
   from  cliente C , orden O , productosOrden PD, producto P  where C.idCliente=O.idCliente AND O.nroOrden = PD.nroOrden
   AND PD.idProducto = P.idProducto AND C.idCliente=261
   /*Ejemplo 6 : Obtener  idproducto, descripcion del producto y la categoria */
   select P.idProducto, P.nombre, CA.descripcion  from producto P  LEFT JOIN categoria CA ON  P.idCategoria= CA.idCategoria 