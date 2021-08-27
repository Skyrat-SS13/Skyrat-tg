//*******************Contains everything related to the fauna on Rockplanet.*******************************

//////////////
//MOBS
//////////////

//--- SLIDER
//--- Unique mob, idly and offensively teleports around, leaves an ethereal trail when it does. Very spooky, not all that threatening unless you're caught off-guard
//TODO - Drops???
//TODO - Find something to subtype it off of?
//Sprites are modified from [STALKER13]
/mob/living/simple_animal/hostile/rockplanet/slider
	name = "slider"
	desc = "An anomalous shadowy figure, wandering between the layers of reality, phasing in and out randomly. Their eyes, or whatever's in that location, seem almost sad..."
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_mobs.dmi'
	icon_state = "slider"
	icon_living = "slider"
	//icon_aggro = "slider" //Not yet implemented due to the fact the lack of subtype = it doesnt exist
	icon_dead = "slider_dead"
	icon_gib = "dark_gib"

/mob/living/simple_animal/hostile/rockplanet/slider/Initialize() //Randomly chooses which appearance to use
	. = ..()
	var/random_icon = pick("", "_1", "_2", "_3")
	icon_state += random_icon
	icon_living += random_icon
	//icon_aggro += random_icon

//--- WEAVER
//--- Reskin/rebalance of the hivelord, creates SPAWN instead
//TODO - Drops???
//TODO - Sprites
/mob/living/simple_animal/hostile/asteroid/hivelord/weaver
	name = "weaver"
	desc = "An anomalous mass of unknown material, constantly fluctuating and shifting. It can sometimes be seen creating Spawn from its own dark matter."
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_mobs.dmi'
	icon_state = "weaver"
	icon_living = "weaver"
	icon_aggro = "weaver_attack"
	icon_dead = "weaver_dead"
	icon_gib = "dark_gib"
	move_to_delay = 14
	speed = 2
	maxHealth = 100
	health = 100
	ranged_cooldown_time = 30
	retreat_distance = 3
	minimum_distance = 2
	loot = list(/obj/item/organ/regenerative_core)	//CHANGE THIS
	brood_type = /mob/living/simple_animal/hostile/asteroid/hivelordbrood/weaver_spawn

//--- SPAWN
//--- (??? WIP CONCEPT, EXPECT CHANGE) Reskin/rebalance of the hivelord brood || Reskin/rebalance of Headcrabs, WEAVERs can spawn max 3
//TODO - Drops???
//TODO - Sprites
/mob/living/simple_animal/hostile/asteroid/hivelordbrood/weaver_spawn
	name = "spawn"
	desc = "A dark creature created by the weaver - easy enough to step on, but in large numbers..."
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_mobs.dmi'
	icon_state = "spawn"
	icon_living = "spawn"
	icon_aggro = "spawn"
	icon_dead = "spawn_dead"
	icon_gib = "dark_gib"
	move_to_delay = 1
	friendly_verb_continuous = "buzzes near"	//CHANGE THIS
	friendly_verb_simple = "buzz near"	//CHANGE THIS
	vision_range = 10
	speed = 2
	maxHealth = 5
	health = 5
	del_on_death = 1

/*
To-do: Overwrite this, Spawn cannot fly. Or re-do the base-type to be headcrabs idk yet.
/mob/living/simple_animal/hostile/asteroid/hivelordbrood/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/death), 100)
	AddElement(/datum/element/simple_flying)
	AddComponent(/datum/component/swarming)
*/

//--- LOST HUSK
//--- Reskin/rebalance of the zombie, less vibrant green, and civilian random equipment (military variant?)
//TODO - Actual mob. Drops need balancing, but will be a randomly selected corpse
/mob/living/simple_animal/hostile

	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost)


//Subtypes for force-spawning certain jobtypes
//DEAR GOD SOMEONE TELL ME A BETTER WAY TO DO THIS
//---START---
/mob/living/simple_animal/hostile
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/civ)
/mob/living/simple_animal/hostile
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/serv)
/mob/living/simple_animal/hostile
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/busi)
/mob/living/simple_animal/hostile
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/engi)
/mob/living/simple_animal/hostile
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/doc)
/mob/living/simple_animal/hostile
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/mil)
/mob/living/simple_animal/hostile
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/op)
/mob/living/simple_animal/hostile
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/cult)

