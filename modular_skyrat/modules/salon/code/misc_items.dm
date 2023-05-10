
/obj/item/storage/box/lipsticks
	name = "lipstick box"

/obj/item/storage/box/lipsticks/PopulateContents()
	..()
	new /obj/item/lipstick(src)
	new /obj/item/lipstick/purple(src)
	new /obj/item/lipstick/jade(src)
	new /obj/item/lipstick/black(src)

/obj/item/lipstick/quantum
	name = "quantum lipstick"

/obj/item/lipstick/quantum/attack(mob/attacked_mob, mob/user)
	if(!open || !ismob(attacked_mob))
		return

	if(!ishuman(attacked_mob))
		to_chat(user, span_warning("Where are the lips on that?"))
		return

	INVOKE_ASYNC(src, PROC_REF(async_set_color), attacked_mob, user)

/obj/item/lipstick/quantum/proc/async_set_color(mob/attacked_mob, mob/user)
	var/new_color = input(
			user,
			"Select lipstick color",
			null,
			COLOR_WHITE,
		) as color | null

	var/mob/living/carbon/human/target = attacked_mob
	if(target.is_mouth_covered())
		to_chat(user, span_warning("Remove [ target == user ? "your" : "[target.p_their()]" ] mask!"))
		return
	if(target.lip_style) //if they already have lipstick on
		to_chat(user, span_warning("You need to wipe off the old lipstick first!"))
		return

	if(target == user)
		user.visible_message(span_notice("[user] does [user.p_their()] lips with \the [src]."), \
			span_notice("You take a moment to apply \the [src]. Perfect!"))
		target.update_lips("lipstick", new_color, lipstick_trait)
		return

	user.visible_message(span_warning("[user] begins to do [target]'s lips with \the [src]."), \
		span_notice("You begin to apply \the [src] on [target]'s lips..."))
	if(!do_after(user, 2 SECONDS, target = target))
		return
	user.visible_message(span_notice("[user] does [target]'s lips with \the [src]."), \
		span_notice("You apply \the [src] on [target]'s lips."))
	target.update_lips("lipstick", new_color, lipstick_trait)

/obj/item/hairbrush/comb
	name = "comb"
	desc = "A rather simple tool, used to straighten out hair and knots in it."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "blackcomb"

/obj/item/hairstyle_preview_magazine
	name = "hip hairstyles magazine"
	desc = "A magazine featuring a magnitude of hairsytles!"

/obj/item/hairstyle_preview_magazine/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	// A simple GUI with a list of hairstyles and a view, so people can choose a hairstyle!

/obj/effect/decal/cleanable/hair
	name = "hair cuttings"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "cut_hair"

/obj/item/razor
	name = "electric razor"
	desc = "The latest and greatest power razor born from the science of shaving."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "razor"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	// How long do we take to shave someone's (facial) hair?
	var/shaving_time = 5 SECONDS

/obj/item/razor/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins shaving [user.p_them()]self without the razor guard! It looks like [user.p_theyre()] trying to commit suicide!"))
	shave(user, BODY_ZONE_PRECISE_MOUTH)
	shave(user, BODY_ZONE_HEAD)//doesnt need to be BODY_ZONE_HEAD specifically, but whatever
	return BRUTELOSS

/obj/item/razor/proc/shave(mob/living/carbon/human/target_human, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		target_human.facial_hairstyle = "Shaved"
	else
		target_human.hairstyle = "Bald"

	target_human.update_body_parts()
	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)


/obj/item/razor/attack(mob/attacked_mob, mob/living/user)
	if(ishuman(attacked_mob))
		var/mob/living/carbon/human/target_human = attacked_mob
		var/location = user.zone_selected
		if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !user.combat_mode)
			to_chat(user, span_warning("You stop, look down at what you're currently holding and ponder to yourself, \"This is probably to be used on their hair or their facial hair.\""))
			return
		if((location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !target_human.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, span_warning("[target_human] doesn't have a head!"))
			return

		if(location == BODY_ZONE_PRECISE_MOUTH)
			if(!(FACEHAIR in target_human.dna.species.species_traits))
				to_chat(user, span_warning("There is no facial hair to shave!"))
				return
			if(!get_location_accessible(target_human, location))
				to_chat(user, span_warning("The mask is in the way!"))
				return
			if(HAS_TRAIT(target_human, TRAIT_SHAVED))
				to_chat(user, span_warning("[target_human] is just way too shaved. Like, really really shaved."))
				return
			if(target_human.facial_hairstyle == "Shaved")
				to_chat(user, span_warning("Already clean-shaven!"))
				return

			var/self_shaving = target_human == user // Shaving yourself?
			user.visible_message(span_notice("[user] starts to shave [self_shaving ? user.p_their() : "[target_human]'s"] hair with [src]."), \
				span_notice("You take a moment to shave [self_shaving ? "your" : "[target_human]'s" ] hair with [src]..."))
			if(do_after(user, shaving_time, target = target_human))
				user.visible_message(span_notice("[user] shaves [self_shaving ? user.p_their() : "[target_human]'s"] hair clean with [src]."), \
					span_notice("You finish shaving [self_shaving ? "your" : " [target_human]'s"] hair with [src]. Fast and clean!"))
				shave(target_human, location)

		else if(location == BODY_ZONE_HEAD)
			if(!(HAIR in target_human.dna.species.species_traits))
				to_chat(user, span_warning("There is no hair to shave!"))
				return
			if(!get_location_accessible(target_human, location))
				to_chat(user, span_warning("The headgear is in the way!"))
				return
			if(target_human.hairstyle == "Bald" || target_human.hairstyle == "Balding Hair" || target_human.hairstyle == "Skinhead")
				to_chat(user, span_warning("There is not enough hair left to shave!"))
				return
			if(HAS_TRAIT(target_human, TRAIT_SHAVED))
				to_chat(user, span_warning("[target_human] is just way too shaved. Like, really really shaved."))
				return

			var/self_shaving = target_human == user // Shaving yourself?
			user.visible_message(span_notice("[user] starts to shave [self_shaving ? user.p_their() : "[target_human]'s"] hair with [src]."), \
				span_notice("You take a moment to shave [self_shaving ? "your" : "[target_human]'s" ] hair with [src]..."))
			if(do_after(user, shaving_time, target = target_human))
				user.visible_message(span_notice("[user] shaves [self_shaving ? user.p_their() : "[target_human]'s"] hair clean with [src]."), \
					span_notice("You finish shaving [self_shaving ? "your" : " [target_human]'s"] hair with [src]. Fast and clean!"))
				shave(target_human, location)
		else
			..()
	else
		..()

/obj/structure/sign/barber
	name = "barbershop sign"
	desc = "A glowing red-blue-white stripe you won't mistake for any other!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "barber"
	buildable_sign = FALSE // Don't want them removed, they look too jank.

/obj/item/storage/box/perfume
	name = "box of perfumes"

/obj/item/storage/box/perfume/PopulateContents()
	new /obj/item/perfume/cologne(src)
	new /obj/item/perfume/wood(src)
	new /obj/item/perfume/rose(src)
	new /obj/item/perfume/jasmine(src)
	new /obj/item/perfume/mint(src)
	new /obj/item/perfume/vanilla(src)
	new /obj/item/perfume/pear(src)
	new /obj/item/perfume/strawberry(src)
	new /obj/item/perfume/cherry(src)
	new /obj/item/perfume/amber(src)
