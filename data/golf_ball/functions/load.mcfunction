
scoreboard objectives add golf_ball.data dummy
scoreboard objectives add golf_ball.motion_x dummy
scoreboard objectives add golf_ball.motion_z dummy
scoreboard objectives add golf_ball.predicted_x dummy
scoreboard objectives add golf_ball.predicted_z dummy
scoreboard objectives add golf_ball.cooldown dummy
scoreboard objectives add golf_ball.right_click minecraft.used:minecraft.warped_fungus_on_a_stick
scoreboard objectives add golf_ball.shots dummy {"text":" Shots ","color":"yellow"}

scoreboard players set GolfBall load.status 1000
scoreboard players set #enable_y_shots golf_ball.data 0
scoreboard players set #strength_percentage golf_ball.data 50
scoreboard players set #energy_loss_percentage golf_ball.data -90
scoreboard players set #collision_multiplier golf_ball.data 50
scoreboard players set #collision golf_ball.data 1

scoreboard players set #-1 golf_ball.data -1
scoreboard players set #2 golf_ball.data 2
scoreboard players set #90 golf_ball.data 90
scoreboard players set #100 golf_ball.data 100
scoreboard players set #1000 golf_ball.data 1000
scoreboard players set #10000 golf_ball.data 10000

#define storage golf_ball:main
#define storage golf_ball:temp
#define score_holder #success
#define score_holder #valid
#define score_holder #count
#define score_holder #temp
#define score_holder #pos

## Setup tellraw prefix
# tellraw @a ["\n",{"nbt":"GolfBall","storage":"golf_ball:main","interpret":true},{"text":" Souhaitez tous la bienvenue à "},{"selector":"@s","color":"aqua"},{"text":" !\nIl est le "},{"score":{"name":"#next_id","objective":"switch.data"},"color":"aqua"},{"text":"ème joueur a rejoindre !"}]
data modify storage golf_ball:main GolfBall set value '[{"text":"[GolfBall]","color":"green"}]'

# Percentages of the ball's speed that is kept every tick
scoreboard players set #k_normal golf_ball.data 90
scoreboard players set #k_fast golf_ball.data 95
scoreboard players set #k_slippery golf_ball.data 98
scoreboard players set #k_slow golf_ball.data 85
scoreboard players set #k_very_slow golf_ball.data 80

