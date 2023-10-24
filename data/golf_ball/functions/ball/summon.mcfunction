
#> golf_ball:ball/summon
#
# @within			nothing
# @executed			as & at the player who summoned the ball
#
# @description		Manage the summoning of a golf ball
#

# Temporary tag for the player
tag @s add golf_ball.temp

# Summoning a golf ball
summon cat ~ ~ ~ {Tags:["golf_ball.base","golf_ball.new"],Invulnerable:1b,Silent:1b,Age:-200000,Passengers:[{id:"minecraft:item_display",Tags:["golf_ball.display","golf_ball.new"],item_display:"ground",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-0.2f,0f],scale:[1f,1f,1f]},item:{id:"minecraft:emerald_block",Count:1b}}],active_effects:[{id:"minecraft:invisibility",amplifier:0b,duration:-1,show_particles:0b}],Attributes:[{Name:"generic.movement_speed",Base:0.00d}]}

# Replace the golf ball visual with a player head
loot replace entity @e[type=item_display,tag=golf_ball.new] container.0 loot golf_ball:player_head

# Additional summoning commands
execute as @e[type=pig,tag=golf_ball.new] at @s run function golf_ball:ball/post_summon

# Remove the temporary tag
tag @s remove golf_ball.temp

