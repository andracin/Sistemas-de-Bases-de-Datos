from pymongo import MongoClient
import datetime


def productosPorCiudad():
        con = MongoClient()
        db = con["bd07"]
        db.authenticate("bd07","$bd07!","admin")
        orders = db["Facturacion"]
        pipeline = [{"$match": {"estado" : "ParaEnvio"}}, {"$project" : {"ciudad": 1 , "productos": 1 }}, {"$unwind" : "$productos"}, {"$project" : {"ciudad": 1 , "productos.idProducto": 1, "productos.cantidad": 1, "productos.producto": 1 }}, {"$group": {"_id": "$productos.idProducto", "data": {"$push" : "$$ROOT"}}}]
        cursor = orders.aggregate(pipeline)
        ciudades = orders.distinct( "ciudad", { "estado" : "ParaEnvio" } )
        for prod in cursor:
                prod_ciudades = {}
                for ciudad in ciudades:
                        prod_ciudades[ciudad] = 0
                idProducto = prod["_id"]
                data = prod["data"]
                for j in range(0, len(data)):
                        producto = data[j]["productos"]["producto"]
                        ciudad2 = data[j]["ciudad"]
                        prod_ciudades[ciudad2] += data[j]["productos"]["cantidad"]
                """print "idProducto: " + str(idProducto) + " Producto: " + str(producto)"""
                for ciudad in ciudades:
                        print  "idProducto: " + str(idProducto) +  " " + str(ciudad) + ": " + str(prod_ciudades[ciudad])


~
~
