
#> golf_ball:ball/marker
#
# @within			golf_ball:ball/right_click
# @executed			as & at a temporary marker
#
# @description		Collect the marker position and kill it
#

data modify storage golf_ball:main Pos set from entity @s Pos
kill @s

