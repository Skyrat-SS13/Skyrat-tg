#define MAX_HUMAN_LIFE 200

//APPLICATION OF STAM DAMAGE
#define TISSUE_DAMAGE_STAMINA_MULTIPLIER 1.75

#define PUNCH_EXTRA_STAMINA_MULTIPLIER 0.75

//STAMINA REGEN
#define STAMINA_STATIC_REGEN_MULTIPLIER 0.2
//Flat amount regenerated per 2 seconds, multiplied by a lot of variables
#define STAMINA_STATIC_REGEN_FLAT 2
//This increases the multiplier in relation to current stamina (staminaloss/THIS)
#define STAMINALOSS_REGEN_COEFF 40

//Thresholds for detrimental effects from stamina
#define STAMINA_THRESHOLD_SLOWDOWN 70

#define STAMINA_THRESHOLD_KNOCKDOWN 130

#define STAMINA_THRESHOLD_SOFTCRIT 160

#define STAMINA_THRESHOLD_HARDCRIT 190

//A coefficient for doing the change of random CC's on a person (staminaloss/THIS)
#define STAMINA_CROWD_CONTROL_COEFF 200

//Resting thresholds
#define STAMINA_THRESHOLD_MEDIUM_GET_UP 50
#define STAMINA_THRESHOLD_SLOW_GET_UP 100

//Standing times in seconds
#define GET_UP_FAST 0.7
#define GET_UP_MEDIUM 1.5
#define GET_UP_SLOW 3

//Stamina threshold for attacking slower with items
#define STAMINA_THRESHOLD_TIRED_CLICK_CD 130
#define CLICK_CD_MELEE_TIRED 11 //#define CLICK_CD_MELEE 8, so 38% slower
#define CLICK_CD_RANGE_TIRED 5 //#define CLICK_CD_RANGE 4, so 25% slower

#define PAIN_THRESHOLD_MESSAGE_ACHE 30
#define PAIN_THRESHOLD_MESSAGE_MILD 70
#define PAIN_THRESHOLD_MESSAGE_MEDIUM 100
#define PAIN_THRESHOLD_MESSAGE_HIGH 130
#define PAIN_THRESHOLD_MESSAGE_SEVERE 160
#define PAIN_THRESHOLD_MESSAGE_OHGOD 190

#define PAIN_MESSAGE_COOLDOWN 20 SECONDS

/mob/living/carbon
	var/next_pain_message = 0

//Stamina crit threshold is MAX_HUMAN_LIFE - HEALTH_THRESHOLD_CRIT so 200 - 40 = 160
//MOVE THOSE LATER
/datum/movespeed_modifier/stamina_slowdown
	multiplicative_slowdown = 1.2

/datum/mood_event/stamina_mild
	description = "<span class='boldwarning'>Oh god it hurts!.</span>\n"
	mood_change = -3
	timeout = 1 MINUTES

/datum/mood_event/stamina_severe
	description = "<span class='boldwarning'>AAAAGHHH THE PAIN!.</span>\n"
	mood_change = -3
	timeout = 1 MINUTES

//Force mob to rest, does NOT do stamina damage.
//It's really not recommended to use this proc to give feedback, hence why silent is defaulting to true.
/mob/living/carbon/proc/KnockToFloor(disarm_items, silent = TRUE, ignore_canknockdown = FALSE)
	if(!silent && body_position != LYING_DOWN)
		to_chat(src, "<span class='warning'>You are knocked to the floor!</span>")
	Knockdown(1, ignore_canknockdown)
	if(disarm_items)
		drop_all_held_items()

/mob/living/proc/StaminaKnockdown(stamina_damage, disarm, hardstun, ignore_canknockdown = FALSE, paralyze_amount)
	if(!stamina_damage)
		return
	return Paralyze((paralyze_amount ? paralyze_amount : stamina_damage))

/mob/living/carbon/StaminaKnockdown(stamina_damage, disarm, hardstun, ignore_canknockdown = FALSE, paralyze_amount)
	if(!stamina_damage)
		return
	if(!ignore_canknockdown && !(status_flags & CANKNOCKDOWN))
		return FALSE
	if(istype(buckled, /obj/vehicle/ridden))
		buckled.unbuckle_mob(src)
	KnockToFloor(disarm, TRUE, ignore_canknockdown)
	adjustStaminaLoss(stamina_damage)
	if(!isnull(hardstun))
		Paralyze((paralyze_amount ? paralyze_amount : stamina_damage))
