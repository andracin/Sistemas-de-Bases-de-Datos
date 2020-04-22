
from pymongo import MongoClient
import datetime



def Mejor5Clientes():
        con = MongoClient()
        db = con["bd07"]
        db.authenticate("bd07","$bd07!","admin")
        orders = db["Facturacion"]
        pipeline = [{"$match": {"$or": [{"estado": "ParaEnvio"},{"estado":"Finalizada"}]}}, {"$project" : {"ciudad": 1 , "productos": 1, "userName": 1}}, {"$unwind" : "$productos"}, {"$group": {"_id": {"ciudad": "$ciudad", "userName": "$userName"}, "Total": {"$sum" : {"$multiply": [ "$productos.precio", "$productos.cantidad" ]}}}}, {"$sort": {"_id.ciudad": 1, "Total": -1}}, {"$group": {"_id": "$_id.ciudad", "usuarios" : {"$push": {"userName": "$_id.userName", "Total": "$Total"}}}}, {"$project": {"_id": 1, "Top 5": {"$slice": ["$usuarios", 5]}}}]
        cursor = orders.aggregate(pipeline)
        for dato in cursor:
                print str(dato["_id"])
                for t in dato["Top 5"]:
                         print   " " + str(t["userName"]) + ": " + str(t["Total"])


