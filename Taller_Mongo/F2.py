from pymongo import MongoClient
import datetime



def calcularTotalOrden(user):
        con = MongoClient()
        db = con["bd07"]
        db.authenticate("bd07","$bd07!","admin")
        orders = db["Facturacion"]
        pipeline = [{"$match": {"$and" : [{"userName": user},{"estado":"EnProceso"}]}}, {"$project" : {"nroOrden": 1 , "productos": 1 }}, {"$unwind" : "$productos"}, {"$group": {"_id":"$nroOrden", "Total": {"$sum": { "$multiply": [ "$productos.precio", "$productos.cantidad" ] }}}}]
        cursor = orders.aggregate(pipeline)
        for o in cursor:
                print "Orden: " + str(o["_id"]) + " Suma Total: " + str(o["Total"])

