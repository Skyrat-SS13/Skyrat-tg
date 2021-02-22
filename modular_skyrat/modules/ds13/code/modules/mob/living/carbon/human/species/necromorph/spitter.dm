#define SPITTER_SNAPSHOT_RANGE	5
/datum/species/necromorph/slasher/spitter
	name = SPECIES_NECROMORPH_SPITTER
	name_plural = "Spitters"
	total_health = 65
	biomass = 55
	mass = 45
	view_range = 8
	icon_template = 'icons/mob/necromorph/spitter.dmi'
	blurb = "A midline skirmisher with the ability to spit acid at medium range. Works best when accompanied by slashers to protect it from attacks. Weak and fragile in direct combat."
	unarmed_types = list(/datum/unarmed_attack/blades/weak, /datum/unarmed_attack/bite/weak) //Bite attack is a backup if blades are severed
	virus_immune = 1

	mob_type = /mob/living/carbon/human/necromorph/spitter

	inherent_verbs = list(/mob/living/proc/spitter_snapshot, /mob/living/proc/spitter_longshot, /mob/proc/shout, /mob/proc/shout_long)
	modifier_verbs = list(KEY_MIDDLE = list(/mob/living/proc/spitter_snapshot),
	KEY_ALT = list(/mob/living/proc/spitter_longshot))

	//Slightly faster than a slasher
	slowdown = 3

	species_audio = list(
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/spitter/spitter_attack_1.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_2.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_3.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_4.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_5.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_6.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_7.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_8.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_9.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_attack_extreme.ogg' = 0.2),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/spitter/spitter_death_1.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_death_2.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_death_3.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/spitter/spitter_pain_1.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_pain_2.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_pain_3.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_pain_4.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_pain_5.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_pain_6.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_pain_7.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_pain_8.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_pain_extreme.ogg' = 0.2,
	'sound/effects/creatures/necromorph/spitter/spitter_pain_extreme_2.ogg' = 0.2),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/spitter/spitter_shout_1.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_shout_2.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_shout_3.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_shout_4.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/spitter/spitter_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_shout_long_3.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_shout_long_4.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_shout_long_5.ogg'),
	SOUND_SPEECH = list('sound/effects/creatures/necromorph/spitter/spitter_speech_1.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_speech_2.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_speech_3.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_speech_4.ogg',
	'sound/effects/creatures/necromorph/spitter/spitter_speech_5.ogg')
	)

/*
	Unarmed Attacks
*/
//Weaker version of slasher blades
/datum/unarmed_attack/blades/weak
	name = "slashing blades"
	desc = "These modest sized blades can cut off a limb or two."
	damage = 12
	delay = 16
	airlock_force_power = 1.5
	armor_penetration = 5

#define SPITTER_PASSIVE	"<h2>PASSIVE: No Friendly Fire:</h2><br>\
All projectiles fired by this necromorph will harmlessly pass over other necromorphs, and will only hit enemies."

#define SPITTER_PASSIVE_2	"<h2>PASSIVE: Crippling Acid:</h2><br>\
All of your abilities douse the victims in acid, which slows their movement speed by 30% as long as its on them."

#define SPITTER_SNAP_DESC	"<h2>Snapshot:</h2><br>\
<h3>Hotkey: Middle Click </h3><br>\
<h3>Cooldown: 3 seconds</h3><br>\
Fires an instant autoaimed shot at a target within a 5 tile range, dealing 10 burn damage on hit. <br>\
In addition, it douses the victim in acid, dealing up to 10 additional burn damage over time <br>\
<br>\
Snapshot requires no manual aiming at all, and is thusly great to use in the middle of a chaotic brawl, to deal extra damage to humans who are already in melee"


#define SPITTER_LONGSHOT_DESC "<h2>Long Shot:</h2><br>\
<h3>Hotkey: Alt+Click</h3><br>\
After a half-second windup, Fires a long ranged unguided bolt of acid, dealing 20 burn damage on hit<br>\
In addition, it douses the victim in acid, dealing up to 20 additional burn damage over time <br>\
Long shot is powerful and has no cooldown, but is easily dodged<br>\

Best used for harassment, skirmishing and initiating fights from afar against unwary targets"

/datum/species/necromorph/slasher/spitter/get_ability_descriptions()
	.= ""
	. += SPITTER_PASSIVE
	. += "<hr>"
	. += SPITTER_PASSIVE_2
	. += "<hr>"
	. += SPITTER_SNAP_DESC
	. += "<hr>"
	. += SPITTER_LONGSHOT_DESC

