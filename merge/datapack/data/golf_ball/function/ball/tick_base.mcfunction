
#> golf_ball:ball/tick_base
#
# @executed			as & at the base of the ball (baby pig)
#
# @description		Manage the tick of the ball
#

# Player tick
execute on passengers if entity @s[type=player] run function golf_ball:ball/tick_player

# Rotate the display of the ball (+180°)
execute if data storage golf_ball:temp Rotation on passengers if entity @s[type=item_display] run function golf_ball:ball/apply_rotation

# Physics calculations
function golf_ball:ball/physics

