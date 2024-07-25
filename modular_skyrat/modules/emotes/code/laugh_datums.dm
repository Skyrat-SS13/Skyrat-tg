GLOBAL_LIST_EMPTY(laugh_types)

/datum/laugh_type
	var/name
	var/list/male_laughsounds
	var/list/female_laughsounds

/datum/laugh_type/none //Why would you want this?
	name = "No Laugh"
	male_laughsounds = null
	female_laughsounds = null

/datum/laugh_type/human
	name = "Human Laugh"
	male_laughsounds = list(
		'sound/voice/human/manlaugh1.ogg',
		'sound/voice/human/manlaugh2.ogg',
	)
	female_laughsounds = list(
		'modular_skyrat/modules/emotes/sound/emotes/female/female_giggle_1.ogg',
		'modular_skyrat/modules/emotes/sound/emotes/female/female_giggle_2.ogg',
		)

/datum/laugh_type/lizard
	name = "Lizard Laugh"
	male_laughsounds = list('sound/voice/lizard/lizard_laugh1.ogg',)
	female_laughsounds = null

/datum/laugh_type/felinid
	name = "Felinid Laugh"
	male_laughsounds = list('modular_skyrat/modules/emotes/sound/emotes/nyahaha1.ogg',
			'modular_skyrat/modules/emotes/sound/emotes/nyahaha2.ogg',
			'modular_skyrat/modules/emotes/sound/emotes/nyaha.ogg',
			'modular_skyrat/modules/emotes/sound/emotes/nyahehe.ogg')
	female_laughsounds = null

/datum/laugh_type/clown
	name = "Clown Laugh"
	male_laughsounds = list(
		'sound/creatures/clown/hohoho.ogg',
		'sound/creatures/clown/hehe.ogg',
	)
	female_laughsounds = null

/datum/laugh_type/moth
	name = "Moth and Insect Laugh"
	male_laughsounds = list('modular_skyrat/modules/emotes/sound/emotes/mothlaugh.ogg')
	female_laughsounds = null
