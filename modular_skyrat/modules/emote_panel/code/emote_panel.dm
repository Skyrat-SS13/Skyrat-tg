/mob/proc/manipulate_emotes()
	if(!mind)
		return
	var/list/available_emotes = list()
	var/list/all_emotes = list()

	// code\modules\mob\emote.dm
	var/static/list/mob_emotes = list(
		/mob/proc/emote_flip,
		/mob/proc/emote_spin
	)
	all_emotes += mob_emotes

	// code\modules\mob\living\emote.dm
	var/static/list/living_emotes = list(
		/mob/living/proc/emote_blush,
		/mob/living/proc/emote_bow,
		/mob/living/proc/emote_burp,
		/mob/living/proc/emote_choke,
		/mob/living/proc/emote_cross,
		/mob/living/proc/emote_chuckle,
		/mob/living/proc/emote_collapse,
		/mob/living/proc/emote_cough,
		/mob/living/proc/emote_dance,
		/mob/living/proc/emote_drool,
		/mob/living/proc/emote_faint,
		/mob/living/proc/emote_flap,
		/mob/living/proc/emote_aflap,
		/mob/living/proc/emote_frown,
		/mob/living/proc/emote_gag,
		/mob/living/proc/emote_giggle,
		/mob/living/proc/emote_glare,
		/mob/living/proc/emote_grin,
		/mob/living/proc/emote_groan,
		/mob/living/proc/emote_grimace,
		/mob/living/proc/emote_jump,
		/mob/living/proc/emote_kiss,
		/mob/living/proc/emote_laugh,
		/mob/living/proc/emote_look,
		/mob/living/proc/emote_nod,
		/mob/living/proc/emote_point,
		/mob/living/proc/emote_pout,
		/mob/living/proc/emote_scream,
		/mob/living/proc/emote_scowl,
		/mob/living/proc/emote_shake,
		/mob/living/proc/emote_shiver,
		/mob/living/proc/emote_sigh,
		/mob/living/proc/emote_sit,
		/mob/living/proc/emote_smile,
		/mob/living/proc/emote_sneeze,
		/mob/living/proc/emote_smug,
		/mob/living/proc/emote_sniff,
		/mob/living/proc/emote_stare,
		/mob/living/proc/emote_strech,
		/mob/living/proc/emote_sulk,
		/mob/living/proc/emote_sway,
		/mob/living/proc/emote_tilt,
		/mob/living/proc/emote_tremble,
		/mob/living/proc/emote_twitch,
		/mob/living/proc/emote_twitch_s,
		/mob/living/proc/emote_wave,
		/mob/living/proc/emote_whimper,
		/mob/living/proc/emote_wsmile,
		/mob/living/proc/emote_yawn,
		/mob/living/proc/emote_gurgle,
		/mob/living/proc/emote_inhale,
		/mob/living/proc/emote_exhale,
		/mob/living/proc/emote_swear
	)
	all_emotes += living_emotes

	// code\modules\mob\living\carbon\emote.dm
	var/static/list/carbon_emotes = list(
		/mob/living/carbon/proc/emote_airguitar,
		/mob/living/carbon/proc/emote_blink,
		/mob/living/carbon/proc/emote_blink_r,
		/mob/living/carbon/proc/emote_crack,
		/mob/living/carbon/proc/emote_circle,
		/mob/living/carbon/proc/emote_moan,
		/mob/living/carbon/proc/emote_slap,
		/mob/living/carbon/proc/emote_wink
	)
	all_emotes += carbon_emotes

	// code\modules\mob\living\carbon\human\emote.dm
	var/static/list/human_emotes = list(
		/mob/living/carbon/human/proc/emote_cry,
		/mob/living/carbon/human/proc/emote_eyebrow,
		/mob/living/carbon/human/proc/emote_grumble,
		/mob/living/carbon/human/proc/emote_mumble,
		/mob/living/carbon/human/proc/emote_pale,
		/mob/living/carbon/human/proc/emote_raise,
		/mob/living/carbon/human/proc/emote_salute,
		/mob/living/carbon/human/proc/emote_shrug,
		/mob/living/carbon/human/proc/emote_wag,
		/mob/living/carbon/human/proc/emote_wing
	)
	all_emotes += human_emotes

	// modular_skyrat\modules\emotes\code\emote.dm
	var/static/list/skyrat_living_emotes = list(
		/mob/living/proc/emote_peep,
		/mob/living/proc/emote_peep2,
		/mob/living/proc/emote_snap,
		/mob/living/proc/emote_snap2,
		/mob/living/proc/emote_snap3,
		/mob/living/proc/emote_awoo,
		/mob/living/proc/emote_nya,
		/mob/living/proc/emote_weh,
		/mob/living/proc/emote_mothsqueak,
		/mob/living/proc/emote_mousesqueak,
		/mob/living/proc/emote_merp,
		/mob/living/proc/emote_bark,
		/mob/living/proc/emote_squish,
		/mob/living/proc/emote_meow,
		/mob/living/proc/emote_hiss1,
		/mob/living/proc/emote_chitter,
		/mob/living/proc/emote_snore,
		/mob/living/proc/emote_clap,
		/mob/living/proc/emote_clap1,
		/mob/living/proc/emote_headtilt,
		/mob/living/proc/emote_blink2,
		/mob/living/proc/emote_rblink,
		/mob/living/proc/emote_squint,
		/mob/living/proc/emote_smirk,
		/mob/living/proc/emote_eyeroll,
		/mob/living/proc/emote_huff,
		/mob/living/proc/emote_etwitch,
		/mob/living/proc/emote_clear,
		/mob/living/proc/emote_bawk,
		/mob/living/proc/emote_caw,
		/mob/living/proc/emote_caw2,
		/mob/living/proc/emote_whistle,
		/mob/living/proc/emote_blep,
		/mob/living/proc/emote_bork,
		/mob/living/proc/emote_hoot,
		/mob/living/proc/emote_growl,
		/mob/living/proc/emote_woof,
		/mob/living/proc/emote_baa,
		/mob/living/proc/emote_baa2,
		/mob/living/proc/emote_wurble,
		/mob/living/proc/emote_rattle,
		/mob/living/proc/emote_cackle,
		/mob/living/proc/emote_warble,
		/mob/living/proc/emote_trills,
		/mob/living/proc/emote_rpurr,
		/mob/living/proc/emote_purr,
		/mob/living/proc/emote_moo,
		/mob/living/proc/emote_honk1
	)
	all_emotes += skyrat_living_emotes

	// code\modules\mob\living\brain\emote.dm
	var/static/list/brain_emotes = list(
		/mob/living/brain/proc/emote_alarm,
		/mob/living/brain/proc/emote_alert,
		/mob/living/brain/proc/emote_flash,
		/mob/living/brain/proc/emote_notice,
		/mob/living/brain/proc/emote_whistle_brain
	)
	all_emotes += brain_emotes

	// code\modules\mob\living\carbon\alien\emote.dm
	var/static/list/alien_emotes = list(
		/mob/living/carbon/alien/proc/emote_gnarl,
		/mob/living/carbon/alien/proc/emote_hiss,
		/mob/living/carbon/alien/proc/emote_roar
	)
	all_emotes += alien_emotes

	// modular_skyrat\modules\emotes\code\synth_emotes.dm
	var/static/list/synth_emotes = list(
		/mob/living/proc/emote_dwoop,
		/mob/living/proc/emote_yes,
		/mob/living/proc/emote_no,
		/mob/living/proc/emote_boop,
		/mob/living/proc/emote_buzz,
		/mob/living/proc/emote_beep,
		/mob/living/proc/emote_beep2,
		/mob/living/proc/emote_buzz2,
		/mob/living/proc/emote_chime,
		/mob/living/proc/emote_honk,
		/mob/living/proc/emote_ping,
		/mob/living/proc/emote_sad,
		/mob/living/proc/emote_warn,
		/mob/living/proc/emote_slowclap
	)
	all_emotes += synth_emotes
	var/static/list/allowed_species_synth = list(
		/datum/species/robotic/ipc,
		/datum/species/robotic/synthliz,
		/datum/species/robotic/synthetic_human,
		/datum/species/robotic/synthetic_mammal
	)

	// modular_skyrat\modules\emotes\code\additionalemotes\overlay_emote.dm
	var/static/list/skyrat_living_emotes_overlay = list(
		/mob/living/proc/emote_sweatdrop,
		/mob/living/proc/emote_exclaim,
		/mob/living/proc/emote_question,
		/mob/living/proc/emote_realize,
		/mob/living/proc/emote_annoyed,
		/mob/living/proc/emote_glasses
	)
	all_emotes += skyrat_living_emotes_overlay

	// modular_skyrat\modules\emotes\code\additionalemotes\turf_emote.dm
	all_emotes += /mob/living/proc/emote_mark_turf

	// Clearing all emotes before applying new ones
	verbs -= all_emotes

	// Checking if preferences allow emote panel
	if(!src.client?.prefs?.read_preference(/datum/preference/toggle/emote_panel))
		return

	// Checking emote availability
	if(isbrain(src))
		// Only brains in MMI have emotes
		var/mob/living/brain/current_brain = src
		if(current_brain.container && istype(current_brain.container, /obj/item/mmi))
			available_emotes += brain_emotes
	else
		if(ismob(src))
			available_emotes += mob_emotes
		if(isliving(src))
			available_emotes += living_emotes
			available_emotes += skyrat_living_emotes
			available_emotes += skyrat_living_emotes_overlay
			available_emotes += /mob/living/proc/emote_mark_turf
		if(iscarbon(src))
			available_emotes += carbon_emotes
		if(ishuman(src))
			available_emotes += human_emotes
			// Checking if should apply Synth emotes
			var/mob/living/carbon/human/current_mob = src
			if(current_mob.dna.species.type in allowed_species_synth)
				available_emotes += synth_emotes
			// Checking if can wag tail
			if(!current_mob.dna.species.can_wag_tail(current_mob))
				available_emotes -= /mob/living/carbon/human/proc/emote_wag
			// Checking if has wings
			if(!current_mob.getorganslot(ORGAN_SLOT_EXTERNAL_WINGS))
				available_emotes -= /mob/living/carbon/human/proc/emote_wing
		if(isalien(src))
			available_emotes += alien_emotes
		if(issilicon(src))
			available_emotes += synth_emotes

	// Applying emote panel if preferences allow
	for(var/emote in available_emotes)
		verbs |= emote

