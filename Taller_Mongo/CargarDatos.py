
""" Taller de Mongo Andres Racines"""
""" Este script carga los datos CSV  en una BD  Facturacion en Mongo, si la BD no existe se crea """

import csv
import datetime

from pymongo import MongoClient

con = MongoClient()
db = con["bd07"]
db.authenticate("bd07","$bd07!","admin")

print "Se selecciona la bd para cargar los datos "
if "Facturacion" in db.collection_names():
                orders = db["Facturacion"]
                orders.delete_many({})
else:
                print "En caso de no existir la BD se Creara "
                db.create_collection("Facturacion")
                orders = db["Facturacion"]

ifile = open("orden.csv", "rU")
reader = csv.reader(ifile, delimiter=";")
ordenes = []
for row in reader:
        ordenes.append(row)

ifile.close()

ifile = open("productosOrden.csv", "rU")
reader = csv.reader(ifile, delimiter=";")
prodOrden = []
for row in reader:
        prodOrden.append(row)

ifile.close()

ifile = open("factura.csv", "rU")
reader = csv.reader(ifile, delimiter=";")
facturas = []
for row in reader:
        facturas.append(row)
ifile.close()

for j in range(1, len(ordenes)):
                       userName = ordenes[j][1]
                nroOrden = ordenes[j][0]
                estado = ordenes[j][3]
                fechaOrden = ordenes[j][2]
                ciudad = ordenes[j][4]
                productos = []
                for k in range(1, len(prodOrden)):
                                nroOrden2 = prodOrden[k][0]
                                if nroOrden == nroOrden2:
                                                prod = {}
                                                prod["idProducto"] = prodOrden[k][1]
                                                prod["producto"] = prodOrden[k][3]
                                                prod["cantidad"] = int(prodOrden[k][2])
                                                prod["precio"] = int(prodOrden[k][4])
                                                productos.append(prod)
                factura = {}
                for k in range(1, len(facturas)):
                                nroOrden2 = facturas[k][6]
                                if nroOrden == nroOrden2:
                                                factura["nroFactura"] = facturas[k][0]
                                                factura["fecha"] = datetime.datetime.strptime(facturas[k][1], "%d/%m/%Y")
                                                factura["noTarjeta"] = facturas[k][2]
                                                factura["tipoTarjeta"] = facturas[k][3]
                                                factura["entidad"] = facturas[k][7]
                orden = {}
                orden["nroOrden"] = nroOrden
                orden["userName"] = userName
                orden["fecha"] = datetime.datetime.strptime(fechaOrden, "%d/%m/%Y")
                orden["estado"] = estado
                orden["productos"] = productos
                orden["pago"] = factura
                orden["ciudad"] = ciudad
                orders.insert_one(orden)

print "Los datos fueron cargados"

