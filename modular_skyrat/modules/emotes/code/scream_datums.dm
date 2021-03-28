GLOBAL_LIST_EMPTY(scream_types)

/datum/scream_type
	var/name
	var/donator_only
	var/list/restricted_species
	var/list/male_screamsounds
	var/list/female_screamsounds

/datum/scream_type/human
	name = "Human Scream"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/voice/scream_m1.ogg', 'modular_skyrat/modules/emotes/sound/voice/scream_m2.ogg')
	female_screamsounds = list('modular_skyrat/modules/emotes/sound/voice/scream_f1.ogg', 'modular_skyrat/modules/emotes/sound/voice/scream_f2.ogg')

/datum/scream_type/robotic
	name = "Robotic Scream"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/voice/scream_silicon.ogg')
	female_screamsounds = null

/datum/scream_type/lizard
	name = "Lizard Scream"
	male_screamsounds = list('sound/voice/lizard/lizard_scream_1.ogg', 'sound/voice/lizard/lizard_scream_3.ogg')
	female_screamsounds = null
	restricted_species = typesof(/datum/species/lizard)

/datum/scream_type/lizard2
	name = "Lizard Scream 2"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/voice/scream_lizard.ogg')
	female_screamsounds = null

/datum/scream_type/skeleton
	name = "Skeleton Scream"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/voice/scream_skeleton.ogg')
	female_screamsounds = null

/datum/scream_type/moth
	name = "Moth Scream"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/voice/scream_moth.ogg')
	female_screamsounds = null

/datum/scream_type/jelly
	name = "Jelly Scream"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/emotes/jelly_scream.ogg')
	female_screamsounds = null

/datum/scream_type/vox
	name = "Vox Scream"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/emotes/voxscream.ogg')
	female_screamsounds = null

/datum/scream_type/xeno
	name = "Xeno Scream"
	male_screamsounds = list('sound/voice/hiss6.ogg')
	female_screamsounds = null

/datum/scream_type/zombie
	name = "Zombie Scream"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/emotes/zombie_scream.ogg')
	female_screamsounds = null

/datum/scream_type/tajaran
	name = "Cat Scream"
	male_screamsounds = list('modular_skyrat/modules/emotes/sound/emotes/cat_scream.ogg')
	female_screamsounds = null
