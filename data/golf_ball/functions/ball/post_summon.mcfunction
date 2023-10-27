
#> golf_ball:ball/post_summon
#
# @within			golf_ball:summon & golf_ball:steppable_summon
# @executed			as & at the summoned the ball
#
# @description		Manage the summoning of a golf ball
#

# Remove new tag
tag @s remove golf_ball.new
execute on passengers run tag @s remove golf_ball.new

# Effects
effect give @s slowness infinite 255 true
effect give @s resistance infinite 255 true

# Make the player ride the ball
ride @p[tag=golf_ball.temp] mount @s

# Remember pos
execute run data modify storage golf_ball:main Pos set from entity @s Pos
execute on passengers if entity @s[type=item_display] run data modify entity @s item.tag.Pos set from storage golf_ball:main Pos

# Apply default values
scoreboard players operation @s golf_ball.do_y_shots = #default_do_y_shots golf_ball.data
scoreboard players operation @s golf_ball.strength_percentage = #default_strength_percentage golf_ball.data
scoreboard players operation @s golf_ball.energy_loss_percentage = #default_energy_loss_percentage golf_ball.data
scoreboard players operation @s golf_ball.collision_multiplier = #default_collision_multiplier golf_ball.data
scoreboard players operation @s golf_ball.do_collision = #default_do_collision golf_ball.data

