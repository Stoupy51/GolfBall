
# ruff: noqa: E501
# Imports
from beet import Context
from stewbeet import write_function


# Setup ball functions
def setup_ball_functions(ctx: Context) -> None:
	ns: str = ctx.project_id

	write_function(f"{ns}:ball/apply_rotation", f"""
#> {ns}:ball/apply_rotation
#
# @executed			at the base of the ball (baby pig) & as the item display
#
# @description		Manage the tick of the ball
#

execute store result score #rotation {ns}.data run data get storage {ns}:temp Rotation[0] 10
scoreboard players add #rotation {ns}.data 1800
execute store result entity @s[type=item_display] Rotation[0] float 0.1 run scoreboard players get #rotation {ns}.data
data remove storage {ns}:temp Rotation
""")

	write_function(f"{ns}:ball/bounce_physics", f"""
#> {ns}:ball/bounce_physics
#
# @executed			as & at the base of the ball (baby pig)
#
# @description		Manage the bounce physics of the ball:
#					- If the ball go into a wall, we reverse the direction of the ball.
#					The direction that is reversed is where the difference with the prediction is the highest.
#					Also, we take 90% of the speed of the ball to simulate the loss of energy.
#
# @example			If dx = 5 and dy = 9, and the ball go into a wall, we reverse the direction of the ball to dx = 5 and dy = -8.
#

# Verbose for debug
#tellraw @a [{{"text":"x : (","color":"aqua"}},{{"score":{{"name":"#pos_x","objective":"{ns}.data"}},"color":"yellow"}},{{"text":" - "}},{{"score":{{"name":"@s","objective":"{ns}.predicted_x"}},"color":"yellow"}},{{"text":") / z : ("}},{{"score":{{"name":"#pos_z","objective":"{ns}.data"}},"color":"yellow"}},{{"text":" - "}},{{"score":{{"name":"@s","objective":"{ns}.predicted_z"}},"color":"yellow"}},{{"text":")"}}]
#tellraw @a [{{"text":"dx/dz : (","color":"aqua"}},{{"score":{{"name":"#dx","objective":"{ns}.data"}},"color":"yellow"}},{{"text":","}},{{"score":{{"name":"#dz","objective":"{ns}.data"}},"color":"yellow"}},{{"text":"), Motion : ("}},{{"score":{{"name":"@s","objective":"{ns}.motion_x"}},"color":"yellow"}},{{"text":","}},{{"score":{{"name":"@s","objective":"{ns}.motion_z"}},"color":"yellow"}},{{"text":")"}}]

# Calculate the absolute value of dx and dz
scoreboard players operation #abs_dx {ns}.data = #dx {ns}.data
scoreboard players operation #abs_dz {ns}.data = #dz {ns}.data
execute if score #abs_dx {ns}.data matches ..-1 run scoreboard players operation #abs_dx {ns}.data *= #-1 {ns}.data
execute if score #abs_dz {ns}.data matches ..-1 run scoreboard players operation #abs_dz {ns}.data *= #-1 {ns}.data

# Bounce the ball
execute if score #abs_dx {ns}.data >= #abs_dz {ns}.data run scoreboard players operation @s {ns}.motion_x *= @s {ns}.energy_loss_percentage
execute if score #abs_dx {ns}.data >= #abs_dz {ns}.data run scoreboard players operation @s {ns}.motion_x /= #100 {ns}.data
execute if score #abs_dx {ns}.data < #abs_dz {ns}.data run scoreboard players operation @s {ns}.motion_z *= @s {ns}.energy_loss_percentage
execute if score #abs_dx {ns}.data < #abs_dz {ns}.data run scoreboard players operation @s {ns}.motion_z /= #100 {ns}.data

# Particles
particle angry_villager ~ ~ ~ 0 0 0 0 1 force @a[distance=..128]
""")

	write_function(f"{ns}:ball/collision_entity", f"""
#> {ns}:ball/collision_entity
#
# @executed			as the collider & at the base of the ball (baby pig)
#
# @description		Calculate the motion to add to the ball when it collides with an entity (1200 - the distance between the ball and the entity)
#

## Real:
# Store the position of the collider and its motion
execute store result score #x_collider {ns}.data run data get entity @s Pos[0] 1000
execute store result score #z_collider {ns}.data run data get entity @s Pos[2] 1000
execute store result score #power_of_the_collision {ns}.data run data get entity @s Motion[0] 1000
execute store result score #my_collider {ns}.data run data get entity @s Motion[1] 1000
execute store result score #mz_collider {ns}.data run data get entity @s Motion[2] 1000

# Calculate the distance between the ball and the entity
scoreboard players operation #x_collider {ns}.data -= #x {ns}.data
scoreboard players operation #z_collider {ns}.data -= #z {ns}.data

# Calculate the motion to add
$scoreboard players set #one_minus_x {ns}.data $(scoreboard)
execute if score #x_collider {ns}.data matches 0.. run scoreboard players operation #one_minus_x {ns}.data -= #x_collider {ns}.data
execute if score #x_collider {ns}.data matches ..-1 run scoreboard players operation #one_minus_x {ns}.data += #x_collider {ns}.data
execute if score #x_collider {ns}.data matches ..-1 run scoreboard players operation #one_minus_x {ns}.data *= #-1 {ns}.data
scoreboard players operation #x_motion_to_add {ns}.data += #one_minus_x {ns}.data
$scoreboard players set #one_minus_z {ns}.data $(scoreboard)
execute if score #z_collider {ns}.data matches 0.. run scoreboard players operation #one_minus_z {ns}.data -= #z_collider {ns}.data
execute if score #z_collider {ns}.data matches ..-1 run scoreboard players operation #one_minus_z {ns}.data += #z_collider {ns}.data
execute if score #z_collider {ns}.data matches ..-1 run scoreboard players operation #one_minus_z {ns}.data *= #-1 {ns}.data
scoreboard players operation #z_motion_to_add {ns}.data += #one_minus_z {ns}.data

# Calculate the product of all the motion components (absolute values)
execute if score #power_of_the_collision {ns}.data matches ..-1 run scoreboard players operation #power_of_the_collision {ns}.data *= #-1 {ns}.data
execute if score #my_collider {ns}.data matches ..-1 run scoreboard players operation #my_collider {ns}.data *= #-1 {ns}.data
execute if score #mz_collider {ns}.data matches ..-1 run scoreboard players operation #mz_collider {ns}.data *= #-1 {ns}.data
scoreboard players operation #power_of_the_collision {ns}.data += #my_collider {ns}.data
scoreboard players operation #power_of_the_collision {ns}.data += #mz_collider {ns}.data

# Multiply the product with one_minus_x and one_minus_z to add extra motion to the ball
scoreboard players operation #one_minus_x {ns}.data *= #power_of_the_collision {ns}.data
scoreboard players operation #one_minus_z {ns}.data *= #power_of_the_collision {ns}.data
scoreboard players operation #one_minus_x {ns}.data /= #1000 {ns}.data
scoreboard players operation #one_minus_z {ns}.data /= #1000 {ns}.data

# Verbose
#tellraw @a [{{"text":"power_of_collision: ","color":"aqua"}},{{"score":{{"name":"#power_of_the_collision","objective":"{ns}.data"}},"color":"yellow"}},{{"text":", one_minus_x&z: "}},{{"score":{{"name":"#one_minus_x","objective":"{ns}.data"}},"color":"yellow"}},{{"text":" & "}},{{"score":{{"name":"#one_minus_z","objective":"{ns}.data"}},"color":"yellow"}}]

# Add the extra motion to the ball
scoreboard players operation #x_motion_to_add {ns}.data += #one_minus_x {ns}.data
scoreboard players operation #z_motion_to_add {ns}.data += #one_minus_z {ns}.data

""")

	write_function(f"{ns}:ball/collision_physics", f"""
#> {ns}:ball/collision_physics
#
# @executed			as & at the base of the ball (baby pig)
#
# @description		Manage the collisions of the ball
#

# Store the position of the ball
execute store result score #x {ns}.data run data get entity @s Pos[0] 1000
execute store result score #z {ns}.data run data get entity @s Pos[2] 1000

# Setup the collision values
scoreboard players set #x_motion_to_add {ns}.data 0
scoreboard players set #z_motion_to_add {ns}.data 0

# For each entity that collides with the ball, add (max_distance - the distance between the ball and the entity) to the motion to add
$execute as @e[distance=0.01..$(selector_distance),type=!#{ns}:no_collision,predicate=!{ns}:has_vehicle] run function {ns}:ball/collision_entity {{scoreboard:"$(scoreboard)"}}
$execute as @e[distance=0.01..$(selector_distance),type=player,gamemode=!spectator,predicate=!{ns}:has_vehicle] run function {ns}:ball/collision_entity {{scoreboard:"$(scoreboard)"}}

# Verbose
#execute unless score #x_motion_to_add {ns}.data matches 0 unless score #z_motion_to_add {ns}.data matches 0 run tellraw @a [{{"text":"motion_to_add : (","color":"aqua"}},{{"score":{{"name":"#x_motion_to_add","objective":"{ns}.data"}},"color":"yellow"}},{{"text":", "}},{{"score":{{"name":"#z_motion_to_add","objective":"{ns}.data"}},"color":"yellow"}},{{"text":")"}}]

# Add the motion to the ball
scoreboard players operation #x_motion_to_add {ns}.data *= @s {ns}.collision_multiplier
scoreboard players operation #z_motion_to_add {ns}.data *= @s {ns}.collision_multiplier
scoreboard players operation @s {ns}.motion_x -= #x_motion_to_add {ns}.data
scoreboard players operation @s {ns}.motion_z -= #z_motion_to_add {ns}.data
""")

	write_function(f"{ns}:ball/exit_player", f"""
#> {ns}:ball/exit_player
#
# @executed			at the base of the ball (baby pig) and as the player
#
# @description		Exit the player and kill the ball
#

# Advancement revoke
advancement revoke @s only {ns}:exit_player

# Remove custom items and invisibility
clear @s *[custom_data~{{{ns}:1b}}]
clear @s *[custom_data~{{exit_{ns}:1b}}]
effect clear @s invisibility

# Remove the ball
execute on vehicle run tag @s add {ns}.dead
execute on vehicle on passengers run kill @s[type=!player]
execute on vehicle run kill @s

# Dismount the ball
ride @s dismount
tp @s ~ ~1 ~

# Restore player size
attribute @s scale base reset
""")

	write_function(f"{ns}:ball/physics", f"""
#> {ns}:ball/physics
#
# @executed			as & at the base of the ball (baby pig)
#
# @description		Manage the physics of the ball
#

## Get the position of the ball with a precision of 0.001
# Positions
execute store result score #pos_x {ns}.data run data get entity @s Pos[0] 1000
execute store result score #pos_y {ns}.data run data get entity @s Pos[1] 1000
execute store result score #pos_z {ns}.data run data get entity @s Pos[2] 1000

# Get the difference between the current position and the predicted position (pos - predicted_pos)
scoreboard players operation #dx {ns}.data = #pos_x {ns}.data
scoreboard players operation #dx {ns}.data -= @s {ns}.predicted_x
scoreboard players operation #dz {ns}.data = #pos_z {ns}.data
scoreboard players operation #dz {ns}.data -= @s {ns}.predicted_z
scoreboard players set #big_difference {ns}.data 0
execute unless score #dx {ns}.data matches -3..3 run scoreboard players set #big_difference {ns}.data 1
execute unless score #dz {ns}.data matches -3..3 run scoreboard players set #big_difference {ns}.data 1
execute if score #big_difference {ns}.data matches 1 run function {ns}:ball/bounce_physics

# Height bounce
scoreboard players operation #dy {ns}.data = #pos_y {ns}.data
scoreboard players operation #dy {ns}.data -= @s {ns}.predicted_y
execute positioned ~ ~-.5 ~ if predicate {ns}:in_water run scoreboard players set #dy {ns}.data 0
execute unless score #dy {ns}.data matches -3..3 run scoreboard players operation #my {ns}.data = @s {ns}.motion_y
execute unless score #dy {ns}.data matches -3..3 run scoreboard players operation #my {ns}.data *= @s {ns}.energy_loss_percentage
execute unless score #dy {ns}.data matches -3..3 run scoreboard players operation #my {ns}.data /= #150 {ns}.data
execute unless score #dy {ns}.data matches -3..3 unless score #my {ns}.data matches -10..300 store result entity @s Motion[1] double 0.001 run scoreboard players get #my {ns}.data
#tellraw @a [{{"text":"dy: "}},{{"score":{{"name":"#dy","objective":"{ns}.data"}}}}," - ",{{"score":{{"name":"#my","objective":"{ns}.data"}}}}]

## Collisions with entities
execute if score @s {ns}.do_collision matches 1 run function {ns}:ball/collision_physics with storage {ns}:main parameters.collision_distance



## Get the surface
# Surface : 0 = normal, 1 = fast, 2 = slippery, 3 = slow, 4 = very slow, in the air = slippery
# When in air : surface = 0
scoreboard players set #surface {ns}.data 0
execute if block ~ ~-.1 ~ #{ns}:surfaces/fast run scoreboard players set #surface {ns}.data 1
execute if block ~ ~-.1 ~ #{ns}:surfaces/slippery run scoreboard players set #surface {ns}.data 2
execute if block ~ ~-.1 ~ air run scoreboard players set #surface {ns}.data 2
execute if block ~ ~-.1 ~ #{ns}:surfaces/slow run scoreboard players set #surface {ns}.data 3
execute if block ~ ~-.1 ~ #{ns}:surfaces/very_slow run scoreboard players set #surface {ns}.data 4
execute if entity @s[tag={ns}.no_grip] run scoreboard players set #surface {ns}.data 2

## Calculate the motion depending on the surface
# Motion X
execute if score #surface {ns}.data matches 0 run scoreboard players operation @s {ns}.motion_x *= @s {ns}.friction_normal
execute if score #surface {ns}.data matches 1 run scoreboard players operation @s {ns}.motion_x *= @s {ns}.friction_fast
execute if score #surface {ns}.data matches 2 run scoreboard players operation @s {ns}.motion_x *= @s {ns}.friction_slippery
execute if score #surface {ns}.data matches 3 run scoreboard players operation @s {ns}.motion_x *= @s {ns}.friction_slow
execute if score #surface {ns}.data matches 4 run scoreboard players operation @s {ns}.motion_x *= @s {ns}.friction_very_slow
scoreboard players operation @s {ns}.motion_x /= #100 {ns}.data
execute store result entity @s Motion[0] double 0.000001 run scoreboard players get @s {ns}.motion_x

# Motion Y
execute store result score #my {ns}.data run data get entity @s Motion[1] 1000
scoreboard players operation @s {ns}.motion_y = #my {ns}.data


# Motion Z
execute if score #surface {ns}.data matches 0 run scoreboard players operation @s {ns}.motion_z *= @s {ns}.friction_normal
execute if score #surface {ns}.data matches 1 run scoreboard players operation @s {ns}.motion_z *= @s {ns}.friction_fast
execute if score #surface {ns}.data matches 2 run scoreboard players operation @s {ns}.motion_z *= @s {ns}.friction_slippery
execute if score #surface {ns}.data matches 3 run scoreboard players operation @s {ns}.motion_z *= @s {ns}.friction_slow
execute if score #surface {ns}.data matches 4 run scoreboard players operation @s {ns}.motion_z *= @s {ns}.friction_very_slow
scoreboard players operation @s {ns}.motion_z /= #100 {ns}.data
execute store result entity @s Motion[2] double 0.000001 run scoreboard players get @s {ns}.motion_z

## Predict the next position of the ball
# Normalize motion
scoreboard players operation #small_motion_x {ns}.data = @s {ns}.motion_x
scoreboard players operation #small_motion_z {ns}.data = @s {ns}.motion_z
scoreboard players operation #small_motion_x {ns}.data /= #1000 {ns}.data
scoreboard players operation #small_motion_z {ns}.data /= #1000 {ns}.data

# Apply prediction
scoreboard players operation @s {ns}.predicted_x = #pos_x {ns}.data
scoreboard players operation @s {ns}.predicted_x += #small_motion_x {ns}.data
scoreboard players operation @s {ns}.predicted_z = #pos_z {ns}.data
scoreboard players operation @s {ns}.predicted_z += #small_motion_z {ns}.data
scoreboard players operation @s {ns}.predicted_y = #pos_y {ns}.data
scoreboard players operation @s {ns}.predicted_y += #my {ns}.data
""")

	write_function(f"{ns}:ball/post_summon", f"""
#> {ns}:ball/post_summon
#
# @executed			as & at the summoned the ball
#
# @description		Manage the summoning of a golf ball
#

# Remove new tag and increase the count of golf balls
tag @s remove {ns}.new
execute on passengers run tag @s remove {ns}.new
scoreboard players add #total_balls {ns}.data 1

# Effects
effect give @s slowness infinite 255 true
effect give @s resistance infinite 255 true

# Make the player ride the ball
ride @p[tag={ns}.temp] mount @s

# Scale attribut to minimum
attribute @s scale base set 0.0
attribute @s jump_strength base set 0.0

# Remember pos, and apply interpolation
data modify storage {ns}:main Pos set from entity @s Pos
execute on passengers if entity @s[type=item_display] run data modify entity @s item.components."minecraft:custom_data".Pos set from storage {ns}:main Pos
execute on passengers if entity @s[type=item_display] run data modify entity @s teleport_duration set value 2

# Apply default values
scoreboard players operation @s {ns}.friction_normal = #k_normal {ns}.data
scoreboard players operation @s {ns}.friction_fast = #k_fast {ns}.data
scoreboard players operation @s {ns}.friction_slippery = #k_slippery {ns}.data
scoreboard players operation @s {ns}.friction_slow = #k_slow {ns}.data
scoreboard players operation @s {ns}.friction_very_slow = #k_very_slow {ns}.data

scoreboard players operation @s {ns}.do_y_shots = #default_do_y_shots {ns}.data
scoreboard players operation @s {ns}.strength_percentage = #default_strength_percentage {ns}.data
scoreboard players operation @s {ns}.energy_loss_percentage = #default_energy_loss_percentage {ns}.data
scoreboard players operation @s {ns}.collision_multiplier = #default_collision_multiplier {ns}.data
scoreboard players operation @s {ns}.do_collision = #default_do_collision {ns}.data

# Add conventions tags
tag @s add smithed.entity
tag @s add smithed.strict
tag @s add global.ignore
tag @s add global.ignore.kill
execute on passengers if entity @s[type=item_display] run tag @s add smithed.entity
execute on passengers if entity @s[type=item_display] run tag @s add smithed.strict
execute on passengers if entity @s[type=item_display] run tag @s add global.ignore
execute on passengers if entity @s[type=item_display] run tag @s add global.ignore.kill
""")

	write_function(f"{ns}:ball/ride_vehicle_macro", """
$execute on vehicle run ride $(name) mount @s
""")

	write_function(f"{ns}:ball/tick_base", f"""
#> {ns}:ball/tick_base
#
# @executed			as & at the base of the ball (baby pig)
#
# @description		Manage the tick of the ball
#

# Player tick
execute on passengers if entity @s[type=player] run function {ns}:ball/tick_player

# Rotate the display of the ball (+180°)
execute if data storage {ns}:temp Rotation on passengers if entity @s[type=item_display] run function {ns}:ball/apply_rotation

# Physics calculations (legacy engine only, vanilla sulfur cube balls rely on the bounciness/friction_modifier/air_drag_modifier attributes)
execute if entity @s[tag={ns}.legacy] run function {ns}:ball/physics
""")

	write_function(f"{ns}:ball/tick_display", f"""
#> {ns}:ball/tick_display
#
# @executed			as & at the item display
#
# @description		Manage the tick of the ball
#

# Check if the base is still alive
scoreboard players set #alive {ns}.data 0
execute on vehicle if entity @s[tag=!{ns}.dead] run scoreboard players set #alive {ns}.data 1

# Force player to be on the ball
execute if score #alive {ns}.data matches 1 run function {ns}:ball/ride_vehicle_macro with entity @s item.components."minecraft:profile"

# If the base is dead, kill the ball
execute if score #alive {ns}.data matches 0 run scoreboard players remove #total_balls {ns}.data 1
execute if score #alive {ns}.data matches 0 run kill @s

# If the ball is alive, tick it
execute if score #alive {ns}.data matches 1 on vehicle at @s run function {ns}:ball/tick_base

# Spin forward the ball (not working as expected)
# execute store result score #rotation {ns}.data run data get entity @s Rotation[1] 10
# scoreboard players operation #rotation {ns}.data += #ball_spin {ns}.data
# execute store result entity @s Rotation[1] float 0.1 run scoreboard players get #rotation {ns}.data
""")

	write_function(f"{ns}:ball/tick_player", f"""
#> {ns}:ball/tick_player
#
# @executed			at the base of the ball (baby pig) and as the player
#
# @description		Manage the player's inputs
#

# Invisibility effect
effect give @s invisibility 1 9 true

# Items for right click detection (Make sure the offhand is empty and one of the two last slots in the hotbar is empty)
execute unless data entity @s Inventory[-1].components."minecraft:custom_data".{ns} run item replace entity @s weapon.offhand with command_block[item_model="air",item_name={{"text":"Right Click Detection","color":"gray"}},custom_data={{{ns}:1b}},consumable={{consume_seconds:1000000}}]
execute unless data entity @s Inventory[].components."minecraft:custom_data".exit_{ns} if data entity @s Inventory[{{Slot:8b}}] run item replace entity @s hotbar.7 with barrier[custom_data={{exit_{ns}:1b}},item_name={{"text":"Abandon","color":"red","italic":false}},attribute_modifiers=[{{"id":"{ns}:block_interaction_range","type":"block_interaction_range",amount:-1024,operation:"add_value",slot:"any"}}],consumable={{}}]
execute unless data entity @s Inventory[].components."minecraft:custom_data".exit_{ns} run item replace entity @s hotbar.8 with barrier[custom_data={{exit_{ns}:1b}},item_name={{"text":"Abandon","color":"red","italic":false}},attribute_modifiers=[{{"id":"{ns}:block_interaction_range","type":"block_interaction_range",amount:-1024,operation:"add_value",slot:"any"}}],consumable={{}}]

# Right click detection score (when the player stops right clicking)
execute if score @s {ns}.right_click matches 1.. run scoreboard players remove @s {ns}.right_click 1
execute if score @s {ns}.right_click matches 0 run function {ns}:right_click/released

# Cooldown actionbar
execute if score @s {ns}.cooldown matches 01..02 run title @s actionbar {{"text":"|=========================|","color":"gray"}}
execute if score @s {ns}.cooldown matches 03..04 run title @s actionbar {{"text":"|========================-|","color":"gray"}}
execute if score @s {ns}.cooldown matches 05..06 run title @s actionbar {{"text":"|=======================--|","color":"gray"}}
execute if score @s {ns}.cooldown matches 07..08 run title @s actionbar {{"text":"|======================---|","color":"gray"}}
execute if score @s {ns}.cooldown matches 09..10 run title @s actionbar {{"text":"|=====================----|","color":"gray"}}
execute if score @s {ns}.cooldown matches 11..12 run title @s actionbar {{"text":"|====================-----|","color":"gray"}}
execute if score @s {ns}.cooldown matches 13..14 run title @s actionbar {{"text":"|===================------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 15..16 run title @s actionbar {{"text":"|==================-------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 17..18 run title @s actionbar {{"text":"|=================--------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 19..20 run title @s actionbar {{"text":"|================---------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 21..22 run title @s actionbar {{"text":"|===============----------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 23..24 run title @s actionbar {{"text":"|==============-----------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 25..26 run title @s actionbar {{"text":"|=============------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 27..28 run title @s actionbar {{"text":"|============-------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 29..30 run title @s actionbar {{"text":"|===========--------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 31..32 run title @s actionbar {{"text":"|==========---------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 33..34 run title @s actionbar {{"text":"|=========----------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 35..36 run title @s actionbar {{"text":"|========-----------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 37..38 run title @s actionbar {{"text":"|=======------------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 39..40 run title @s actionbar {{"text":"|======-------------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 41..42 run title @s actionbar {{"text":"|=====--------------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 43..44 run title @s actionbar {{"text":"|====---------------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 45..46 run title @s actionbar {{"text":"|===----------------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 47..48 run title @s actionbar {{"text":"|==-----------------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 0049.. run title @s actionbar {{"text":"|=------------------------|","color":"gray"}}
execute if score @s {ns}.cooldown matches 1.. run scoreboard players remove @s {ns}.cooldown 1

# Copy the player's rotation
data modify storage {ns}:temp Rotation set from entity @s Rotation
""")

