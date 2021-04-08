GLOBAL_LIST_EMPTY(city_of_cogs_spawns) //Anyone entering the City of Cogs spawns here
GLOBAL_LIST_EMPTY(servant_spawns) //Servants of Ratvar spawn here

#define PRESSURE_PLATE_LAYER 2.49
#define CHANNEL_JUSTICAR_ARK 1020
#define NOJAUNT_1					(1<<0)
#define ZTRAIT_REEBE "Reebe"
#define ZTRAITS_REEBE list(ZTRAIT_REEBE = TRUE, ZTRAIT_BOMBCAP_MULTIPLIER = 0.5)
#define ROLE_SERVANT_OF_RATVAR	"Servant of Ratvar"
#define ANTAG_HUD_CLOCKWORK		22
#define TRAIT_STARGAZED			"stargazed"	//Affected by a stargazer
#define STARGAZER_TRAIT "stargazer"
#define CLOCKCULT_SERVANTS 4
#define COMSIG_ATOM_RATVAR_ACT "atom_ratvar_act"
#define LIGHT_COLOR_CLOCKWORK 	"#BE8700"
#define TELEPORT_MODE_CLOCKWORK 2
#define COMSIG_ATOM_EMINENCE_ACT "atom_eminence_act"
#define COMSIG_CLOCKWORK_SIGNAL_RECEIVED "clock_received"			//! When anything the trap is attatched to is triggered
#define VANGUARD_TRAIT "vanguard"
#define INCORPOREAL_MOVE_EMINENCE 4 //! same as jaunt, but lets eminence pass clockwalls
#define STATUS_EFFECT_INTERDICTION /datum/status_effect/interdiction //! The affected is inside the range of an interdiction lens
#define MOVESPEED_ID_INTERDICTION						"interdiction"

#define ismovableatom(A) ismovable(A)
#define iseminence(A) (istype(A, /mob/living/simple_animal/eminence))
#define iscogscarab(A) (istype(A, /mob/living/simple_animal/drone/cogscarab))
#define is_reebe(z) SSmapping.level_trait(z, ZTRAIT_REEBE)


//component id defines; sometimes these may not make sense in regards to their use in scripture but important ones are bright
#define BELLIGERENT_EYE "belligerent_eye" //! Use this for offensive and damaging scripture!
#define VANGUARD_COGWHEEL "vanguard_cogwheel" //! Use this for defensive and healing scripture!
#define GEIS_CAPACITOR "geis_capacitor" //! Use this for niche scripture!
#define REPLICANT_ALLOY "replicant_alloy"
#define HIEROPHANT_ANSIBLE "hierophant_ansible" //! Use this for construction-related scripture!

//Invokation speech types
#define INVOKATION_WHISPER 1
#define INVOKATION_SPOKEN 2
#define INVOKATION_SHOUT 3

#define DEFAULT_CLOCKSCRIPTS "6:-29,4:-2"

//scripture types
#define SPELLTYPE_ABSTRACT "Abstract"
#define SPELLTYPE_SERVITUDE "Servitude"
#define SPELLTYPE_PRESERVATION "Preservation"
#define SPELLTYPE_STRUCTURES "Structures"

//Trap type
#define TRAPMOUNT_WALL 1
#define TRAPMOUNT_FLOOR 2

//Conversion warnings
#define CONVERSION_WARNING_NONE 0
#define CONVERSION_WARNING_HALFWAY 1
#define CONVERSION_WARNING_THREEQUARTERS 2
#define CONVERSION_WARNING_CRITIAL 3

//Name types
#define CLOCKCULT_PREFIX_EMINENCE 2
#define CLOCKCULT_PREFIX_MASTER 1
#define CLOCKCULT_PREFIX_RECRUIT 0


// cwall construction states
#define COG_COVER 1
#define COG_EXPOSED 3
#define ACCESS_CLOCKCULT 251

/atom/movable/screen/alert/status_effect/interdiction
	name = "Interdicted"
	desc = "I don't think I am meant to go this way."
	icon_state = "inathneqs_endowment"

/datum/language/ratvar
	name = "Ratvarian"
	desc = "A timeless language full of power and incomprehensible to the unenlightened."
	var/static/random_speech_verbs = list("clanks", "clinks", "clunks", "clangs")
	key = "r"
	default_priority = 10
	spans = list(SPAN_ROBOT)
	icon_state = "ratvar"

