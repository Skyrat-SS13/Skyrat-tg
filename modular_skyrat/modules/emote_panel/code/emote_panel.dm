/mob/proc/manipulate_emotes()
	if(!mind)
		return
	var/list/available_emotes = list()
	var/list/all_emotes = list()

	// code\modules\mob\emote.dm
	var/list/mob_emotes = list(
		/mob/proc/emote_flip,
		/mob/proc/emote_spin
	)
	all_emotes += mob_emotes
	if(istype(src, /mob))
		available_emotes += mob_emotes

	// code\modules\mob\living\emote.dm
	var/list/living_emotes = list(
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
	if(istype(src, /mob/living))
		available_emotes += living_emotes

	// code\modules\mob\living\carbon\emote.dm
	var/list/carbon_emotes = list(
		/mob/living/carbon/proc/emote_airguitar,
		/mob/living/carbon/proc/emote_blink,
		/mob/living/carbon/proc/emote_blink_r,
		/mob/living/carbon/proc/emote_crack,
		/mob/living/carbon/proc/emote_circle,
		/mob/living/carbon/proc/emote_moan,
		///mob/living/carbon/proc/emote_noogie,
		/mob/living/carbon/proc/emote_slap,
		/mob/living/carbon/proc/emote_wink
	)
	all_emotes += carbon_emotes
	if(istype(src, /mob/living/carbon))
		available_emotes += carbon_emotes

	// code\modules\mob\living\carbon\human\emote.dm
	var/list/human_emotes = list(
		/mob/living/carbon/human/proc/emote_cry,
		///mob/living/carbon/human/proc/emote_dap,
		/mob/living/carbon/human/proc/emote_eyebrow,
		/mob/living/carbon/human/proc/emote_grumble,
		///mob/living/carbon/human/proc/emote_hug,
		/mob/living/carbon/human/proc/emote_mumble,
		/mob/living/carbon/human/proc/emote_pale,
		/mob/living/carbon/human/proc/emote_raise,
		/mob/living/carbon/human/proc/emote_salute,
		/mob/living/carbon/human/proc/emote_shrug,
		/mob/living/carbon/human/proc/emote_wag,
		/mob/living/carbon/human/proc/emote_wing
	)
	all_emotes += human_emotes
	if(istype(src, /mob/living/carbon/human))
		available_emotes += human_emotes

	// modular_skyrat\modules\emotes\code\emote.dm
	var/list/skyrat_living_emotes = list(
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
	if(istype(src, /mob/living))
		available_emotes += skyrat_living_emotes

	// code\modules\mob\living\brain\emote.dm
	var/list/brain_emotes = list(
		/mob/living/brain/proc/emote_alarm,
		/mob/living/brain/proc/emote_alert,
		/mob/living/brain/proc/emote_flash,
		/mob/living/brain/proc/emote_notice,
		/mob/living/brain/proc/emote_whistle_brain
	)
	all_emotes += brain_emotes
	if(istype(src, /mob/living/brain))
		available_emotes += brain_emotes

	// code\modules\mob\living\carbon\alien\emote.dm
	var/list/alien_emotes = list(
		/mob/living/carbon/alien/proc/emote_gnarl,
		/mob/living/carbon/alien/proc/emote_hiss,
		/mob/living/carbon/alien/proc/emote_roar
	)
	all_emotes += alien_emotes
	if(istype(src, /mob/living/carbon/alien))
		available_emotes += alien_emotes

	// modular_skyrat\modules\emotes\code\synth_emotes.dm
	var/list/synth_emotes = list(
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
		/mob/living/proc/emote_slowclaps
	)
	all_emotes += synth_emotes
	if(istype(src, /mob/living/carbon/human))
		var/allowed_species_synth = list(
			/datum/species/robotic/ipc,
			/datum/species/robotic/synthliz,
			/datum/species/robotic/synthetic_human,
			/datum/species/robotic/synthetic_mammal
		)
		var/mob/living/carbon/human/current_mob = src
		if(current_mob.dna.species.type in allowed_species_synth)
			available_emotes += synth_emotes
	if(istype(src, /mob/living/silicon))
		available_emotes += synth_emotes

	//We don't like brains having verbs
	if(istype(src, /mob/living/brain))
		available_emotes -= living_emotes
		available_emotes -= skyrat_living_emotes

	// Clearing all emotes before applying new ones
	verbs -= all_emotes

	// Applying emote panel if preferences allow
	if(src.client?.prefs?.read_preference(/datum/preference/toggle/emote_panel))
		for(var/emote in available_emotes)
			verbs |= emote

/mob/mind_initialize()
	. = ..()
	manipulate_emotes()

// code\modules\mob\emote.dm
/mob/proc/emote_flip()
	set name = "| Flip |"
	set category = "Emotes"
	usr.emote("flip")

/mob/proc/emote_spin()
	set name = "| Spin |"
	set category = "Emotes"
	usr.emote("spin")

// code\modules\mob\living\emote.dm

/mob/living/proc/emote_blush()
	set name = "~ Blush"
	set category = "Emotes"
	usr.emote("blush")

/mob/living/proc/emote_bow()
	set name = "~ Bow"
	set category = "Emotes"
	usr.emote("bow")

/mob/living/proc/emote_burp()
	set name = "> Burp"
	set category = "Emotes"
	usr.emote("burp")

/mob/living/proc/emote_choke()
	set name = "~ Choke"
	set category = "Emotes"
	usr.emote("choke")

/mob/living/proc/emote_cross()
	set name = "~ Cross"
	set category = "Emotes"
	usr.emote("cross")

/mob/living/proc/emote_chuckle()
	set name = "~ Chuckle"
	set category = "Emotes"
	usr.emote("chuckle")

/mob/living/proc/emote_collapse()
	set name = "~ Collapse"
	set category = "Emotes"
	usr.emote("collapse")

/mob/living/proc/emote_cough()
	set name = "> Cough"
	set category = "Emotes"
	usr.emote("cough")

/mob/living/proc/emote_dance()
	set name = "~ Dance"
	set category = "Emotes"
	usr.emote("dance")

/mob/living/proc/emote_drool()
	set name = "~ Drool"
	set category = "Emotes"
	usr.emote("drool")

/mob/living/proc/emote_faint()
	set name = "~ Faint"
	set category = "Emotes"
	usr.emote("faint")

/mob/living/proc/emote_flap()
	set name = "~ Flap"
	set category = "Emotes"
	usr.emote("flap")

/mob/living/proc/emote_aflap()
	set name = "~ Angry Flap"
	set category = "Emotes"
	usr.emote("aflap")

/mob/living/proc/emote_frown()
	set name = "~ Frown"
	set category = "Emotes"
	usr.emote("frown")

/mob/living/proc/emote_gag()
	set name = "~ Gag"
	set category = "Emotes"
	usr.emote("gag")

/mob/living/proc/emote_giggle()
	set name = "~ Giggle"
	set category = "Emotes"
	usr.emote("giggle")

/mob/living/proc/emote_glare()
	set name = "~ Glare"
	set category = "Emotes"
	usr.emote("glare")

/mob/living/proc/emote_grin()
	set name = "~ Grin"
	set category = "Emotes"
	usr.emote("grin")

/mob/living/proc/emote_groan()
	set name = "~ Groan"
	set category = "Emotes"
	usr.emote("groan")

/mob/living/proc/emote_grimace()
	set name = "~ Grimace"
	set category = "Emotes"
	usr.emote("grimace")

/mob/living/proc/emote_jump()
	set name = "~ Jump"
	set category = "Emotes"
	usr.emote("jump")

/mob/living/proc/emote_kiss()
	set name = "| Kiss |"
	set category = "Emotes"
	usr.emote("kiss")

/mob/living/proc/emote_laugh()
	set name = "> Laugh"
	set category = "Emotes"
	usr.emote("laugh")

/mob/living/proc/emote_look()
	set name = "~ Look"
	set category = "Emotes"
	usr.emote("look")

/mob/living/proc/emote_nod()
	set name = "~ Nod"
	set category = "Emotes"
	usr.emote("nod")

/mob/living/proc/emote_point()
	set name = "~ Point"
	set category = "Emotes"
	usr.emote("point")

/mob/living/proc/emote_pout()
	set name = "~ Pout"
	set category = "Emotes"
	usr.emote("pout")

/mob/living/proc/emote_scream()
	set name = "> Scream"
	set category = "Emotes"
	usr.emote("scream")

/mob/living/proc/emote_scowl()
	set name = "~ Scowl"
	set category = "Emotes"
	usr.emote("scowl")

/mob/living/proc/emote_shake()
	set name = "~ Shake"
	set category = "Emotes"
	usr.emote("shake")

/mob/living/proc/emote_shiver()
	set name = "~ Shiver"
	set category = "Emotes"
	usr.emote("shiver")

/mob/living/proc/emote_sigh()
	set name = "> Sigh"
	set category = "Emotes"
	usr.emote("sigh")

/mob/living/proc/emote_sit()
	set name = "~ Sit"
	set category = "Emotes"
	usr.emote("sit")

/mob/living/proc/emote_smile()
	set name = "~ Smile"
	set category = "Emotes"
	usr.emote("smile")

/mob/living/proc/emote_sneeze()
	set name = "> Sneeze"
	set category = "Emotes"
	usr.emote("sneeze")

/mob/living/proc/emote_smug()
	set name = "~ Smug"
	set category = "Emotes"
	usr.emote("smug")

/mob/living/proc/emote_sniff()
	set name = "> Sniff"
	set category = "Emotes"
	usr.emote("sniff")

/mob/living/proc/emote_stare()
	set name = "~ Stare"
	set category = "Emotes"
	usr.emote("stare")

/mob/living/proc/emote_strech()
	set name = "~ Stretch"
	set category = "Emotes"
	usr.emote("stretch")

/mob/living/proc/emote_sulk()
	set name = "~ Sulk"
	set category = "Emotes"
	usr.emote("sulk")

/mob/living/proc/emote_sway()
	set name = "~ Sway"
	set category = "Emotes"
	usr.emote("sway")

/mob/living/proc/emote_tilt()
	set name = "~ Tilt"
	set category = "Emotes"
	usr.emote("tilt")

/mob/living/proc/emote_tremble()
	set name = "~ Tremble"
	set category = "Emotes"
	usr.emote("tremble")

/mob/living/proc/emote_twitch()
	set name = "~ Twitch"
	set category = "Emotes"
	usr.emote("twitch")

/mob/living/proc/emote_twitch_s()
	set name = "~ Slight Twitch"
	set category = "Emotes"
	usr.emote("twitch_s")

/mob/living/proc/emote_wave()
	set name = "~ Wave"
	set category = "Emotes"
	usr.emote("wave")

/mob/living/proc/emote_whimper()
	set name = "~ Whimper"
	set category = "Emotes"
	usr.emote("whimper")

/mob/living/proc/emote_wsmile()
	set name = "~ Smile Weak"
	set category = "Emotes"
	usr.emote("wsmile")

/mob/living/proc/emote_yawn()
	set name = "~ Yawn"
	set category = "Emotes"
	usr.emote("yawn")

/mob/living/proc/emote_gurgle()
	set name = "~ Gurgle"
	set category = "Emotes"
	usr.emote("gurgle")

/mob/living/proc/emote_inhale()
	set name = "~ Inhale"
	set category = "Emotes"
	usr.emote("inhale")

/mob/living/proc/emote_exhale()
	set name = "~ Exhale"
	set category = "Emotes"
	usr.emote("exhale")

/mob/living/proc/emote_swear()
	set name = "~ Swear"
	set category = "Emotes"
	usr.emote("swear")

// code\modules\mob\living\carbon\emote.dm

/mob/living/carbon/proc/emote_airguitar()
	set name = "~ Airguitar"
	set category = "Emotes"
	usr.emote("airguitar")

/mob/living/carbon/proc/emote_blink()
	set name = "~ Blink"
	set category = "Emotes"
	usr.emote("blink")

/mob/living/carbon/proc/emote_blink_r()
	set name = "~ Blink Rapid"
	set category = "Emotes"
	usr.emote("blink_r")

/mob/living/carbon/proc/emote_crack()
	set name = "> Crack"
	set category = "Emotes"
	usr.emote("crack")

/mob/living/carbon/proc/emote_circle()
	set name = "| Circle |"
	set category = "Emotes"
	usr.emote("circle")

/mob/living/carbon/proc/emote_moan()
	set name = "~ Moan"
	set category = "Emotes"
	usr.emote("moan")

/mob/living/carbon/proc/emote_noogie()
	set name = "~ Noogie"
	set category = "Emotes"
	usr.emote("noogie")

/mob/living/carbon/proc/emote_slap()
	set name = "| Slap |"
	set category = "Emotes"
	usr.emote("slap")

/mob/living/carbon/proc/emote_wink()
	set name = "~ Wink"
	set category = "Emotes"
	usr.emote("wink")

// code\modules\mob\living\carbon\human\emote.dm

/mob/living/carbon/human/proc/emote_cry()
	set name = "~ Cry"
	set category = "Emotes"
	usr.emote("cry")

/mob/living/carbon/human/proc/emote_dap()
	set name = "~ Dap"
	set category = "Emotes"
	usr.emote("dap")

/mob/living/carbon/human/proc/emote_eyebrow()
	set name = "~ Eyebrow"
	set category = "Emotes"
	usr.emote("eyebrow")

/mob/living/carbon/human/proc/emote_grumble()
	set name = "~ Grumble"
	set category = "Emotes"
	usr.emote("grumble")

/mob/living/carbon/human/proc/emote_hug()
	set name = "~ Hug"
	set category = "Emotes"
	usr.emote("hug")

/mob/living/carbon/human/proc/emote_mumble()
	set name = "~ Mumble"
	set category = "Emotes"
	usr.emote("mumble")

/mob/living/carbon/human/proc/emote_pale()
	set name = "~ Pale"
	set category = "Emotes"
	usr.emote("pale")

/mob/living/carbon/human/proc/emote_raise()
	set name = "~ Raise hand"
	set category = "Emotes"
	usr.emote("raise")

/mob/living/carbon/human/proc/emote_salute()
	set name = "~ Salute"
	set category = "Emotes"
	usr.emote("salute")

/mob/living/carbon/human/proc/emote_shrug()
	set name = "~ Shrug"
	set category = "Emotes"
	usr.emote("shrug")

/mob/living/carbon/human/proc/emote_wag()
	set name = "| Wag |"
	set category = "Emotes"
	usr.emote("wag")

/mob/living/carbon/human/proc/emote_wing()
	set name = "| Wing |"
	set category = "Emotes"
	usr.emote("wing")

// modular_skyrat\modules\emotes\code\emote.dm

/mob/living/proc/emote_peep()
	set name = "> Peep"
	set category = "Emotes+"
	usr.emote("peep")

/mob/living/proc/emote_peep2()
	set name = "> Peep twice"
	set category = "Emotes+"
	usr.emote("peep2")

/mob/living/proc/emote_snap()
	set name = "> Snap"
	set category = "Emotes+"
	usr.emote("snap")

/mob/living/proc/emote_snap2()
	set name = "> Snap twice"
	set category = "Emotes+"
	usr.emote("snap2")

/mob/living/proc/emote_snap3()
	set name = "> Snap thrice"
	set category = "Emotes+"
	usr.emote("snap3")

/mob/living/proc/emote_awoo()
	set name = "> Awoo"
	set category = "Emotes+"
	usr.emote("awoo")

/mob/living/proc/emote_nya()
	set name = "> Nya"
	set category = "Emotes+"
	usr.emote("nya")

/mob/living/proc/emote_weh()
	set name = "> Weh"
	set category = "Emotes+"
	usr.emote("weh")

/mob/living/proc/emote_mothsqueak()
	set name = "> Mothsqueak"
	set category = "Emotes+"
	usr.emote("msqueak")

/mob/living/proc/emote_mousesqueak()
	set name = "> Mousesqueak"
	set category = "Emotes+"
	usr.emote("squeak")

/mob/living/proc/emote_merp()
	set name = "> Merp"
	set category = "Emotes+"
	usr.emote("merp")

/mob/living/proc/emote_bark()
	set name = "> Bark"
	set category = "Emotes+"
	usr.emote("bark")

/mob/living/proc/emote_squish()
	set name = "> Squish"
	set category = "Emotes+"
	usr.emote("squish")

/mob/living/proc/emote_meow()
	set name = "> Meow"
	set category = "Emotes+"
	usr.emote("meow")

/mob/living/proc/emote_hiss1()
	set name = "> Hiss"
	set category = "Emotes+"
	usr.emote("hiss1")

/mob/living/proc/emote_chitter()
	set name = "> Chitter"
	set category = "Emotes+"
	usr.emote("chitter")

/mob/living/proc/emote_snore()
	set name = "> Snore"
	set category = "Emotes+"
	usr.emote("snore")

/mob/living/proc/emote_clap()
	set name = "> Clap"
	set category = "Emotes+"
	usr.emote("clap")

/mob/living/proc/emote_clap1()
	set name = "> Clap once"
	set category = "Emotes+"
	usr.emote("clap1")

/mob/living/proc/emote_headtilt()
	set name = "~ Head tilt"
	set category = "Emotes+"
	usr.emote("tilt")

/mob/living/proc/emote_blink2()
	set name = "~ Blink twice"
	set category = "Emotes+"
	usr.emote("blink2")

/mob/living/proc/emote_rblink()
	set name = "~ Blink rapid"
	set category = "Emotes+"
	usr.emote("rblink")

/mob/living/proc/emote_squint()
	set name = "~ Squint"
	set category = "Emotes+"
	usr.emote("squint")

/mob/living/proc/emote_smirk()
	set name = "~ Smirk"
	set category = "Emotes+"
	usr.emote("smirk")

/mob/living/proc/emote_eyeroll()
	set name = "~ Eyeroll"
	set category = "Emotes+"
	usr.emote("eyeroll")

/mob/living/proc/emote_huff()
	set name = "~ Huff"
	set category = "Emotes+"
	usr.emote("huffs")

/mob/living/proc/emote_etwitch()
	set name = "~ Ears twitch"
	set category = "Emotes+"
	usr.emote("etwitch")

/mob/living/proc/emote_clear()
	set name = "~ Clear throat"
	set category = "Emotes+"
	usr.emote("clear")

/mob/living/proc/emote_bawk()
	set name = "> Bawk"
	set category = "Emotes+"
	usr.emote("bawk")

/mob/living/proc/emote_caw()
	set name = "> Caw"
	set category = "Emotes+"
	usr.emote("caw")

/mob/living/proc/emote_caw2()
	set name = "> Caw twice"
	set category = "Emotes+"
	usr.emote("caw2")

/mob/living/proc/emote_whistle()
	set name = "~ Whistle"
	set category = "Emotes+"
	usr.emote("whistle")

/mob/living/proc/emote_blep()
	set name = "~ Blep"
	set category = "Emotes+"
	usr.emote("blep")

/mob/living/proc/emote_bork()
	set name = "> Bork"
	set category = "Emotes+"
	usr.emote("bork")

/mob/living/proc/emote_hoot()
	set name = "> Hoot"
	set category = "Emotes+"
	usr.emote("hoot")

/mob/living/proc/emote_growl()
	set name = "> Growl"
	set category = "Emotes+"
	usr.emote("growl")

/mob/living/proc/emote_woof()
	set name = "> Woof"
	set category = "Emotes+"
	usr.emote("woof")

/mob/living/proc/emote_baa()
	set name = "> Baa"
	set category = "Emotes+"
	usr.emote("baa")

/mob/living/proc/emote_baa2()
	set name = "> Bleat"
	set category = "Emotes+"
	usr.emote("baa2")

/mob/living/proc/emote_wurble()
	set name = "> Wurble"
	set category = "Emotes+"
	usr.emote("wurble")
/mob/living/proc/emote_rattle()
	set name = "> Rattle"
	set category = "Emotes+"
	usr.emote("rattle")

/mob/living/proc/emote_cackle()
	set name = "> Cackle"
	set category = "Emotes+"
	usr.emote("cackle")

/mob/living/proc/emote_warble()
	set name = "> Warble"
	set category = "Emotes+"
	usr.emote("warble")

/mob/living/proc/emote_trills()
	set name = "> Trills"
	set category = "Emotes+"
	usr.emote("trills")

/mob/living/proc/emote_rpurr()
	set name = "> Raptor"
	set category = "Emotes+"
	usr.emote("rpurr")

/mob/living/proc/emote_purr()
	set name = "> Purr"
	set category = "Emotes+"
	usr.emote("purr")

/mob/living/proc/emote_moo()
	set name = "> Moo"
	set category = "Emotes+"
	usr.emote("moo")

/mob/living/proc/emote_honk1()
	set name = "> Honk"
	set category = "Emotes+"
	usr.emote("honk1")

// code\modules\mob\living\brain\emote.dm

/mob/living/brain/proc/emote_alarm()
	set name = "< Alarm >"
	set category = "Emotes"
	usr.emote("alarm")

/mob/living/brain/proc/emote_alert()
	set name = "< Alert >"
	set category = "Emotes"
	usr.emote("alert")

/mob/living/brain/proc/emote_flash()
	set name = "< Flash >"
	set category = "Emotes"
	usr.emote("flash")

/mob/living/brain/proc/emote_notice()
	set name = "< Notice >"
	set category = "Emotes"
	usr.emote("notice")

/mob/living/brain/proc/emote_whistle_brain()
	set name = "< Whistle >"
	set category = "Emotes"
	usr.emote("whistle")

// code\modules\mob\living\carbon\alien\emote.dm

/mob/living/carbon/alien/proc/emote_gnarl()
	set name = "< Gnarl >"
	set category = "Emotes"
	usr.emote("gnarl")

/mob/living/carbon/alien/proc/emote_hiss()
	set name = "< Hiss >"
	set category = "Emotes"
	usr.emote("hiss")

/mob/living/carbon/alien/proc/emote_roar()
	set name = "< Roar >"
	set category = "Emotes"
	usr.emote("roar")

//modular_skyrat\modules\emotes\code\synth_emotes.dm

/mob/living/proc/emote_dwoop()
	set name = "< Dwoop >"
	set category = "Emotes"
	usr.emote("dwoop")

/mob/living/proc/emote_yes()
	set name = "< Yes >"
	set category = "Emotes"
	usr.emote("yes")

/mob/living/proc/emote_no()
	set name = "< No >"
	set category = "Emotes"
	usr.emote("no")

/mob/living/proc/emote_boop()
	set name = "< Boop >"
	set category = "Emotes"
	usr.emote("boop")

/mob/living/proc/emote_buzz()
	set name = "< Buzz >"
	set category = "Emotes"
	usr.emote("buzz")

/mob/living/proc/emote_beep()
	set name = "< Beep >"
	set category = "Emotes"
	usr.emote("beep")

/mob/living/proc/emote_beep2()
	set name = "< Beep Sharply >"
	set category = "Emotes"
	usr.emote("beep2")

/mob/living/proc/emote_buzz2()
	set name = "< Buzz Twice >"
	set category = "Emotes"
	usr.emote("buzz2")

/mob/living/proc/emote_chime()
	set name = "< Chime >"
	set category = "Emotes"
	usr.emote("chime")

/mob/living/proc/emote_honk()
	set name = "< Honk >"
	set category = "Emotes"
	usr.emote("honk")

/mob/living/proc/emote_ping()
	set name = "< Ping >"
	set category = "Emotes"
	usr.emote("ping")

/mob/living/proc/emote_sad()
	set name = "< Sad >"
	set category = "Emotes"
	usr.emote("sad")

/mob/living/proc/emote_warn()
	set name = "< Warn >"
	set category = "Emotes"
	usr.emote("warn")

/mob/living/proc/emote_slowclaps()
	set name = "< Slow Clap >"
	set category = "Emotes"
	usr.emote("slowclap")
