
# Imports
from stewbeet import Context, write_load_file, write_tick_file


# Main function is run just before making finalyzing the build process (zip, headers, lang, ...)
def beet_default(ctx: Context) -> None:
	ns: str = ctx.project_id

	write_tick_file(f"""
# Ball ticking
execute if score #total_balls {ns}.data matches 1.. as @e[type=item_display,tag={ns}.display] at @s run function {ns}:ball/tick_display
#execute if score #total_balls {ns}.data matches 1.. as @e[type=item_display,tag={ns}.display,x=107,y=53,z=-134,dx=56,dy=56,dz=20] at @s run function {ns}:ball/tick_display
""")

	write_load_file(f"""
scoreboard objectives remove {ns}.right_click

scoreboard objectives add {ns}.id dummy
scoreboard objectives add {ns}.data dummy
scoreboard objectives add {ns}.motion_x dummy
scoreboard objectives add {ns}.motion_y dummy
scoreboard objectives add {ns}.motion_z dummy
scoreboard objectives add {ns}.predicted_x dummy
scoreboard objectives add {ns}.predicted_y dummy
scoreboard objectives add {ns}.predicted_z dummy
scoreboard objectives add {ns}.cooldown dummy
scoreboard objectives add {ns}.right_click dummy
scoreboard objectives add {ns}.shots dummy {{"text":" Shots ","color":"yellow"}}
scoreboard objectives add {ns}.power dummy
scoreboard objectives add {ns}.power_direction dummy

# Friction scores
scoreboard objectives add {ns}.friction_normal dummy
scoreboard objectives add {ns}.friction_fast dummy
scoreboard objectives add {ns}.friction_slippery dummy
scoreboard objectives add {ns}.friction_slow dummy
scoreboard objectives add {ns}.friction_very_slow dummy

# Misc scores
scoreboard objectives add {ns}.do_y_shots dummy
scoreboard objectives add {ns}.strength_percentage dummy
scoreboard objectives add {ns}.energy_loss_percentage dummy
scoreboard objectives add {ns}.collision_multiplier dummy
scoreboard objectives add {ns}.do_collision dummy

# Load status and default values
scoreboard players set #default_do_y_shots {ns}.data 0
scoreboard players set #default_strength_percentage {ns}.data 50
scoreboard players set #default_energy_loss_percentage {ns}.data -90
scoreboard players set #default_collision_multiplier {ns}.data 50
scoreboard players set #default_do_collision {ns}.data 1

data modify storage {ns}:main parameters set value {{collision_distance:{{selector_distance:"1.2",scoreboard:"1200"}}}}

scoreboard players set #-1 {ns}.data -1
scoreboard players set #2 {ns}.data 2
scoreboard players set #90 {ns}.data 90
scoreboard players set #100 {ns}.data 100
scoreboard players set #150 {ns}.data 150
scoreboard players set #1000 {ns}.data 1000
scoreboard players set #10000 {ns}.data 10000

# Back and Forth power constants
scoreboard players set #min_power {ns}.data 40
scoreboard players set #max_power {ns}.data 500
scoreboard players set #direction_power {ns}.data 1

# Count the number of balls
execute store result score #total_balls {ns}.data if entity @e[type=item_display,tag={ns}.display]

#define storage {ns}:main
#define storage {ns}:temp
#define score_holder #success
#define score_holder #valid
#define score_holder #count
#define score_holder #temp
#define score_holder #pos

## Setup tellraw prefix
data modify storage {ns}:main GolfBall set value [{{"text":"[GolfBall]","color":"green"}}]

# Percentages of the ball's speed that is kept every tick
scoreboard players set #k_normal {ns}.data 90
scoreboard players set #k_fast {ns}.data 95
scoreboard players set #k_slippery {ns}.data 98
scoreboard players set #k_slow {ns}.data 85
scoreboard players set #k_very_slow {ns}.data 80
""")

