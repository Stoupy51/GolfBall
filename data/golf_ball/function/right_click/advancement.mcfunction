
# Revoke advancement
advancement revoke @s only golf_ball:right_click
execute if score @s golf_ball.cooldown matches 1.. run return fail
execute unless score @s golf_ball.right_click matches 2.. run scoreboard players set @s golf_ball.right_click 2

# Title action bar to show the power (steps of 19)
execute if score #power golf_ball.data matches 040..059 run title @s actionbar [{"text":"|","color":"green"},{"text":"P","color":"yellow"},{"text":"======================|"}]
execute if score #power golf_ball.data matches 060..079 run title @s actionbar [{"text":"|=","color":"green"},{"text":"P","color":"yellow"},{"text":"=====================|"}]
execute if score #power golf_ball.data matches 080..099 run title @s actionbar [{"text":"|==","color":"green"},{"text":"P","color":"yellow"},{"text":"====================|"}]
execute if score #power golf_ball.data matches 100..119 run title @s actionbar [{"text":"|===","color":"green"},{"text":"P","color":"yellow"},{"text":"===================|"}]
execute if score #power golf_ball.data matches 120..139 run title @s actionbar [{"text":"|====","color":"green"},{"text":"P","color":"yellow"},{"text":"==================|"}]
execute if score #power golf_ball.data matches 140..159 run title @s actionbar [{"text":"|=====","color":"green"},{"text":"P","color":"yellow"},{"text":"=================|"}]
execute if score #power golf_ball.data matches 160..179 run title @s actionbar [{"text":"|======","color":"green"},{"text":"P","color":"yellow"},{"text":"================|"}]
execute if score #power golf_ball.data matches 180..199 run title @s actionbar [{"text":"|=======","color":"green"},{"text":"P","color":"yellow"},{"text":"===============|"}]
execute if score #power golf_ball.data matches 200..219 run title @s actionbar [{"text":"|=========","color":"green"},{"text":"P","color":"yellow"},{"text":"=============|"}]
execute if score #power golf_ball.data matches 220..239 run title @s actionbar [{"text":"|==========","color":"green"},{"text":"P","color":"yellow"},{"text":"============|"}]
execute if score #power golf_ball.data matches 240..259 run title @s actionbar [{"text":"|===========","color":"green"},{"text":"P","color":"yellow"},{"text":"===========|"}]
execute if score #power golf_ball.data matches 260..279 run title @s actionbar [{"text":"|============","color":"green"},{"text":"P","color":"yellow"},{"text":"==========|"}]
execute if score #power golf_ball.data matches 280..299 run title @s actionbar [{"text":"|=============","color":"green"},{"text":"P","color":"yellow"},{"text":"=========|"}]
execute if score #power golf_ball.data matches 300..319 run title @s actionbar [{"text":"|==============","color":"green"},{"text":"P","color":"yellow"},{"text":"========|"}]
execute if score #power golf_ball.data matches 320..339 run title @s actionbar [{"text":"|===============","color":"green"},{"text":"P","color":"yellow"},{"text":"=======|"}]
execute if score #power golf_ball.data matches 340..359 run title @s actionbar [{"text":"|================","color":"green"},{"text":"P","color":"yellow"},{"text":"======|"}]
execute if score #power golf_ball.data matches 360..379 run title @s actionbar [{"text":"|=================","color":"green"},{"text":"P","color":"yellow"},{"text":"=====|"}]
execute if score #power golf_ball.data matches 380..399 run title @s actionbar [{"text":"|==================","color":"green"},{"text":"P","color":"yellow"},{"text":"====|"}]
execute if score #power golf_ball.data matches 400..419 run title @s actionbar [{"text":"|==================","color":"green"},{"text":"P","color":"yellow"},{"text":"====|"}]
execute if score #power golf_ball.data matches 420..439 run title @s actionbar [{"text":"|===================","color":"green"},{"text":"P","color":"yellow"},{"text":"===|"}]
execute if score #power golf_ball.data matches 440..459 run title @s actionbar [{"text":"|====================","color":"green"},{"text":"P","color":"yellow"},{"text":"==|"}]
execute if score #power golf_ball.data matches 460..479 run title @s actionbar [{"text":"|=====================","color":"green"},{"text":"P","color":"yellow"},{"text":"=|"}]
execute if score #power golf_ball.data matches 480..500 run title @s actionbar [{"text":"|======================","color":"green"},{"text":"P","color":"yellow"},{"text":"|"}]

