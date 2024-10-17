
#> golf_ball:ball/tick_base
#
# @within			golf_ball:ball/tick_display
# @executed			as & at the base of the ball (baby pig)
#
# @description		Manage the tick of the ball
#

# Player tick
execute on passengers if entity @s[type=player] run function golf_ball:ball/tick_player

# Physics calculations
function golf_ball:ball/physics

