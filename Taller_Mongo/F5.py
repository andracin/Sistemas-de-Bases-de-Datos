from pymongo import MongoClient
import datetime



def MasIncluido():
        con = MongoClient()
        db = con["bd07"]
        db.authenticate("bd07","$bd07!","admin")
        orders = db["Facturacion"]
        fecha = (datetime.date.today() - datetime.timedelta(6*365/12))
        fechaISO = "ISODATE(" + fecha.strftime("%Y") + "-" + fecha.strftime("%m") + "-" + fecha.strftime("%d") + "T00:00:00Z)"
        pipeline = [{"$match": {"$or" : [{"estado": "Cancelada"},{"$and": [{"estado": "EnProceso"},{ "fecha": { "$gte": fechaISO}}]}]}}, {"$project": {"productos":1}}, {"$unwind" : "$productos"}, {"$group": {"_id": "$productos.producto", "Total":{"$sum": 1}}}, {"$sort": {"Total": -1}}, {"$limit": 1}]
        cursor = orders.aggregate(pipeline)
        for c in cursor:
                print str(c["_id"]) + ": " + str(c["Total"])

~
~