/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost
	mob_color = "#cdd4a5"	//Dilutes the color to always look like the lost husk
	var/lost_jobtype	//pre-created here, for use in pre-determined Lost. Good for forcing engineers into construction ruins, or military into military bases

/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/civ
	lost_jobtype = "Civilian"
/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/serv
	lost_jobtype = "Service"
/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/busi
	lost_jobtype = "Businessman"
/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/engi
	lost_jobtype = "Engineer"
/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/doc
	lost_jobtype = "Doctor"
/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/mil
	lost_jobtype = "Military"
/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/op
	lost_jobtype = "Operative"
/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/preset_job/cult
	lost_jobtype = "Cultist"
//---END---
//See why I'm BEGGING for a cleaner way to do this??? THERE'S SO MUCH

/obj/effect/mob_spawn/human/corpse/damaged/rockplanet_lost/Initialize()	//Sets the 'job', determining loot and clothing
	if(!lost_jobtype)
		lost_jobtype = pickweight(list("Civilian" = 66, "Service" = 8, "Businessman" = 8, "Engineer" = 8, "Doctor" = 6, pick(list("Military", "Operative", "Cultist")) = 4))
	mob_species = /datum/species/human	//Always humans, the planet died before reaching spaceage/meeting alien life

	shoes = /obj/item/clothing/shoes/sneakers/black	//Everyone has these, unless overwritten
	switch(type)
		if("Civilian")	//Most common, just everyday civilians. Also the most randomized.
			if(mob_gender == FEMALE && prob(50))	//50% chance for females to roll to wear dresses
				uniform = pick(/obj/item/clothing/under/dress/sundress/white, /obj/item/clothing/under/suit/black/female/skirt, /obj/item/clothing/under/dress/littleblack, /obj/item/clothing/under/dress/flower)
			else	//Non-female, or missed the 50% roll, get normal clothes.
				uniform = pick(/obj/item/clothing/under/pants/jeanripped, /obj/item/clothing/under/pants/track, /obj/item/clothing/under/misc/greyshirt, /obj/item/clothing/under/*FINISH*/)
			if(prob(10))
				belt = pickweight(list(/obj/item/pickaxe = 8, /obj/item/pickaxe/mini = 4, /obj/item/pickaxe/silver = 2, /obj/item/pickaxe/diamond = 1))	//CHANGE THESE
			if(prob(50))
				shoes = pick(/obj/item/clothing/shoes/laceup, /obj/item/clothing/shoes/workboots, /obj/item/clothing/shoes/sandal, -1)
			if(prob(4))
				gloves = pick(/obj/item/clothing/gloves/fingerless, /obj/item/clothing/gloves/ring/silver)
			if(prob(20) || uniform == /obj/item/clothing/under/pants)	//Random suit chance, or if the uniform is topless. This society needed to learn to #FtT
				suit = pickweight(list(/obj/item/clothing/suit/toggle/jacket = 10, /obj/item/clothing/suit/toggle/jacket/flannel = 10, /obj/item/clothing/suit/storage/toggle/hoodie = 10, /obj/item/clothing/suit/storage/toggle/hoodie/red = 10, /obj/item/clothing/suit/storage/toggle/hoodie/green = 10, /obj/item/clothing/suit/hawaiian_purple = 5))
			if(prob(30))
				r_pocket = pickweight(list(/obj/item/stack/spacecash/c1000 = 7, /obj/item/storage/wallet = 10))
			if(prob(10))
				l_pocket = pickweight(list(/obj/item/stack/spacecash/c1000 = 7, /obj/item/storage/box/matches = 10, /obj/item/pda = 10))
		if("Service") //Service workers, from garbage to kitchen staff
			if(prob(30))
				r_pocket = pickweight(list(/obj/item/stack/spacecash/c1000 = 7, /obj/item/soap = 10))
			var/s_job = pick("Janitor", "Garbage", "Chef", "Clerk", "Pizza")
			switch(s_job)
				if("Janitor")
					uniform = /obj/item/clothing/under/rank/civilian/janitor
					if(prob(10))
						gloves = /obj/item/clothing/gloves/color/latex
					if(prob(70))
						head = /obj/item/clothing/head/soft/purple
				if("Garbage")
					uniform = /obj/item/clothing/under/color/garbage_green
					if(prob(10))
						gloves = /obj/item/clothing/gloves/color/latex
				if("Chef")
					uniform = /obj/item/clothing/under/rank/civilian/chef
					if(prob(10))
						gloves = /obj/item/clothing/gloves/color/latex
					if(prob(70))
						head = /obj/item/clothing/head/chefhat
					if(prob(10))
						l_pocket = /obj/item/kitchen/knife
				if("Clerk")
					uniform = /obj/item/clothing/under/suit/waiter
				if("Pizza")	//Annoying that all the items mention it being Dogginos but idc
					uniform = /obj/item/clothing/under/pizza
					suit = /obj/item/clothing/suit/pizzahoodie
					if(prob(70))
						head = /obj/item/clothing/head/soft/red
		if("Businessman") //Desk job workers or, rarely, rich people
			if(prob(45))
				shoes = /obj/item/clothing/shoes/laceup
			if(prob(10))	//Rich person
				uniform = pick(/obj/item/clothing/under/suit/black, /obj/item/clothing/under/suit/charcoal, /obj/item/clothing/under/suit/beige)
				gloves = pick(/obj/item/clothing/gloves/ring/silver, /obj/item/clothing/gloves/ring)
				l_pocket = /obj/item/stack/spacecash/c1000
			else
				uniform = pick(/obj/item/clothing/under/rank/civilian/lawyer/bluesuit, /obj/item/clothing/under/rank/civilian/lawyer/purpsuit, /obj/item/clothing/under/suit/waiter)
		if("Engineer")	//Construction Crew
			var/e_job = pick("Mechanic", "Firefighter", "Construction")
			if(prob(40))
				shoes = /obj/item/clothing/shoes/workboots
			if(prob(35))
				belt = /obj/item/storage/belt/utility/full
			switch(e_job)
				if("Mechanic")
					uniform = pick(/obj/item/clothing/under/misc/mechanic, /obj/item/clothing/under/color/mechanic_blue)
					if(prob(10))
						gloves = /obj/item/clothing/gloves/color/latex
					if(prob(70))
						head = /obj/item/clothing/head/soft/purple
				if("Firefighter")
					uniform = pick(/obj/item/clothing/under/utility/haz_green, /obj/item/clothing/under/rank/engineering/engineer/hazard)
					if(prob(75))
						suit = /obj/item/clothing/suit/fire/firefighter
					head = /obj/item/clothing/head/hardhat/red
					if(prob(30))
						mask = /obj/item/clothing/mask/gas
						suit_store = /obj/item/tank/internals/oxygen/red
					l_pocket = /obj/item/extinguisher/mini
				if("Construction")
					uniform = pick(/obj/item/clothing/under/rank/engineering/engineer/hazard, /obj/item/clothing/under/misc/greyshirt, /obj/item/clothing/under/pants/jeans,  /obj/item/clothing/under/misc/overalls)
					if(prob(30))
						gloves = /obj/item/clothing/gloves/fingerless
					if(prob(30))
						suit = /obj/item/clothing/suit/hazardvest
					if(prob(40))
						head = pickweight(list(/obj/item/clothing/head/hardhat/orange = 30, /obj/item/clothing/head/welding = 20, /obj/item/clothing/head/hardhat/dblue = 5))
		if("Doctor")	//From Pharmacists to Paramedics
			var/m_job = pick("Pharmacist", "Nurse", "Surgeon", "Paramedic")
			shoes = /obj/item/clothing/shoes/sneakers/white
			switch(m_job)
				if("Pharmacist")
					uniform = /obj/item/clothing/under/misc/greyshirt
					suit = /obj/item/clothing/suit/toggle/labcoat/chemist
					if(prob(15))
						l_pocket = /obj/item/storage/pill_bottle/happinesspsych
				if("Nurse")
					uniform = /obj/item/clothing/under/rank/medical/doctor/blue
				if("Surgeon")
					uniform = /obj/item/clothing/under/rank/medical/doctor/green
					if(prob(30))
						suit = pick(/obj/item/clothing/suit/toggle/labcoat, /obj/item/clothing/suit/apron/surgical)
					if(prob(30))
						gloves = /obj/item/clothing/gloves/color/latex/nitrile
						mask = /obj/item/clothing/mask/surgical
					if(prob(15))
						back = /obj/item/storage/backpack/duffelbag/med/surgery
				if("Paramedic")
					uniform = /obj/item/clothing/under/rank/medical/paramedic
					back = /obj/item/storage/backpack/duffelbag/med
					if(prob(30))
						suit = /obj/item/clothing/suit/toggle/labcoat/paramedic
						head = /obj/item/clothing/head/soft/paramedic
					if(prob(30))
						gloves = /obj/item/clothing/gloves/color/latex/nitrile
						mask = /obj/item/clothing/mask/surgical
					if(prob(15))
						back = /obj/item/storage/backpack/duffelbag/med/surgery
		/*
		if("Mimic")
			//Concept: rare chance to spawn a Weaver_Spawn on death. Look into how to code that.
			//Add it to the list with military/operative/cultist if this concept goes thru
		*/
		/*
		//NYI - Military loot, no guns, small armor. Mostly for force-use in ruins.
		if("Military")
			glasses = /obj/item/clothing/glasses/blindfold
			mask = /obj/item/clothing/mask/breath
			neck = /obj/item/clothing/accessory/medal/plasma/nobel_science
			uniform = /obj/item/clothing/under/color/black
			suit = /obj/item/clothing/suit/toggle/labcoat
			shoes = /obj/item/clothing/shoes/sneakers/black
			r_pocket = /obj/item/reagent_containers/pill/shadowtoxin
			back = /obj/item/tank/internals/oxygen
		*/
		if("Operative") //Unchanged from lavaland's cultist (Changes will be considered though)
			outfit = /datum/outfit/syndicatecommandocorpse
		if("Cultist")	//Unchanged from lavaland's cultist
			uniform = /obj/item/clothing/under/costume/roman
			suit = /obj/item/clothing/suit/hooded/cultrobes
			suit_store = /obj/item/tome
			r_pocket = /obj/item/restraints/legcuffs/bola/cult
			l_pocket = /obj/item/melee/cultblade/dagger
			glasses =  /obj/item/clothing/glasses/hud/health/night/cultblind
			backpack_contents = list(/obj/item/reagent_containers/glass/beaker/unholywater = 1, /obj/item/cult_shift = 1, /obj/item/flashlight/flare/culttorch = 1, /obj/item/stack/sheet/runed_metal = 15)
	. = ..()

