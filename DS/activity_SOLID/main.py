"""Main module"""
from mongodb import MongoDB
from producto import Producto
from reporte import Reporte
from sql import SQL


if __name__ == "__main__":

    #sql_connection = SQL()
    mongo_connection = MongoDB()

    #sql_reporte = Reporte(database=sql_connection)
    mongo_reporte = Reporte(database=mongo_connection)

    #sql_reporte.abrir()
    mongo_reporte.abrir()

    producto_1 = Producto(id=1, nombre="Pelota", precio=250.20, cantidad= 10)
    producto_2 = Producto(id=2, nombre="Bate", precio=100.20, cantidad= 5)
    producto_3 = Producto(id=3, nombre="Cazuela", precio=30.20, cantidad= 3)
    producto_4 = Producto(id=4, nombre="Avion de juguete", precio=20.20, cantidad= 2)

    producto_actualizado = Producto(id=2, nombre="Batidora", precio=120.00, cantidad=3)

    #sql_reporte.database.insertar(producto=producto_1)
    #sql_reporte.database.insertar(producto=producto_2)
    #sql_reporte.database.insertar(producto=producto_3)
    #sql_reporte.database.insertar(producto=producto_4)

    #sql_reporte.database.actualizar(id=2, producto=producto_actualizado)
    #sql_reporte.cerrar()


    mongo_reporte.database.insertar(producto=producto_1)
    mongo_reporte.database.insertar(producto=producto_2)
    mongo_reporte.database.insertar(producto=producto_3)
    mongo_reporte.database.insertar(producto=producto_4)

    mongo_reporte.database.actualizar(id=2, producto=producto_actualizado)
    mongo_reporte.cerrar()
