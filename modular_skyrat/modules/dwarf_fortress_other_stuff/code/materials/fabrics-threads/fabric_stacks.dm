// BASE TYPES

/obj/item/stack/dwarf_certified/thread
	name = "generic special event threads"
	singular_name = "generic special event thread"

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
	name = "generic special event bolt of fabric"
	singular_name = "generic special event fabric"

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

/obj/item/stack/dwarf_certified/thread/cloth
	name = "spool of cloth thread"
	singular_name = "cloth thread"

	desc = "Thread made of cloth."

	merge_type = /obj/item/stack/dwarf_certified/thread/cloth

	mats_per_unit = list(/datum/material/dwarf_certified/fabric/cloth = MINERAL_MATERIAL_AMOUNT / 2)
	material_type = /datum/material/dwarf_certified/fabric/cloth

	fabric_we_weave = /obj/item/stack/dwarf_certified/fabric/cloth

/obj/item/stack/dwarf_certified/fabric/cloth
	name = "bolt of cloth fabric"
	singular_name = "cloth fabric"

	desc = "Fabric made of cloth."

	merge_type = /obj/item/stack/dwarf_certified/fabric/cloth

	mats_per_unit = list(/datum/material/dwarf_certified/fabric/cloth = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/fabric/cloth
