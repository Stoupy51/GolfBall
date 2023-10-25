
#> golf_ball:ball/collision_entity
#
# @within			golf_ball:ball/collision_physics
# @executed			as the collider & at the base of the ball (baby pig)
#
# @description		Calculate the motion to add to the ball when it collides with an entity (1200 - the distance between the ball and the entity)
#

## Real:
# Store the position of the ball
execute store result score #x_collider golf_ball.data run data get entity @s Pos[0] 1000
execute store result score #z_collider golf_ball.data run data get entity @s Pos[2] 1000

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

