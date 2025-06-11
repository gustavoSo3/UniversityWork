"""Representation of an entry in the database"""

from dataclasses import dataclass

@dataclass
class Producto:
    """Represents an entry in the database
    id : int
    nombre : str
    precio : float
    cantidad : int
    """
    id: int
    nombre: str
    precio: float
    cantidad: int