//--- OLDWORLD ROBOTS
//--- Rebalance/reskin of the hivebot, for the Factory ruin. Sprites from [Ashen Sky]
/mob/living/simple_animal/hostile/hivebot/rapid/oldworld
	name = "ancient drone"
	desc = "A small robot, as simple as a gun on treads. Whatever its original intention, its targeting systems have gone off entirely - consider it hostile."
	health = 20
	maxHealth = 20
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_mobs.dmi'
	icon_state = "guntrack"
	icon_living = "guntrack"
	icon_dead = "guntrack"

/mob/living/simple_animal/hostile/hivebot/oldworld
	name = "ancient robot"
	desc = "A medium bipedal robot, assumedly for heavy lifting. With its haywire systems, it's sharpened its gripping claws into blades."
	health = 50
	maxHealth = 50
	melee_damage_lower = 2
	melee_damage_upper = 5
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_mobs.dmi'
	icon_state = "bipod"
	icon_living = "bipod"
	icon_dead = "bipod"
	ranged = TRUE

//////////////
//DROPS
//////////////
/obj/item/clothing/under/color/garbage_green	//Literally just a color variant
	name = "garbage-man's jumpsuit"
	greyscale_colors = "#5e6d45"

/obj/item/clothing/under/color/mechanic_blue	//Literally just a color variant
	name = "mechanic's jumpsuit"
	greyscale_colors = "#49576d"

//////////////
//EFFECTS
//////////////
//--- SLIDER
//--- Trail the slider leaves as it teleports, point a to b, fades. Not Yet Sprited


//--- WEAVER/SPAWN DEATH
//--- A burst as the black form simply explodes and dissipates. Not Yet Sprited
//--- To-be-implemented in every mention of "dark_gib"