/mob/mind_initialize()
	. = ..()
	manipulate_emotes()

// code\modules\mob\emote.dm
/mob/proc/emote_flip()
	set name = "| Flip |"
	set category = "Emotes"
	usr.emote("flip", intentional = TRUE)

/mob/proc/emote_spin()
	set name = "| Spin |"
	set category = "Emotes"
	usr.emote("spin", intentional = TRUE)

// code\modules\mob\living\emote.dm

/mob/living/proc/emote_blush()
	set name = "~ Blush"
	set category = "Emotes"
	usr.emote("blush", intentional = TRUE)

/mob/living/proc/emote_bow()
	set name = "~ Bow"
	set category = "Emotes"
	usr.emote("bow", intentional = TRUE)

/mob/living/proc/emote_burp()
	set name = "> Burp"
	set category = "Emotes"
	usr.emote("burp", intentional = TRUE)

/mob/living/proc/emote_choke()
	set name = "~ Choke"
	set category = "Emotes"
	usr.emote("choke", intentional = TRUE)

/mob/living/proc/emote_cross()
	set name = "~ Cross"
	set category = "Emotes"
	usr.emote("cross", intentional = TRUE)

/mob/living/proc/emote_chuckle()
	set name = "~ Chuckle"
	set category = "Emotes"
	usr.emote("chuckle", intentional = TRUE)

