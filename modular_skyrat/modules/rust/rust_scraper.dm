/obj/item/rustscraper
	name = "Rust Scraper"
	desc = "Use to remove rust from anything!"
	tool_behaviour = "RUST_SCRAPER"
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 3
	throwforce = 5
	hitsound = "swing_hit"
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL

/datum/design/rustscraper
	name = "Rust Scraper"
	id = "rustscraper"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 75)
	build_path = /obj/item/rustscraper
	category = list("initial","Tools","Tool Designs")
