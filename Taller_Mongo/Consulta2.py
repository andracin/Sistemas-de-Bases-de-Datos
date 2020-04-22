import F2
salir = False
opcion = 0
import sys

user=sys.argv[1]

if len(sys.argv)>=2:
        F2.calcularTotalOrden(user)



else:
    print "Este programa necesita un parametro"
