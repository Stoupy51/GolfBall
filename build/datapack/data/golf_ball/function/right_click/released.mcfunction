
#> golf_ball:right_click/released
#
# @within	golf_ball:ball/tick_player
#
# @executed			at the base of the ball (baby pig) and as the player
# 
# @description		The player right clicked, so we need to launch the ball where he is looking
#

# Increase shots, set cooldown, and reset the right click score
scoreboard players add @s golf_ball.shots 1
scoreboard players set @s golf_ball.cooldown 51
scoreboard players reset @s golf_ball.right_click

# Copy ball parameters
execute on vehicle run scoreboard players operation #do_y_shots golf_ball.data = @s golf_ball.do_y_shots
execute on vehicle run scoreboard players operation #strength_percentage golf_ball.data = @s golf_ball.strength_percentage

# Summon marker and apply power to get the position
data modify storage golf_ball:temp input set value {power:0}
execute store result storage golf_ball:temp input.power int 1 run scoreboard players get @s golf_ball.power
function golf_ball:right_click/get_motion with storage golf_ball:temp input

# Add the motion to the ball
execute store result score #motion_x golf_ball.data run data get storage golf_ball:main Pos[0]
execute store result score #motion_z golf_ball.data run data get storage golf_ball:main Pos[2]
scoreboard players operation #motion_x golf_ball.data *= #strength_percentage golf_ball.data
scoreboard players operation #motion_z golf_ball.data *= #strength_percentage golf_ball.data
scoreboard players operation #motion_x golf_ball.data /= #100 golf_ball.data
scoreboard players operation #motion_z golf_ball.data /= #100 golf_ball.data
execute on vehicle run scoreboard players operation @s golf_ball.motion_x += #motion_x golf_ball.data
execute on vehicle run scoreboard players operation @s golf_ball.motion_z += #motion_z golf_ball.data
execute if score #do_y_shots golf_ball.data matches 1 on vehicle store result entity @s Motion[1] double 0.1 run data get storage golf_ball:main Pos[1] 0.00001
execute if score #do_y_shots golf_ball.data matches 1 on vehicle store result score @s golf_ball.predicted_y run data get entity @s Pos[1] 1000

# Remember the original position
execute on vehicle at @s unless block ~ ~-.1 ~ air run data modify storage golf_ball:main Pos set from entity @s Pos
execute on vehicle at @s unless block ~ ~-.1 ~ air on passengers if entity @s[type=item_display] run data modify entity @s item.components."minecraft:custom_data".Pos set from storage golf_ball:main Pos

# Reset power and direction
scoreboard players operation @s golf_ball.power = #min_power golf_ball.data
scoreboard players operation @s golf_ball.power_direction = #direction_power golf_ball.data

# Playsound and particles
playsound entity.arrow.shoot ambient @s
particle cloud ~ ~ ~ 0.1 0.1 0.1 0.001 10

