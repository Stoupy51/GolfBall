
#> golf_ball:v1.4.0/tick
#
# @within	golf_ball:v1.4.0/load/tick_verification
#

# Ball ticking
execute if score #total_balls golf_ball.data matches 1.. as @e[type=item_display,tag=golf_ball.display] at @s run function golf_ball:ball/tick_display
#execute if score #total_balls golf_ball.data matches 1.. as @e[type=item_display,tag=golf_ball.display,x=107,y=53,z=-134,dx=56,dy=56,dz=20] at @s run function golf_ball:ball/tick_display

