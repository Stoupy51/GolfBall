
# Revoke advancement
advancement revoke @s only golf_ball:right_click
execute if score @s golf_ball.cooldown matches 1.. run return fail
execute unless score @s golf_ball.right_click matches 2.. run scoreboard players set @s golf_ball.right_click 2

# Unless power and direction are set, set them to default
execute unless score @s golf_ball.power matches 1.. run scoreboard players operation @s golf_ball.power = #min_power golf_ball.data
execute unless score @s golf_ball.power_direction matches -1..1 run scoreboard players operation @s golf_ball.power_direction = #direction_power golf_ball.data

# Back and forth score for the power of the shot
execute if score @s golf_ball.power_direction matches 1 run scoreboard players add @s golf_ball.power 20
execute if score @s golf_ball.power_direction matches 1 if score @s golf_ball.power > #max_power golf_ball.data run scoreboard players set @s golf_ball.power_direction -1
execute if score @s golf_ball.power_direction matches -1 run scoreboard players remove @s golf_ball.power 20
execute if score @s golf_ball.power_direction matches -1 if score @s golf_ball.power < #min_power golf_ball.data run scoreboard players set @s golf_ball.power_direction 1

# Title action bar to show the power (steps of 19)
execute if score @s golf_ball.power matches 040..059 run title @s actionbar [{"text":"|","color":"green"},{"text":"P","color":"yellow"},{"text":"======================|"}]
execute if score @s golf_ball.power matches 060..079 run title @s actionbar [{"text":"|=","color":"green"},{"text":"P","color":"yellow"},{"text":"=====================|"}]
execute if score @s golf_ball.power matches 080..099 run title @s actionbar [{"text":"|==","color":"green"},{"text":"P","color":"yellow"},{"text":"====================|"}]
execute if score @s golf_ball.power matches 100..119 run title @s actionbar [{"text":"|===","color":"green"},{"text":"P","color":"yellow"},{"text":"===================|"}]
execute if score @s golf_ball.power matches 120..139 run title @s actionbar [{"text":"|====","color":"green"},{"text":"P","color":"yellow"},{"text":"==================|"}]
execute if score @s golf_ball.power matches 140..159 run title @s actionbar [{"text":"|=====","color":"green"},{"text":"P","color":"yellow"},{"text":"=================|"}]
execute if score @s golf_ball.power matches 160..179 run title @s actionbar [{"text":"|======","color":"green"},{"text":"P","color":"yellow"},{"text":"================|"}]
execute if score @s golf_ball.power matches 180..199 run title @s actionbar [{"text":"|=======","color":"green"},{"text":"P","color":"yellow"},{"text":"===============|"}]
execute if score @s golf_ball.power matches 200..219 run title @s actionbar [{"text":"|=========","color":"green"},{"text":"P","color":"yellow"},{"text":"=============|"}]
execute if score @s golf_ball.power matches 220..239 run title @s actionbar [{"text":"|==========","color":"green"},{"text":"P","color":"yellow"},{"text":"============|"}]
execute if score @s golf_ball.power matches 240..259 run title @s actionbar [{"text":"|===========","color":"green"},{"text":"P","color":"yellow"},{"text":"===========|"}]
execute if score @s golf_ball.power matches 260..279 run title @s actionbar [{"text":"|============","color":"green"},{"text":"P","color":"yellow"},{"text":"==========|"}]
execute if score @s golf_ball.power matches 280..299 run title @s actionbar [{"text":"|=============","color":"green"},{"text":"P","color":"yellow"},{"text":"=========|"}]
execute if score @s golf_ball.power matches 300..319 run title @s actionbar [{"text":"|==============","color":"green"},{"text":"P","color":"yellow"},{"text":"========|"}]
execute if score @s golf_ball.power matches 320..339 run title @s actionbar [{"text":"|===============","color":"green"},{"text":"P","color":"yellow"},{"text":"=======|"}]
execute if score @s golf_ball.power matches 340..359 run title @s actionbar [{"text":"|================","color":"green"},{"text":"P","color":"yellow"},{"text":"======|"}]
execute if score @s golf_ball.power matches 360..379 run title @s actionbar [{"text":"|=================","color":"green"},{"text":"P","color":"yellow"},{"text":"=====|"}]
execute if score @s golf_ball.power matches 380..399 run title @s actionbar [{"text":"|==================","color":"green"},{"text":"P","color":"yellow"},{"text":"====|"}]
execute if score @s golf_ball.power matches 400..419 run title @s actionbar [{"text":"|==================","color":"green"},{"text":"P","color":"yellow"},{"text":"====|"}]
execute if score @s golf_ball.power matches 420..439 run title @s actionbar [{"text":"|===================","color":"green"},{"text":"P","color":"yellow"},{"text":"===|"}]
execute if score @s golf_ball.power matches 440..459 run title @s actionbar [{"text":"|====================","color":"green"},{"text":"P","color":"yellow"},{"text":"==|"}]
execute if score @s golf_ball.power matches 460..479 run title @s actionbar [{"text":"|=====================","color":"green"},{"text":"P","color":"yellow"},{"text":"=|"}]
execute if score @s golf_ball.power matches 480..500 run title @s actionbar [{"text":"|======================","color":"green"},{"text":"P","color":"yellow"},{"text":"|"}]

