#define PUKER_SNAPSHOT_RANGE	6
/datum/species/necromorph/puker
	name = SPECIES_NECROMORPH_PUKER
	name_plural = "pukers"
	total_health = 160
	biomass = 130
	mass = 120
	view_range = 9
	limb_health_factor = 1.15
	icon_template = 'icons/mob/necromorph/puker.dmi'
	icon_lying = "_lying"
	pixel_offset_x = -8
	single_icon = FALSE
	blurb = "A tough and flexible elite who fights by dousing enemies in acid, and is effective at all ranges. Good for crowd control and direct firefights"
	evasion = -10	//Not agile
	unarmed_types = list(/datum/unarmed_attack/claws/puker)
	step_priority = 2
	step_volume = 10
	virus_immune = 1

	//Acid has long since burned out its eyes, somehow the puker sees without them
	override_organ_types = list(BP_EYES = null)
	vision_organ = null

	//The puker has functional arms to grapple with
	grasping_limbs = list(BP_R_ARM, BP_L_ARM)

	mob_type = /mob/living/carbon/human/necromorph/puker

	inherent_verbs = list(/mob/living/proc/puker_snapshot, /mob/living/proc/puker_longshot, /mob/living/carbon/human/proc/puker_vomit, /mob/proc/shout, /mob/proc/shout_long)
	modifier_verbs = list(KEY_MIDDLE = list(/mob/living/proc/puker_snapshot),
	KEY_ALT = list(/mob/living/proc/puker_longshot),
	KEY_CTRLALT = list(/mob/living/carbon/human/proc/puker_vomit))

	//Slightly slow than a slasher
	slowdown = 3.75

	species_audio = list(
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/puker/puker_attack_1.ogg',
	'sound/effects/creatures/necromorph/puker/puker_attack_2.ogg',
	'sound/effects/creatures/necromorph/puker/puker_attack_3.ogg',
	'sound/effects/creatures/necromorph/puker/puker_attack_4.ogg',
	'sound/effects/creatures/necromorph/puker/puker_attack_5.ogg'),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/puker/puker_death_1.ogg',
	'sound/effects/creatures/necromorph/puker/puker_death_2.ogg',
	'sound/effects/creatures/necromorph/puker/puker_death_3.ogg'),
	SOUND_FOOTSTEP = list('sound/effects/creatures/necromorph/puker/puker_footstep_1.ogg',
	'sound/effects/creatures/necromorph/puker/puker_footstep_2.ogg',
	'sound/effects/creatures/necromorph/puker/puker_footstep_3.ogg',
	'sound/effects/creatures/necromorph/puker/puker_footstep_4.ogg',
	'sound/effects/creatures/necromorph/puker/puker_footstep_5.ogg',
	'sound/effects/creatures/necromorph/puker/puker_footstep_6.ogg',
	'sound/effects/creatures/necromorph/puker/puker_footstep_7.ogg',
	'sound/effects/creatures/necromorph/puker/puker_footstep_8.ogg',
	'sound/effects/creatures/necromorph/puker/puker_footstep_9.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/puker/puker_pain_1.ogg',
	'sound/effects/creatures/necromorph/puker/puker_pain_2.ogg',
	'sound/effects/creatures/necromorph/puker/puker_pain_3.ogg',
	'sound/effects/creatures/necromorph/puker/puker_pain_4.ogg',
	'sound/effects/creatures/necromorph/puker/puker_pain_5.ogg',
	'sound/effects/creatures/necromorph/puker/puker_pain_6.ogg',
	'sound/effects/creatures/necromorph/puker/puker_pain_7.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/puker/puker_shout_1.ogg',
	'sound/effects/creatures/necromorph/puker/puker_shout_2.ogg',
	'sound/effects/creatures/necromorph/puker/puker_shout_3.ogg',
	'sound/effects/creatures/necromorph/puker/puker_shout_4.ogg',
	'sound/effects/creatures/necromorph/puker/puker_shout_5.ogg',
	'sound/effects/creatures/necromorph/puker/puker_shout_6.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/puker/puker_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/puker/puker_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/puker/puker_shout_long_3.ogg',
	'sound/effects/creatures/necromorph/puker/puker_shout_long_4.ogg'),
	SOUND_SPEECH = list('sound/effects/creatures/necromorph/puker/puker_speech_1.ogg',
	'sound/effects/creatures/necromorph/puker/puker_speech_2.ogg',
	'sound/effects/creatures/necromorph/puker/puker_speech_3.ogg')
	)


