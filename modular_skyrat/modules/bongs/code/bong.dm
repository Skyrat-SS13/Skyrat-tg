/obj/item/bong
	name = "bong"
	desc = "Technically known as a water pipe."
	icon = 'modular_skyrat/modules/bongs/icons/bong.dmi'
	lefthand_file = 'modular_skyrat/modules/bongs/icons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/bongs/icons/righthand.dmi'
	icon_state = "bongoff"
	inhand_icon_state = "bongoff"
	var/icon_on = "bongon"
	var/icon_off = "bongoff"
	var/lit = FALSE
	var/useable_bonghits = 4
	var/bonghits = 0
	var/chem_volume = 30
	var/list_reagents = null
	var/packeditem = FALSE
	var/quarter_volume = 0

/obj/item/bong/Initialize()
	. = ..()
	create_reagents(chem_volume, INJECTABLE | NO_REACT)

/obj/item/bong/attackby(obj/item/used_item, mob/user, params)
	if(istype(used_item, /obj/item/food/grown))
		var/obj/item/food/grown/grown_item = used_item
		if(!packeditem)
			if(HAS_TRAIT(grown_item, TRAIT_DRIED))
				to_chat(user, span_notice("You stuff [grown_item] into [src]."))
				bonghits = useable_bonghits
				packeditem = TRUE
				if(grown_item.reagents)
					grown_item.reagents.trans_to(src, grown_item.reagents.total_volume, transfered_by = user)
					quarter_volume = reagents.total_volume/useable_bonghits
				qdel(grown_item)
			else
				to_chat(user, span_warning("It has to be dried first!"))
		else
			to_chat(user, span_warning("It is already packed!"))
	else if(istype(used_item, /obj/item/reagent_containers/hash)) //for hash/dabs
		if(!packeditem)
			to_chat(user, span_notice("You stuff [used_item] into [src]."))
			bonghits = useable_bonghits
			packeditem = TRUE
			if(used_item.reagents)
				used_item.reagents.trans_to(src, used_item.reagents.total_volume, transfered_by = user)
				quarter_volume = reagents.total_volume/useable_bonghits
			qdel(used_item)
	else
		var/lighting_text = used_item.ignition_effect(src,user)
		if(lighting_text)
			if(bonghits > 0)
				light(lighting_text)
				name = "lit [initial(name)]"
			else
				to_chat(user, span_warning("There is nothing to smoke!"))
		else
			return ..()

/obj/item/bong/attack_self(mob/user)
	var/turf/location = get_turf(user)
	if(lit)
		user.visible_message(span_notice("[user] puts out [src]."), span_notice("You put out [src]."))
		lit = FALSE
		icon_state = icon_off
		inhand_icon_state = icon_off
		return
	if(!lit && bonghits > 0)
		to_chat(user, span_notice("You empty [src] onto [location]."))
		new /obj/effect/decal/cleanable/ash(location)
		packeditem = FALSE
		bonghits = 0
		reagents.clear_reagents()
	return

/obj/item/bong/attack(mob/hit_mob, mob/user, def_zone)
	if(packeditem && lit)
		if(hit_mob == user)
			hit_mob.visible_message(span_notice("[user] starts taking a hit from the [src]."))
			playsound(src, 'sound/chemistry/heatdam.ogg', 50, TRUE)
			if(do_after(user,40))
				to_chat(hit_mob, span_notice("You finish taking a hit from the [src]."))
				if(reagents.total_volume)
					reagents.trans_to(hit_mob, quarter_volume, transfered_by = user, methods = VAPOR)
					bonghits--
				var/turf/open/pos = get_turf(src)
				if(istype(pos) && pos.air.return_pressure() < 2*ONE_ATMOSPHERE)
					pos.atmos_spawn_air("water_vapor=10;TEMP=T20C + 20")
				if(bonghits <= 0)
					to_chat(hit_mob, span_notice("Your [name] goes out."))
					lit = FALSE
					packeditem = FALSE
					icon_state = icon_off
					inhand_icon_state = icon_off
					name = "[initial(name)]"
					reagents.clear_reagents() //just to make sure

