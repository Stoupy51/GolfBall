
#> golf_ball:v1.4.4/load/tick_verification
#
# @within	#minecraft:tick
#

execute if score #golf_ball.major load.status matches 1 if score #golf_ball.minor load.status matches 4 if score #golf_ball.patch load.status matches 4 run function golf_ball:v1.4.4/tick

