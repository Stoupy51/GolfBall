
#> golf_ball:ball/exit_player
#
# @within			golf_ball:ball/tick_player
# @executed			at the base of the ball (baby pig) and as the player
#
# @description		Exit the player and kill the ball
#

# Remove barrier block and invisibility
item replace entity @s hotbar.8 with air
effect clear @s invisibility

# Remove the ball
execute on vehicle run tag @s add golf_ball.dead
execute on vehicle run kill @s

# Dismount the ball
ride @s dismount