/mob/living/proc/emote_collapse()
	set name = "~ Collapse"
	set category = "Emotes"
	usr.emote("collapse", intentional = TRUE)

/mob/living/proc/emote_cough()
	set name = "> Cough"
	set category = "Emotes"
	usr.emote("cough", intentional = TRUE)

/mob/living/proc/emote_dance()
	set name = "~ Dance"
	set category = "Emotes"
	usr.emote("dance", intentional = TRUE)

/mob/living/proc/emote_drool()
	set name = "~ Drool"
	set category = "Emotes"
	usr.emote("drool", intentional = TRUE)

/mob/living/proc/emote_faint()
	set name = "~ Faint"
	set category = "Emotes"
	usr.emote("faint", intentional = TRUE)

/mob/living/proc/emote_flap()
	set name = "~ Flap"
	set category = "Emotes"
	usr.emote("flap", intentional = TRUE)

/mob/living/proc/emote_aflap()
	set name = "~ Angry Flap"
	set category = "Emotes"
	usr.emote("aflap", intentional = TRUE)

/mob/living/proc/emote_frown()
	set name = "~ Frown"
	set category = "Emotes"
	usr.emote("frown", intentional = TRUE)

/mob/living/proc/emote_gag()
	set name = "~ Gag"
	set category = "Emotes"
	usr.emote("gag", intentional = TRUE)

