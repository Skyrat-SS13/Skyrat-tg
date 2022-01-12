//This file is for defines related to damage, armor, and generally violence

//Weapon Force: Provides the base damage for melee weapons.
#define WEAPON_FORCE_HARMLESS    3
#define WEAPON_FORCE_WEAK        4
#define WEAPON_FORCE_NORMAL      6
#define WEAPON_FORCE_PAINFUL     10
#define WEAPON_FORCE_DANGEROUS   14
#define WEAPON_FORCE_ROBUST      19
#define WEAPON_FORCE_LETHAL      28


//Resistance values, used on floors, windows, airlocks, girders, and similar hard targets
//Reduces the damage they take by flat amounts
#define RESISTANCE_FRAGILE 				3
#define RESISTANCE_AVERAGE 				5
#define RESISTANCE_IMPROVED 			8
#define RESISTANCE_TOUGH 				12
#define RESISTANCE_ARMOURED 			16
#define RESISTANCE_HEAVILY_ARMOURED 	22
#define RESISTANCE_VAULT 				28
#define RESISTANCE_UNBREAKABLE 			40


//Structure damage values: Multipliers on base damage for attacking hard targets
//Blades are weaker, and heavy/blunt weapons are stronger.
//Drills, fireaxes and energy melee weapons are the high end
#define STRUCTURE_DAMAGE_BLADE 			0.5
#define STRUCTURE_DAMAGE_WEAK 			0.8
#define STRUCTURE_DAMAGE_NORMAL 		1.0
#define STRUCTURE_DAMAGE_BLUNT 			1.3
#define STRUCTURE_DAMAGE_HEAVY 			1.5
#define STRUCTURE_DAMAGE_BREACHING 		1.8
#define STRUCTURE_DAMAGE_BORING 		3

//These multipliers are factored with the integrity and resistance values on materials
#define WALL_HEALTH_MULTIPLIER			1
#define WALL_RESISTANCE_MULTIPLIER		1

//Quick defines for rapid fire
#define FULL_AUTO_300	list(mode_name="full auto",  mode_type = /datum/firemode/automatic, fire_delay=2)
#define FULL_AUTO_400	list(mode_name="full auto",  mode_type = /datum/firemode/automatic, fire_delay=1.5)
#define FULL_AUTO_600	list(mode_name="full auto",  mode_type = /datum/firemode/automatic, fire_delay=1)

//Defines used for how bullets expire
#define EXPIRY_DELETE	1	//Delete the bullet as soon as it's done
#define EXPIRY_FADEOUT	2	//Fade to zero alpha over some time, then delete
#define EXPIRY_ANIMATION	3	//Play an animation over some time, then delete



//Gun loading types
#define SINGLE_CASING 	1	//The gun only accepts ammo_casings. ammo_magazines should never have this as their mag_type.
#define SPEEDLOADER 	2	//Transfers casings from the mag to the gun when used.
#define MAGAZINE 		4	//The magazine item itself goes inside the gun



#define BASE_DEFENSE_CHANCE	85	//The basic chance of a human to block incoming hits, assuming they're conscious and facing the right direction
//This is extremely high so that humans will reliably lose limbs before core parts in combat.


//How fast most objects are thrown by an ordinary human, measured in metres per second
#define BASE_THROW_SPEED	6


// Special return values from bullet_act(). Positive return values are already used to indicate the blocked level of the projectile.
//A value of 0 indicates a normal unblocked hit
#define PROJECTILE_HIT	0
#define PROJECTILE_CONTINUE   -1 	//if the projectile should continue flying after calling bullet_act()
#define PROJECTILE_FORCE_MISS -2 	//if the projectile should treat the attack as a miss (suppresses attack and admin logs) - only applies to mobs.
#define PROJECTILE_DEFLECT		-3	//if the projectile should continue flying in a new direction


//Damage dealt by fire per second, is equal to the fire temperature - heat resistance, multiplied by this
//1 damage (per second) per 125 degrees kelvin
#define FIRE_DAMAGE_MULTIPLIER	0.008


//Defines for types of damage sources sent through take_damage
//These are only needed for rare cases where you want to do special snowflakey behaviour depending on what caused the damage. EG explosions, acid, directed energy
#define DAMAGE_SOURCE_EXPLOSION	"Explosive Blast"