
#> golf_ball:ball/post_summon
#
# @within			golf_ball:ball/summon
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

