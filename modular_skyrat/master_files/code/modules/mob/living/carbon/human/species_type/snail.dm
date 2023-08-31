#define SHELL_TRANSPARENCY_ALPHA 90

/obj/item/storage/backpack/snail
	/// Whether or not a bluespace anomaly core has been inserted
	var/storage_core = FALSE
	obj_flags = IMMUTABLE_SLOW

/obj/item/storage/backpack/snail/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 30

/obj/item/storage/backpack/snail/attackby(obj/item/core, mob/user)
	if(!istype(core, /obj/item/assembly/signaler/anomaly/bluespace))
		return ..()

	to_chat(user, span_notice("You insert [core] into your shell, and it starts to glow blue with expanded storage potential!"))
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	add_filter("bluespace_shell", 2, list("type" = "outline", "color" = COLOR_BLUE_LIGHT, "size" = 1))
	storage_core = TRUE
	qdel(core)
	emptyStorage()
	create_storage(max_specific_storage = WEIGHT_CLASS_GIGANTIC, max_total_storage = 35, max_slots = 30, storage_type = /datum/storage/bag_of_holding)
	atom_storage.allow_big_nesting = TRUE
	name = "snail shell of holding"
	user.update_worn_back()
	update_appearance()

/obj/item/storage/backpack/snail/build_worn_icon(
	default_layer = 0,
	default_icon_file = null,
	isinhands = FALSE,
	female_uniform = NO_FEMALE_UNIFORM,
	override_state = null,
	override_file = null,
	mutant_styles = NONE,
)

	var/mutable_appearance/standing = ..()
	if(storage_core == TRUE)
		standing.add_filter("bluespace_shell", 2, list("type" = "outline", "color" = COLOR_BLUE_LIGHT, "alpha" = SHELL_TRANSPARENCY_ALPHA, "size" = 1))
	return standing

/datum/species/snail/prepare_human_for_preview(mob/living/carbon/human/snail)
	snail.dna.features["mcolor"] = "#adaba7"
	snail.update_body(TRUE)

/datum/species/snail/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "home",
			SPECIES_PERK_NAME = "Shellback",
			SPECIES_PERK_DESC = "Snails have a shell fused to their back. While it doesn't offer any protection, it offers great storage. Alt click to change the sprite!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "wine-glass",
			SPECIES_PERK_NAME = "Poison Resistance",
			SPECIES_PERK_DESC = "Snails have a higher tolerance for poison owing to their robust livers.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "water",
			SPECIES_PERK_NAME = "Water Breathing",
			SPECIES_PERK_DESC = "Snails can breathe underwater.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "Boneless",
			SPECIES_PERK_DESC = "Snails are invertebrates.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "crutch",
			SPECIES_PERK_NAME = "Sheer Mollusk Speed",
			SPECIES_PERK_DESC = "Snails move incredibly slow while standing. They move much faster while crawling.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "frown",
			SPECIES_PERK_NAME = "Weak Fighter",
			SPECIES_PERK_DESC = "Snails punch half as hard as a human.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "skull",
			SPECIES_PERK_NAME = "Salt Weakness",
			SPECIES_PERK_DESC = "Salt burns snails, and salt piles will block their path.",
		),
	)

	return to_add

#undef SHELL_TRANSPARENCY_ALPHA
