
#> golf_ball:ball/bounce_physics
#
# @within			golf_ball:ball/physics
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
#tellraw @a [{"text":"x : (","color":"aqua"},{"score":{"name":"#pos_x","objective":"golf_ball.data"},"color":"yellow"},{"text":" - "},{"score":{"name":"@s","objective":"golf_ball.predicted_x"},"color":"yellow"},{"text":") / z : ("},{"score":{"name":"#pos_z","objective":"golf_ball.data"},"color":"yellow"},{"text":" - "},{"score":{"name":"@s","objective":"golf_ball.predicted_z"},"color":"yellow"},{"text":")"}]
#tellraw @a [{"text":"dx/dz : (","color":"aqua"},{"score":{"name":"#dx","objective":"golf_ball.data"},"color":"yellow"},{"text":","},{"score":{"name":"#dz","objective":"golf_ball.data"},"color":"yellow"},{"text":"), Motion : ("},{"score":{"name":"@s","objective":"golf_ball.motion_x"},"color":"yellow"},{"text":","},{"score":{"name":"@s","objective":"golf_ball.motion_z"},"color":"yellow"},{"text":")"}]

# Calculate the absolute value of dx and dz
scoreboard players operation #abs_dx golf_ball.data = #dx golf_ball.data
scoreboard players operation #abs_dz golf_ball.data = #dz golf_ball.data
execute if score #abs_dx golf_ball.data matches ..-1 run scoreboard players operation #abs_dx golf_ball.data *= #-1 golf_ball.data
execute if score #abs_dz golf_ball.data matches ..-1 run scoreboard players operation #abs_dz golf_ball.data *= #-1 golf_ball.data

# Bounce the ball
execute if score #abs_dx golf_ball.data > #abs_dz golf_ball.data run scoreboard players operation @s golf_ball.motion_x *= #energy_loss_percentage golf_ball.data
execute if score #abs_dx golf_ball.data > #abs_dz golf_ball.data run scoreboard players operation @s golf_ball.motion_x /= #100 golf_ball.data
execute if score #abs_dx golf_ball.data < #abs_dz golf_ball.data run scoreboard players operation @s golf_ball.motion_z *= #energy_loss_percentage golf_ball.data
execute if score #abs_dx golf_ball.data < #abs_dz golf_ball.data run scoreboard players operation @s golf_ball.motion_z /= #100 golf_ball.data

# Particles
particle angry_villager ~ ~ ~ 0 0 0 0 1 force @a[distance=..128]

