
#> golf_ball:ball/right_click
#
# @within			golf_ball:ball/tick_player
# @executed			at the base of the ball (baby pig) and at the player
#
# @description		The player right clicked, so we need to launch the ball where he is looking
#

# Increase shots
scoreboard players add @s golf_ball.shots 1

# Copy ball parameters
execute on vehicle run scoreboard players operation #do_y_shots golf_ball.data = @s golf_ball.do_y_shots
execute on vehicle run scoreboard players operation #strength_percentage golf_ball.data = @s golf_ball.strength_percentage

# Summon marker depending on the slot
execute store result score #hotbar_slot golf_ball.data run data get entity @s SelectedItemSlot
execute unless score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 0 positioned 0 0 0 rotated as @s rotated ~ 0 positioned ^ ^ ^400000 summon marker run function golf_ball:ball/marker
execute unless score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 1 positioned 0 0 0 rotated as @s rotated ~ 0 positioned ^ ^ ^800000 summon marker run function golf_ball:ball/marker
execute unless score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 2 positioned 0 0 0 rotated as @s rotated ~ 0 positioned ^ ^ ^1000000 summon marker run function golf_ball:ball/marker
execute unless score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 3 positioned 0 0 0 rotated as @s rotated ~ 0 positioned ^ ^ ^1200000 summon marker run function golf_ball:ball/marker
execute unless score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 4 positioned 0 0 0 rotated as @s rotated ~ 0 positioned ^ ^ ^1600000 summon marker run function golf_ball:ball/marker
execute unless score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 5 positioned 0 0 0 rotated as @s rotated ~ 0 positioned ^ ^ ^2400000 summon marker run function golf_ball:ball/marker
execute unless score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 6 positioned 0 0 0 rotated as @s rotated ~ 0 positioned ^ ^ ^3000000 summon marker run function golf_ball:ball/marker
execute unless score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 7 positioned 0 0 0 rotated as @s rotated ~ 0 positioned ^ ^ ^4200000 summon marker run function golf_ball:ball/marker
execute if score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 0 positioned 0 0 0 rotated as @s positioned ^ ^ ^400000 summon marker run function golf_ball:ball/marker
execute if score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 1 positioned 0 0 0 rotated as @s positioned ^ ^ ^800000 summon marker run function golf_ball:ball/marker
execute if score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 2 positioned 0 0 0 rotated as @s positioned ^ ^ ^1000000 summon marker run function golf_ball:ball/marker
execute if score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 3 positioned 0 0 0 rotated as @s positioned ^ ^ ^1200000 summon marker run function golf_ball:ball/marker
execute if score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 4 positioned 0 0 0 rotated as @s positioned ^ ^ ^1600000 summon marker run function golf_ball:ball/marker
execute if score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 5 positioned 0 0 0 rotated as @s positioned ^ ^ ^2400000 summon marker run function golf_ball:ball/marker
execute if score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 6 positioned 0 0 0 rotated as @s positioned ^ ^ ^3000000 summon marker run function golf_ball:ball/marker
execute if score #do_y_shots golf_ball.data matches 1 if score #hotbar_slot golf_ball.data matches 7 positioned 0 0 0 rotated as @s positioned ^ ^ ^4200000 summon marker run function golf_ball:ball/marker
execute if score #hotbar_slot golf_ball.data matches 0..7 run scoreboard players set @s golf_ball.cooldown 51

# Add the motion to the ball
execute store result score #motion_x golf_ball.data run data get storage golf_ball:main Pos[0]
execute store result score #motion_z golf_ball.data run data get storage golf_ball:main Pos[2]
scoreboard players operation #motion_x golf_ball.data *= #strength_percentage golf_ball.data
scoreboard players operation #motion_z golf_ball.data *= #strength_percentage golf_ball.data
scoreboard players operation #motion_x golf_ball.data /= #100 golf_ball.data
scoreboard players operation #motion_z golf_ball.data /= #100 golf_ball.data
execute on vehicle run scoreboard players operation @s golf_ball.motion_x += #motion_x golf_ball.data
execute on vehicle run scoreboard players operation @s golf_ball.motion_z += #motion_z golf_ball.data
execute if score #do_y_shots golf_ball.data matches 1 on vehicle store result entity @s Motion[1] double 0.1 run data get storage golf_ball:main Pos[1] 0.00001

# Remember the original position
execute on vehicle run data modify storage golf_ball:main Pos set from entity @s Pos
execute on vehicle on passengers if entity @s[type=item_display] run data modify entity @s item.tag.Pos set from storage golf_ball:main Pos

# Playsound and particles
playsound entity.arrow.shoot ambient @s
particle cloud ~ ~ ~ 0.1 0.1 0.1 0.001 10

