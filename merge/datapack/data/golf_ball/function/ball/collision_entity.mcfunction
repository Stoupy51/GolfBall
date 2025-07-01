
#> golf_ball:ball/collision_entity
#
# @executed			as the collider & at the base of the ball (baby pig)
#
# @description		Calculate the motion to add to the ball when it collides with an entity (1200 - the distance between the ball and the entity)
#

## Real:
# Store the position of the collider and its motion
execute store result score #x_collider golf_ball.data run data get entity @s Pos[0] 1000
execute store result score #z_collider golf_ball.data run data get entity @s Pos[2] 1000
execute store result score #power_of_the_collision golf_ball.data run data get entity @s Motion[0] 1000
execute store result score #my_collider golf_ball.data run data get entity @s Motion[1] 1000
execute store result score #mz_collider golf_ball.data run data get entity @s Motion[2] 1000

# Calculate the distance between the ball and the entity
scoreboard players operation #x_collider golf_ball.data -= #x golf_ball.data
scoreboard players operation #z_collider golf_ball.data -= #z golf_ball.data

# Calculate the motion to add
$scoreboard players set #one_minus_x golf_ball.data $(scoreboard)
execute if score #x_collider golf_ball.data matches 0.. run scoreboard players operation #one_minus_x golf_ball.data -= #x_collider golf_ball.data
execute if score #x_collider golf_ball.data matches ..-1 run scoreboard players operation #one_minus_x golf_ball.data += #x_collider golf_ball.data
execute if score #x_collider golf_ball.data matches ..-1 run scoreboard players operation #one_minus_x golf_ball.data *= #-1 golf_ball.data
scoreboard players operation #x_motion_to_add golf_ball.data += #one_minus_x golf_ball.data
$scoreboard players set #one_minus_z golf_ball.data $(scoreboard)
execute if score #z_collider golf_ball.data matches 0.. run scoreboard players operation #one_minus_z golf_ball.data -= #z_collider golf_ball.data
execute if score #z_collider golf_ball.data matches ..-1 run scoreboard players operation #one_minus_z golf_ball.data += #z_collider golf_ball.data
execute if score #z_collider golf_ball.data matches ..-1 run scoreboard players operation #one_minus_z golf_ball.data *= #-1 golf_ball.data
scoreboard players operation #z_motion_to_add golf_ball.data += #one_minus_z golf_ball.data

# Calculate the product of all the motion components (absolute values)
execute if score #power_of_the_collision golf_ball.data matches ..-1 run scoreboard players operation #power_of_the_collision golf_ball.data *= #-1 golf_ball.data
execute if score #my_collider golf_ball.data matches ..-1 run scoreboard players operation #my_collider golf_ball.data *= #-1 golf_ball.data
execute if score #mz_collider golf_ball.data matches ..-1 run scoreboard players operation #mz_collider golf_ball.data *= #-1 golf_ball.data
scoreboard players operation #power_of_the_collision golf_ball.data += #my_collider golf_ball.data
scoreboard players operation #power_of_the_collision golf_ball.data += #mz_collider golf_ball.data

# Multiply the product with one_minus_x and one_minus_z to add extra motion to the ball
scoreboard players operation #one_minus_x golf_ball.data *= #power_of_the_collision golf_ball.data
scoreboard players operation #one_minus_z golf_ball.data *= #power_of_the_collision golf_ball.data
scoreboard players operation #one_minus_x golf_ball.data /= #1000 golf_ball.data
scoreboard players operation #one_minus_z golf_ball.data /= #1000 golf_ball.data

# Verbose
#tellraw @a [{"text":"power_of_collision: ","color":"aqua"},{"score":{"name":"#power_of_the_collision","objective":"golf_ball.data"},"color":"yellow"},{"text":", one_minus_x&z: "},{"score":{"name":"#one_minus_x","objective":"golf_ball.data"},"color":"yellow"},{"text":" & "},{"score":{"name":"#one_minus_z","objective":"golf_ball.data"},"color":"yellow"}]

# Add the extra motion to the ball
scoreboard players operation #x_motion_to_add golf_ball.data += #one_minus_x golf_ball.data
scoreboard players operation #z_motion_to_add golf_ball.data += #one_minus_z golf_ball.data


