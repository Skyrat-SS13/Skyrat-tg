#define KNIFE_HITSOUND 'sound/weapons/bladeslice.ogg'
#define KNIFE_USESOUND 'sound/weapons/bladeslice.ogg'
#define KNIFE_ATTACK_VERB_CONTINUOUS list("slashes", "tears", "slices", "tears", "lacerates", "rips", "dices", "cuts", "rends")
#define KNIFE_ATTACK_VERB_SIMPLE list("slash", "tear", "slice", "tear", "lacerate", "rip", "dice", "cut", "rend")
#define KNIFE_SHARPNESS SHARP_EDGED
#define KNIFE_BARE_WOUND_BONUS 15
#define CUTTER_HITSOUND 'sound/items/wirecutter.ogg'
#define CUTTER_USESOUND 'sound/items/wirecutter.ogg'
#define CUTTER_ATTACK_VERB_CONTINUOUS list("bashes", "batters", "bludgeons", "thrashes", "whacks")
#define CUTTER_ATTACK_VERB_SIMPLE list("bash", "batter", "bludgeon", "thrash", "whack")
#define CUTTER_FORCE 6
#define CUTTER_WOUND_BONUS 0
#define ENHANCED_KNIFE_FORCE 15
#define ENHANCED_KNIFE_WOUND_BONUS 15
#define ENHANCED_KNIFE_ARMOR_PENETRATION 10

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

/obj/item/knife/razor_claws
	name = "implanted razor claws"
	desc = "A set of sharp, retractable claws built into the fingertips, five double-edged blades sure to turn people into mincemeat. Capable of shifting into 'Precision' mode to act similar to wirecutters."
	icon = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	righthand_file = 'modular_skyrat/modules/implants/icons/razorclaws_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/implants/icons/razorclaws_lefthand.dmi'
	icon_state = "wolverine"
	inhand_icon_state = "wolverine"
	var/knife_force = 10
	w_class = WEIGHT_CLASS_BULKY
	var/knife_wound_bonus = 5
	var/cutter_force = CUTTER_FORCE
	var/cutter_wound_bonus = CUTTER_WOUND_BONUS
	var/cutter_bare_wound_bonus = CUTTER_WOUND_BONUS
	tool_behaviour = TOOL_KNIFE
	toolspeed = 1
	item_flags = NEEDS_PERMIT //Beepers gets angry if you get caught with this.

/obj/item/knife/razor_claws/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour != TOOL_WIRECUTTER)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, span_notice("You shift [src] into Precision mode, for wirecutting."))
		icon_state = "precision_wolverine"
		inhand_icon_state = "precision_wolverine"
		force = cutter_force
		wound_bonus = cutter_wound_bonus
		bare_wound_bonus = cutter_bare_wound_bonus
		sharpness = NONE
		hitsound = CUTTER_HITSOUND
		usesound = CUTTER_USESOUND
		attack_verb_continuous = CUTTER_ATTACK_VERB_CONTINUOUS
		attack_verb_simple = CUTTER_ATTACK_VERB_SIMPLE
	else
		tool_behaviour = TOOL_KNIFE
		to_chat(user, span_notice("You shift [src] into Killing mode, for slicing."))
		icon_state = "wolverine"
		inhand_icon_state = "wolverine"
		force = knife_force
		sharpness = KNIFE_SHARPNESS
		wound_bonus = knife_wound_bonus
		bare_wound_bonus = KNIFE_BARE_WOUND_BONUS
		hitsound = KNIFE_HITSOUND
		usesound = KNIFE_USESOUND
		attack_verb_continuous = KNIFE_ATTACK_VERB_CONTINUOUS
		attack_verb_simple = KNIFE_ATTACK_VERB_SIMPLE

/obj/item/knife/razor_claws/attackby(obj/item/stone, mob/user, param)
	if(!istype(stone, /obj/item/scratching_stone))
		return ..()

	knife_force = ENHANCED_KNIFE_FORCE
	knife_wound_bonus = ENHANCED_KNIFE_WOUND_BONUS
	armour_penetration = ENHANCED_KNIFE_ARMOR_PENETRATION //Let's give them some AP for the trouble.

	if(tool_behaviour == TOOL_KNIFE)
		force = knife_force
		wound_bonus = knife_wound_bonus

	name = "enhanced razor claws"
	desc += span_warning("\n\nThese have undergone a special honing process; they'll kill people even faster than they used to.")
	user.visible_message(span_warning("[user] sharpens [src], [stone] disintegrating!"), span_warning("You sharpen [src], making it much more deadly than before, but [stone] disintegrates under the stress."))
	playsound(src, 'sound/items/unsheath.ogg', 25, TRUE)
	qdel(stone)
	return ..()

/obj/item/organ/internal/cyberimp/arm/razor_claws
	name = "razor claws implant"
	desc = "A set of hidden, retractable blades built into the fingertips; cyborg mercenary approved."
	items_to_create = list(/obj/item/knife/razor_claws)
	actions_types = list(/datum/action/item_action/organ_action/toggle/razor_claws)
	icon = 'modular_skyrat/modules/implants/icons/razorclaws.dmi'
	icon_state = "wolverine"
	extend_sound = 'sound/items/unsheath.ogg'
	retract_sound = 'sound/items/sheath.ogg'

