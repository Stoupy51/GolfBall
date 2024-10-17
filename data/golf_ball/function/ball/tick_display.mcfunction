
#> golf_ball:ball/tick_display
#
# @within			golf_ball:tick
# @executed			as & at the item display
#
# @description		Manage the tick of the ball
#

# Check if the base is still alive
scoreboard players set #alive golf_ball.data 0
execute on vehicle if entity @s[tag=!golf_ball.dead] run scoreboard players set #alive golf_ball.data 1

# Force player to be on the ball
function golf_ball:ball/ride_vehicle_macro with entity @s item.components."minecraft:profile".name

# If the base is dead, kill the ball
execute if score #alive golf_ball.data matches 0 run scoreboard players remove #total_balls golf_ball.data 1
execute if score #alive golf_ball.data matches 0 run kill @s

# If the ball is alive, tick it
execute if score #alive golf_ball.data matches 1 on vehicle at @s run function golf_ball:ball/tick_base

# Spin forward the ball (not working as expected)
# execute store result score #rotation golf_ball.data run data get entity @s Rotation[1] 10
# scoreboard players operation #rotation golf_ball.data += #ball_spin golf_ball.data
# execute store result entity @s Rotation[1] float 0.1 run scoreboard players get #rotation golf_ball.data

