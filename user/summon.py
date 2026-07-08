
# ruff: noqa: E501
# Imports
from beet import Context
from stewbeet import write_function


# Setup summon functions
def setup_summon_functions(ctx: Context) -> None:
	ns: str = ctx.project_id

	write_function(f"{ns}:respawn", f"""
#> {ns}:respawn
#
# @executed			as & at the player that executes the command
#
# @description		Teleport the ball back to its original position
#

# Get position
execute on vehicle on passengers if entity @s[type=item_display] run data modify storage {ns}:main Pos set from entity @s item.components."minecraft:custom_data".Pos

# Apply position and remove motion
execute on vehicle run data modify entity @s Pos set from storage {ns}:main Pos
execute on vehicle run scoreboard players set @s {ns}.motion_x 0
execute on vehicle run scoreboard players set @s {ns}.motion_y 0
execute on vehicle run scoreboard players set @s {ns}.motion_z 0
execute on vehicle run data modify entity @s Motion set value [0.0d, 0.0d, 0.0d]
""")

	write_function(f"{ns}:sulfur_cube", f"""
#> {ns}:sulfur_cube
#
# @executed			as & at the player who summoned the ball
#
# @description		Manage the summoning of a golf ball, forcing the sulfur cube base (26.2+ vanilla physics) instead of the default cat base
#					⚠️ Vanilla limitation: a sulfur cube holding a block has its step height hardcoded to 0, so it cannot step up slabs or snow layers
#

# Reduce player size
attribute @s scale base set 0.5

# Temporary tag for the player
tag @s add {ns}.temp

# Summoning a golf ball (tiny sulfur cube with an absorbed sponge, the 'Golf Ball' archetype - bouncing/friction/air drag are handled by vanilla attributes)
summon sulfur_cube ~ ~ ~ {{Tags:["{ns}.base","{ns}.new"],Invulnerable:1b,Silent:1b,PersistenceRequired:1b,equipment:{{body:{{id:"minecraft:stone",count:1}}}},Passengers:[{{id:"minecraft:item_display",Tags:["{ns}.display","{ns}.new"],item_display:"ground",transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-0.075f,0f],scale:[1f,1f,1f]}},item:{{id:"minecraft:emerald_block",count:1b}}}}],active_effects:[{{id:"minecraft:invisibility",amplifier:0b,duration:-1,show_particles:0b}}],attributes:[{{id:"movement_speed",base:0.0d}}]}}

# Replace the golf ball visual with a player head
loot replace entity @e[type=item_display,tag={ns}.new] container.0 loot {ns}:player_head

# Additional summoning commands
execute as @e[tag={ns}.base,tag={ns}.new] at @s run function {ns}:ball/post_summon

# Remove the temporary tag
tag @s remove {ns}.temp

# Execute the first player tick
function {ns}:ball/tick_player
""")

	write_function(f"{ns}:summon", f"""
#> {ns}:summon
#
# @executed			as & at the player who summoned the ball
#
# @description		Manage the summoning of a golf ball
#

# Reduce player size
attribute @s scale base set 0.5

# Temporary tag for the player
tag @s add {ns}.temp

# Summoning a golf ball (cat base with the scoreboard physics engine)
summon cat ~ ~ ~ {{Tags:["{ns}.base","{ns}.new","{ns}.legacy"],Invulnerable:1b,Silent:1b,Age:-200000,Passengers:[{{id:"minecraft:item_display",Tags:["{ns}.display","{ns}.new"],item_display:"ground",transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0.04f,0f],scale:[1f,1f,1f]}},item:{{id:"minecraft:emerald_block",count:1b}}}}],active_effects:[{{id:"minecraft:invisibility",amplifier:0b,duration:-1,show_particles:0b}}],attributes:[{{id:"movement_speed",base:0.0d}}]}}

# Replace the golf ball visual with a player head
loot replace entity @e[type=item_display,tag={ns}.new] container.0 loot {ns}:player_head

# Additional summoning commands
execute as @e[tag={ns}.base,tag={ns}.new] at @s run function {ns}:ball/post_summon

# Remove the temporary tag
tag @s remove {ns}.temp

# Execute the first player tick
function {ns}:ball/tick_player
""")

