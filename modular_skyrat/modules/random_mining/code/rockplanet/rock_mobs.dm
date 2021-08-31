//*******************Contains everything related to the fauna on Rockplanet.*******************************
//*************For sorting sake, all mobs contained will have LV669_ prefixing their name******************
//////////////
//MOBS
//////////////

//--- SLIDER
//--- Unique mob, idly and offensively teleports around, leaves an ethereal trail when it does. Very spooky, not all that threatening unless you're caught off-guard
//TODO - Drops???
//TODO - Find something to subtype it off of?
//TODO - Sandstorm-proofing
//Sprites are modified from [STALKER13]
/mob/living/simple_animal/hostile/LV669_slider
	name = "slider"
	desc = "An anomalous shadowy figure, wandering between the layers of reality, phasing in and out randomly. Their eyes, or whatever's possessing their eyesockets, seem almost sad..."
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_mobs.dmi'
	icon_state = "slider"
	icon_living = "slider"
	//icon_aggro = "slider" //Not yet implemented due to the fact the lack of subtype = it doesnt exist
	icon_dead = "slider_dead"
	icon_gib = "dark_gib"
	loot = /obj/item/pizzabox	//TODO: loot

/mob/living/simple_animal/hostile/LV669_slider/Initialize() //Randomly chooses which appearance to use
	. = ..()
	var/random_icon = pick("", "_1", "_2", "_3")
	icon_state += random_icon
	icon_living += random_icon
	//icon_aggro += random_icon	//Not yet implemented due to the fact the lack of subtype = it doesnt exist

//--- WEAVER
//--- Reskin/rebalance of the hivelord, creates SPAWN instead
//TODO - Drops???
//TODO - Sprites
//TODO - Sandstorm-proofing
/mob/living/simple_animal/hostile/asteroid/hivelord/LV669_weaver
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
	brood_type = /mob/living/simple_animal/hostile/asteroid/hivelordbrood/LV669_weaver_spawn

//--- SPAWN
//--- (??? WIP CONCEPT, EXPECT CHANGE) Reskin/rebalance of the hivelord brood |OR| Reskin/rebalance of Headcrabs, weavers can spawn max 3-to-5
//TODO - Drops???
//TODO - Sprites
//TODO - Sandstorm-proofing
/mob/living/simple_animal/hostile/asteroid/hivelordbrood/LV669_weaver_spawn
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
--- issue with redoing it to headcrabs as the base-type; hivelord OpenFire() proc uses hivelordbrood subtype; will need to overwrite so it spawns the correct mob?
/mob/living/simple_animal/hostile/asteroid/hivelordbrood/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/death), 100)
	AddElement(/datum/element/simple_flying)
	AddComponent(/datum/component/swarming)
*/



