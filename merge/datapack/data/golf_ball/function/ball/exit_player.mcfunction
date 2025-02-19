
#> golf_ball:ball/exit_player
#
# @within			golf_ball:ball/tick_player
# @executed			at the base of the ball (baby pig) and as the player
#
# @description		Exit the player and kill the ball
#

# Advancement revoke
advancement revoke @s only golf_ball:exit_player

# Remove custom items and invisibility
clear @s *[custom_data~{golf_ball:1b}]
clear @s *[custom_data~{exit_golf_ball:1b}]
effect clear @s invisibility

# Remove the ball
execute on vehicle run tag @s add golf_ball.dead
execute on vehicle on passengers run kill @s[type=!player]
execute on vehicle run kill @s

# Dismount the ball
ride @s dismount
tp @s ~ ~1 ~

# Restore player size
attribute @s scale base reset

