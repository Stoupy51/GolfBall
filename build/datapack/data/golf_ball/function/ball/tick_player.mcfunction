
#> golf_ball:ball/tick_player
#
# @within	golf_ball:ball/tick_base
#			golf_ball:summon
#
# @executed			at the base of the ball (baby pig) and as the player
# 
# @description		Manage the player's inputs
#

# Invisibility effect
effect give @s invisibility 1 9 true

# Items for right click detection (Make sure the offhand is empty and one of the two last slots in the hotbar is empty)
execute unless data entity @s Inventory[-1].components."minecraft:custom_data".golf_ball run item replace entity @s weapon.offhand with command_block[item_model="air",item_name={"text":"Right Click Detection","color":"gray"},custom_data={golf_ball:1b},consumable={consume_seconds:1000000}]
execute unless data entity @s Inventory[].components."minecraft:custom_data".exit_golf_ball if data entity @s Inventory[{Slot:8b}] run item replace entity @s hotbar.7 with barrier[custom_data={exit_golf_ball:1b},item_name={"text":"Abandon","color":"red","italic":false},attribute_modifiers=[{"id":"golf_ball:block_interaction_range","type":"block_interaction_range",amount:-1024,operation:"add_value",slot:"any"}],consumable={}]
execute unless data entity @s Inventory[].components."minecraft:custom_data".exit_golf_ball run item replace entity @s hotbar.8 with barrier[custom_data={exit_golf_ball:1b},item_name={"text":"Abandon","color":"red","italic":false},attribute_modifiers=[{"id":"golf_ball:block_interaction_range","type":"block_interaction_range",amount:-1024,operation:"add_value",slot:"any"}],consumable={}]

# Right click detection score (when the player stops right clicking)
execute if score @s golf_ball.right_click matches 1.. run scoreboard players remove @s golf_ball.right_click 1
execute if score @s golf_ball.right_click matches 0 run function golf_ball:right_click/released

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

