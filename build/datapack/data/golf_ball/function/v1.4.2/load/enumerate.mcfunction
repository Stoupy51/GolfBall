
#> golf_ball:v1.4.2/load/enumerate
#
# @within	#golf_ball:enumerate
#

# If current major is too low, set it to the current major
execute unless score #golf_ball.major load.status matches 1.. run scoreboard players set #golf_ball.major load.status 1

# If current minor is too low, set it to the current minor (only if major is correct)
execute if score #golf_ball.major load.status matches 1 unless score #golf_ball.minor load.status matches 4.. run scoreboard players set #golf_ball.minor load.status 4

# If current patch is too low, set it to the current patch (only if major and minor are correct)
execute if score #golf_ball.major load.status matches 1 if score #golf_ball.minor load.status matches 4 unless score #golf_ball.patch load.status matches 2.. run scoreboard players set #golf_ball.patch load.status 2

