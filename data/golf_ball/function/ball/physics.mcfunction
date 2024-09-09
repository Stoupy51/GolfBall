
#> golf_ball:ball/physics
#
# @within			golf_ball:ball/tick_base
# @executed			as & at the base of the ball (baby pig)
#
# @description		Manage the physics of the ball
#

## Get the position of the ball with a precision of 0.001
# Positions
execute store result score #pos_x golf_ball.data run data get entity @s Pos[0] 1000
execute store result score #pos_y golf_ball.data run data get entity @s Pos[1] 1000
execute store result score #pos_z golf_ball.data run data get entity @s Pos[2] 1000

# Get the difference between the current position and the predicted position (pos - predicted_pos)
scoreboard players operation #dx golf_ball.data = #pos_x golf_ball.data
scoreboard players operation #dx golf_ball.data -= @s golf_ball.predicted_x
scoreboard players operation #dz golf_ball.data = #pos_z golf_ball.data
scoreboard players operation #dz golf_ball.data -= @s golf_ball.predicted_z
scoreboard players set #big_difference golf_ball.data 0
execute unless score #dx golf_ball.data matches -3..3 run scoreboard players set #big_difference golf_ball.data 1
execute unless score #dz golf_ball.data matches -3..3 run scoreboard players set #big_difference golf_ball.data 1
execute if score #big_difference golf_ball.data matches 1 run function golf_ball:ball/bounce_physics

# Height bounce
scoreboard players operation #dy golf_ball.data = #pos_y golf_ball.data
scoreboard players operation #dy golf_ball.data -= @s golf_ball.predicted_y
execute positioned ~ ~-.5 ~ if predicate golf_ball:in_water run scoreboard players set #dy golf_ball.data 0
execute unless score #dy golf_ball.data matches -3..3 run scoreboard players operation #my golf_ball.data = @s golf_ball.motion_y
execute unless score #dy golf_ball.data matches -3..3 run scoreboard players operation #my golf_ball.data *= @s golf_ball.energy_loss_percentage
execute unless score #dy golf_ball.data matches -3..3 run scoreboard players operation #my golf_ball.data /= #150 golf_ball.data
execute unless score #dy golf_ball.data matches -3..3 unless score #my golf_ball.data matches -10..300 store result entity @s Motion[1] double 0.001 run scoreboard players get #my golf_ball.data
#tellraw @a [{"text":"dy: "},{"score":{"name":"#dy","objective":"golf_ball.data"}}," - ",{"score":{"name":"#my","objective":"golf_ball.data"}}]

## Collisions with players
execute if score @s golf_ball.do_collision matches 1 run function golf_ball:ball/collision_physics with storage golf_ball:main parameters.collision_distance



## Get the surface
# Surface : 0 = normal, 1 = fast, 2 = slippery, 3 = slow, 4 = very slow, in the air = slippery
# When in air : surface = 0
scoreboard players set #surface golf_ball.data 0
execute if block ~ ~-.1 ~ #golf_ball:surfaces/fast run scoreboard players set #surface golf_ball.data 1
execute if block ~ ~-.1 ~ #golf_ball:surfaces/slippery run scoreboard players set #surface golf_ball.data 2
execute if block ~ ~-.1 ~ air run scoreboard players set #surface golf_ball.data 2
execute if block ~ ~-.1 ~ #golf_ball:surfaces/slow run scoreboard players set #surface golf_ball.data 3
execute if block ~ ~-.1 ~ #golf_ball:surfaces/very_slow run scoreboard players set #surface golf_ball.data 4
execute if entity @s[tag=golf_ball.no_grip] run scoreboard players set #surface golf_ball.data 2

## Calculate the motion depending on the surface
# Motion X
execute if score #surface golf_ball.data matches 0 run scoreboard players operation @s golf_ball.motion_x *= #k_normal golf_ball.data
execute if score #surface golf_ball.data matches 1 run scoreboard players operation @s golf_ball.motion_x *= #k_fast golf_ball.data
execute if score #surface golf_ball.data matches 2 run scoreboard players operation @s golf_ball.motion_x *= #k_slippery golf_ball.data
execute if score #surface golf_ball.data matches 3 run scoreboard players operation @s golf_ball.motion_x *= #k_slow golf_ball.data
execute if score #surface golf_ball.data matches 4 run scoreboard players operation @s golf_ball.motion_x *= #k_very_slow golf_ball.data
scoreboard players operation @s golf_ball.motion_x /= #100 golf_ball.data
execute store result entity @s Motion[0] double 0.000001 run scoreboard players get @s golf_ball.motion_x

# Motion Y
execute store result score #my golf_ball.data run data get entity @s Motion[1] 1000
scoreboard players operation @s golf_ball.motion_y = #my golf_ball.data


# Motion Z
execute if score #surface golf_ball.data matches 0 run scoreboard players operation @s golf_ball.motion_z *= #k_normal golf_ball.data
execute if score #surface golf_ball.data matches 1 run scoreboard players operation @s golf_ball.motion_z *= #k_fast golf_ball.data
execute if score #surface golf_ball.data matches 2 run scoreboard players operation @s golf_ball.motion_z *= #k_slippery golf_ball.data
execute if score #surface golf_ball.data matches 3 run scoreboard players operation @s golf_ball.motion_z *= #k_slow golf_ball.data
execute if score #surface golf_ball.data matches 4 run scoreboard players operation @s golf_ball.motion_z *= #k_very_slow golf_ball.data
scoreboard players operation @s golf_ball.motion_z /= #100 golf_ball.data
execute store result entity @s Motion[2] double 0.000001 run scoreboard players get @s golf_ball.motion_z

## Predict the next position of the ball
# Normalize motion
scoreboard players operation #small_motion_x golf_ball.data = @s golf_ball.motion_x
scoreboard players operation #small_motion_z golf_ball.data = @s golf_ball.motion_z
scoreboard players operation #small_motion_x golf_ball.data /= #1000 golf_ball.data
scoreboard players operation #small_motion_z golf_ball.data /= #1000 golf_ball.data

# Apply prediction
scoreboard players operation @s golf_ball.predicted_x = #pos_x golf_ball.data
scoreboard players operation @s golf_ball.predicted_x += #small_motion_x golf_ball.data
scoreboard players operation @s golf_ball.predicted_z = #pos_z golf_ball.data
scoreboard players operation @s golf_ball.predicted_z += #small_motion_z golf_ball.data
scoreboard players operation @s golf_ball.predicted_y = #pos_y golf_ball.data
scoreboard players operation @s golf_ball.predicted_y += #my golf_ball.data

