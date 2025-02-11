
#> golf_ball:v1.4.1/load/main
#
# @within	golf_ball:v1.4.1/load/resolve
#

# Avoiding multiple executions of the same load function
execute unless score #golf_ball.loaded load.status matches 1 run function golf_ball:v1.4.1/load/secondary

