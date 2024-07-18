/mob/living/basic/pet/cat/clown
	name = "clown cat"
	desc = "A funny little creature imported to Clown Planet, beloved by millions."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "clowncat"
	icon_living = "clowncat"
	icon_dead = "clowncat_dead"
	speak_emote = list("purrs", "honks", "meows")
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/internal/ears/cat = 1,
		/obj/item/organ/external/tail/cat = 1,
		/obj/item/clothing/mask/gas/clown_hat = 1,

	)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "asks to not joke about that"
	response_disarm_simple = "ask not to joke about that"
	response_harm_continuous = "throws tomatos"
	response_harm_simple = "throws tomato"
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_icon_state = "clowncat"
	has_collar_resting_icon_state = FALSE
	can_be_held = TRUE
	ai_controller = /datum/ai_controller/basic_controller/cat
	held_state = "cat2"
	attack_verb_continuous = "honks"
	attack_verb_simple = "honk"
	attack_sound = 'sound/items/bikehorn.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW


/mob/living/basic/pet/cat/mime
	name = "mime cat"
	desc = "Almost invisible, this little fella eats mice you can't even see!"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "catmime"
	icon_living = "catmime"
	icon_dead = "catmime_dead"
	speak_emote = list("...",)
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/internal/ears/cat = 1,
		/obj/item/organ/external/tail/cat = 1,
		/obj/item/clothing/mask/gas/mime = 1,
	)

/mob/living/basic/pet/cat/tiger
	name = "tiger cat"
	desc = "A tiger made of paper."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "tiger"
	icon_living = "tiger"
	icon_dead = "tiger_dead"
	speak_emote = list("roar","roars", "purrs", "meows",)
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	unsuitable_atmos_damage = 0.5
	butcher_results = list(
		/obj/item/food/meat/slab = 1,
		/obj/item/organ/internal/ears/cat = 1,
		/obj/item/organ/external/tail/cat = 1,
		/obj/item/clothing/head/pelt/tiger = 1,
	)


/mob/living/basic/carp/clarp
	name = "clarp"
	desc = "A Space Dragon ate a Clown Station, it tasted funny. This was the result."
	faction = list(FACTION_NEUTRAL)
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_dead = "clarp_dead"
	icon_gib = "clarp_gib"
	icon_living = "clarp"
	icon_state = "clarp"
	greyscale_config = NONE

/mob/living/basic/carp/petcarp
	faction = list(FACTION_NEUTRAL)

/mob/living/basic/pet/fox/redpanda
	name = "red panda"
	desc = "Wah't a dork."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "red_panda"
	icon_living = "red_panda"
	icon_dead = "dead_panda"
	speak_emote = list("chirps", "huff-quacks")
	butcher_results = list(/obj/item/food/meat/slab = 3)
	gold_core_spawnable = FRIENDLY_SPAWN
	can_be_held = TRUE
	held_state = "fox"
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	ai_controller = /datum/ai_controller/basic_controller/fox/docile //he's a nice boy


/mob/living/basic/pet/dog/corgi/robocorgo
	name = "\improper robocorgi"
	real_name = "corgi"
	desc = "They're a corgi with various mechanical modifications. The first stage in an E-N's life cycle."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "robocorgi"
	icon_living = "robocorgi"
	icon_dead = "robocorgi_dead"
	held_state = "corgi"
	butcher_results = list(/obj/item/food/meat/slab/corgi = 3, /obj/item/stack/sheet/animalhide/corgi = 1)
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_icon_state = "robocorgi"

