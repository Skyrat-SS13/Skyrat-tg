/mob/living/carbon/necromorph
	name = "Necromorph - BASE"
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'
	icon_state = "twitcher"
	gender = FEMALE //All xenos are girls!!
	dna = null
	faction = list(ROLE_NECROMORPH)
	sight = SEE_MOBS
	see_in_dark = 4
	verb_say = "hisses"
	initial_language_holder = /datum/language_holder/alien
	bubble_icon = "alien"
	type_of_meat = /obj/item/food/meat/slab/xeno
	blocks_emissive = EMISSIVE_BLOCK_UNIQUE
	var/leaping = FALSE

	var/move_delay_add = 0 // movement delay to add

	status_flags = CANUNCONSCIOUS|CANPUSH

	heat_protection = 0.5 // minor heat insulation

	gib_type = /obj/effect/decal/cleanable/xenoblood/xgibs
	unique_name = TRUE

/mob/living/carbon/necromorph/Initialize()
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)

	create_bodyparts() //initialize bodyparts

	create_internal_organs()

	ADD_TRAIT(src, TRAIT_CAN_STRIP, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_NEVER_WOUNDED, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	. = ..()

/mob/living/carbon/necromorph/create_internal_organs()
	internal_organs += new /obj/item/organ/brain/necromorph
	internal_organs += new /obj/item/organ/eyes/night_vision/necromorph
	internal_organs += new /obj/item/organ/lungs/necromorph
	internal_organs += new /obj/item/organ/heart/necromorph
	internal_organs += new /obj/item/organ/liver/necromorph
	internal_organs += new /obj/item/organ/tongue/necromorph
	..()


/mob/living/carbon/necromorph/on_lying_down(new_lying_angle)
	. = ..()
	update_icons()

/mob/living/carbon/necromorph/on_standing_up()
	. = ..()
	update_icons()
