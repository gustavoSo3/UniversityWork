from abc import ABC


class AirTransport(ABC):

	"""Interface for air transport"""

	def volar(self) -> str:
		return "I'm flying"

class Plane(AirTransport):
	"""Hello plane xD"""

	def __init__(self, name : str = "Plane") -> None:
		self.asientos : list = list()
		self._name : str = name
	
	def __str__(self) -> str:
		return f"{self._name} goes fiumm"
	
	@property
	def name(self) -> str:
		return f"Me llamo {self._name}"
	
	@name.setter
	def name(self, new_name : str) -> None:
		self._name = new_name

class Helicopter(AirTransport):
	"""Helicopter helicopter"""

	def __init__(self, name : str = "Helicopter") -> None:
		self.name = name
		
    

def main():
	boeing = Plane(name = "Boing")
	print(boeing)


if __name__ == "__main__":
    main()