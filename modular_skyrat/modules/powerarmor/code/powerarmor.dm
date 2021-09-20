/obj/item/powerarmor
	icon = 'modular_skyrat/modules/powerarmor/icons/suit_construction.dmi'

/obj/item/powerarmor/powerarmor_construct
	name = "power armor construct"
	desc = "An unfinished power armor that requires certain parts."
	icon_state = "skeleton"

	///a list that checks what parts have been added
	var/list/part_completion = list(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE) //head, chest, larm, rarm, lleg, rleg
	///a list that determines what tool is required to continue
	var/list/tool_required = list(FALSE, FALSE, FALSE) //screwdriver, wrench, wires
	///a stored value on whether it is being used already
	var/in_use = FALSE

/obj/item/powerarmor/powerarmor_construct/proc/check_completion()
	for(var/check_parts in 1 to 6)
		if(!part_completion[check_parts])
			return FALSE
	for(var/check_tools in 1 to 3)
		if(!tool_required[check_tools])
			return FALSE
	return TRUE

/obj/item/powerarmor/powerarmor_construct/examine(mob/user)
	. = ..()

	//if its all complete, just do the multitool
	if(check_completion())
		. += span_green("Object Required: FORGED PLATE")
		return

	//if any of the parts are missing, tell them
	if(!part_completion[1])
		. += span_notice("Part Missing: HEAD")
	if(!part_completion[2])
		. += span_notice("Part Missing: CHEST")
	if(!part_completion[3])
		. += span_notice("Part Missing: LEFT ARM")
	if(!part_completion[4])
		. += span_notice("Part Missing: RIGHT ARM")
	if(!part_completion[5])
		. += span_notice("Part Missing: LEFT LEG")
	if(!part_completion[6])
		. += span_notice("Part Missing: RIGHT LEG")

	//if any of the tools are missing, tell them
	if(tool_required[1])
		. += span_warning("Tool Required: SCREWDRIVER")
	if(tool_required[2])
		. += span_warning("Tool Required: WRENCH")
	if(tool_required[3])
		. += span_warning("Tool Required: CABLE")