/obj/item/bong/proc/light(flavor_text = null)
	if(lit)
		return
	if(!(flags_1 & INITIALIZED_1))
		icon_state = icon_on
		inhand_icon_state = icon_on
		return

	lit = TRUE
	name = "lit [name]"
	if(reagents.get_reagent_amount(/datum/reagent/toxin/plasma)) // the plasma explodes when exposed to fire
		var/datum/effect_system/reagents_explosion/explosion = new()
		explosion.set_up(round(reagents.get_reagent_amount(/datum/reagent/toxin/plasma) / 2.5, 1), get_turf(src), 0, 0)
		explosion.start()
		qdel(src)
		return
	if(reagents.get_reagent_amount(/datum/reagent/fuel)) // the fuel explodes, too, but much less violently
		var/datum/effect_system/reagents_explosion/explosion = new()
		explosion.set_up(round(reagents.get_reagent_amount(/datum/reagent/fuel) / 5, 1), get_turf(src), 0, 0)
		explosion.start()
		qdel(src)
		return
	// allowing reagents to react after being lit
	reagents.flags &= ~(NO_REACT)
	reagents.handle_reactions()
	icon_state = icon_on
	inhand_icon_state = icon_on
	if(flavor_text)
		var/turf/bong_turf = get_turf(src)
		bong_turf.visible_message(flavor_text)

/obj/item/bong/lungbuster
	name = "the lungbuster"
	desc = "30 inches of doom."
	icon_state = "lungbusteroff"
	inhand_icon_state = "lungbusteroff"
	icon_on = "lungbusteron"
	icon_off = "lungbusteroff"
	useable_bonghits = 2
	chem_volume = 50

/obj/item/bong/lungbuster/attack(mob/hit_mob, mob/user, def_zone)
	if(packeditem && lit)
		if(hit_mob == user)
			hit_mob.visible_message(span_notice("[user] starts taking a hit from the [src]."))
			playsound(src, 'sound/chemistry/heatdam.ogg', 50, TRUE)
			if(do_after(user,40))
				to_chat(hit_mob, span_notice("You finish taking a hit from the [src]."))
				if(reagents.total_volume)
					reagents.trans_to(hit_mob, quarter_volume, transfered_by = user, methods = VAPOR)
					bonghits--
				var/turf/open/pos = get_turf(src)
				if(istype(pos) && pos.air.return_pressure() < 2*ONE_ATMOSPHERE)
					pos.atmos_spawn_air("water_vapor=30;TEMP=T20C + 20")
				if(prob(50))
					playsound(hit_mob, pick('modular_skyrat/master_files/sound/effects/lungbust_moan1.ogg','modular_skyrat/master_files/sound/effects/lungbust_moan2.ogg', 'modular_skyrat/master_files/sound/effects/lungbust_moan3.ogg'), 50, TRUE)
					hit_mob.emote("moan")
				else
					playsound(hit_mob, pick('modular_skyrat/master_files/sound/effects/lungbust_cough1.ogg','modular_skyrat/master_files/sound/effects/lungbust_cough2.ogg'), 50, TRUE)
					hit_mob.emote("cough")
				if(bonghits <= 0)
					to_chat(hit_mob, span_notice("Your [name] goes out."))
					lit = FALSE
					packeditem = FALSE
					icon_state = icon_off
					inhand_icon_state = icon_off
					name = "[initial(name)]"
					reagents.clear_reagents() //just to make sure

/datum/crafting_recipe/bong
	name = "Bong"
	result = /obj/item/bong
	reqs = list(/obj/item/stack/sheet/iron = 5,
				/obj/item/stack/sheet/glass = 10)
	time = 20
	category = CAT_CHEMISTRY

/datum/crafting_recipe/lungbuster
	name = "The Lungbuster"
	result = /obj/item/bong/lungbuster
	reqs = list(/obj/item/stack/sheet/iron = 10,
				/obj/item/stack/sheet/glass = 20)
	time = 30
	category = CAT_CHEMISTRY