#define PUKER_PASSIVE	"<h2>PASSIVE: Corrosive Vengeance:</h2><br>\
When the puker loses a limb, a wave of acid spurts out in all directions, dousing nearby people. This can hurt other necromorphs, so don't stand too close to allies."

#define PUKER_PASSIVE_2	"<h2>PASSIVE: Eyeless Horror:</h2><br>\
Constant exposure to corrosion has long since burned out its eyes, and the puker has learned to cope without them.<br>\
As a result, puker is not blinded if its head is cut off. However, losing its head will affect the vomit ability."

#define PUKER_PASSIVE_3	"<h2>PASSIVE: Crippling Acid:</h2><br>\
All of your abilities douse the victims in acid, which slows their movement speed by 30% as long as its on them."


#define PUKER_SNAP_DESC	"<h2>Snapshot:</h2><br>\
<h3>Hotkey: Middle Click </h3><br>\
<h3>Cooldown: 3 seconds</h3><br>\
Fires an instant autoaimed shot at a target within a 6 tile range, dealing 17.5 burn damage on hit. <br>\
In addition, it douses the victim in acid, dealing up to 17.5 additional burn damage over time <br>\
<br>\
This ability will harmlessly pass over other necromorphs.<br>\
Snapshot requires no manual aiming at all, and is thusly great to use in the middle of a chaotic brawl, to deal extra damage to humans who are already in melee"


#define PUKER_LONGSHOT_DESC "<h2>Long Shot:</h2><br>\
<h3>Hotkey: Alt+Click</h3><br>\
After a half-second windup, Fires a long ranged unguided bolt of acid, dealing 35 burn damage on hit<br>\
In addition, it douses the victim in acid, dealing up to 35 additional burn damage over time <br>\
Long shot is powerful and has no cooldown, but is easily dodged<br>\

This ability will harmlessly pass over other necromorphs.<br>\
Best used for harassment, skirmishing and initiating fights from afar against unwary targets"

#define PUKER_VOMIT_DESC "<h2>Vomit:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click</h3><br>\
After a 1 second windup, the Puker starts vomiting a vast torrent of acid, dousing all tiles in a 4-tile long cone over 3.5 seconds<br>\
The puker is unable to move while vomiting, but you can move your mouse to rotate on the spot and aim it in different directions. <br>\
In addition to splashing on any creatures within the radius, the floor is covered in acid for a long time afterwards, which will be soaked up by any non-necromorph that walks on it<br>\
The acid splashed on floors will accumulate without limit, repeatedly vomiting will make a larger, longer-lasting patch of acid. It will dry up eventually if left alone though. <br>\
If the puker has been decapitated, the range of vomit is significantly reduced.<br>\

Vomit is an extremely powerful signature ability, useful to decimate vast crowds of victims, and deny access to a broad area.<br>\
Be warned that friendly fire is fully active, it can harm other necromorphs as much as your enemies."

/datum/species/necromorph/puker/get_ability_descriptions()
	.= ""
	. += PUKER_PASSIVE
	. += "<hr>"
	. += PUKER_PASSIVE_2
	. += "<hr>"
	. += PUKER_PASSIVE_3
	. += "<hr>"
	. += PUKER_VOMIT_DESC
	. += "<hr>"
	. += PUKER_SNAP_DESC
	. += "<hr>"
	. += PUKER_LONGSHOT_DESC



/*
	Unarmed Attacks
*/
//Weaker version of slasher blades
//Light claw attack, not its main means of damage
/datum/unarmed_attack/claws/puker
	damage = 7


