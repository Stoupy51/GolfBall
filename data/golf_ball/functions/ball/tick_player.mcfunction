
#> golf_ball:ball/tick_player
#
# @within			golf_ball:ball/tick_base
# @executed			at the base of the ball (baby pig) and as the player
#
# @description		Manage the player's inputs
#

# Invisibility effect
effect give @s invisibility 1 9 true

# Right click detection
execute unless data entity @s Inventory[-1].tag.golf_ball run item replace entity @s weapon.offhand with warped_fungus_on_a_stick{CustomModelData:2010003,Unbreakable:1b,golf_ball:1b}
execute unless data entity @s Inventory[{Slot:8b}].tag.golf_ball run item replace entity @s hotbar.8 with barrier{golf_ball:1b,display:{Name:'{"text":"Sortir de la balle","color":"red","italic":false}'}}
execute if score @s golf_ball.right_click matches 1.. if data entity @s {SelectedItemSlot:8} run function golf_ball:ball/exit_player
execute if score @s golf_ball.right_click matches 1.. unless score @s golf_ball.cooldown matches 1.. unless data entity @s {SelectedItemSlot:8} at @s run function golf_ball:ball/right_click
scoreboard players reset @s golf_ball.right_click

# Cooldown actionbar
execute if score @s golf_ball.cooldown matches 01..02 run title @s actionbar {"text":"|=========================|","color":"gray"}
execute if score @s golf_ball.cooldown matches 03..04 run title @s actionbar {"text":"|========================-|","color":"gray"}
execute if score @s golf_ball.cooldown matches 05..06 run title @s actionbar {"text":"|=======================--|","color":"gray"}
execute if score @s golf_ball.cooldown matches 07..08 run title @s actionbar {"text":"|======================---|","color":"gray"}
execute if score @s golf_ball.cooldown matches 09..10 run title @s actionbar {"text":"|=====================----|","color":"gray"}
execute if score @s golf_ball.cooldown matches 11..12 run title @s actionbar {"text":"|====================-----|","color":"gray"}
execute if score @s golf_ball.cooldown matches 13..14 run title @s actionbar {"text":"|===================------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 15..16 run title @s actionbar {"text":"|==================-------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 17..18 run title @s actionbar {"text":"|=================--------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 19..20 run title @s actionbar {"text":"|================---------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 21..22 run title @s actionbar {"text":"|===============----------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 23..24 run title @s actionbar {"text":"|==============-----------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 25..26 run title @s actionbar {"text":"|=============------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 27..28 run title @s actionbar {"text":"|============-------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 29..30 run title @s actionbar {"text":"|===========--------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 31..32 run title @s actionbar {"text":"|==========---------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 33..34 run title @s actionbar {"text":"|=========----------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 35..36 run title @s actionbar {"text":"|========-----------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 37..38 run title @s actionbar {"text":"|=======------------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 39..40 run title @s actionbar {"text":"|======-------------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 41..42 run title @s actionbar {"text":"|=====--------------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 43..44 run title @s actionbar {"text":"|====---------------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 45..46 run title @s actionbar {"text":"|===----------------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 47..48 run title @s actionbar {"text":"|==-----------------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 0049.. run title @s actionbar {"text":"|=------------------------|","color":"gray"}
execute if score @s golf_ball.cooldown matches 1.. run scoreboard players remove @s golf_ball.cooldown 1

# Copy the player's rotation
data modify storage golf_ball:temp Rotation set from entity @s Rotation

