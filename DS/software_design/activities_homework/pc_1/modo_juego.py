from abc import ABC, abstractmethod
from enum import Enum

# Producto


class MCube(ABC):
    """Abstract Cube"""
    @abstractmethod
    def place(self) -> str:
        """Place a cube"""

# Producto concreto


class Grass(MCube):
    """A Grass Cube"""

    def place(self) -> str:
        return 'assets/grass_block.png'


class Brick(MCube):
    """A Brick Cube"""

    def place(self) -> str:
        return 'assets/brick_block.png'


class Stone(MCube):
    """A Stone Cube"""

    def place(self) -> str:
        return 'assets/stone_block.png'


class Dirt(MCube):
    """A Dirt Cube"""

    def place(self) -> str:
        return 'assets/dirt_block.png'


# Creadora
class GameMode:
    """GameMode Factory class"""

    def create_cube(self, cube_type) -> MCube:
        """Creates a new block from this game mode"""
        return cube_type.value

    def place(self, cube_type: MCube) -> str:
        """Place a block"""
        return self.create_cube(cube_type).place()

# Creadoras concretas


class CreativeGameMode(GameMode):
    """Creative Game Mode"""
    class CubeType(Enum):
        """Available Creative Cubes"""
        GRASS = Grass()
        BRICK = Brick()


class SurvivalGameMode(GameMode):
    """Survival Game Mode"""

    class CubeType(Enum):
        """Available Survival Cubes"""
        STONE = Stone()
        DIRT = Dirt()
