
#> golf_ball:ball/ride_vehicle_macro
#
# @executed	as @e[type=item_display,tag=golf_ball.display] & at @s
#
# @within	golf_ball:ball/tick_display with entity @s item.components."minecraft:profile"
#
# @args		name (unknown)
#

$execute on vehicle run ride $(name) mount @s