/mob/living/proc/emote_giggle()
	set name = "~ Giggle"
	set category = "Emotes"
	usr.emote("giggle", intentional = TRUE)

/mob/living/proc/emote_glare()
	set name = "~ Glare"
	set category = "Emotes"
	usr.emote("glare", intentional = TRUE)

/mob/living/proc/emote_grin()
	set name = "~ Grin"
	set category = "Emotes"
	usr.emote("grin", intentional = TRUE)

/mob/living/proc/emote_groan()
	set name = "~ Groan"
	set category = "Emotes"
	usr.emote("groan", intentional = TRUE)

/mob/living/proc/emote_grimace()
	set name = "~ Grimace"
	set category = "Emotes"
	usr.emote("grimace", intentional = TRUE)

/mob/living/proc/emote_jump()
	set name = "~ Jump"
	set category = "Emotes"
	usr.emote("jump", intentional = TRUE)

/mob/living/proc/emote_kiss()
	set name = "| Kiss |"
	set category = "Emotes"
	usr.emote("kiss", intentional = TRUE)

/mob/living/proc/emote_laugh()
	set name = "> Laugh"
	set category = "Emotes"
	usr.emote("laugh", intentional = TRUE)

/mob/living/proc/emote_look()
	set name = "~ Look"
	set category = "Emotes"
	usr.emote("look", intentional = TRUE)

/mob/living/proc/emote_nod()
	set name = "~ Nod"
	set category = "Emotes"
	usr.emote("nod", intentional = TRUE)

/mob/living/proc/emote_point()
	set name = "~ Point"
	set category = "Emotes"
	usr.emote("point", intentional = TRUE)

/mob/living/proc/emote_pout()
	set name = "~ Pout"
	set category = "Emotes"
	usr.emote("pout", intentional = TRUE)

/mob/living/proc/emote_scream()
	set name = "> Scream"
	set category = "Emotes"
	usr.emote("scream", intentional = TRUE)

/mob/living/proc/emote_scowl()
	set name = "~ Scowl"
	set category = "Emotes"
	usr.emote("scowl", intentional = TRUE)

/mob/living/proc/emote_shake()
	set name = "~ Shake"
	set category = "Emotes"
	usr.emote("shake", intentional = TRUE)

/mob/living/proc/emote_shiver()
	set name = "~ Shiver"
	set category = "Emotes"
	usr.emote("shiver", intentional = TRUE)

/mob/living/proc/emote_sigh()
	set name = "> Sigh"
	set category = "Emotes"
	usr.emote("sigh", intentional = TRUE)

/mob/living/proc/emote_sit()
	set name = "~ Sit"
	set category = "Emotes"
	usr.emote("sit", intentional = TRUE)

/mob/living/proc/emote_smile()
	set name = "~ Smile"
	set category = "Emotes"
	usr.emote("smile", intentional = TRUE)

/mob/living/proc/emote_sneeze()
	set name = "> Sneeze"
	set category = "Emotes"
	usr.emote("sneeze", intentional = TRUE)

/mob/living/proc/emote_smug()
	set name = "~ Smug"
	set category = "Emotes"
	usr.emote("smug", intentional = TRUE)

/mob/living/proc/emote_sniff()
	set name = "> Sniff"
	set category = "Emotes"
	usr.emote("sniff", intentional = TRUE)

/mob/living/proc/emote_stare()
	set name = "~ Stare"
	set category = "Emotes"
	usr.emote("stare", intentional = TRUE)

/mob/living/proc/emote_strech()
	set name = "~ Stretch"
	set category = "Emotes"
	usr.emote("stretch", intentional = TRUE)

/mob/living/proc/emote_sulk()
	set name = "~ Sulk"
	set category = "Emotes"
	usr.emote("sulk", intentional = TRUE)

/mob/living/proc/emote_sway()
	set name = "~ Sway"
	set category = "Emotes"
	usr.emote("sway", intentional = TRUE)

/mob/living/proc/emote_tilt()
	set name = "~ Tilt"
	set category = "Emotes"
	usr.emote("tilt", intentional = TRUE)

