#define NRI_ARMOR_POWEROFF list(25, 25, 25, 25, 25, 25, 30, 30, 30, 10)

#define NRI_ARMOR_POWERON list(40, 50, 30, 40, 60, 75, 50, 50, 50, 40)

#define NRI_POWERUSE_HIT 100
#define NRI_POWERUSE_HEAL 150

#define NRI_COOLDOWN_HEAL (10 SECONDS)
#define NRI_COOLDOWN_RADS (20 SECONDS)
#define NRI_COOLDOWN_ACID (20 SECONDS)

#define NRI_HEAL_AMOUNT 10
#define NRI_BLOOD_REPLENISHMENT 20

/obj/item/clothing/suit/armor/vest/russian/nri
	name = "\improper B42M combined armor vest"
	desc = "A B42M combined body armor designed to protect the torso from bullets, shrapnel and blunt force. This vest performed well in the Border War against SolFed, but NRI required significant design changes due to the enemy's new and improved weaponry. These models were recently phased out and then quickly found their way onto the black market, now commonly seen in the hands (or on the bodies) of insurgents."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	icon_state = "russian_green_armor"
	armor_type = /datum/armor/russian_nri
	supports_variations_flags = CLOTHING_NO_VARIATION
	inhand_icon_state = "armor"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Basic" = list(
			RESKIN_ICON_STATE = "russian_green_armor",
			RESKIN_WORN_ICON_STATE = "russian_green_armor"
		),
		"Corpsman" = list(
			RESKIN_ICON_STATE = "russian_medic_armor",
			RESKIN_WORN_ICON_STATE = "russian_medic_armor"
		),
	)

/datum/armor/russian_nri
	melee = 30
	bullet = 40
	laser = 20
	energy = 30
	bomb = 35
	fire = 50
	acid = 50
	wound = 15

/obj/item/clothing/suit/armor/heavy/nri
	name = "\improper Cordun-M armor system"
	desc = "A robust set of full-body armor designed for the harshest of environments. A modern set of heavy armor recently implemented by NRI Defense Collegium to accomodate with modern specifications. While a combination of lighter materials and a passive internal exoskeleton might assist the user's movement, you'll still be as slow as a snail."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	icon_state = "russian_heavy_armor"
	armor_type = /datum/armor/heavy_nri
	resistance_flags = FIRE_PROOF|UNACIDABLE|ACID_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|SNUG_FIT|BLOCK_GAS_SMOKE_EFFECT|THICKMATERIAL
	slowdown = 1.5
	equip_delay_self = 5 SECONDS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/datum/armor/heavy_nri
	melee = 60
	bullet = 60
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 70
	acid = 70
	wound = 35

/obj/item/clothing/suit/armor/heavy/nri/old
	name = "\improper REDUT armor system"
	desc = "A strong set of full-body armor designed for harsh environments. After the NRI withdrew them, these models found their way onto the black market and have been rarely used by freelance mercenaries and planetary militias ever since, because of their relatively low cost."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	armor_type = /datum/armor/nri_old
	resistance_flags = FIRE_PROOF|ACID_PROOF|FREEZE_PROOF
	clothing_flags = SNUG_FIT|THICKMATERIAL
	slowdown = 2

/datum/armor/nri_old
	melee = 50
	bullet = 50
	laser = 40
	energy = 40
	bomb = 75
	bio = 60
	fire = 45
	acid = 45
	wound = 20

