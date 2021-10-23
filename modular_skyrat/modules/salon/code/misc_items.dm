
/obj/item/storage/box/lipsticks
	name = "lipstick box"

/obj/item/storage/box/lipsticks/PopulateContents()
	..()
	new /obj/item/lipstick(src)
	new /obj/item/lipstick/purple(src)
	new /obj/item/lipstick/jade(src)
	new /obj/item/lipstick/black(src)

/obj/item/lipstick/quantum
	name = "Quantum Lipstick"

/obj/item/lipstick/quantum/attack(mob/M, mob/user)
	if(!open || !ismob(M))
		return

	if(!ishuman(M))
		to_chat(user, span_warning("Where are the lips on that?"))
		return

	var/new_color = input(
			user,
			"Select lipstick color",
			null,
			COLOR_WHITE,
		) as color | null

	var/mob/living/carbon/human/target = M
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

/obj/item/razor/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins shaving [user.p_them()]self without the razor guard! It looks like [user.p_theyre()] trying to commit suicide!"))
	shave(user, BODY_ZONE_PRECISE_MOUTH)
	shave(user, BODY_ZONE_HEAD)//doesnt need to be BODY_ZONE_HEAD specifically, but whatever
	return BRUTELOSS

/obj/item/razor/proc/shave(mob/living/carbon/human/H, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		H.facial_hairstyle = "Shaved"
	else
		H.hairstyle = "Bald"

	H.update_hair()
	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)


/obj/item/razor/attack(mob/M, mob/living/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/location = user.zone_selected
		if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !user.combat_mode)
			to_chat(user, span_warning("You stop, look down at what you're currently holding and ponder to yourself, \"This is probably to be used on their hair.\""))
			return
		if((location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !H.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, span_warning("[H] doesn't have a head!"))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH)
			if(!(FACEHAIR in H.dna.species.species_traits))
				to_chat(user, span_warning("There is no facial hair to shave!"))
				return
			if(!get_location_accessible(H, location))
				to_chat(user, span_warning("The mask is in the way!"))
				return
			if(H.facial_hairstyle == "Shaved")
				to_chat(user, span_warning("Already clean-shaven!"))
				return

			if(H == user) //shaving yourself
				user.visible_message(span_notice("[user] starts to shave [user.p_their()] facial hair with [src]."), \
					span_notice("You take a moment to shave your facial hair with [src]..."))
				if(do_after(user, 50, target = H))
					user.visible_message(span_notice("[user] shaves [user.p_their()] facial hair clean with [src]."), \
						span_notice("You finish shaving with [src]. Fast and clean!"))
					shave(H, location)
			else
				user.visible_message(span_warning("[user] tries to shave [H]'s facial hair with [src]."), \
					span_notice("You start shaving [H]'s facial hair..."))
				if(do_after(user, 50, target = H))
					user.visible_message(span_warning("[user] shaves off [H]'s facial hair with [src]."), \
						span_notice("You shave [H]'s facial hair clean off."))
					shave(H, location)
		else if(location == BODY_ZONE_HEAD)
			if(!(HAIR in H.dna.species.species_traits))
				to_chat(user, span_warning("There is no hair to shave!"))
				return
			if(!get_location_accessible(H, location))
				to_chat(user, span_warning("The headgear is in the way!"))
				return
			if(H.hairstyle == "Bald" || H.hairstyle == "Balding Hair" || H.hairstyle == "Skinhead")
				to_chat(user, span_warning("There is not enough hair left to shave!"))
				return

			if(H == user) //shaving yourself
				user.visible_message(span_notice("[user] starts to shave [user.p_their()] head with [src]."), \
					span_notice("You start to shave your head with [src]..."))
				if(do_after(user, 5, target = H))
					user.visible_message(span_notice("[user] shaves [user.p_their()] head with [src]."), \
						span_notice("You finish shaving with [src]."))
					shave(H, location)
			else
				var/turf/H_loc = H.loc
				user.visible_message(span_warning("[user] tries to shave [H]'s head with [src]!"), \
					span_notice("You start shaving [H]'s head..."))
				if(do_after(user, 50, target = H))
					if(H_loc == H.loc)
						user.visible_message(span_warning("[user] shaves [H]'s head bald with [src]!"), \
							span_notice("You shave [H]'s head bald."))
						shave(H, location)
		else
			..()
	else
		..()

/obj/structure/sign/barber
	name = "barbershop sign"
	desc = "A glowing red-blue-white stripe you won't mistake for any other!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "barber"

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
