
#> golf_ball:ball/post_summon
#
# @executed			as & at the summoned the ball
#
# @description		Manage the summoning of a golf ball
#

# Remove new tag and increase the count of golf balls
tag @s remove golf_ball.new
execute on passengers run tag @s remove golf_ball.new
scoreboard players add #total_balls golf_ball.data 1

# Effects
effect give @s slowness infinite 255 true
effect give @s resistance infinite 255 true

# Make the player ride the ball
ride @p[tag=golf_ball.temp] mount @s

# Scale attribut to minimum
attribute @s scale base set 0.0
attribute @s jump_strength base set 0.0

# Remember pos, and apply interpolation
data modify storage golf_ball:main Pos set from entity @s Pos
execute on passengers if entity @s[type=item_display] run data modify entity @s item.components."minecraft:custom_data".Pos set from storage golf_ball:main Pos
execute on passengers if entity @s[type=item_display] run data modify entity @s teleport_duration set value 2

# Apply default values
scoreboard players operation @s golf_ball.friction_normal = #k_normal golf_ball.data
scoreboard players operation @s golf_ball.friction_fast = #k_fast golf_ball.data
scoreboard players operation @s golf_ball.friction_slippery = #k_slippery golf_ball.data
scoreboard players operation @s golf_ball.friction_slow = #k_slow golf_ball.data
scoreboard players operation @s golf_ball.friction_very_slow = #k_very_slow golf_ball.data

scoreboard players operation @s golf_ball.do_y_shots = #default_do_y_shots golf_ball.data
scoreboard players operation @s golf_ball.strength_percentage = #default_strength_percentage golf_ball.data
scoreboard players operation @s golf_ball.energy_loss_percentage = #default_energy_loss_percentage golf_ball.data
scoreboard players operation @s golf_ball.collision_multiplier = #default_collision_multiplier golf_ball.data
scoreboard players operation @s golf_ball.do_collision = #default_do_collision golf_ball.data

# Add conventions tags
tag @s add smithed.entity
tag @s add smithed.strict
tag @s add global.ignore
tag @s add global.ignore.kill
execute on passengers if entity @s[type=item_display] run tag @s add smithed.entity
execute on passengers if entity @s[type=item_display] run tag @s add smithed.strict
execute on passengers if entity @s[type=item_display] run tag @s add global.ignore
execute on passengers if entity @s[type=item_display] run tag @s add global.ignore.kill