/mob/living/proc/emote_tremble()
	set name = "~ Tremble"
	set category = "Emotes"
	usr.emote("tremble", intentional = TRUE)

/mob/living/proc/emote_twitch()
	set name = "~ Twitch"
	set category = "Emotes"
	usr.emote("twitch", intentional = TRUE)

/mob/living/proc/emote_twitch_s()
	set name = "~ Twitch Slightly"
	set category = "Emotes"
	usr.emote("twitch_s", intentional = TRUE)

/mob/living/proc/emote_wave()
	set name = "~ Wave"
	set category = "Emotes"
	usr.emote("wave", intentional = TRUE)

/mob/living/proc/emote_whimper()
	set name = "~ Whimper"
	set category = "Emotes"
	usr.emote("whimper", intentional = TRUE)

/mob/living/proc/emote_wsmile()
	set name = "~ Smile Weak"
	set category = "Emotes"
	usr.emote("wsmile", intentional = TRUE)

/mob/living/proc/emote_yawn()
	set name = "~ Yawn"
	set category = "Emotes"
	usr.emote("yawn", intentional = TRUE)

/mob/living/proc/emote_gurgle()
	set name = "~ Gurgle"
	set category = "Emotes"
	usr.emote("gurgle", intentional = TRUE)

/mob/living/proc/emote_inhale()
	set name = "~ Inhale"
	set category = "Emotes"
	usr.emote("inhale", intentional = TRUE)

/mob/living/proc/emote_exhale()
	set name = "~ Exhale"
	set category = "Emotes"
	usr.emote("exhale", intentional = TRUE)

/mob/living/proc/emote_swear()
	set name = "~ Swear"
	set category = "Emotes"
	usr.emote("swear", intentional = TRUE)

// code\modules\mob\living\carbon\emote.dm

/mob/living/carbon/proc/emote_airguitar()
	set name = "~ Airguitar"
	set category = "Emotes"
	usr.emote("airguitar", intentional = TRUE)

/mob/living/carbon/proc/emote_blink()
	set name = "~ Blink"
	set category = "Emotes"
	usr.emote("blink", intentional = TRUE)

/mob/living/carbon/proc/emote_blink_r()
	set name = "~ Blink Rapidly"
	set category = "Emotes"
	usr.emote("blink_r", intentional = TRUE)

/mob/living/carbon/proc/emote_crack()
	set name = "> Crack"
	set category = "Emotes"
	usr.emote("crack", intentional = TRUE)

/mob/living/carbon/proc/emote_circle()
	set name = "| Circle |"
	set category = "Emotes"
	usr.emote("circle", intentional = TRUE)

/mob/living/carbon/proc/emote_moan()
	set name = "~ Moan"
	set category = "Emotes"
	usr.emote("moan", intentional = TRUE)

/mob/living/carbon/proc/emote_slap()
	set name = "| Slap |"
	set category = "Emotes"
	usr.emote("slap", intentional = TRUE)

/mob/living/carbon/proc/emote_wink()
	set name = "~ Wink"
	set category = "Emotes"
	usr.emote("wink", intentional = TRUE)

// code\modules\mob\living\carbon\human\emote.dm

/mob/living/carbon/human/proc/emote_cry()
	set name = "~ Cry"
	set category = "Emotes"
	usr.emote("cry", intentional = TRUE)

/mob/living/carbon/human/proc/emote_eyebrow()
	set name = "~ Eyebrow"
	set category = "Emotes"
	usr.emote("eyebrow", intentional = TRUE)

/mob/living/carbon/human/proc/emote_grumble()
	set name = "~ Grumble"
	set category = "Emotes"
	usr.emote("grumble", intentional = TRUE)

/mob/living/carbon/human/proc/emote_mumble()
	set name = "~ Mumble"
	set category = "Emotes"
	usr.emote("mumble", intentional = TRUE)

/mob/living/carbon/human/proc/emote_pale()
	set name = "~ Pale"
	set category = "Emotes"
	usr.emote("pale", intentional = TRUE)

/mob/living/carbon/human/proc/emote_raise()
	set name = "~ Raise Hand"
	set category = "Emotes"
	usr.emote("raise", intentional = TRUE)

/mob/living/carbon/human/proc/emote_salute()
	set name = "~ Salute"
	set category = "Emotes"
	usr.emote("salute", intentional = TRUE)

