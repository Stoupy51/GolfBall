
# Ball ticking
execute as @e[tag=golf_ball.display] at @s run function golf_ball:ball/tick_display

# Reset right click
scoreboard players reset @a golf_ball.right_click

