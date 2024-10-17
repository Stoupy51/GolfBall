
# Ball ticking
execute if score #total_balls golf_ball.data matches 1.. as @e[tag=golf_ball.display] at @s run function golf_ball:ball/tick_display

