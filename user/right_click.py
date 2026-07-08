
# Imports
from beet import Context
from stewbeet import write_function


# Setup right click functions
def setup_right_click_functions(ctx: Context) -> None:
	ns: str = ctx.project_id

	write_function(f"{ns}:right_click/advancement", f"""
# Revoke advancement
advancement revoke @s only {ns}:right_click
execute if score @s {ns}.cooldown matches 1.. run return fail
execute unless score @s {ns}.right_click matches 2.. run scoreboard players set @s {ns}.right_click 2

# Unless power and direction are set, set them to default
execute unless score @s {ns}.power matches 1.. run scoreboard players operation @s {ns}.power = #min_power {ns}.data
execute unless score @s {ns}.power_direction matches -1..1 run scoreboard players operation @s {ns}.power_direction = #direction_power {ns}.data

# Back and forth score for the power of the shot
execute if score @s {ns}.power_direction matches 1 run scoreboard players add @s {ns}.power 20
execute if score @s {ns}.power_direction matches 1 if score @s {ns}.power > #max_power {ns}.data run scoreboard players set @s {ns}.power_direction -1
execute if score @s {ns}.power_direction matches -1 run scoreboard players remove @s {ns}.power 20
execute if score @s {ns}.power_direction matches -1 if score @s {ns}.power < #min_power {ns}.data run scoreboard players set @s {ns}.power_direction 1

# Title action bar to show the power (steps of 19)
execute if score @s {ns}.power matches 040..059 run title @s actionbar [{{"text":"|","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"======================|"}}]
execute if score @s {ns}.power matches 060..079 run title @s actionbar [{{"text":"|=","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"=====================|"}}]
execute if score @s {ns}.power matches 080..099 run title @s actionbar [{{"text":"|==","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"====================|"}}]
execute if score @s {ns}.power matches 100..119 run title @s actionbar [{{"text":"|===","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"===================|"}}]
execute if score @s {ns}.power matches 120..139 run title @s actionbar [{{"text":"|====","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"==================|"}}]
execute if score @s {ns}.power matches 140..159 run title @s actionbar [{{"text":"|=====","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"=================|"}}]
execute if score @s {ns}.power matches 160..179 run title @s actionbar [{{"text":"|======","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"================|"}}]
execute if score @s {ns}.power matches 180..199 run title @s actionbar [{{"text":"|=======","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"===============|"}}]
execute if score @s {ns}.power matches 200..219 run title @s actionbar [{{"text":"|=========","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"=============|"}}]
execute if score @s {ns}.power matches 220..239 run title @s actionbar [{{"text":"|==========","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"============|"}}]
execute if score @s {ns}.power matches 240..259 run title @s actionbar [{{"text":"|===========","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"===========|"}}]
execute if score @s {ns}.power matches 260..279 run title @s actionbar [{{"text":"|============","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"==========|"}}]
execute if score @s {ns}.power matches 280..299 run title @s actionbar [{{"text":"|=============","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"=========|"}}]
execute if score @s {ns}.power matches 300..319 run title @s actionbar [{{"text":"|==============","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"========|"}}]
execute if score @s {ns}.power matches 320..339 run title @s actionbar [{{"text":"|===============","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"=======|"}}]
execute if score @s {ns}.power matches 340..359 run title @s actionbar [{{"text":"|================","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"======|"}}]
execute if score @s {ns}.power matches 360..379 run title @s actionbar [{{"text":"|=================","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"=====|"}}]
execute if score @s {ns}.power matches 380..399 run title @s actionbar [{{"text":"|==================","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"====|"}}]
execute if score @s {ns}.power matches 400..419 run title @s actionbar [{{"text":"|==================","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"====|"}}]
execute if score @s {ns}.power matches 420..439 run title @s actionbar [{{"text":"|===================","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"===|"}}]
execute if score @s {ns}.power matches 440..459 run title @s actionbar [{{"text":"|====================","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"==|"}}]
execute if score @s {ns}.power matches 460..479 run title @s actionbar [{{"text":"|=====================","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"=|"}}]
execute if score @s {ns}.power matches 480..500 run title @s actionbar [{{"text":"|======================","color":"green"}},{{"text":"P","color":"yellow"}},{{"text":"|"}}]
""")

	write_function(f"{ns}:right_click/get_motion", f"""
$execute positioned 0 0 0 rotated as @s positioned ^ ^ ^$(power)0000 summon marker run function {ns}:right_click/marker
""")

	write_function(f"{ns}:right_click/marker", f"""
#> {ns}:ball/marker
#
# @executed			as & at a temporary marker
#
# @description		Collect the marker position and kill it
#

data modify storage {ns}:main Pos set from entity @s Pos
execute unless score #do_y_shots {ns}.data matches 1 run data modify storage {ns}:main Pos[1] set value 0.0d
kill @s
""")

	write_function(f"{ns}:right_click/released", f"""
#> {ns}:ball/right_click
#
# @executed			at the base of the ball (baby pig) and as the player
#
# @description		The player right clicked, so we need to launch the ball where he is looking
#

# Increase shots, set cooldown, and reset the right click score
scoreboard players add @s {ns}.shots 1
scoreboard players set @s {ns}.cooldown 51
scoreboard players reset @s {ns}.right_click

# Copy ball parameters
execute on vehicle run scoreboard players operation #do_y_shots {ns}.data = @s {ns}.do_y_shots
execute on vehicle run scoreboard players operation #strength_percentage {ns}.data = @s {ns}.strength_percentage

# Summon marker and apply power to get the position
data modify storage {ns}:temp input set value {{power:0}}
execute store result storage {ns}:temp input.power int 1 run scoreboard players get @s {ns}.power
function {ns}:right_click/get_motion with storage {ns}:temp input

# Add the motion to the ball (legacy physics: through the motion scores consumed by the physics loop)
execute store result score #motion_x {ns}.data run data get storage {ns}:main Pos[0]
execute store result score #motion_z {ns}.data run data get storage {ns}:main Pos[2]
scoreboard players operation #motion_x {ns}.data *= #strength_percentage {ns}.data
scoreboard players operation #motion_z {ns}.data *= #strength_percentage {ns}.data
scoreboard players operation #motion_x {ns}.data /= #100 {ns}.data
scoreboard players operation #motion_z {ns}.data /= #100 {ns}.data
execute on vehicle if entity @s[tag={ns}.legacy] run scoreboard players operation @s {ns}.motion_x += #motion_x {ns}.data
execute on vehicle if entity @s[tag={ns}.legacy] run scoreboard players operation @s {ns}.motion_z += #motion_z {ns}.data
execute if score #do_y_shots {ns}.data matches 1 on vehicle store result entity @s Motion[1] double 0.1 run data get storage {ns}:main Pos[1] 0.00001
execute if score #do_y_shots {ns}.data matches 1 on vehicle store result score @s {ns}.predicted_y run data get entity @s Pos[1] 1000

# Add the motion to the ball (vanilla physics: write directly into the Motion NBT, the sulfur cube attributes handle friction/bounces/air drag)
execute on vehicle unless entity @s[tag={ns}.legacy] store result score #temp {ns}.data run data get entity @s Motion[0] 1000000
execute on vehicle unless entity @s[tag={ns}.legacy] run scoreboard players operation #motion_x {ns}.data += #temp {ns}.data
execute on vehicle unless entity @s[tag={ns}.legacy] store result entity @s Motion[0] double 0.000001 run scoreboard players get #motion_x {ns}.data
execute on vehicle unless entity @s[tag={ns}.legacy] store result score #temp {ns}.data run data get entity @s Motion[2] 1000000
execute on vehicle unless entity @s[tag={ns}.legacy] run scoreboard players operation #motion_z {ns}.data += #temp {ns}.data
execute on vehicle unless entity @s[tag={ns}.legacy] store result entity @s Motion[2] double 0.000001 run scoreboard players get #motion_z {ns}.data

# Remember the original position
execute on vehicle at @s unless block ~ ~-.1 ~ air run data modify storage {ns}:main Pos set from entity @s Pos
execute on vehicle at @s unless block ~ ~-.1 ~ air on passengers if entity @s[type=item_display] run data modify entity @s item.components."minecraft:custom_data".Pos set from storage {ns}:main Pos

# Reset power and direction
scoreboard players operation @s {ns}.power = #min_power {ns}.data
scoreboard players operation @s {ns}.power_direction = #direction_power {ns}.data

# Playsound and particles
playsound entity.arrow.shoot ambient @s
particle cloud ~ ~ ~ 0.1 0.1 0.1 0.001 10
""")

