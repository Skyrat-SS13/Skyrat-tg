/datum/map_template/holodeck/wargame
	name = "Holodeck - Naval Wargames"
	template_id = "holodeck_wargame"
	description = "more than enough space for a quick bout of naval warfare"
	mappath = "_maps/skyrat/holodeck_wargame.dmm"

/obj/item/storage/secure/briefcase/white/wargame_kit
	name = "DIY Wargaming Kit"
	desc = "Contains everything an aspiring naval officer (or just massive nerd) would need for a proper modern naval wargame."
	custom_premium_price = PAYCHECK_CREW * 2

/obj/item/storage/secure/briefcase/white/wargame_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/wargame_projector/ships = 1,
		/obj/item/wargame_projector/terrain = 1,
		/obj/item/dice/d20 = 1,
		)
	generate_items_inside(items_inside,src)
