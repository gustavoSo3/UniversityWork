# https://www.ursinaengine.org/api_reference.html

from ursina import *
from ursina.prefabs.first_person_controller import FirstPersonController

from modo_juego import CreativeGameMode, SurvivalGameMode

app = Ursina()

DEFAULT_TEXTURE = load_texture('assets/grass_block.png')
sky_texture = load_texture('assets/skybox.png')
arm_texture = load_texture('assets/arm_texture.png')
punch_sound = Audio('assets/stone.aiff', loop=False, autoplay=False)
grass_sound = Audio('assets/grass2.wav', loop=False, autoplay=False)

BLOCK_PICK = 1
# Aqui se aplica lo de factory elegir el modo de juego
# game_mode = SurvivalGameMode()
game_mode = CreativeGameMode()

window.fps_counter.visible = False
window.exit_button.visible = False
window.fullscreen = False


def update():
    global BLOCK_PICK

    if held_keys['left mouse'] or held_keys['left mouse']:
        hand.active()
    else:
        hand.pasive()

    # Se bajo el numero de bloques por modo para demostracion
    if held_keys['1']:
        BLOCK_PICK = 1
    if held_keys['2']:
        BLOCK_PICK = 2


class Voxel(Button):
    def __init__(self, position=(0, 0, 0), texture=DEFAULT_TEXTURE):
        super().__init__(
            parent=scene,
            position=position,
            model='assets/block',
            origin_y=0.5,
            texture=texture,
            color=color.white,
            scale=0.5,
            highlight_color=color.lime,
        )

    def input(self, key):
        if self.hovered:
            if key == 'left mouse down':
                punch_sound.play()
                # Aqui solo podemos elegir cubos del game_mode
                if BLOCK_PICK == 1:
                    Voxel(position=self.position +
                          mouse.normal, texture=game_mode.place(game_mode.CubeType.GRASS))
                if BLOCK_PICK == 2:
                    Voxel(position=self.position +
                          mouse.normal, texture=game_mode.place(game_mode.CubeType.BRICK))

            if key == 'right mouse down':
                grass_sound.play()
                destroy(self)


class Hand(Entity):
    def __init__(self):
        super().__init__(
            parent=camera.ui,
            model='assets/arm',
            texture=arm_texture,
            scale=0.2,
            rotation=Vec3(150, -10, 0),
            position=Vec2(0.4, -0.6)
        )

    def active(self):
        self.position = Vec2(0.3, -0.5)

    def pasive(self):
        self.position = Vec2(0.4, -0.6)


for z in range(20):
    for x in range(20):
        voxel = Voxel(
            position=(x, 0, z),
            texture=DEFAULT_TEXTURE
        )

Audio('assets/musica.mp3', loop=True, automplay=True)
player = FirstPersonController()
sky = Sky()
hand = Hand()
Text('Presiona Alt+F4 para salir', origin=(.5, 0), position=(-.55, .4))

app.run()
