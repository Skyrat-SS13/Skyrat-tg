#define NRI_COOLDOWN_HEAL 30 SECONDS
#define NRI_COOLDOWN_RADS 45 SECONDS
#define NRI_COOLDOWN_ACID 45 SECONDS

#define NRI_HEAL_AMOUNT 5
#define NRI_BLOOD_REPLENISHMENT 10

/datum/outfit/pirate/enclave_officer
	name = "Imperial Enclave Officer"

	head = /obj/item/clothing/head/beret/sec/nri
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild/command
	mask = null

	uniform = /obj/item/clothing/under/costume/nri/captain
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/automatic/plastikov/nri_pirate

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/military/nri/captain/pirate_officer
	back = /obj/item/storage/backpack/duffelbag/syndie/nri/captain
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack = 1, /obj/item/ammo_box/magazine/automag = 3, /obj/item/gun/ballistic/automatic/pistol/automag = 1, /obj/item/crucifix = 1, /obj/item/device/traitor_announcer = 1, /obj/item/clothing/mask/gas/hecu2 = 1, /obj/item/modular_computer/tablet/pda/security = 1)
	l_pocket = /obj/item/paper/fluff/nri_document
	r_pocket = /obj/item/storage/bag/ammo

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/enclave/officer

/datum/outfit/pirate/enclave_officer/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()

/datum/id_trim/enclave/officer
	assignment = "NRI Field Officer"

/datum/outfit/pirate/enclave_trooper
	name = "Imperial Enclave Trooper"

	head = null
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild
	mask = null

	uniform = /obj/item/clothing/under/costume/nri
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/automatic/plastikov/nri_pirate

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/military/nri/pirate
	back = /obj/item/storage/backpack/duffelbag/syndie/nri
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack = 1, /obj/item/crucifix = 1, /obj/item/ammo_box/magazine/m9mm_aps = 3, /obj/item/clothing/mask/gas/hecu2 = 1, /obj/item/modular_computer/tablet/pda/security = 1)
	l_pocket = /obj/item/gun/ballistic/automatic/pistol/ladon/nri
	r_pocket = /obj/item/storage/bag/ammo

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/enclave

/datum/outfit/pirate/enclave_trooper/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()

/datum/id_trim/enclave
	assignment = "NRI Marine"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_nri"
	sechud_icon_state = "hud_nri"
	access = list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS)

/obj/effect/mob_spawn/ghost_role/human/pirate/enclave
	name = "NRI Raider sleeper"
	desc = "Cozy. You get the feeling you aren't supposed to be here, though..."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	mob_name = "Novaya Rossiyskaya Imperiya raiding party's marine"
	outfit = /datum/outfit/pirate/enclave_trooper
	rank = "NRI Marine"
	you_are_text = "You are a Novaya Rossiyskaya Imperiya task force."
	flavour_text = "The station has refused to pay the fine for breaking Imperial regulations, you are here to recover the debt. Do so by demanding the funds. Force approach is usually recommended, but isn't the only method."
	important_text = "Allowed races are humans, Akulas, IPCs. Follow your field officer's orders."
	spawner_job_path = /datum/job/space_pirate
	restricted_species = list(/datum/species/human, /datum/species/akula, /datum/species/robotic/ipc)
	spawn_oldpod = FALSE
	random_appearance = FALSE
	show_flavor = TRUE

/obj/effect/mob_spawn/ghost_role/human/pirate/enclave/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.remove_language(/datum/language/piratespeak)

/datum/job/fugitive_hunter
	title = ROLE_FUGITIVE_HUNTER
	policy_index = ROLE_FUGITIVE_HUNTER


/obj/effect/mob_spawn/ghost_role/human/pirate/enclave/generate_pirate_name(spawn_gender)
	var/last_name = pick(GLOB.last_names)
	return "[rank] [last_name]"

/obj/effect/mob_spawn/ghost_role/human/pirate/enclave/captain
	name = "NRI Officer sleeper"
	mob_name = "Novaya Rossiyskaya Imperiya raiding party's field officer"
	outfit = /datum/outfit/pirate/enclave_officer
	rank = "Field Officer"
	important_text = "Allowed races are humans, Akulas, IPCs. There is an important document in your pocket I'd advise you to read - do NOT dispose of it by throwing it into space, burning it, or otherwise destroying it or making it unreadable afterwards. I'd also advise putting it in your locker or keeping it by yourself, but if you do have better ideas do whatever."

/obj/effect/mob_spawn/ghost_role/human/pirate/enclave/captain/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.grant_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.grant_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.remove_language(/datum/language/piratespeak)

/obj/effect/mob_spawn/ghost_role/human/pirate/enclave/gunner
	rank = "Marine"

/datum/map_template/shuttle/pirate/imperial_enclave
	prefix = "_maps/shuttles/skyrat/"
	suffix = "enclave"
	name = "pirate ship (NRI Enforcer-Class Starship)"

/obj/item/gun/ballistic/automatic/pistol/automag
	name = "\improper Automag"
	desc = "A .44 AMP handgun with a sleek metallic finish."
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

/obj/item/storage/belt/military/nri/captain/pirate_officer/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/plastikov9mm = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/storage/belt/military/nri/pirate/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/plastikov9mm = 4,
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/frag = 1,
	),src)

/obj/item/paper/fluff/nri_document
	name = "NRI Mission Specifications"
	default_raw_text = {"On behalf of Novaya Rossiyskaya Imperiya Defense and Economical Collegias by the order of the Admiral Voronov Platon Aleksandrovich and the Active Privy Councillor Radich Katarina Dinovich:
	<br> By the Supreme command, a special meeting of representatives from the Imperial Academy of Finances and the Collegias of Foreign and Internal Affairs, Economy, Defense was convened under the chairmanship of Adjutant General Tarkhanov to consider the issue of the incongruity with the Imperial regulations by the Nanotrasen Research Station.
	<br> This meeting, having familiarized itself with all the other possible actions and solutions, came to the conviction that the indenture of fines has casus belli to perform a strategic secret operation.
	<br> The Imperial Regulation has to be enforced in order to minimise any potential threat for the whole Empire, not excluding allied kingdoms, organisations and other partners, and to strengthen our positions in the ongoing Border War.
	<br>
	<br> About such a Supreme Will, reported in the recall of the Councillor of the Defense Collegium, No. 217648, We announce to the military department for immediate actions in appropriate cases.
	<br>
	<br> Signed by We,
	<br> <span style=\"color:black;font-family:'Segoe Script';\"><p><b>Voronov Platon Aleksandrovich and Radich Katarina Dinovich.</b></p></span>"}

/obj/machinery/suit_storage_unit/nri
	mod_type = /obj/item/mod/control/pre_equipped/frontline/pirate
	storage_type = /obj/item/tank/internals/oxygen/yellow

/obj/machinery/suit_storage_unit/nri/captain

#undef NRI_COOLDOWN_HEAL
#undef NRI_COOLDOWN_RADS
#undef NRI_COOLDOWN_ACID

#undef NRI_HEAL_AMOUNT
#undef NRI_BLOOD_REPLENISHMENT
