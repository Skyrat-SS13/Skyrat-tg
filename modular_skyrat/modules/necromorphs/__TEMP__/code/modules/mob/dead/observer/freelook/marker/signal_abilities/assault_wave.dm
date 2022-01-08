/datum/signal_ability/assault_wave
	name = "Assault Resonance"
	id = "assault"
	desc	=	"This powerful spell applies a long-lasting buff to all necromorphs in existence, having the following effects:<br><br>\
		-Duration: 3 Minutes<br>\
		<br>\
		-Movespeed: +15%<br>\
		-Attack Speed: +15%<br>\
		-Evasion: +5%<br>\
		-Max Health: +15%<br>\
	The energy cost is relatively cheap, and the effect lasts for 3 minutes. It's extremely useful! However, there are two major caveats:<br>\
		1. It only affects currently existing necromorphs. Any spawned after its cast won't get the effect. <br>\
		2. It has an extremely long cooldown of 15 minutes.<br>\
	Once used, it'll be quite a while before the next time. So you should strive to make the most of it,\
	 by spawning lots of necromorphs and having them wait until you're ready to launch an assault with a large group all at once."
	energy_cost = 500
	cooldown = 15 MINUTES
	targeting_method	=	TARGET_SELF
	autotarget_range = 0
	require_corruption = FALSE
	marker_only = TRUE

/datum/signal_ability/assault_wave/on_cast()

	//Lets gather up every living necromorph
	var/list/necromorphs = list()
	for (var/key in SSnecromorph.necromorph_players)
		var/datum/player/P = get_player_from_key(key)
		if (!P)
			continue
		var/mob/M = P.get_mob()
		if (!M || !isliving(M))
			continue

		if (M.stat == DEAD)
			continue

		necromorphs |= M

	necromorphs |= SSnecromorph.major_vessels
	necromorphs |= SSnecromorph.minor_vessels

	for (var/mob/living/L in necromorphs)
		set_extension(L, /datum/extension/assault_wave)
		spawn(rand(1, 30))
			L.shout()



/datum/extension/assault_wave
	name = "Corruption Effect"
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE

	//Effects on necromorphs
	var/evasion_bonus = 	5
	var/health_factor	=	1.15


	statmods = list(STATMOD_MOVESPEED_MULTIPLICATIVE = 1.15,
	STATMOD_ATTACK_SPEED = 1.15)

	var/health_delta

	var/necro = FALSE


/datum/extension/assault_wave/New(var/datum/holder)
	.=..()
	var/mob/living/L = holder

	var/newval = L.max_health * health_factor
	health_delta = L.max_health - newval
	L.max_health = newval

	L.evasion += evasion_bonus

	to_chat(L, "<span class = 'critical'>Your vessel surges with killing power. Go forth and slaughter!</span>")

	addtimer(CALLBACK(src, /datum/extension/assault_wave/proc/stop),	15 MINUTES)

/datum/extension/assault_wave/proc/stop()
	remove_extension(holder, type)

/datum/extension/assault_wave/Destroy()
	var/mob/living/L = holder
	if (istype(L))
		L.max_health += health_delta
		L.evasion -= evasion_bonus
		L.updatehealth()

		to_chat(L, "<span class = 'critical'>Your enhanced power wears off..</span>")

	.=..()