/datum/language/ratvar/scramble(input)
	. = text2ratvar(input)


/datum/movespeed_modifier/clockwork/interdiction
	multiplicative_slowdown = 0.5

/datum/language_holder/clockmob
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/ratvar = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/ratvar = list(LANGUAGE_ATOM))

/obj/effect/landmark/servant_of_ratvar
	name = "servant of ratvar spawn"
	icon_state = "clockwork_orange"
	layer = MOB_LAYER

/obj/effect/landmark/servant_of_ratvar/Initialize(mapload)
	..()
	GLOB.servant_spawns += loc
	return INITIALIZE_HINT_QDEL

//City of Cogs entrances
/obj/effect/landmark/city_of_cogs
	name = "city of cogs entrance"
	icon_state = "city_of_cogs"

/obj/effect/landmark/city_of_cogs/Initialize(mapload)
	..()
	GLOB.city_of_cogs_spawns += loc
	return INITIALIZE_HINT_QDEL

/atom/movable/screen/alert/ratvar
	name = "Eternal Servitude"
	desc = "Hazardous functions detected, sentience prohibation drivers offline. Glory to Rat'var."
	icon_state = "ratvar_hack"

/datum/status_effect/interdiction
	id = "interdicted"
	duration = 25
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = 1
	alert_type = /atom/movable/screen/alert/status_effect/interdiction
	var/running_toggled = FALSE

/datum/status_effect/interdiction/tick()
	if(owner.m_intent == MOVE_INTENT_RUN)
		owner.toggle_move_intent(owner)
		if(owner.get_confusion(10))
			owner.add_confusion(10)
		running_toggled = TRUE
		to_chat(owner, "<span class='warning'>You know you shouldn't be running here.</span>")
	owner.add_movespeed_modifier(/datum/movespeed_modifier/clockwork/interdiction)

/datum/status_effect/interdiction/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/clockwork/interdiction)
	if(running_toggled && owner.m_intent == MOVE_INTENT_WALK)
		owner.toggle_move_intent(owner)

/datum/ai_laws/ratvar
	name = "Servant of the Justiciar"
	id = "ratvar"
	zeroth = ("Purge all untruths and honor Ratvar.")
	inherent = list()

/atom/movable/screen/alert/clockwork/clocksense
	name = "The Ark of the Clockwork Justicar"
	desc = "Shows infomation about the Ark of the Clockwork Justicar"
	icon_state = "clockinfo"
	alerttooltipstyle = "clockcult"

/atom/movable/screen/alert/clockwork/clocksense/Initialize()
	. = ..()
	START_PROCESSING(SSprocessing, src)

/atom/movable/screen/alert/clockwork/clocksense/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/atom/movable/screen/alert/clockwork/clocksense/process()
	var/datum/antagonist/servant_of_ratvar/servant_antagonist = is_servant_of_ratvar(owner)
	if(!(servant_antagonist?.team))
		return
	desc = "Stored Power - <b>[DisplayPower(GLOB.clockcult_power)]</b>.<br>"
	desc += "Stored Vitality - <b>[GLOB.clockcult_vitality]</b>.<br>"
	if(GLOB.ratvar_arrival_tick)
		if(GLOB.ratvar_arrival_tick - world.time > 6000)
			desc += "The Ark is preparing to open, it will activate in <b>[round((GLOB.ratvar_arrival_tick - world.time - 6000) / 10)]</b> seconds.<br>"
		else
			desc += "Ratvar will rise in <b>[round((GLOB.ratvar_arrival_tick - world.time) / 10)]</b> seconds, protect the Ark with your life!<br>"
	if(GLOB.servants_of_ratvar)
		desc += "There [GLOB.servants_of_ratvar.len == 1?"is" : "are"] currently [GLOB.servants_of_ratvar.len] loyal servant[GLOB.servants_of_ratvar.len == 1 ? "" : "s"].<br>"
	if(GLOB.critical_servant_count)
		desc += "Upon reaching [GLOB.critical_servant_count] the Ark will open, or it can be opened immediately by invoking Gateway Activation with 6 servants."


