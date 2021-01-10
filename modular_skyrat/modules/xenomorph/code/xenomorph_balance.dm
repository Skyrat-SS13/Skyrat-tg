/////////////  SPEED CHANGES  /////////////
/datum/config_entry/keyed_list/multiplicative_movespeed
	key_mode = KEY_MODE_TYPE
	value_mode = VALUE_MODE_NUM
	config_entry_value = list(			//DEFAULTS
	/mob/living/carbon/alien/humanoid/drone = -0.2,
	/mob/living/carbon/alien/humanoid/hunter = -0.5,
	/mob/living/carbon/alien/humanoid/royal/praetorian = 1,
	/mob/living/carbon/alien/humanoid/royal/queen = 1.5
	)
// TG values
// • Hunter -1
// • Drone 0
// • Sentinal 0
// • Praetorian 1
// • Queen 3
// Hunters were so fast you were fighting BYOND to be able to click on them, not the hunter itself.
// Praetorians will not receive a speed buff. They instead get a huge health buff and high damage, at the minor cost of increased click delay.
// Queen gets a speed boost, health buff and very high damage.
// Drones will be made very slightly faster than humans.
/////////////  SPEED CHANGES  /////////////
///////////////////////////////////////////
/////////////   XENO QUEEN    /////////////
/mob/living/carbon/alien/humanoid/royal/queen
	maxHealth = 500				//TG: 400
	health = 500				//TG: 400
	melee_damage_lower = 50		//TG: 20
	melee_damage_upper = 50		//TG: 20
	next_move_modifier = 0.75
/////////////   XENO QUEEN    /////////////
///////////////////////////////////////////
/////////////   PRAETORIAN    /////////////
/mob/living/carbon/alien/humanoid/royal/praetorian
	maxHealth = 350				//TG: 250
	health = 350				//TG: 250
	melee_damage_lower = 40		//TG: 20
	melee_damage_upper = 40		//TG: 20
	next_move_modifier = 0.75
/////////////   PRAETORIAN    /////////////
///////////////////////////////////////////
/////////////    SENTINAL     /////////////
/mob/living/carbon/alien/humanoid/sentinel
	maxHealth = 200				//TG: 150
	health = 200				//TG: 150
	melee_damage_lower = 25		//TG: 20
	melee_damage_upper = 25		//TG: 20
	next_move_modifier = 0.75
/////////////    SENTINAL     /////////////
///////////////////////////////////////////
/////////////     HUNTER      /////////////
/mob/living/carbon/alien/humanoid/hunter
	maxHealth = 150				//TG: 125
	health = 150				//TG: 125
	melee_damage_lower = 25		//TG: 20
	melee_damage_upper = 25		//TG: 20
	next_move_modifier = 0.75
/////////////     HUNTER      /////////////
///////////////////////////////////////////
/////////////   XENO  DRONE   /////////////
/mob/living/carbon/alien/humanoid/drone
	maxHealth = 150				//TG: 125
	health = 150				//TG: 125
	melee_damage_lower = 20		//TG: 20
	melee_damage_upper = 20		//TG: 20
	next_move_modifier = 0.75
/////////////   XENO  DRONE   /////////////
///////////////////////////////////////////
/////////////   FLAVOR TEXT   /////////////
/mob/living/carbon/alien/humanoid/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, "<b>As an adult alien, you have a fair amount of intelligence. You have some familiarity with your enemy and know where's where on the station.</b>")
	to_chat(src, "<span class='warning'>Do not instantly attack the AI unless:<br>• Enemy threat is overwhelming (IE: multiple combat mechs)<br>• The AI has spotted you<br>• You wish to build a nest in their core.</span>")
/////////////   FLAVOR TEXT   /////////////
///////////////////////////////////////////
