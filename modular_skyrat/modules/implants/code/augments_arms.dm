/obj/item/melee/implantarmblade
	name = "implanted arm blade"
	desc = "A long, sharp, mantis-like blade implanted into someones arm. Cleaves through flesh like its particularly strong butter."
	icon = 'modular_skyrat/modules/implants/icons/implanted_blade.dmi'
	righthand_file = 'modular_skyrat/modules/implants/icons/implanted_blade_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/implants/icons/implanted_blade_lefthand.dmi'
	icon_state = "mantis_blade"
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	sharpness = SHARP_EDGED
	force = 25
	armour_penetration = 20
	item_flags = NEEDS_PERMIT //Beepers gets angry if you get caught with this.
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'

/obj/item/melee/implantarmblade/energy
	name = "energy arm blade"
	desc = "A long mantis-like blade made entirely of blazing-hot energy. Stylish and EXTRA deadly!"
	icon_state = "energy_mantis_blade"
	force = 30
	armour_penetration = 10 //Energy isn't as good at going through armor as it is through flesh alone.
	hitsound = 'sound/weapons/blade1.ogg'

/obj/item/organ/internal/cyberimp/arm/armblade
	name = "arm blade implant"
	desc = "An integrated blade implant designed to be installed into a persons arm. Stylish and deadly; Although, being caught with this without proper permits is sure to draw unwanted attention."
	items_to_create = list(/obj/item/melee/implantarmblade)
	icon = 'modular_skyrat/modules/implants/icons/implanted_blade.dmi'
	icon_state = "mantis_blade"

/obj/item/organ/internal/cyberimp/arm/armblade/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s integrated energy arm blade! You madman!"))
	items_list += WEAKREF(new /obj/item/melee/implantarmblade/energy(src))
	return TRUE

/obj/item/melee/knife/razorclaws
	name = "implanted razor claws"
	desc = "A set of sharp, retractable claws built into the fingertips, five double-edged blades sure to turn people into mincemeat. Capable of shifting into 'Precision' mode to act similar to wirecutters."
	icon = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	righthand_file = 'modular_skyrat/modules/implants/icons/razorclaws_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/implants/icons/razorclaws_lefthand.dmi'
	icon_state = "wolverine"
	var/knife_force = 10
	w_class = WEIGHT_CLASS_BULKY
	var/knife_hitsound = 'sound/weapons/bladeslice.ogg'
	var/knife_attack_verb_continuous = list("slashes", "tears", "slices", "tears", "lacerates", "rips", "dices", "cuts", "rends")
	var/knife_attack_verb_simple = list("slash", "tear", "slice", "tear", "lacerate", "rip", "dice", "cut", "rend")
	var/knife_sharpness = SHARP_EDGED
	var/knife_wound_bonus = 5
	var/knife_bare_wound_bonus = 15
	tool_behaviour = TOOL_KNIFE

/obj/item/melee/knife/razorclaws/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour != TOOL_WIRECUTTER)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, span_notice("You shift [src] into Precision mode, for wirecutting."))
		icon_state = "precision_wolverine"
		flags_1 = CONDUCT_1
		force = 6
		sharpness = NONE
		hitsound = 'sound/items/wirecutter.ogg'
		usesound = 'sound/items/wirecutter.ogg'
		attack_verb_continuous = list("bashes", "batters", "bludgeons", "thrashes", "whacks")
		attack_verb_simple = list("bash", "batter", "bludgeon", "thrash", "whack")
		toolspeed = 1

	else
		tool_behaviour = TOOL_KNIFE
		to_chat(user, span_notice("You shift [src] into Killing mode, for slicing."))
		icon_state = "wolverine"
		force = knife_force
		sharpness = knife_sharpness
		wound_bonus = knife_wound_bonus
		bare_wound_bonus = knife_bare_wound_bonus
		hitsound = 'sound/weapons/bladeslice.ogg'
		attack_verb_continuous = knife_attack_verb_continuous
		attack_verb_simple = knife_attack_verb_simple

/obj/item/melee/knife/razorclaws/attackby(obj/item/stone, mob/user, param)
	if(!istype(stone, /obj/item/scratchingstone))
		return ..()

	knife_force = 15
	knife_wound_bonus = 15
	armour_penetration = 10 //Let's give them some AP for the trouble.
	name = "enhanced razor claws"
	desc = "[desc] These have undergone a special honing process; they'll kill people even faster than they used to."
	user.visible_message(span_notice("[user] sharpens [src], the stone disintegrating!"), span_notice("You sharpen [src], making it much more deadly than before; but the stone disintegrates under the stress."))
	playsound(src, 'sound/items/unsheath.ogg', 25, TRUE)
	qdel(stone)
	return TRUE