/*
LOST BULLSHIT, PLEASE IGNORE


//--- LOST HUSK
//--- Reskin/rebalance of the zombie, less vibrant green, and civilian random equipment (military variant?)
//TODO - Actual mob. Drops need balancing, but will be a randomly selected outfit
//TODO - make it DIE and have the loot ON IT, instead of needing this random corpse bullshit
//TODO - Sandstorm-proofing

/mob/living/simple_animal/hostile/zombie/LV669_lost
	zombiejob = "Civilian"
	loot = list(/obj/effect/mob_spawn/human/corpse/damaged/LV669_lost)


/mob/living/simple_animal/hostile/zombie/LV669_lost/random/Initialize()
	. = ..()
	zombiejob = pickweight(list("Civilian" = 66, "Service" = 8, "Businessman" = 8, "Engineer" = 8, "Doctor" = 6, pick(list("Military", "Operative", "Cultist")) = 4))	//Add "Mimic" to mil-op-cult list if/when implemented
	if(zombiejob == "Civilian")
		lost_subjob = pick("CivA", "CivB", "CivC", "CivD", "CivE")
		loot = /obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/civ/[lost_subjob]
	if(zombiejob == "Service")
		lost_subjob = pickweight("CivA", "CivB", "CivC", "CivD", "CivE")
		loot = /obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/civ/[lost_subjob]
	if(zombiejob == "Businessman")
		lost_subjob = pickweight("CivA", "CivB", "CivC", "CivD", "CivE")
		loot = /obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/civ/[lost_subjob]
	if(zombiejob == "Engineer")
		loot = /obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/civ/[lost_subjob]
	if(zombiejob == "Doctor")
		lost_subjob = pickweight("CivA", "CivB", "CivC", "CivD", "CivE")
		loot = /obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/civ/[lost_subjob]
	if(zombiejob == "Military")
		lost_subjob = pickweight("CivA", "CivB", "CivC", "CivD", "CivE")
		loot = /obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/civ/[lost_subjob]
	if(zombiejob == "Operative")
		lost_subjob = pickweight("CivA", "CivB", "CivC", "CivD", "CivE")
		loot = /obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/civ/[lost_subjob]
	if(zombiejob == "Cultist")
		lost_subjob = pickweight("CivA", "CivB", "CivC", "CivD", "CivE")
		loot = /obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/civ/[lost_subjob]

/obj/effect/mob_spawn/human/corpse/damaged/LV669_lost
	mob_color = "#cdd4a5"	//Dilutes the color to always look like the lost husk
	var/lost_jobtype	//mirror to the mob's lost_subjob


/obj/effect/mob_spawn/human/corpse/damaged/LV669_lost/Initialize()	//Sets the 'job', determining loot and clothing
	if(!lost_jobtype)
		lost_jobtype = pickweight(list("Civilian" = 66, "Service" = 8, "Businessman" = 8, "Engineer" = 8, "Doctor" = 6, pick(list("Military", "Operative", "Cultist")) = 4))
	mob_species = /datum/species/human	//Always humans, the planet died before reaching spaceage/meeting alien life

	shoes = -1	//Unless its overwritten, they dont have shoes
	switch(type)
		if("Civilian")	//Most common, just everyday civilians. Also the most randomized.
			if(mob_gender == FEMALE && prob(50))	//50% chance for females to roll to wear dresses
				uniform = pick(/obj/item/clothing/under/dress/sundress/white, /obj/item/clothing/under/suit/black/female/skirt, /obj/item/clothing/under/dress/littleblack, /obj/item/clothing/under/dress/flower)
			else	//Non-female, or missed the 50% roll, get normal clothes.
				uniform = pick(/obj/item/clothing/under/pants/jeanripped, /obj/item/clothing/under/pants/track, /obj/item/clothing/under/misc/greyshirt)	//More variety?
			if(prob(10))
				belt = pickweight(list(/obj/item/pickaxe = 8, /obj/item/pickaxe/mini = 4, /obj/item/pickaxe/silver = 2, /obj/item/pickaxe/diamond = 1))	//CHANGE THESE
			if(prob(50))
				shoes = pick(/obj/item/clothing/shoes/sneakers/black, /obj/item/clothing/shoes/laceup, /obj/item/clothing/shoes/workboots, /obj/item/clothing/shoes/sandal)
			if(prob(4))
				gloves = pick(/obj/item/clothing/gloves/fingerless, /obj/item/clothing/gloves/ring/silver)
			if(prob(20) || uniform == /obj/item/clothing/under/pants)	//Random suit chance, or forced if the uniform is a topless one. This society needed to learn to #FtT
				suit = pickweight(list(/obj/item/clothing/suit/toggle/jacket = 10, /obj/item/clothing/suit/toggle/jacket/flannel = 10, /obj/item/clothing/suit/storage/toggle/hoodie = 10, /obj/item/clothing/suit/storage/toggle/hoodie/red = 10, /obj/item/clothing/suit/storage/toggle/hoodie/green = 10, /obj/item/clothing/suit/hawaiian_purple = 5))
			if(prob(30))
				r_pocket = pickweight(list(/obj/item/stack/spacecash/c1000 = 7, /obj/item/storage/wallet = 10))
			if(prob(10))
				l_pocket = pickweight(list(/obj/item/stack/spacecash/c1000 = 7, /obj/item/storage/box/matches = 10, /obj/item/pda = 10))
		if("Service") //Service workers, from garbage to kitchen staff
			if(prob(30))
				r_pocket = pickweight(list(/obj/item/stack/spacecash/c1000 = 7, /obj/item/soap = 10))
			var/s_job = pickweight(list("Janitor" = 10, "Garbage" = 10, "Chef" = 10, "Clerk" = 20, "Mechanic" = 10, "Firefighter" = 15, "Pizza" = 5))
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
					if(prob(50))
						shoes = pick(/obj/item/clothing/shoes/sneakers/black, /obj/item/clothing/shoes/laceup)
					uniform = /obj/item/clothing/under/suit/waiter
				if("Mechanic")
					if(prob(40))
						shoes = /obj/item/clothing/shoes/workboots
					if(prob(35))
						belt = /obj/item/storage/belt/utility/full
					uniform = pick(/obj/item/clothing/under/misc/mechanic, /obj/item/clothing/under/color/mechanic_blue)
					if(prob(10))
						gloves = /obj/item/clothing/gloves/color/latex
					if(prob(70))
						head = /obj/item/clothing/head/soft/purple
				if("Firefighter")
					if(prob(40))
						shoes = /obj/item/clothing/shoes/workboots
					if(prob(35))
						belt = /obj/item/storage/belt/utility/full
					uniform = pick(/obj/item/clothing/under/utility/haz_green, /obj/item/clothing/under/rank/engineering/engineer/hazard)
					if(prob(75))
						suit = /obj/item/clothing/suit/fire/firefighter
					head = /obj/item/clothing/head/hardhat/red
					if(prob(30))
						mask = /obj/item/clothing/mask/gas
						suit_store = /obj/item/tank/internals/oxygen/red
					l_pocket = /obj/item/extinguisher/mini
				if("Pizza")	//Annoying that all the items mention it being Dogginos but idc
					uniform = /obj/item/clothing/under/pizza
					suit = /obj/item/clothing/suit/pizzahoodie
					back = /obj/item/storage/backpack/satchel/leather
					if(prob(20))
						backpack_contents = pickweight(list(/obj/item/pizzabox = 10, /obj/item/pizzabox/margherita = 5, /obj/item/pizzabox/mushroom= 5, /obj/item/pizzabox/meat= 10, /obj/item/pizzabox/vegetable= 5, /obj/item/pizzabox/pineapple= 5))
					if(prob(70))
						head = /obj/item/clothing/head/soft/red
		if("Businessman") //Desk job workers or, rarely, rich people
			if(prob(45))
				shoes = /obj/item/clothing/shoes/laceup
			if(prob(10))	//Rich person
				uniform = pick(/obj/item/clothing/under/suit/black, /obj/item/clothing/under/suit/charcoal, /obj/item/clothing/under/suit/beige)
				gloves = pick(/obj/item/clothing/gloves/ring/silver, /obj/item/clothing/gloves/ring)
				l_pocket = /obj/item/stack/spacecash/c1000
				r_pocket = /obj/item/phone //What? There's no proper cellphones in the code, so i get to improvise. Its funny. Laugh.
			else
				uniform = pick(/obj/item/clothing/under/rank/civilian/lawyer/bluesuit, /obj/item/clothing/under/rank/civilian/lawyer/purpsuit, /obj/item/clothing/under/suit/waiter)
		if("Engineer")	//Construction Crew
			if(prob(40))
				shoes = /obj/item/clothing/shoes/workboots
			if(prob(35))
				belt = /obj/item/storage/belt/utility/full
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
		//NYI - Military loot, no guns, small armor. Mostly for forced-use in ruins, to add flavor.
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

END LOST BULLSHIT
*/

//--- OLDWORLD ROBOTS
//--- Rebalance/reskin of the hivebot, for the Factory ruin. Sprites from [Ashen Sky]
/mob/living/simple_animal/hostile/hivebot/rapid/LV669_oldworld
	name = "ancient drone"
	desc = "A small robot, as simple as a gun on treads. Whatever its original intention, its targeting systems have gone off entirely - consider it hostile."
	health = 20
	maxHealth = 20
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_mobs.dmi'
	icon_state = "guntrack"
	icon_living = "guntrack"
	icon_dead = "guntrack"

/mob/living/simple_animal/hostile/hivebot/LV669_oldworld
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
