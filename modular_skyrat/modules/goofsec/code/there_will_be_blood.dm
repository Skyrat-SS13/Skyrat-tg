/obj/item/storage/belt/hf
	name = "high frequency blade sheath"
	desc = "A utilitarian sheath used to hold high frequency blades, among other security gear."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "hfbelt"
	worn_icon_state = "hfbelt"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/hf/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	STR.rustle_sound = FALSE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/highfrequencyblade,
		/obj/item/ammo_box,
		/obj/item/ammo_casing/shotgun,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/clothing/gloves,
		/obj/item/flashlight/seclite,
		/obj/item/food/donut,
		/obj/item/grenade,
		/obj/item/holosign_creator/security,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
		/obj/item/radio,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/stock_parts/cell/microfusion, //SKYRAT EDIT ADDITION
		))

/obj/item/storage/belt/hf/proc/find_blade()
	for(var/obj/item/item_to_check in contents)
		if(istype(item_to_check, /obj/item/highfrequencyblade))
			return item_to_check
	return FALSE

/obj/item/storage/belt/hf/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(find_blade())
		context[SCREENTIP_CONTEXT_ALT_LMB] = "Draw Blade"

/obj/item/storage/belt/hf/examine(mob/user)
	. = ..()
	if(find_blade())
		. += span_notice("Alt-click it to quickly draw the blade.")

/obj/item/storage/belt/hf/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		return
	var/obj/item/highfrequencyblade/found_blade = find_blade()
	if(found_blade)
		user.visible_message(span_notice("[user] takes [found_blade] out of [src]."), span_notice("You take [found_blade] out of [src]."))
		user.put_in_hands(found_blade)
		update_appearance()
	else
		to_chat(user, span_warning("[src] is empty!"))

/obj/item/storage/belt/hf/update_icon_state()
	icon_state = "hfbelt"
	worn_icon_state = "hfbelt"
	if(find_blade())
		icon_state += "-full"
		worn_icon_state += "-full"
	return ..()

/obj/item/storage/belt/hf/PopulateContents()
	new /obj/item/highfrequencyblade/security(src)
	update_appearance()

/obj/item/storage/belt/hf/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/highfrequencyblade/security(src)
	update_appearance()

/obj/item/highfrequencyblade/security
	name = "security high frequency blade"
	desc = "Lopland rolled out this tuned down high frequency blade after facing backlash from the public about the lethality of their agents in riot control. \
	It lacks the ability to explode humanoids into a shower of gibs, but it is still a useful weapon provided you understand it has to be this way."
	force = 5 // can get up to 4.5x force if the minigame is played correctly, so upper damage of 22.5 per slash
	throwforce = 15
	wound_bonus = 20
	bare_wound_bonus = 25
	block_chance_wielded = 25
	can_gib = FALSE
	can_deflect_projectiles_unwielded = FALSE
	can_effect_non_mobs = FALSE

/datum/supply_pack/security/armory/hf
	name = "High Frequency Blade Crate"
	desc = "Three High Frequency Blades in sheaths, if your security team gets disarmed."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/storage/belt/hf,
					/obj/item/storage/belt/hf,
					/obj/item/storage/belt/hf)
	crate_name = "High Frequency Blade crate"
