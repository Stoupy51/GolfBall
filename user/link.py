
# Imports
from python_datapack.constants import *
from python_datapack.utils.print import *
from python_datapack.utils.io import *
from config import *
import requests

# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def main(config: dict) -> None:
	write_to_tick_file(config, """
# Ball ticking
execute if score #total_balls golf_ball.data matches 1.. as @e[type=item_display,tag=golf_ball.display] at @s run function golf_ball:ball/tick_display
#execute if score #total_balls golf_ball.data matches 1.. as @e[type=item_display,tag=golf_ball.display,x=107,y=53,z=-134,dx=56,dy=56,dz=20] at @s run function golf_ball:ball/tick_display
""")

	write_to_load_file(config, """
scoreboard objectives remove golf_ball.right_click

scoreboard objectives add golf_ball.id dummy
scoreboard objectives add golf_ball.data dummy
scoreboard objectives add golf_ball.motion_x dummy
scoreboard objectives add golf_ball.motion_y dummy
scoreboard objectives add golf_ball.motion_z dummy
scoreboard objectives add golf_ball.predicted_x dummy
scoreboard objectives add golf_ball.predicted_y dummy
scoreboard objectives add golf_ball.predicted_z dummy
scoreboard objectives add golf_ball.cooldown dummy
scoreboard objectives add golf_ball.right_click dummy
scoreboard objectives add golf_ball.shots dummy {"text":" Shots ","color":"yellow"}
scoreboard objectives add golf_ball.power dummy
scoreboard objectives add golf_ball.power_direction dummy

# Friction scores
scoreboard objectives add golf_ball.friction_normal dummy
scoreboard objectives add golf_ball.friction_fast dummy
scoreboard objectives add golf_ball.friction_slippery dummy
scoreboard objectives add golf_ball.friction_slow dummy
scoreboard objectives add golf_ball.friction_very_slow dummy

# Misc scores
scoreboard objectives add golf_ball.do_y_shots dummy
scoreboard objectives add golf_ball.strength_percentage dummy
scoreboard objectives add golf_ball.energy_loss_percentage dummy
scoreboard objectives add golf_ball.collision_multiplier dummy
scoreboard objectives add golf_ball.do_collision dummy

# Load status and default values
scoreboard players set GolfBall load.status 1300
scoreboard players set #default_do_y_shots golf_ball.data 0
scoreboard players set #default_strength_percentage golf_ball.data 50
scoreboard players set #default_energy_loss_percentage golf_ball.data -90
scoreboard players set #default_collision_multiplier golf_ball.data 50
scoreboard players set #default_do_collision golf_ball.data 1

data modify storage golf_ball:main parameters set value {collision_distance:{selector_distance:"1.2",scoreboard:"1200"}}

scoreboard players set #-1 golf_ball.data -1
scoreboard players set #2 golf_ball.data 2
scoreboard players set #90 golf_ball.data 90
scoreboard players set #100 golf_ball.data 100
scoreboard players set #150 golf_ball.data 150
scoreboard players set #1000 golf_ball.data 1000
scoreboard players set #10000 golf_ball.data 10000

# Back and Forth power constants
scoreboard players set #min_power golf_ball.data 40
scoreboard players set #max_power golf_ball.data 500
scoreboard players set #direction_power golf_ball.data 1

# Count the number of balls
execute store result score #total_balls golf_ball.data if entity @e[type=item_display,tag=golf_ball.display]

#define storage golf_ball:main
#define storage golf_ball:temp
#define score_holder #success
#define score_holder #valid
#define score_holder #count
#define score_holder #temp
#define score_holder #pos

## Setup tellraw prefix
# tellraw @a ["\\n",{"nbt":"GolfBall","storage":"golf_ball:main","interpret":true},{"text":" Souhaitez tous la bienvenue à "},{"selector":"@s","color":"aqua"},{"text":" !\\nIl est le "},{"score":{"name":"#next_id","objective":"switch.data"},"color":"aqua"},{"text":"ème joueur a rejoindre !"}]
data modify storage golf_ball:main GolfBall set value '[{"text":"[GolfBall]","color":"green"}]'

# Percentages of the ball's speed that is kept every tick
scoreboard players set #k_normal golf_ball.data 90
scoreboard players set #k_fast golf_ball.data 95
scoreboard players set #k_slippery golf_ball.data 98
scoreboard players set #k_slow golf_ball.data 85
scoreboard players set #k_very_slow golf_ball.data 80
""")