/obj/item/powerarmor/powerarmor_construct/attackby(obj/item/I, mob/living/user, params)

	//to complete the building process... with something from reagent forging! content tying!
	if(istype(I, /obj/item/forging/complete/plate))
		if(in_use)
			to_chat(user, span_warning("[src] is already being worked on!"))
			return
		in_use = TRUE
		if(!check_completion())
			to_chat(user, span_warning("[src] is not ready for completion!"))
			in_use = FALSE
			return
		to_chat(user, span_notice("You begin using [I] on [src]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("You interrupt using [I] on [src]!"))
			in_use = FALSE
			return
		to_chat(user, span_notice("You finish using [I] on [src]..."))
		new /obj/item/clothing/suit/hooded/powerarmor(get_turf(src))
		qdel(src)
		return

	//for deconstructing what you have currently built
	if(I.tool_behaviour == TOOL_CROWBAR)
		cut_overlays()
		for(var/check_parts in 1 to 6)
			part_completion[check_parts] = FALSE
		for(var/check_tools in 1 to 3)
			tool_required[check_tools] = FALSE
		for(var/obj/remove_item in contents)
			remove_item.forceMove(get_turf(src))
		in_use = FALSE
		return

	//for the building process: screwdriver
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(in_use)
			to_chat(user, span_warning("[src] is already being worked on!"))
			return
		in_use = TRUE
		if(!tool_required[1])
			to_chat(user, span_warning("It is not necessary to use [I] on [src] currently!"))
			in_use = FALSE
			return
		to_chat(user, span_notice("You begin using [I] on [src]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("You interrupt using [I] on [src]!"))
			in_use = FALSE
			return
		tool_required[1] = FALSE
		in_use = FALSE
		return

	//for the building process: wrench
	if(I.tool_behaviour == TOOL_WRENCH)
		if(in_use)
			to_chat(user, span_warning("[src] is already being worked on!"))
			return
		in_use = TRUE
		if(!tool_required[1])
			to_chat(user, span_warning("It is not necessary to use [I] on [src] currently!"))
			in_use = FALSE
			return
		to_chat(user, span_notice("You begin using [I] on [src]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("You interrupt using [I] on [src]!"))
			in_use = FALSE
			return
		tool_required[2] = FALSE
		in_use = FALSE
		return

	//for the building process: coil
	if(istype(I, /obj/item/stack/cable_coil))
		if(in_use)
			to_chat(user, span_warning("[src] is already being worked on!"))
			return
		in_use = TRUE
		var/obj/item/stack/cable_coil/cable_item = I
		if(!tool_required[1])
			to_chat(user, span_warning("It is not necessary to use [I] on [src] currently!"))
			in_use = FALSE
			return
		if(!cable_item.use(1))
			to_chat(user, span_warning("You must be able to use [I]!"))
			in_use = FALSE
			return
		to_chat(user, span_notice("You begin using [I] on [src]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("You interrupt using [I] on [src]!"))
			in_use = FALSE
			return
		//so that when deconstructed, it will give us back a coil
		new /obj/item/stack/cable_coil(src)
		tool_required[3] = FALSE
		in_use = FALSE
		return

	//for when we are going to attach parts now
	if(istype(I, /obj/item/powerarmor/powerarmor_part))
		//dont want the power armor to be completed too fast
		if(in_use)
			to_chat(user, span_warning("[src] is already being worked on!"))
			return
		in_use = TRUE
		var/obj/item/powerarmor/powerarmor_part/armorpart_item = I
		//this will be checking the tool requirement
		for(var/check_tools in 1 to 3)
			if(!tool_required[check_tools])
				to_chat(user, span_warning("You need to use a certain tool to secure the parts before continuing to add parts! Check the construct's debug!"))
				in_use = FALSE
				return
		//this will check if we already have it installed
		if(part_completion[armorpart_item.powerarmor_part])
			to_chat(user, span_warning("[src] already has this kind of part attached, this would be meaningless!"))
			in_use = FALSE
			return
		to_chat(user, span_notice("You begin attaching [I] to [src]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("You interrupt attaching [I] to [src]!"))
			in_use = FALSE
			return
		armorpart_item.forceMove(src)
		part_completion[armorpart_item.powerarmor_part] = TRUE
		for(var/check_toolarmor in armorpart_item.powerarmor_tool)
			tool_required[check_toolarmor] = TRUE
		in_use = FALSE
		var/mutable_appearance/apply_overlay = mutable_appearance(armorpart_item.icon, armorpart_item.icon_state)
		overlays += apply_overlay
		return
	return ..()


/obj/item/powerarmor/powerarmor_part
	name = "power armor part"
	desc = "A part of power armor."
	//checks the constructs [x] in the list
	var/powerarmor_part = 0
	//enables the constructs [x] in tool_required
	//this means that after putting in this part, you must do these actions before continuing
	var/list/powerarmor_tool = list(0)

/obj/item/powerarmor/powerarmor_part/head
	name = "head power armor part"
	icon_state = "head"
	powerarmor_part = 1
	powerarmor_tool = list(3)

/obj/item/powerarmor/powerarmor_part/chest
	name = "chest power armor part"
	icon_state = "chest"
	powerarmor_part = 2
	powerarmor_tool = list(2,3)

/obj/item/powerarmor/powerarmor_part/larm
	name = "left arm power armor part"
	icon_state = "larm"
	powerarmor_part = 3
	powerarmor_tool = list(1)

/obj/item/powerarmor/powerarmor_part/rarm
	name = "right arm power armor part"
	icon_state = "rarm"
	powerarmor_part = 4
	powerarmor_tool = list(1)

/obj/item/powerarmor/powerarmor_part/lleg
	name = "left leg power armor part"
	icon_state = "lleg"
	powerarmor_part = 5
	powerarmor_tool = list(1)

/obj/item/powerarmor/powerarmor_part/rleg
	name = "right leg power armor part"
	icon_state = "rleg"
	powerarmor_part = 6
	powerarmor_tool = list(1)

/obj/item/clothing/suit/hooded/powerarmor
	name = "power armor suit"
	desc = "A suit for the power armor that is capable of being modified to give the user even greater potential."
	icon = 'modular_skyrat/modules/powerarmor/icons/suits.dmi'
	worn_icon = 'modular_skyrat/modules/powerarmor/icons/suit.dmi'
	icon_state = "powersuit"
	hoodtype = /obj/item/clothing/head/hooded/powerarmor
	body_parts_covered = HEAD|CHEST|GROIN|LEGS|ARMS
	equip_delay_self = 50
	strip_delay = 50
	slowdown = 3

	///the maximum amount of upgrades it can have (where some upgrades can cost multiple)
	var/upgradelimit = 10
	///whether the upgradelimit has been up'd, by some item
	var/upgradeboosted = FALSE
	//the cooldown for
	COOLDOWN_DECLARE(healing_cooldown)
	//the list of upgrades possible, starting here
	var/list/armor_upgraded = list(0, 0, 0, 0) //melee, bullet, laser, energy
	var/list/healing_upgraded = list(FALSE, FALSE, FALSE, FALSE) //brute, burn, toxin, oxygen
	var/speed_upgraded = 0
	var/list/misc_upgraded = list(FALSE) //spaceproof

	var/mob/wearer

/obj/item/clothing/suit/hooded/powerarmor/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/hooded/powerarmor/equipped(mob/user, slot)
	. = ..()
	wearer = user

/obj/item/clothing/suit/hooded/powerarmor/dropped()
	. = ..()
	wearer = null

/obj/item/clothing/suit/hooded/powerarmor/process(delta_time)
	if(!COOLDOWN_FINISHED(src, healing_cooldown))
		return
	COOLDOWN_START(src, healing_cooldown, 3 SECONDS)
	if(!wearer)
		return
	if(!isliving(wearer))
		return
	var/mob/living/living_wearer = wearer
	if(healing_upgraded[1] && living_wearer.getBruteLoss())
		living_wearer.adjustBruteLoss(-3)
	if(healing_upgraded[2] && living_wearer.getFireLoss())
		living_wearer.adjustFireLoss(-3)
	if(healing_upgraded[3] && living_wearer.getToxLoss())
		living_wearer.adjustToxLoss(-3)
	if(healing_upgraded[4] && living_wearer.getOxyLoss())
		living_wearer.adjustOxyLoss(-3)

/obj/item/clothing/suit/hooded/powerarmor/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/suit/hooded/powerarmor/proc/update_upgrades()
	armor.setRating(armor_upgraded[1] * 20, armor_upgraded[2] * 20, armor_upgraded[3] * 20, armor_upgraded[4] * 20, 0, 0, 0, 0, 0, 0, 0)
	slowdown = initial(slowdown) - speed_upgraded
	clothing_flags = initial(clothing_flags)
	min_cold_protection_temperature = initial(min_cold_protection_temperature)
	max_heat_protection_temperature = initial(max_heat_protection_temperature)
	heat_protection = initial(heat_protection)
	cold_protection = initial(cold_protection)
	if(misc_upgraded[1])
		heat_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
		cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
		clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
		max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
		min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
		if(hood)
			hood.armor.setRating(armor_upgraded[1] * 20, armor_upgraded[2] * 20, armor_upgraded[3] * 20, armor_upgraded[4] * 20, 0, 0, 0, 0, 0, 0, 0)
			hood.clothing_flags = initial(clothing_flags)
			hood.min_cold_protection_temperature = initial(min_cold_protection_temperature)
			hood.max_heat_protection_temperature = initial(max_heat_protection_temperature)
			hood.heat_protection = initial(heat_protection)
			hood.cold_protection = initial(cold_protection)
			if(misc_upgraded[1])
				hood.heat_protection = HEAD
				hood.cold_protection = HEAD
				hood.clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
				hood.max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
				hood.min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/suit/hooded/powerarmor/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/powerarmor_upgrade))
		var/obj/item/powerarmor_upgrade/upgrade_item = W
		if(upgradelimit <= 0)
			return
		if(!upgrade_item.upgrade_type)
			return
		var/upgrade_name = upgrade_item.upgrade_type
		switch(upgrade_name)
			if("melee armor")
				armor_upgraded[1]++
			if("bullet armor")
				armor_upgraded[2]++
			if("laser armor")
				armor_upgraded[3]++
			if("energy armor")
				armor_upgraded[4]++
			if("brute healing")
				if(healing_upgraded[1])
					return
				healing_upgraded[1] = TRUE
			if("burn healing")
				if(healing_upgraded[2])
					return
				healing_upgraded[2] = TRUE
			if("toxin healing")
				if(healing_upgraded[3])
					return
				healing_upgraded[3] = TRUE
			if("oxygen healing")
				if(healing_upgraded[4])
					return
				healing_upgraded[4] = TRUE
			if("speed")
				speed_upgraded++
			if("space proof")
				if(misc_upgraded[1])
					return
				misc_upgraded[1] = TRUE
		upgrade_item.forceMove(src)
		update_upgrades()
	return ..()

/obj/item/clothing/head/hooded/powerarmor
	name = "power armor helmet"
	desc = "A helment for the power armor that is capable of being modified to give the user even greater potential."
	icon = 'modular_skyrat/modules/powerarmor/icons/hats.dmi'
	worn_icon = 'modular_skyrat/modules/powerarmor/icons/head.dmi'
	icon_state = "helmet0"

/obj/item/powerarmor_upgrade
	name = "power armor upgrade"
	desc = "A small item that will upgrade the power suit"

	var/upgrade_type

/obj/item/powerarmor_upgrade/melee_armor
	upgrade_type = "melee armor"

/obj/item/powerarmor_upgrade/bullet_armor
	upgrade_type = "bullet armor"

/obj/item/powerarmor_upgrade/laser_armor
	upgrade_type = "laser armor"

/obj/item/powerarmor_upgrade/energy_armor
	upgrade_type = "energy armor"

/obj/item/powerarmor_upgrade/brute_heal
	upgrade_type = "brute healing"

/obj/item/powerarmor_upgrade/burn_heal
	upgrade_type = "burn healing"

/obj/item/powerarmor_upgrade/toxin_heal
	upgrade_type = "toxin healing"

/obj/item/powerarmor_upgrade/oxygen_heal
	upgrade_type = "oxygen healing"

/obj/item/powerarmor_upgrade/speed_upgrade
	upgrade_type = "speed"

/obj/item/powerarmor_upgrade/space_proof
	upgrade_type = "space proof"