/mob/living/carbon/human/proc/emote_shrug()
	set name = "~ Shrug"
	set category = "Emotes"
	usr.emote("shrug", intentional = TRUE)

/mob/living/carbon/human/proc/emote_wag()
	set name = "| Wag |"
	set category = "Emotes"
	usr.emote("wag", intentional = TRUE)

/mob/living/carbon/human/proc/emote_wing()
	set name = "| Wing |"
	set category = "Emotes"
	usr.emote("wing", intentional = TRUE)

// modular_skyrat\modules\emotes\code\emote.dm

/mob/living/proc/emote_peep()
	set name = "> Peep"
	set category = "Emotes+"
	usr.emote("peep", intentional = TRUE)

/mob/living/proc/emote_peep2()
	set name = "> Peep Twice"
	set category = "Emotes+"
	usr.emote("peep2", intentional = TRUE)

/mob/living/proc/emote_snap()
	set name = "> Snap"
	set category = "Emotes+"
	usr.emote("snap", intentional = TRUE)

/mob/living/proc/emote_snap2()
	set name = "> Snap Twice"
	set category = "Emotes+"
	usr.emote("snap2", intentional = TRUE)

/mob/living/proc/emote_snap3()
	set name = "> Snap Thrice"
	set category = "Emotes+"
	usr.emote("snap3", intentional = TRUE)

/mob/living/proc/emote_awoo()
	set name = "> Awoo"
	set category = "Emotes+"
	usr.emote("awoo", intentional = TRUE)

/mob/living/proc/emote_nya()
	set name = "> Nya"
	set category = "Emotes+"
	usr.emote("nya", intentional = TRUE)

/mob/living/proc/emote_weh()
	set name = "> Weh"
	set category = "Emotes+"
	usr.emote("weh", intentional = TRUE)

/mob/living/proc/emote_mothsqueak()
	set name = "> Moth Squeak"
	set category = "Emotes+"
	usr.emote("msqueak", intentional = TRUE)

/mob/living/proc/emote_mousesqueak()
	set name = "> Mouse Squeak"
	set category = "Emotes+"
	usr.emote("squeak", intentional = TRUE)

/mob/living/proc/emote_merp()
	set name = "> Merp"
	set category = "Emotes+"
	usr.emote("merp", intentional = TRUE)

/mob/living/proc/emote_bark()
	set name = "> Bark"
	set category = "Emotes+"
	usr.emote("bark", intentional = TRUE)

/mob/living/proc/emote_squish()
	set name = "> Squish"
	set category = "Emotes+"
	usr.emote("squish", intentional = TRUE)

/mob/living/proc/emote_meow()
	set name = "> Meow"
	set category = "Emotes+"
	usr.emote("meow", intentional = TRUE)

/mob/living/proc/emote_hiss1()
	set name = "> Hiss"
	set category = "Emotes+"
	usr.emote("hiss1", intentional = TRUE)

/mob/living/proc/emote_chitter()
	set name = "> Chitter"
	set category = "Emotes+"
	usr.emote("chitter", intentional = TRUE)

/mob/living/proc/emote_snore()
	set name = "> Snore"
	set category = "Emotes+"
	usr.emote("snore", intentional = TRUE)

/mob/living/proc/emote_clap()
	set name = "> Clap"
	set category = "Emotes+"
	usr.emote("clap", intentional = TRUE)

/mob/living/proc/emote_clap1()
	set name = "> Clap once"
	set category = "Emotes+"
	usr.emote("clap1", intentional = TRUE)

/mob/living/proc/emote_headtilt()
	set name = "~ Head Hilt"
	set category = "Emotes+"
	usr.emote("tilt", intentional = TRUE)

/mob/living/proc/emote_blink2()
	set name = "~ Blink Twice"
	set category = "Emotes+"
	usr.emote("blink2", intentional = TRUE)

/mob/living/proc/emote_rblink()
	set name = "~ Blink Rapidly"
	set category = "Emotes+"
	usr.emote("rblink", intentional = TRUE)

/mob/living/proc/emote_squint()
	set name = "~ Squint"
	set category = "Emotes+"
	usr.emote("squint", intentional = TRUE)

/mob/living/proc/emote_smirk()
	set name = "~ Smirk"
	set category = "Emotes+"
	usr.emote("smirk", intentional = TRUE)

