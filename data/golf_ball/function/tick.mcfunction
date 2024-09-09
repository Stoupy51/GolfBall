
# Back and forth score for the power of the shot
execute if score #direction golf_ball.data matches 1 run scoreboard players add #power golf_ball.data 20
execute if score #direction golf_ball.data matches 1 if score #power golf_ball.data > #max_power golf_ball.data run scoreboard players set #direction golf_ball.data -1
execute if score #direction golf_ball.data matches -1 run scoreboard players remove #power golf_ball.data 20
execute if score #direction golf_ball.data matches -1 if score #power golf_ball.data < #min_power golf_ball.data run scoreboard players set #direction golf_ball.data 1

# Ball ticking
execute as @e[tag=golf_ball.display] at @s run function golf_ball:ball/tick_display

