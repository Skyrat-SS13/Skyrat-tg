//If you're looking for spawners like ash walker eggs, check ghost_role_spawners.dm

///Wizard tower item
/obj/item/disk/design_disk/knight_gear
	name = "Magic Disk of Smithing"

/obj/item/disk/design_disk/knight_gear/Initialize(mapload)
	. = ..()
	blueprints += new /datum/design/knight_armour
	blueprints += new /datum/design/knight_helmet

//Free Golems

/obj/item/disk/design_disk/golem_shell
	name = "Golem Creation Disk"
	desc = "A gift from the Liberator."
	icon_state = "datadisk1"

/obj/item/disk/design_disk/golem_shell/Initialize(mapload)
	. = ..()
	blueprints += new /datum/design/golem_shell

/datum/design/golem_shell
	name = "Golem Shell Construction"
	desc = "Allows for the construction of a Golem Shell."
	id = "golem"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 40000)
	build_path = /obj/item/golem_shell
	category = list(RND_CATEGORY_IMPORTED)

/obj/item/golem_shell
	name = "incomplete free golem shell"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "shell_unfinished"
	desc = "The incomplete body of a golem. Add ten sheets of certain minerals to finish."
	w_class = WEIGHT_CLASS_BULKY
	/// Amount of minerals you need to feed the shell to wake it up
	var/required_stacks = 10
	/// Type of shell to create
	var/shell_type = /obj/effect/mob_spawn/ghost_role/human/golem

/obj/item/golem_shell/attackby(obj/item/potential_food, mob/user, params)
	. = ..()
<<<<<<< HEAD
	var/static/list/golem_shell_species_types = list(
		/obj/item/stack/sheet/iron = /datum/species/golem,
		/obj/item/stack/sheet/glass = /datum/species/golem/glass,
		/obj/item/stack/sheet/plasteel = /datum/species/golem/plasteel,
		/obj/item/stack/sheet/mineral/sandstone = /datum/species/golem/sand,
		/obj/item/stack/sheet/mineral/plasma = /datum/species/golem/plasma,
		/obj/item/stack/sheet/mineral/diamond = /datum/species/golem/diamond,
		/obj/item/stack/sheet/mineral/gold = /datum/species/golem/gold,
		/obj/item/stack/sheet/mineral/silver = /datum/species/golem/silver,
		/obj/item/stack/sheet/mineral/uranium = /datum/species/golem/uranium,
		/obj/item/stack/sheet/mineral/bananium = /datum/species/golem/bananium,
		/obj/item/stack/sheet/mineral/titanium = /datum/species/golem/titanium,
		/obj/item/stack/sheet/mineral/plastitanium = /datum/species/golem/plastitanium,
		/obj/item/stack/sheet/mineral/abductor = /datum/species/golem/alloy,
		/obj/item/stack/sheet/mineral/wood = /datum/species/golem/wood,
		/obj/item/stack/sheet/bluespace_crystal = /datum/species/golem/bluespace,
		/obj/item/stack/sheet/runed_metal = /datum/species/golem/runic,
		/obj/item/stack/medical/gauze = /datum/species/golem/cloth,
		/obj/item/stack/sheet/cloth = /datum/species/golem/cloth,
		/obj/item/stack/sheet/mineral/adamantine = /datum/species/golem/adamantine,

		/obj/item/stack/sheet/bronze = /datum/species/golem/bronze,
		/obj/item/stack/sheet/cardboard = /datum/species/golem/cardboard,
		/obj/item/stack/sheet/leather = /datum/species/golem/leather,
		/obj/item/stack/sheet/bone = /datum/species/golem/bone,
		/obj/item/stack/sheet/durathread = /datum/species/golem/durathread,
		/obj/item/stack/sheet/cotton/durathread = /datum/species/golem/durathread,
		/obj/item/stack/sheet/mineral/snow = /datum/species/golem/snow,
		/obj/item/stack/sheet/mineral/metal_hydrogen= /datum/species/golem/mhydrogen,
	)

	if(!isstack(I))
=======
	if(!isstack(potential_food))
		balloon_alert(user, "not a mineral!")
>>>>>>> 1a918a2e141 (Golem Rework (#74197))
		return
	var/obj/item/stack/stack_food = potential_food
	var/stack_type = stack_food.merge_type
	if (!is_path_in_list(stack_type, GLOB.golem_stack_food_directory))
		balloon_alert(user, "incompatible mineral!")
		return
	if(stack_food.amount < required_stacks)
		balloon_alert(user, "not enough minerals!")
		return
	if(!do_after(user, delay = 4 SECONDS, target = src))
		return
	if(!stack_food.use(required_stacks))
		balloon_alert(user, "not enough minerals!")
		return
	new shell_type(get_turf(src), /* creator = */ user, /* made_of = */ stack_type)
	qdel(src)

///made with xenobiology, the golem obeys its creator
/obj/item/golem_shell/servant
	name = "incomplete servant golem shell"
	shell_type = /obj/effect/mob_spawn/ghost_role/human/golem/servant
