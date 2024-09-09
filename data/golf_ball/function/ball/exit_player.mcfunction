
#> golf_ball:ball/exit_player
#
# @within			golf_ball:ball/tick_player
# @executed			at the base of the ball (baby pig) and as the player
#
# @description		Exit the player and kill the ball
#

# Advancement revoke
advancement revoke @s only golf_ball:exit_player

# Remove barrier block, warped fungus and invisibility
item replace entity @s weapon.offhand with air
item replace entity @s hotbar.8 with air
effect clear @s invisibility

# Remove the ball
execute on vehicle run tag @s add golf_ball.dead
execute on vehicle run kill @s

# Dismount the ball
ride @s dismount
tp @s ~ ~ ~

