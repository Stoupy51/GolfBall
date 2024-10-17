
tellraw @a[tag=convention.debug] {"text":"[Loaded Golf Ball v1.2.0]","italic":false,"color":"green"}

execute unless entity @a run schedule function golf_ball:post_load 1t

