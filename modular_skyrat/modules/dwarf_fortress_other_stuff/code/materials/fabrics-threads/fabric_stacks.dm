// BASE TYPES

/obj/item/stack/dwarf_certified/thread
	name = "generic threads"
	singular_name = "generic thread"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = "thread"

	inhand_icon_state = "fabriclike"

	merge_type = /obj/item/stack/dwarf_certified/thread

	mats_per_unit = list(/datum/material/dwarf_certified/fabric = MINERAL_MATERIAL_AMOUNT / 2)
	material_type = /datum/material/dwarf_certified/fabric

	max_amount = 6

	/// Tells us what type of fabric we craft into
	var/fabric_we_weave = /obj/item/stack/dwarf_certified/fabric

/obj/item/stack/dwarf_certified/thread/get_main_recipes()
	. = ..()
	. += fabric_recipe_maker()

/obj/item/stack/dwarf_certified/thread/proc/fabric_recipe_maker()
	var/recipe_we_return = new /datum/stack_recipe( \
	"[name] fabric", \
	fabric_we_weave, \
	req_amount = 2, \
	res_amount = 1, \
	time = 1 SECONDS, \
	)

	return recipe_we_return

/obj/item/stack/dwarf_certified/thread/examine(mob/user)
	. = ..()

	. += span_notice("You can make <b>sutures</b> out of [src] if you're desperate.")
	. += span_notice("If you had <b>2</b> of [src], you could turn it into fabric.")

/obj/item/stack/dwarf_certified/fabric
	name = "generic bolt of fabric"
	singular_name = "generic fabric"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = "fabric"

	inhand_icon_state = "fabriclike"

	merge_type = /obj/item/stack/dwarf_certified/fabric

	mats_per_unit = list(/datum/material/dwarf_certified/fabric = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/fabric

	max_amount = 3

/obj/item/stack/dwarf_certified/fabric/examine(mob/user)
	. = ..()

	. += span_notice("You can make <b>gauze</b> out of [src] if you're desperate.")
	. += span_notice("Maybe with a <b>tailoring station</b>, you could turn [src] into clothing?")

// CLOTH

/obj/item/stack/dwarf_certified/thread/cotton
	name = "spool of cotton thread"
	singular_name = "cotton thread"

	desc = "Thread made of cotton."

	merge_type = /obj/item/stack/dwarf_certified/thread/cotton

	mats_per_unit = list(/datum/material/dwarf_certified/fabric/cotton = MINERAL_MATERIAL_AMOUNT / 2)
	material_type = /datum/material/dwarf_certified/fabric/cotton

	fabric_we_weave = /obj/item/stack/dwarf_certified/fabric/cotton

/obj/item/stack/dwarf_certified/fabric/cotton
	name = "bolt of cotton fabric"
	singular_name = "cotton fabric"

	desc = "Fabric made of cotton."

	merge_type = /obj/item/stack/dwarf_certified/fabric/cotton

	mats_per_unit = list(/datum/material/dwarf_certified/fabric/cotton = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/fabric/cotton
