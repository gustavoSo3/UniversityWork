from abc import ABC
from typing import List

class Swimmer(ABC):
	"""A creature that can swim"""
	def swim() -> str:
		"""Basic action of a swimmer"""
		pass

	def dive(meters: float) -> float:
		"""Call when swimmer wants to go deeper"""
		pass
	def rise(meters: float) -> float:
		"""Call when swimmer wants to rise"""
		pass

	def __repr__(self) -> str:
		return "I can swimm"

class Whale(Swimmer):
	"""The biggest animal on earth"""
	def __init__(self, air_capacity : float = 100.00) -> None:
		"""How much air can I hold?"""
		super().__init__()
		self.air_capacity : float = air_capacity
	
class Shark(Swimmer):
	"""Stay away from the theet"""
	def __init__(self, number_of_theet : int = 20) -> None:
		"""How dangerous am I?"""
		super().__init__()
		self.number_of_theet : int = number_of_theet
		
	def bite() -> None:
		"""Reduce healt of player if true"""
		pass

class HammerShark(Shark):
	"""You can't miss it"""
	def __init__(self, head_length : float = 100.00) -> None:
		"""How big is my head?"""
		super().__init__(25)
		self.head_length = head_length



if __name__ == "__main__":

	whale : Whale = Whale(air_capacity=20)
	hammer_shark : HammerShark = HammerShark(head_length=200.2)

	items : List[Swimmer] = [whale, hammer_shark]

	for swimmer in items:
		print(swimmer)