/*
	Snapshot fires a highly accurate projectile which autoaims at a nearby target.
	It has low damage and a limited range, but is almost certain to hit. Making it very consistent damage and easily useable in a chaotic fight
*/
/mob/living/proc/spitter_snapshot(var/atom/A)
	set name = "Snapshot"
	set category = "Abilities"
	set desc = "A weak projectile that auto-aims at targets within [SPITTER_SNAPSHOT_RANGE] range. HK: Middleclick"

	//If the user tried to fire at something out of range, change the target to their turf. This will block firing unless a valid mob is found in range
	if (get_dist(src, A) > SPITTER_SNAPSHOT_RANGE)
		A = get_turf(A)

	//If the target isn't a living mob (including if we just changed it to not be) then we attempt to find a valid enemy mob in range
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 15, src, SPITTER_SNAPSHOT_RANGE)

	if (!isliving(A))
		to_chat(src, SPAN_WARNING("No valid targets found within [SPITTER_SNAPSHOT_RANGE] range"))
		return FALSE

	face_atom(A)
	.= shoot_ability(/datum/extension/shoot/snapshot, A , /obj/item/projectile/bullet/acid/spitter_snap, accuracy = 50, dispersion = 0, num = 1, windup_time = 0, fire_sound = null, nomove = 1 SECOND, cooldown = 3 SECONDS)
	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 3)


/*
	Longshot fires an unguided accurate projectile with no range limits and good damage.
	It can be difficult to land on a moving target
*/
/mob/living/proc/spitter_longshot(var/atom/A)
	set name = "Long shot"
	set category = "Abilities"
	set desc = "A moderate-strength projectile for longrange shooting. HK: Alt+Click"

	face_atom(A)
	.= shoot_ability(/datum/extension/shoot/longshot, A , /obj/item/projectile/bullet/acid/spitter_long, accuracy = 50, dispersion = 0, num = 1, windup_time = 0.5 SECONDS, fire_sound = null, nomove = 1 SECOND, cooldown = 1 SECONDS)
	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 3)


//Shoot extension subtype. This just needs to exist so it has its own cooldown and name.
/datum/extension/shoot/snapshot
	name = "Snapshot"
	base_type = /datum/extension/shoot/snapshot

/datum/extension/shoot/longshot
	name = "Long Shot"
	base_type = /datum/extension/shoot/longshot
/*
	Acid projectiles deal total damage equal to 100-200% of the damage value written here. So write in a value for half of what it should actually do
	On impact, the damage is applied immediately as burn, and the victim is doused in enough acid to deal that same amount of damage again over time.
	The effectiveness of the acid component is heavily dependant on worn equipment
*/
//This probably shouldn't be defined here, all acid projectiles are a child of this one, and it's not a logical place to look to find the parent. Perhaps a necro_projectiles.dm?
/obj/item/projectile/bullet/acid
	name = "acid bolt"
	icon_state = "acid_small"
	fire_sound = null
	damage = 15
	damage_type = BURN
	nodamage = 0
	check_armour = "laser"
	embed = FALSE
	sharp = FALSE
	penetration_modifier = 0

	muzzle_type = /obj/effect/projectile/bio/muzzle
	impact_type = /obj/effect/projectile/acid/impact
	miss_sounds = list('sound/weapons/guns/miss1.ogg','sound/weapons/guns/miss2.ogg','sound/weapons/guns/miss3.ogg','sound/weapons/guns/miss4.ogg')



/obj/item/projectile/bullet/acid/attack_mob(var/mob/living/target_mob, var/distance, var/miss_modifier=0)
	if (firer.is_allied(target_mob))	//The bullet passes through our own allies harmlessly
		return TRUE

	.=..()
	//The parent call will return false if we stop on this victim, but it will return true if we miss them or bounce off
	//We only want to deposit acid on the victim in the former case, not the latter. So check for false
	if (!.)
		var/acid_volume = damage / NECROMORPH_ACID_POWER	//Figure out how many units of acid we need
		var/datum/reagents/R = new(acid_volume, GLOB.bioblast_acid_holder)
		R.add_reagent(/datum/reagent/acid/necromorph, acid_volume, safety = TRUE)
		R.trans_to(target_mob, R.total_volume)	//Apply acid to mob
		qdel(R)

//Snapshot projectile. Lower damage, limited range
/obj/item/projectile/bullet/acid/spitter_snap
	icon_state = "acid_small"
	damage = 10
	step_delay = 1.5
	kill_count = SPITTER_SNAPSHOT_RANGE
	impact_type = /obj/effect/projectile/acid/impact/small


//Longshot projectile. Good damage, no range limits, slower moving
/obj/item/projectile/bullet/acid/spitter_long
	name = "acid blast"
	icon_state = "acid_large"
	step_delay = 2
	damage = 20
	grippable = TRUE


#undef SPITTER_SNAPSHOT_RANGE