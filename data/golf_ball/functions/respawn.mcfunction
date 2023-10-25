
#> golf_ball:respawn
#
# @within			nothing
# @executed			as & at the player that executes the command
#
# @description		Teleport the ball back to its original position
#

# Get position
execute on vehicle on passengers if entity @s[type=item_display] run data modify storage golf_ball:main Pos set from entity @s item.tag.Pos

# Apply position
execute on vehicle run data modify entity @s Pos set from storage golf_ball:main Pos

