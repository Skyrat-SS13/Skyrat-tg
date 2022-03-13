/datum/outfit/pirate/enclave_officer
	name = "Imperial Enclave Officer"

	head = /obj/item/clothing/head/soft/enclaveo
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild/command

	uniform = /obj/item/clothing/under/enclaveo
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/automatic/pistol/automag

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/military/assault
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/ammo_box/magazine/automag = 4)

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/enclave/officer

/datum/outfit/pirate/enclave_officer/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.hairstyle = "Crewcut"
	equipped_human.hair_color = COLOR_ALMOST_BLACK
	equipped_human.facial_hairstyle = "Shaved"
	equipped_human.facial_hair_color = COLOR_ALMOST_BLACK
	equipped_human.update_hair()

/datum/id_trim/enclave/officer
	assignment = "Imperial Enclave Officer"

/datum/outfit/pirate/enclave_trooper
	name = "Imperial Enclave Trooper"

	head = /obj/item/clothing/head/soft/enclave
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild

	uniform = /obj/item/clothing/under/enclave
	suit = /obj/item/clothing/suit/armor/vest/alt
	suit_store = /obj/item/gun/ballistic/automatic/m16

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/military/assault
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/ammo_box/magazine/m16 = 4)

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/enclave

/datum/outfit/pirate/enclave_trooper/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.hairstyle = "Crewcut"
	equipped_human.hair_color = COLOR_ALMOST_BLACK
	equipped_human.facial_hairstyle = "Shaved"
	equipped_human.facial_hair_color = COLOR_ALMOST_BLACK
	equipped_human.update_hair()

/datum/id_trim/enclave
	assignment = "Imperial Enclave Trooper"
	trim_state = "trim_syndicate"
	access = list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS)

/obj/effect/mob_spawn/ghost_role/human/pirate/enclave
	name = "imperial enclave sleeper"
	desc = "Cozy. You get the feeling you aren't supposed to be here, though..."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	mob_name = "an imperial enclave trooper"
	outfit = /datum/outfit/pirate/enclave_trooper
	rank = "Imperial Enclave Trooper"
	you_are_text = "You are an Imperial Enclave outfit."
	flavour_text = "The station has refused to pay the fine for breaking Imperial regulations, you are here to recover the debt. Do so by ransoming crew and stealing credits."
	spawner_job_path = /datum/job/space_pirate
	restricted_species = list(/datum/species/human)
	spawn_oldpod = FALSE
	random_appearance = TRUE

/datum/job/fugitive_hunter
	title = ROLE_FUGITIVE_HUNTER
	policy_index = ROLE_FUGITIVE_HUNTER


/obj/effect/mob_spawn/ghost_role/human/pirate/enclave/generate_pirate_name(spawn_gender)
	var/first_name = pick(GLOB.commando_names)
	return "[rank] [first_name]"

/obj/effect/mob_spawn/ghost_role/human/pirate/enclave/captain
	rank = "Imperial Enclave Officer"
	outfit = /datum/outfit/pirate/enclave_officer

/obj/effect/mob_spawn/ghost_role/human/pirate/enclave/gunner
	rank = "Imperial Enclave Trooper"

/datum/map_template/shuttle/pirate/imperial_enclave
	prefix = "_maps/shuttles/skyrat/"
	suffix = "enclave"
	name = "pirate ship (Imperial Enclave Enforcer-Class Starship)"

/obj/item/gun/ballistic/automatic/pistol/automag
	name = "\improper Automag"
	desc = "A .44 AMP handgun with a seek metallic finish."
	icon_state = "automag"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/automag.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/automag
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/automag.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'

/obj/item/ammo_box/magazine/automag
	name = "handgun magazine (.44 AMP)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "automag"
	base_icon_state = "automag"
	ammo_type = /obj/item/ammo_casing/c44
	caliber = CALIBER_44
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_casing/c44
	name = ".44 AMP bullet casing"
	desc = "A .44 AMP bullet casing."
	caliber = CALIBER_44
	projectile_type = /obj/projectile/bullet/c44

/obj/projectile/bullet/c44
	name = ".44 AMP bullet"
	damage = 40
	wound_bonus = 30

