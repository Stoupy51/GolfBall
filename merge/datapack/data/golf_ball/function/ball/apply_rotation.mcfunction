
#> golf_ball:ball/apply_rotation
#
# @executed			at the base of the ball (baby pig) & as the item display
#
# @description		Manage the tick of the ball
#

execute store result score #rotation golf_ball.data run data get storage golf_ball:temp Rotation[0] 10
scoreboard players add #rotation golf_ball.data 1800
execute store result entity @s[type=item_display] Rotation[0] float 0.1 run scoreboard players get #rotation golf_ball.data
data remove storage golf_ball:temp Rotation

