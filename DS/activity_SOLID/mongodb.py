"""Connection to MongoDB"""

from pymongo import MongoClient

from database import Database
from producto import Producto


class MongoDB(Database):
    """Connection to MongoDB"""

    def insertar(self, producto:Producto) -> None:
        """Insert in mongoDB"""
        self.collection.insert_one(
            {
                "id": producto.id,
                "name": producto.nombre,
                "precio": producto.precio,
                "cantidad": producto.cantidad
            }
        )
        print("Mongo: Insert correcto")

    def actulizar(self, id:int, producto: Producto) -> None:
        """Actualizar en mongo DB"""
        self.collection.update_one({"id":id}, {
                "id": producto.id,
                "name": producto.nombre,
                "precio": producto.precio,
                "cantidad": producto.cantidad
            })
        print("Mongo: Registro actualizado")

    def eliminar(self, id: int) -> None:
        """Eliminar en mongoDB"""
        self.collection.delete_one({"id" : id})
        print("Mongo: Producto eliminado")

    def abrir(self) -> None:
        self.client = MongoClient(
        )
        self.db = self.client["Solid"]
        self.collection = self.db["Productos"]
        print("Mongo: connectado")

    def cerrar(self) -> None:
        self.client.close()
        print("Mongo: desconectado")
