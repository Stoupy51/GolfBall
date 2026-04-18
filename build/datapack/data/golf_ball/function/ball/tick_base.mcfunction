
#> golf_ball:ball/tick_base
#
# @executed	at @s
#
# @within	golf_ball:ball/tick_display [ at @s ]
#
# @description		Manage the tick of the ball
#

# Player tick
execute on passengers if entity @s[type=player] run function golf_ball:ball/tick_player

# Rotate the display of the ball (+180°)
execute if data storage golf_ball:temp Rotation on passengers if entity @s[type=item_display] run function golf_ball:ball/apply_rotation

# Physics calculations
function golf_ball:ball/physics

