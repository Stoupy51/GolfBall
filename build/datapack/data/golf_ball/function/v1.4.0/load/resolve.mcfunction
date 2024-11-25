
#> golf_ball:v1.4.0/load/resolve
#
# @within	#golf_ball:resolve
#

# If correct version, load the datapack
execute if score #golf_ball.major load.status matches 1 if score #golf_ball.minor load.status matches 4 if score #golf_ball.patch load.status matches 0 run function golf_ball:v1.4.0/load/main

