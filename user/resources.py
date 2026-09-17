
# ruff: noqa: E501
# Imports
from beet import Advancement, BlockTag, Enchantment, EntityTypeTag, LootTable, Predicate
from stewbeet import Context, JsonDict, set_json_encoder


# Setup json resources (loot tables, predicates, tags, ...)
def setup_resources(ctx: Context) -> None:
	ns: str = ctx.project_id
	json_content: JsonDict

	# Advancements
	json_content = {"criteria":{"requirement":{"trigger":"minecraft:consume_item","conditions":{"item":{"predicates":{"minecraft:custom_data":f"{{exit_{ns}:1b}}"}}}}},"rewards":{"function":f"{ns}:ball/exit_player"}}
	ctx.data[ns].advancements["exit_player"] = set_json_encoder(Advancement(json_content), max_level=-1)

	json_content = {"criteria":{"requirement":{"trigger":"minecraft:using_item","conditions":{"item":{"predicates":{"minecraft:custom_data":f"{{{ns}:1b}}"}}}}},"rewards":{"function":f"{ns}:right_click/advancement"}}
	ctx.data[ns].advancements["right_click"] = set_json_encoder(Advancement(json_content), max_level=-1)

	# Loot tables
	json_content = {"type":"minecraft:block","pools":[{"rolls":1,"bonus_rolls":0,"entries":[{"type":"minecraft:item","name":"minecraft:player_head","modifier":[{"type":"minecraft:fill_player_head","entity":"this"}]}]}]}
	ctx.data[ns].loot_tables["player_head"] = set_json_encoder(LootTable(json_content), max_level=-1)

	# Predicates
	json_content = {"type":"minecraft:entity_scores","entity":"this","scores":{f"{ns}.id":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"#predicate"},"score":f"{ns}.id"}}}
	ctx.data[ns].predicates["has_same_id"] = set_json_encoder(Predicate(json_content), max_level=-1)

	json_content = {"type":"minecraft:entity_properties","entity":"this","predicate":{"vehicle":{}}}
	ctx.data[ns].predicates["has_vehicle"] = set_json_encoder(Predicate(json_content), max_level=-1)

	json_content = {"type":"minecraft:entity_properties","entity":"this","predicate":{"passenger":{}}}
	ctx.data[ns].predicates["have_passenger"] = set_json_encoder(Predicate(json_content), max_level=-1)

	json_content = {"type":"minecraft:entity_properties","entity":"this","predicate":{"passenger":{"minecraft:entity_type":"minecraft:player"}}}
	ctx.data[ns].predicates["have_player_passenger"] = set_json_encoder(Predicate(json_content), max_level=-1)

	json_content = {"type":"minecraft:location_check","predicate":{"fluid":{"fluids":"#minecraft:water"}}}
	ctx.data[ns].predicates["in_water"] = set_json_encoder(Predicate(json_content), max_level=-1)

	# Block tags
	json_content = {"values":["white_concrete","orange_concrete","magenta_concrete","light_blue_concrete","yellow_concrete","lime_concrete","pink_concrete","gray_concrete","light_gray_concrete","cyan_concrete","purple_concrete","blue_concrete","brown_concrete","green_concrete","red_concrete","black_concrete"]}
	ctx.data[ns].block_tags["surfaces/fast"] = set_json_encoder(BlockTag(json_content))

	json_content = {"values":["ice","packed_ice","blue_ice"]}
	ctx.data[ns].block_tags["surfaces/slippery"] = set_json_encoder(BlockTag(json_content))

	json_content = {"values":["dirt","rooted_dirt","sand","red_sand","snow_block","snow"]}
	ctx.data[ns].block_tags["surfaces/slow"] = set_json_encoder(BlockTag(json_content))

	json_content = {"values":["soul_sand","mud","mud_brick_slab","mud_brick_stairs","mud_brick_wall"]}
	ctx.data[ns].block_tags["surfaces/very_slow"] = set_json_encoder(BlockTag(json_content))

	# Entity type tags
	json_content = {"values":["#minecraft:arrows","area_effect_cloud","armor_stand","block_display","dragon_fireball","egg","experience_bottle","experience_orb","falling_block","fireball","firework_rocket","firework_rocket","glow_item_frame","interaction","item","item_display","item_frame","leash_knot","llama_spit","marker","painting","player","lingering_potion","splash_potion","small_fireball","snowball","text_display","tnt","trident","trident","wither_skull"]}
	ctx.data[ns].entity_type_tags["no_collision"] = set_json_encoder(EntityTypeTag(json_content))

	# Enchantments
	json_content = {"anvil_cost":99,"description":"Invulnerable","effects":{"minecraft:damage_immunity":[{"effect":{}}]},"exclusive_set":"#minecraft:exclusive_set/armor","max_cost":{"base":99,"per_level_above_first":1},"max_level":1,"min_cost":{"base":99,"per_level_above_first":1},"slots":["any"],"supported_items":"minecraft:stone","weight":1}
	ctx.data[ns].enchantments["invulnerable"] = set_json_encoder(Enchantment(json_content), max_level=-1)