/*
	Snapshot fires a highly accurate projectile which autoaims at a nearby target.
	It has low damage and a limited range, but is almost certain to hit. Making it very consistent damage and easily useable in a chaotic fight
*/
/mob/living/proc/puker_snapshot(var/atom/A)
	set name = "Snapshot"
	set category = "Abilities"
	set desc = "A moderate-strength projectile that auto-aims at targets within [PUKER_SNAPSHOT_RANGE] range. HK: Middleclick"

	//If the user tried to fire at something out of range, change the target to their turf. This will block firing unless a valid mob is found in range
	if (get_dist(src, A) > PUKER_SNAPSHOT_RANGE)
		A = get_turf(A)

	//If the target isn't a living mob (including if we just changed it to not be) then we attempt to find a valid enemy mob in range
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 17, src, PUKER_SNAPSHOT_RANGE)


	if (!isliving(A))
		to_chat(src, SPAN_WARNING("No valid targets found within [PUKER_SNAPSHOT_RANGE] range"))
		return FALSE

	face_atom(A)
	.= shoot_ability(/datum/extension/shoot/snapshot, A , /obj/item/projectile/bullet/acid/puker_snap, accuracy = 50, dispersion = 0, num = 1, windup_time = 0, fire_sound = null, nomove = 1 SECOND, cooldown = 3 SECONDS)
	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 3)


/*
	Longshot fires an unguided accurate projectile with no range limits and good damage.
	It can be difficult to land on a moving target
*/
/mob/living/proc/puker_longshot(var/atom/A)
	set name = "Long shot"
	set category = "Abilities"
	set desc = "A powerful projectile for longrange shooting. HK: Alt+Click"

	face_atom(A)
	.= shoot_ability(/datum/extension/shoot/longshot, A , /obj/item/projectile/bullet/acid/puker_long, accuracy = 50, dispersion = 0, num = 1, windup_time = 0.5 SECONDS, fire_sound = null, nomove = 1 SECOND, cooldown = 1 SECONDS)
	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 3)


/mob/living/carbon/human/proc/puker_vomit(var/atom/A)
	set name = "Vomit"
	set category = "Abilities"
	set desc = "A powerful projectile for longrange shooting. HK: Alt+Click"

	if (!can_spray())
		return
	face_atom(A)
	var/vangle = 70
	var/vlength = 5.5
	if (!has_organ(BP_HEAD))
		to_chat(src, SPAN_WARNING("Without a mouth to focus it, the pressure of your acid is reduced!"))
		vangle = 100
		vlength = 2.5

	//It plays a series of gurgling sounds over the 1.5 sec windup time
	play_species_audio(src, SOUND_PAIN, VOLUME_MID, 1, 3)
	shake_animation(30)
	spawn(9)
		play_species_audio(src, SOUND_PAIN, VOLUME_HIGH, 1, 3)
		shake_animation(30)
	spawn(18)
		play_species_audio(src, SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 3)
	var/list/spraydata = list("reagent" = /datum/reagent/acid/necromorph, "volume" = 5.5)
	.= spray_ability(subtype = /datum/extension/spray/reagent, target = A , angle = vangle, length = vlength, stun = TRUE, duration = 3 SECONDS, cooldown = 12 SECONDS, windup = 1.8 SECOND, extra_data = spraydata)





//Snapshot projectile. Lower damage, limited range
/obj/item/projectile/bullet/acid/puker_snap
	icon_state = "acid_small"
	damage = 15
	step_delay = 1.25
	kill_count = PUKER_SNAPSHOT_RANGE
	impact_type = /obj/effect/projectile/acid/impact/small


//Longshot projectile. Good damage, no range limits, slower moving
/obj/item/projectile/bullet/acid/puker_long
	name = "acid blast"
	icon_state = "acid_large"
	step_delay = 1.75
	damage = 30
	grippable = TRUE


/*
	Acid Blood
*/
/mob/living/proc/puker_acidblood()
	var/target = pick(view(1, src))	//Pick literally anything as target, it doesnt matter. We just need something to avoid runtimes
	var/datum/extension/spray/defensive/S = set_extension(src, /datum/extension/spray/defensive, target,
	360, //Angle
	1.5, //Range
	/datum/reagent/acid/necromorph, //Chem
	20, //Volume
	0.1, //Tickdelay
	FALSE,	//Stun
	0.8 SECOND,	//Duration
	0)//Cooldown
	S.start()

/datum/extension/spray/defensive
	flags = EXTENSION_FLAG_IMMEDIATE | EXTENSION_FLAG_MULTIPLE_INSTANCES	//This version is allowed


/datum/species/necromorph/puker/handle_amputated(var/mob/living/carbon/human/H,var/obj/item/organ/external/E, var/clean, var/disintegrate, var/ignore_children, var/silent)
	H.puker_acidblood()

#undef PUKER_SNAPSHOT_RANGE