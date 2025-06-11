

class Computer:
	"""Class to represent a computer"""

	def __init__(self) -> None:
		"""Let's give you a computer"""
		self.mhz: float = 0.0
		self.ram: float = 0.0

	@staticmethod
	def run_program(program: str) -> None:
		"""Run any program you want"""
		print(f"Running: {program}")


class MacbookPro(Computer):
	"""Nice"""

	def __init__(self) -> None:
		super().__init__()
		self.mhz = 3.5
		self.ram = 16.0
		self.screen_size: float = 16.0

	@staticmethod
	def make_start_up_sound() -> None:
		print(f"Mac goes: tuuuummmmm")


if __name__ == "__main__":
	mac = MacbookPro()
	mac.make_start_up_sound()
	Computer.run_program("Hello World")