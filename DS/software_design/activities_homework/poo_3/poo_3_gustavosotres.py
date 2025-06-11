from typing import (List)

class Enemy:
	"""Im a bad guy"""
	def __init__(self, name: str, healt: int) -> None:
		self.name = name 
		self.healt = healt

class Level:
	"""Hello, I'm a level"""
	def __init__(self, name: str, n_enemies: int) -> None:
		self.name = name 
		self.enemies : List[Enemy] = []
		for i in range(n_enemies):
			self.enemies.append(
				Enemy(
					f"Enemy {i}. Lvl: {self.name}",
					100
					),
				)
	
	def play(self):
		print(f"Playing level {self.name}")
		
			
class Game:
	"""Start a new game"""
	def __init__(self, name: str, levels: List[Level]) -> None:
		self.name = name 
		self.levels : List[Level] = levels
		self._current_level: int = 0

	def next_level(self):
		self.levels[self._current_level].play()
		self._current_level = (self._current_level + 1) % len(self.levels)

if __name__ == "__main__":
	level_1 = Level("Fist", 5)
	level_2 = Level("Second", 7)
	level_3 = Level("Third", 2)

	single_player = Game(
		"Single player game",
		[
			level_1,
			level_3,
		]
	)
	multi_player = Game(
		"multi player game",
		[
			level_1,
			level_2,
			level_3,
		]
	)

	single_player.next_level()
	single_player.next_level()
	single_player.next_level()
	single_player.next_level()

	multi_player.next_level()
	multi_player.next_level()