/mob/living/proc/emote_eyeroll()
	set name = "~ Eyeroll"
	set category = "Emotes+"
	usr.emote("eyeroll", intentional = TRUE)

/mob/living/proc/emote_huff()
	set name = "~ Huff"
	set category = "Emotes+"
	usr.emote("huffs", intentional = TRUE)

/mob/living/proc/emote_etwitch()
	set name = "~ Ears twitch"
	set category = "Emotes+"
	usr.emote("etwitch", intentional = TRUE)

/mob/living/proc/emote_clear()
	set name = "~ Clear Throat"
	set category = "Emotes+"
	usr.emote("clear", intentional = TRUE)

/mob/living/proc/emote_bawk()
	set name = "> Bawk"
	set category = "Emotes+"
	usr.emote("bawk", intentional = TRUE)

/mob/living/proc/emote_caw()
	set name = "> Caw"
	set category = "Emotes+"
	usr.emote("caw", intentional = TRUE)

/mob/living/proc/emote_caw2()
	set name = "> Caw-caw"
	set category = "Emotes+"
	usr.emote("caw2", intentional = TRUE)

/mob/living/proc/emote_whistle()
	set name = "~ Whistle"
	set category = "Emotes+"
	usr.emote("whistle", intentional = TRUE)

/mob/living/proc/emote_blep()
	set name = "~ Blep"
	set category = "Emotes+"
	usr.emote("blep", intentional = TRUE)

/mob/living/proc/emote_bork()
	set name = "> Bork"
	set category = "Emotes+"
	usr.emote("bork", intentional = TRUE)

/mob/living/proc/emote_hoot()
	set name = "> Hoot"
	set category = "Emotes+"
	usr.emote("hoot", intentional = TRUE)

/mob/living/proc/emote_growl()
	set name = "> Growl"
	set category = "Emotes+"
	usr.emote("growl", intentional = TRUE)

/mob/living/proc/emote_woof()
	set name = "> Woof"
	set category = "Emotes+"
	usr.emote("woof", intentional = TRUE)

/mob/living/proc/emote_baa()
	set name = "> Baa"
	set category = "Emotes+"
	usr.emote("baa", intentional = TRUE)

/mob/living/proc/emote_baa2()
	set name = "> Bleat"
	set category = "Emotes+"
	usr.emote("baa2", intentional = TRUE)

/mob/living/proc/emote_wurble()
	set name = "> Wurble"
	set category = "Emotes+"
	usr.emote("wurble", intentional = TRUE)
/mob/living/proc/emote_rattle()
	set name = "> Rattle"
	set category = "Emotes+"
	usr.emote("rattle", intentional = TRUE)

/mob/living/proc/emote_cackle()
	set name = "> Cackle"
	set category = "Emotes+"
	usr.emote("cackle", intentional = TRUE)

/mob/living/proc/emote_warble()
	set name = "> Warble"
	set category = "Emotes+"
	usr.emote("warble", intentional = TRUE)

/mob/living/proc/emote_trills()
	set name = "> Trills"
	set category = "Emotes+"
	usr.emote("trills", intentional = TRUE)

/mob/living/proc/emote_rpurr()
	set name = "> Raptor"
	set category = "Emotes+"
	usr.emote("rpurr", intentional = TRUE)

/mob/living/proc/emote_purr()
	set name = "> Purr"
	set category = "Emotes+"
	usr.emote("purr", intentional = TRUE)

/mob/living/proc/emote_moo()
	set name = "> Moo"
	set category = "Emotes+"
	usr.emote("moo", intentional = TRUE)

/mob/living/proc/emote_honk1()
	set name = "> Honk"
	set category = "Emotes+"
	usr.emote("honk1", intentional = TRUE)

// code\modules\mob\living\brain\emote.dm

/mob/living/brain/proc/emote_alarm()
	set name = "< Alarm >"
	set category = "Emotes"
	usr.emote("alarm", intentional = TRUE)

/mob/living/brain/proc/emote_alert()
	set name = "< Alert >"
	set category = "Emotes"
	usr.emote("alert", intentional = TRUE)

/mob/living/brain/proc/emote_flash()
	set name = "< Flash >"
	set category = "Emotes"
	usr.emote("flash", intentional = TRUE)

/mob/living/brain/proc/emote_notice()
	set name = "< Notice >"
	set category = "Emotes"
	usr.emote("notice", intentional = TRUE)

