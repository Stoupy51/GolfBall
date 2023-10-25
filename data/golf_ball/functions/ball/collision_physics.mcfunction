
#> golf_ball:ball/collision_physics
#
# @within			golf_ball:ball/physics
# @executed			as & at the base of the ball (baby pig)
#
# @description		Manage the collisions of the ball
#

# Store the position of the ball
execute store result score #x golf_ball.data run data get entity @s Pos[0] 1000
execute store result score #z golf_ball.data run data get entity @s Pos[2] 1000

# Setup the collision values
scoreboard players set #x_motion_to_add golf_ball.data 0
scoreboard players set #z_motion_to_add golf_ball.data 0

# For each entity that collides with the ball, add (1500 - the distance between the ball and the entity) to the motion to add
execute as @e[distance=0.01..1.5,type=!item,predicate=!golf_ball:has_vehicle] run function golf_ball:ball/collision_entity

# Verbose
#execute unless score #x_motion_to_add golf_ball.data matches 0 unless score #z_motion_to_add golf_ball.data matches 0 run tellraw @a [{"text":"motion_to_add : (","color":"aqua"},{"score":{"name":"#x_motion_to_add","objective":"golf_ball.data"},"color":"yellow"},{"text":", "},{"score":{"name":"#z_motion_to_add","objective":"golf_ball.data"},"color":"yellow"},{"text":")"}]

# Add the motion to the ball
scoreboard players operation #x_motion_to_add golf_ball.data *= #collision_multiplier golf_ball.data
scoreboard players operation #z_motion_to_add golf_ball.data *= #collision_multiplier golf_ball.data
scoreboard players operation @s golf_ball.motion_x -= #x_motion_to_add golf_ball.data
scoreboard players operation @s golf_ball.motion_z -= #z_motion_to_add golf_ball.data

