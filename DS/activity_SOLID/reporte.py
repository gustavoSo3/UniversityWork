"""Reporte"""
from database import Database

class Reporte:
    """A class representign a product report"""

    def __init__(self, database:Database) -> None:
        self.database = database

    def abrir(self):
        """Método que abrirá la conexión con la base de datos"""
        self.database.abrir()

    def cerrar(self):
        """Método que cerrará la conexión con la base de datos"""
        self.database.cerrar()