/obj/item/organ/internal/cyberimp/arm/razorclaws
	name = "razor claws implant"
	desc = "A set of hidden, retractable blades built into the fingertips; cyborg mercenary approved."
	items_to_create = list(/obj/item/melee/knife/razorclaws)
	actions_types = list(/datum/action/item_action/organ_action/toggle/razorclaws)
	icon = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	icon_state = "wolverine"
	extend_sound = 'sound/items/unsheath.ogg'
	retract_sound = 'sound/items/sheath.ogg'

/obj/item/organ/internal/cyberimp/arm/razorclaws/lefthand
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_LEFT_ARM_AUG //This is for the loadout because things tend to get tricky in there.

/datum/action/item_action/organ_action/toggle/razorclaws
	name = "Extend Claws"
	desc = "You can also activate the claws in your hand to change their mode."
	button_icon = 'modular_skyrat/master_files/icons/hud/actions.dmi'
	button_icon_state = "wolverine"

/obj/item/organ/internal/cyberimp/arm/hacker
	name = "hacking arm implant"
	desc = "An small arm implant containing an advanced screwdriver, wirecutters, and multitool designed for engineers and on-the-field machine modification. Actually legal, despite what the name may make you think."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "multitool_cyborg"
	items_to_create = list(/obj/item/screwdriver/cyborg, /obj/item/wirecutters/cyborg, /obj/item/multitool/abductor/implant)

/obj/item/organ/internal/cyberimp/arm/botany
	name = "botany arm implant"
	desc = "A rather simple arm implant containing tools used in gardening and botanical research."
	items_to_create = list(/obj/item/cultivator, /obj/item/shovel/spade, /obj/item/hatchet, /obj/item/gun/energy/floragun, /obj/item/plant_analyzer, /obj/item/geneshears, /obj/item/secateurs, /obj/item/storage/bag/plants, /obj/item/storage/bag/plants/portaseeder)

/obj/item/implant_mounted_chainsaw
	name = "integrated chainsaw"
	desc = "A chainsaw that conceals inside your arm."
	icon = 'icons/obj/weapons/chainsaw.dmi'
	icon_state = "chainsaw_on"
	inhand_icon_state = "mounted_chainsaw"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	force = 24
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1

/obj/item/organ/internal/cyberimp/arm/botany/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s deluxe landscaping equipment!"))
	items_list += WEAKREF(new /obj/item/implant_mounted_chainsaw(src)) //time to landscape the station
	obj_flags |= EMAGGED
	return TRUE

/obj/item/multitool/abductor/implant
	name = "multitool"
	desc = "An optimized, highly advanced stripped-down multitool able to interface with electronics far better than its standard counterpart."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "multitool_cyborg"

/obj/item/organ/internal/cyberimp/arm/janitor
	name = "janitorial tools implant"
	desc = "A set of janitorial tools on the user's arm."
	items_to_create = list(/obj/item/lightreplacer, /obj/item/holosign_creator, /obj/item/soap/nanotrasen, /obj/item/reagent_containers/spray/cyborg_drying, /obj/item/mop/advanced, /obj/item/paint/paint_remover, /obj/item/reagent_containers/cup/beaker/large, /obj/item/reagent_containers/spray/cleaner) //Beaker if for refilling sprays

/obj/item/organ/internal/cyberimp/arm/janitor/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s integrated deluxe cleaning supplies!"))
	items_list += WEAKREF(new /obj/item/soap/syndie(src)) //We add not replace.
	items_list += WEAKREF(new /obj/item/reagent_containers/spray/cyborg_lube(src))
	obj_flags |= EMAGGED
	return TRUE

/obj/item/organ/internal/cyberimp/arm/lighter
	name = "lighter implant"
	desc = "A... implanted lighter. Incredibly useless."
	items_to_create = list(/obj/item/lighter/greyscale) //Hilariously useless.

/obj/item/organ/internal/cyberimp/arm/lighter/emag_act()
	if(obj_flags & EMAGGED)
		return FALSE
	for(var/datum/weakref/created_item in items_list)
	to_chat(usr, span_notice("You unlock [src]'s integrated Zippo lighter! Finally, classy smoking!"))
	items_list += WEAKREF(new /obj/item/lighter(src)) //Now you can choose between bad and worse!
	obj_flags |= EMAGGED
	return TRUE
