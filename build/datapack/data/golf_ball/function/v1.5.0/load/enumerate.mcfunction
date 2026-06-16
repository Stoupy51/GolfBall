
#> golf_ball:v1.5.0/load/enumerate
#
# @within	#golf_ball:enumerate
#

# If current major is too low, set it to the current major
execute unless score #golf_ball.major load.status matches 1.. run scoreboard players set #golf_ball.major load.status 1

# If current minor is too low, set it to the current minor (only if major is correct)
execute if score #golf_ball.major load.status matches 1 unless score #golf_ball.minor load.status matches 5.. run scoreboard players set #golf_ball.minor load.status 5

# If current patch is too low, set it to the current patch (only if major and minor are correct)
execute if score #golf_ball.major load.status matches 1 if score #golf_ball.minor load.status matches 5 unless score #golf_ball.patch load.status matches 0.. run scoreboard players set #golf_ball.patch load.status 0

