///Fish feed can
/obj/item/fish_feed
	name = "fish feed can"
	desc = "A refillable can that dispenses nutritious fish feed."
	icon = 'icons/obj/aquarium/supplies.dmi'
	icon_state = "fish_feed"
	w_class = WEIGHT_CLASS_TINY

/obj/item/fish_feed/Initialize(mapload)
	. = ..()
	create_reagents(5, OPENCONTAINER)
	reagents.add_reagent(/datum/reagent/consumable/nutriment, 2.5) //Default fish diet

/**
 * Stasis fish case container for moving fish between aquariums safely.
 * Their w_class scales with that of the fish inside it.
 * Most subtypes of this also start with a fish already inside.
 */
/obj/item/storage/fish_case
	name = "stasis fish case"
	desc = "A resizable case keeping the fish inside in stasis."
	icon = 'icons/obj/storage/case.dmi'
	icon_state = "fishbox"
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	storage_type = /datum/storage/fish_case/adjust_size

/obj/item/storage/fish_case/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/fish_safe_storage)

/obj/item/storage/fish_case/PopulateContents()
	var/fish_type = get_fish_type()
	if(fish_type)
		var/obj/item/fish/spawned_fish = new fish_type(null)
		ADD_TRAIT(spawned_fish, TRAIT_FISH_FROM_CASE, TRAIT_GENERIC)
		spawned_fish.forceMove(src) // trigger storage.handle_entered

/obj/item/storage/fish_case/proc/get_fish_type()
	return

/obj/item/storage/fish_case/random

	var/fluid_type

/obj/item/storage/fish_case/random/get_fish_type()
	return random_fish_type(fluid_type)

/obj/item/storage/fish_case/random/freshwater
	fluid_type = AQUARIUM_FLUID_FRESHWATER

/obj/item/storage/fish_case/random/saltwater
	fluid_type = AQUARIUM_FLUID_SALTWATER

/obj/item/storage/fish_case/syndicate
	name = "ominous fish case"

/obj/item/storage/fish_case/syndicate/get_fish_type()
	return pick(/obj/item/fish/donkfish, /obj/item/fish/emulsijack, /obj/item/fish/jumpercable)

/obj/item/storage/fish_case/tiziran
	name = "imported fish case"

/obj/item/storage/fish_case/tiziran/get_fish_type()
	return pick(/obj/item/fish/dwarf_moonfish, /obj/item/fish/gunner_jellyfish, /obj/item/fish/needlefish, /obj/item/fish/armorfish)

///Subtype bought from the blackmarket at a gratuitously cheap price. The catch? The fish inside it is dead.
/obj/item/storage/fish_case/blackmarket
	name = "ominous fish case"
	desc = "A resizable case keeping the fish inside in stasis. This one holds a faint cadaverine smell."

/obj/item/storage/fish_case/blackmarket/get_fish_type()
	var/static/list/weighted_list = list(
		/obj/item/fish/boned = 1,
		/obj/item/fish/clownfish/lube = 3,
		/obj/item/fish/emulsijack = 1,
		/obj/item/fish/jumpercable = 1,
		/obj/item/fish/sludgefish/purple = 1,
		/obj/item/fish/pufferfish = 3,
		/obj/item/fish/slimefish = 2,
		/obj/item/fish/ratfish = 2,
		/obj/item/fish/chasm_crab/ice = 2,
		/obj/item/fish/chasm_crab = 2,
	)
	return pick_weight(weighted_list)

/obj/item/storage/fish_case/blackmarket/Initialize(mapload)
	. = ..()
	for(var/obj/item/fish/fish as anything in contents)
		fish.set_status(FISH_DEAD)

/obj/item/storage/fish_case/bluespace
	name = "bluespace fish case"
	icon_state = "fishbox_bluespace"
	desc = "An improved fish case to keep large fish in stasis in a compact little space."
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/fish_case

/obj/item/aquarium_kit
	name = "DIY Aquarium Construction Kit"
	desc = "Everything you need to build your own aquarium. Raw materials sold separately."
	icon = 'icons/obj/aquarium/supplies.dmi'
	icon_state = "construction_kit"
	w_class = WEIGHT_CLASS_TINY

/obj/item/aquarium_kit/Initialize(mapload)
	. = ..()
	var/static/list/recipes = list(/datum/crafting_recipe/aquarium)
	AddElement(/datum/element/slapcrafting, recipes)

/obj/item/aquarium_prop
	name = "generic aquarium prop"
	desc = "very boring"
	icon = 'icons/obj/aquarium/supplies.dmi'

	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/plastic = COIN_MATERIAL_AMOUNT)
	var/layer_mode = AQUARIUM_LAYER_MODE_BOTTOM
	var/beauty = 150

/obj/item/aquarium_prop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/aquarium_content, icon, beauty = beauty)

/obj/item/aquarium_prop/rocks
	name = "decorative rocks"
	desc = "A bunch of tiny plastic rocks for decorating an aquarium. Surely you could have just used real pebbles?"
	icon_state = "rocks"

/obj/item/aquarium_prop/seaweed
	name = "fake seaweed"
	desc = "Little plastic sheets with weighted bottoms, designed to look like underwater foliage. They can be used to spruce up an aquarium."
	icon_state = "seaweeds_back"
	layer_mode = AQUARIUM_LAYER_MODE_BOTTOM

/obj/item/aquarium_prop/seaweed/top
	desc = "A bunch of artificial plants for an aquarium."
	icon_state = "seaweeds_front"
	layer_mode = AQUARIUM_LAYER_MODE_TOP

/obj/item/aquarium_prop/sand
	name = "aquarium sand"
	desc = "A plastic board for lining the bottom of an aquarium. It's got a bumpy patterned surface vaguely reminiscent of yellow sand."
	icon_state = "sand"
	layer_mode = AQUARIUM_LAYER_MODE_BEHIND_GLASS

/obj/item/aquarium_prop/treasure
	name = "tiny treasure chest"
	desc = "A very small plastic treaure chest, with nothing inside. You could put this in an aquarium, and it'll look like very small pirates hid treasure in there. Wouldn't that be nice?"
	icon_state = "treasure"
	layer_mode = AQUARIUM_LAYER_MODE_BOTTOM

/obj/item/storage/box/aquarium_props
	name = "aquarium props box"
	desc = "All you need to make your aquarium look good."
	illustration = "fish"

/obj/item/storage/box/aquarium_props/PopulateContents()
	for(var/prop_type in subtypesof(/obj/item/aquarium_prop))
		new prop_type(src)
