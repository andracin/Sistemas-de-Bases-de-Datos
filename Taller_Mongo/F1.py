from pymongo import MongoClient
import datetime

def consultar_orden(user, estado):
          con = MongoClient()
          db = con["bd07"]
          db.authenticate("bd07","$bd07!","admin")
          orders = db["Facturacion"]
          cursor = orders.find({"userName": user, "estado": "EnProceso"})
          for orden_user in cursor:
              print("Numero Orden: " + str(orden_user["nroOrden"]) + " " + " fecha: " + str(orden_user["fecha"]) + " productos:")
              productos = orden_user["productos"]
              for prod_user in productos:
                  print("Descripcion : " + str(prod_user ["producto"]) + " cantidad: " + str(prod_user["cantidad"]))


~