/obj/item/clothing/suit/space/hev_suit/nri
	name = "\improper VOSKHOD powered combat armor"
	desc = "A hybrid set of space-resistant armor built on a modified mass-produced Nomex-Aerogel flight suit, polyurea coated durathread-lined light plasteel plates hinder mobility as little as possible while the onboard life support system aids the user in combat. The power cell is what makes the armor work without hassle, a sticker in the power supply unit warns anyone reading to responsibly manage battery levels."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/spacesuit.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDESEXTOY|HIDETAIL
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	cell = /obj/item/stock_parts/cell/bluespace
	actions_types = list(/datum/action/item_action/hev_toggle/nri, /datum/action/item_action/hev_toggle_notifs/nri, /datum/action/item_action/toggle_spacesuit)
	resistance_flags = FIRE_PROOF|UNACIDABLE|ACID_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|SNUG_FIT|BLOCKS_SHOVE_KNOCKDOWN

	activation_song = null //No nice song.

	logon_sound = 'modular_skyrat/modules/hev_suit/sound/nri/01_hev_logon.ogg' //don't tell anyone that we've used russian HEV sounds
	armor_sound = 'modular_skyrat/modules/hev_suit/sound/nri/02_powerarmor_on.ogg'
	atmospherics_sound = 'modular_skyrat/modules/hev_suit/sound/nri/03_atmospherics_on.ogg'
	vitalsigns_sound = 'modular_skyrat/modules/hev_suit/sound/nri/04_vitalsigns_on.ogg'
	automedic_sound = 'modular_skyrat/modules/hev_suit/sound/nri/05_automedic_on.ogg'
	weaponselect_sound = 'modular_skyrat/modules/hev_suit/sound/nri/06_weaponselect_on.ogg'
	munitions_sound = 'modular_skyrat/modules/hev_suit/sound/nri/07_munitionview_on.ogg'
	communications_sound = 'modular_skyrat/modules/hev_suit/sound/nri/08_communications_on.ogg'
	safe_day_sound = 'modular_skyrat/modules/hev_suit/sound/nri/09_safe_day.ogg'

	batt_50_sound = 'modular_skyrat/modules/hev_suit/sound/nri/power_level_is_fifty.ogg'
	batt_40_sound = 'modular_skyrat/modules/hev_suit/sound/nri/power_level_is_fourty.ogg'
	batt_30_sound = 'modular_skyrat/modules/hev_suit/sound/nri/power_level_is_thirty.ogg'
	batt_20_sound = 'modular_skyrat/modules/hev_suit/sound/nri/power_level_is_twenty.ogg'
	batt_10_sound = 'modular_skyrat/modules/hev_suit/sound/nri/power_level_is_ten.ogg'

	near_death_sound = 'modular_skyrat/modules/hev_suit/sound/nri/near_death.ogg'
	health_critical_sound = 'modular_skyrat/modules/hev_suit/sound/nri/health_critical.ogg'
	health_dropping_sound = 'modular_skyrat/modules/hev_suit/sound/nri/health_dropping.ogg'

	blood_loss_sound = 'modular_skyrat/modules/hev_suit/sound/nri/blood_loss.ogg'
	blood_toxins_sound = 'modular_skyrat/modules/hev_suit/sound/nri/blood_toxins.ogg'
	biohazard_sound = 'modular_skyrat/modules/hev_suit/sound/nri/biohazard_detected.ogg'
	chemical_sound = 'modular_skyrat/modules/hev_suit/sound/nri/chemical_detected.ogg'

	minor_fracture_sound = 'modular_skyrat/modules/hev_suit/sound/nri/minor_fracture.ogg'
	major_fracture_sound = 'modular_skyrat/modules/hev_suit/sound/nri/major_fracture.ogg'
	minor_lacerations_sound = 'modular_skyrat/modules/hev_suit/sound/nri/minor_lacerations.ogg'
	major_lacerations_sound = 'modular_skyrat/modules/hev_suit/sound/nri/major_lacerations.ogg'

	morphine_sound = 'modular_skyrat/modules/hev_suit/sound/nri/morphine_shot.ogg'
	wound_sound = 'modular_skyrat/modules/hev_suit/sound/nri/wound_sterilized.ogg'
	antitoxin_sound = 'modular_skyrat/modules/hev_suit/sound/nri/antitoxin_shot.ogg'
	antidote_sound = 'modular_skyrat/modules/hev_suit/sound/nri/antidote_shot.ogg'

	radio_channel = RADIO_CHANNEL_CENTCOM

	armor_poweroff = NRI_ARMOR_POWEROFF
	armor_poweron = NRI_ARMOR_POWERON
	heal_amount = NRI_HEAL_AMOUNT
	blood_replenishment = NRI_BLOOD_REPLENISHMENT
	health_static_cooldown = NRI_COOLDOWN_HEAL
	rads_static_cooldown = NRI_COOLDOWN_RADS
	acid_static_cooldown = NRI_COOLDOWN_ACID
	suit_name = "VOSKHOD"
	first_use = FALSE //No nice song.



/datum/armor/hev_suit_nri
	melee = 25
	bullet = 25
	laser = 25
	energy = 25
	bomb = 25
	bio = 20
	fire = 20
	acid = 20
	wound = 10

/datum/action/item_action/hev_toggle/nri
	name = "Toggle VOSKHOD Suit"
	button_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	background_icon_state = "bg_nri"
	button_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	button_icon_state = "toggle"

/datum/action/item_action/hev_toggle_notifs/nri
	name = "Toggle VOSKHOD Suit Notifications"
	button_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	background_icon_state = "bg_nri"
	button_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	button_icon_state = "sound"

/obj/item/clothing/suit/space/hev_suit/nri/captain
	name = "\improper VOSKHOD-2 powered combat armor"
	desc = "A unique hybrid set of space-resistant armor made for high-ranking NRI operatives, built on a proprietary durathread padded, Akulan made Larr'Takh silk utility uniform. Polyurea coated hexagraphene-lined plastitanium plates hinder mobility as little as possible while the onboard life support system aids the user in combat. The power cell is what makes the armor work without hassle, a sticker in the power supply unit warns anyone reading to responsibly manage battery levels."
	icon_state = "nri_captain"

/obj/item/clothing/suit/space/hev_suit/nri/medic
	name = "\improper VOSKHOD-KH powered combat armor"
	desc = "A hybrid set of space-resistant armor built on a modified mass-produced Dipolyester-Aerogel surgeon field jumpsuit, polyurea coated titanium plates hinder mobility as little as possible while the onboard life support system aids the user in combat and provides additional medical functions. The power cell is what makes the armor work without hassle, a sticker in the power supply unit warns anyone reading to responsibly manage battery levels."
	icon_state = "nri_medic"

/obj/item/clothing/suit/space/hev_suit/nri/engineer
	name = "\improper VOSKHOD-IN powered combat armor"
	desc = "A hybrid set of space-resistant armor built on a modified Nanotrasen heavy-duty engineering undersuit, polyurea coated lead-lined light plasteel plates hinder mobility as little as possible and offer additional radiation protection while the onboard life support system aids the user in combat. The power cell is what makes the armor work without hassle, a sticker in the power supply unit warns anyone reading to responsibly manage battery levels."
	icon_state = "nri_engineer"