/// bespoke subtypes for augs menu since it's a bit wonky
/obj/item/organ/internal/cyberimp/arm/razor_claws/right_arm
    zone = BODY_ZONE_R_ARM
    slot = ORGAN_SLOT_RIGHT_ARM_AUG

/obj/item/organ/internal/cyberimp/arm/razor_claws/left_arm
    zone = BODY_ZONE_L_ARM
    slot = ORGAN_SLOT_LEFT_ARM_AUG


/datum/action/item_action/organ_action/toggle/razor_claws
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

// Razorwire implant, long reach whip made of extremely thin wire, ouch!

/obj/item/melee/razorwire
	name = "implanted razorwire"
	desc = "A long length of monomolecular filament, built into the back of your hand. \
		Impossibly thin and flawlessly sharp, it should slice through organic materials with no trouble; \
		even from a few steps away. However, results against anything more durable will heavily vary."
	icon = 'modular_skyrat/modules/implants/icons/implants.dmi'
	icon_state = "razorwire_weapon"
	righthand_file = 'modular_skyrat/modules/implants/icons/inhands/lefthand.dmi'
	lefthand_file = 'modular_skyrat/modules/implants/icons/inhands/righthand.dmi'
	inhand_icon_state = "razorwire"
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	force = 18
	demolition_mod = 0.25 // This thing sucks at destroying stuff
	wound_bonus = 10
	bare_wound_bonus = 20
	weak_against_armour = TRUE
	reach = 2
	hitsound = 'sound/weapons/whip.ogg'
	attack_verb_continuous = list("slashes", "whips", "lashes", "lacerates")
	attack_verb_simple = list("slash", "whip", "lash", "lacerate")

/obj/item/organ/internal/cyberimp/arm/razorwire
	name = "razorwire spool implant"
	desc = "An integrated spool of razorwire, capable of being used as a weapon when whipped at your foes. \
		Built into the back of your hand, try your best to not get it tangled."
	items_to_create = list(/obj/item/melee/razorwire)
	icon = 'modular_skyrat/modules/implants/icons/implants.dmi'
	icon_state = "razorwire"

// Shell launch system, an arm mounted single-shot shotgun/.980 grenade launcher that comes out of your arm

/obj/item/gun/ballistic/shotgun/shell_launcher
	name = "shell launch system"
	desc = "A mounted cannon seated comfortably in a forearm compartment. This humanitarian device is capable in normal \
		mode of firing essentially any shotgun shell, and can be wrenched to a .980 Tydhouer grenade mode, \
		shells famously seen in the 'Kiboko' launcher."
	icon = 'modular_skyrat/modules/implants/icons/implants.dmi'
	icon_state = "shell_cannon_weapon"
	righthand_file = 'modular_skyrat/modules/implants/icons/inhands/lefthand.dmi'
	lefthand_file = 'modular_skyrat/modules/implants/icons/inhands/righthand.dmi'
	inhand_icon_state = "shell_cannon"
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "gun"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_LIGHT
	force = 10
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/shell_cannon
	obj_flags = UNIQUE_RENAME
	rack_sound = 'modular_skyrat/modules/modular_weapons/sounds/shotgun_rack.ogg'
	semi_auto = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	can_be_sawn_off = FALSE
	pb_knockback = 2
	initial_caliber = CALIBER_SHOTGUN
	alternative_caliber = CALIBER_980TYDHOUER
	recoil = 4
	inhand_x_dimension = 32
	inhand_y_dimension = 32

/obj/item/gun/ballistic/shotgun/shell_launcher/give_gun_safeties()
	return

/obj/item/ammo_box/magazine/internal/shot/shell_cannon
	name = "shell launch system internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	caliber = CALIBER_SHOTGUN
	max_ammo = 1
	multiload = FALSE

/obj/item/organ/internal/cyberimp/arm/shell_launcher
	name = "shell launch system implant"
	desc = "A mounted, single-shot housing for a shell launch cannon; capable of firing either twelve gauge shotgun shells, or .980 Tydhouer grenades."
	items_to_create = list(/obj/item/gun/ballistic/shotgun/shell_launcher)
	icon = 'modular_skyrat/modules/implants/icons/implants.dmi'
	icon_state = "shell_cannon"

#undef KNIFE_HITSOUND
#undef KNIFE_USESOUND
#undef KNIFE_ATTACK_VERB_CONTINUOUS
#undef KNIFE_ATTACK_VERB_SIMPLE
#undef KNIFE_SHARPNESS
#undef KNIFE_BARE_WOUND_BONUS
#undef CUTTER_HITSOUND
#undef CUTTER_USESOUND
#undef CUTTER_ATTACK_VERB_CONTINUOUS
#undef CUTTER_ATTACK_VERB_SIMPLE
#undef CUTTER_FORCE
#undef CUTTER_WOUND_BONUS
#undef ENHANCED_KNIFE_FORCE
#undef ENHANCED_KNIFE_WOUND_BONUS
#undef ENHANCED_KNIFE_ARMOR_PENETRATION
