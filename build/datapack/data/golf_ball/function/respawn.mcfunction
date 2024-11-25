
#> golf_ball:respawn
#
# @within	???
#

#> golf_ball:respawn
#
# @within			nothing
# @executed			as & at the player that executes the command
#
# @description		Teleport the ball back to its original position
#

# Get position
execute on vehicle on passengers if entity @s[type=item_display] run data modify storage golf_ball:main Pos set from entity @s item.components."minecraft:custom_data".Pos

# Apply position and remove motion
execute on vehicle run data modify entity @s Pos set from storage golf_ball:main Pos
execute on vehicle run scoreboard players set @s golf_ball.motion_x 0
execute on vehicle run scoreboard players set @s golf_ball.motion_y 0
execute on vehicle run scoreboard players set @s golf_ball.motion_z 0
execute on vehicle run data modify entity @s Motion set value [0.0d, 0.0d, 0.0d]