/mob/living/brain/proc/emote_whistle_brain()
	set name = "< Whistle >"
	set category = "Emotes"
	usr.emote("whistle", intentional = TRUE)

// code\modules\mob\living\carbon\alien\emote.dm

/mob/living/carbon/alien/proc/emote_gnarl()
	set name = "< Gnarl >"
	set category = "Emotes"
	usr.emote("gnarl", intentional = TRUE)

/mob/living/carbon/alien/proc/emote_hiss()
	set name = "< Hiss >"
	set category = "Emotes"
	usr.emote("hiss", intentional = TRUE)

/mob/living/carbon/alien/proc/emote_roar()
	set name = "< Roar >"
	set category = "Emotes"
	usr.emote("roar", intentional = TRUE)

//modular_skyrat\modules\emotes\code\synth_emotes.dm

/mob/living/proc/emote_dwoop()
	set name = "< Dwoop >"
	set category = "Emotes"
	usr.emote("dwoop", intentional = TRUE)

/mob/living/proc/emote_yes()
	set name = "< Yes >"
	set category = "Emotes"
	usr.emote("yes", intentional = TRUE)

/mob/living/proc/emote_no()
	set name = "< No >"
	set category = "Emotes"
	usr.emote("no", intentional = TRUE)

/mob/living/proc/emote_boop()
	set name = "< Boop >"
	set category = "Emotes"
	usr.emote("boop", intentional = TRUE)

/mob/living/proc/emote_buzz()
	set name = "< Buzz >"
	set category = "Emotes"
	usr.emote("buzz", intentional = TRUE)

/mob/living/proc/emote_beep()
	set name = "< Beep >"
	set category = "Emotes"
	usr.emote("beep", intentional = TRUE)

/mob/living/proc/emote_beep2()
	set name = "< Beep Sharply >"
	set category = "Emotes"
	usr.emote("beep2", intentional = TRUE)

/mob/living/proc/emote_buzz2()
	set name = "< Buzz Twice >"
	set category = "Emotes"
	usr.emote("buzz2", intentional = TRUE)

/mob/living/proc/emote_chime()
	set name = "< Chime >"
	set category = "Emotes"
	usr.emote("chime", intentional = TRUE)

/mob/living/proc/emote_honk()
	set name = "< Honk >"
	set category = "Emotes"
	usr.emote("honk", intentional = TRUE)

/mob/living/proc/emote_ping()
	set name = "< Ping >"
	set category = "Emotes"
	usr.emote("ping", intentional = TRUE)

/mob/living/proc/emote_sad()
	set name = "< Sad >"
	set category = "Emotes"
	usr.emote("sad", intentional = TRUE)

/mob/living/proc/emote_warn()
	set name = "< Warn >"
	set category = "Emotes"
	usr.emote("warn", intentional = TRUE)

/mob/living/proc/emote_slowclap()
	set name = "< Slow Clap >"
	set category = "Emotes"
	usr.emote("slowclap", intentional = TRUE)

// modular_skyrat\modules\emotes\code\additionalemotes\overlay_emote.dm
/mob/living/proc/emote_sweatdrop()
	set name = "| Sweatdrop |"
	set category = "Emotes+"
	usr.emote("sweatdrop", intentional = TRUE)

/mob/living/proc/emote_exclaim()
	set name = "| Exclaim |"
	set category = "Emotes+"
	usr.emote("exclaim", intentional = TRUE)

/mob/living/proc/emote_question()
	set name = "| Question |"
	set category = "Emotes+"
	usr.emote("question", intentional = TRUE)

/mob/living/proc/emote_realize()
	set name = "| Realize |"
	set category = "Emotes+"
	usr.emote("realize", intentional = TRUE)

/mob/living/proc/emote_annoyed()
	set name = "| Annoyed |"
	set category = "Emotes+"
	usr.emote("annoyed", intentional = TRUE)

/mob/living/proc/emote_glasses()
	set name = "| Adjust Glasses |"
	set category = "Emotes+"
	usr.emote("glasses", intentional = TRUE)

//modular_skyrat\modules\emotes\code\additionalemotes\turf_emote.dm
/mob/living/proc/emote_mark_turf()
	set name = "| Mark Turf |"
	set category = "Emotes+"
	usr.emote("turf", intentional = TRUE)
