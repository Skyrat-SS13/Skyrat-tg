/obj/item/strangerock
	icon = 'modular_skyrat/modules/xenoarch/icons/obj/artifacts.dmi'
	name = "strange rock"
	desc = "This is a strange rock, it appears to have a relic encased."
	icon_state = "strange"

	//chosen from the artifact_list.dm
	var/chosenitem = null

	/*here is a small thing to explain the vars
	[|||||:::::]
	there are 10 characters, so imagine that the characters are the depth.
	since there is 10 depth, this means the base depth is 10.
	since there are 5 colons (:), that means that the safe depth is 5.
	each of those colons are possible positions that the relic can be.
	*/

	var/itemsafedepth = null
	var/itembasedepth = null
	var/itemactualdepth = null

	var/dugdepth = null

	//the var that stops spamming
	var/tryagain = null

/obj/item/strangerock/Initialize()
	icon_state = pick("strange","strange0","strange1","strange2","strange3")
	var/randomnumber = rand(1,100)
	switch(randomnumber)
		if(1 to 69)
			chosenitem = pickweight(GLOB.bas_artifact)
		if(70 to 99)
			chosenitem = pickweight(GLOB.adv_artifact)
		if(100)
			chosenitem = pickweight(GLOB.ult_artifact)
	itembasedepth = rand(30,100)
	itemsafedepth = rand(5,20)
	itemactualdepth = rand(itembasedepth - itemsafedepth,itembasedepth)
	dugdepth = rand(0,10)
	..()

/obj/item/strangerock/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/xenoarch/clean/hammer))

		if(tryagain)
			to_chat(user,"You are already mining this.")
			return

		tryagain = TRUE

		var/obj/item/xenoarch/clean/hammer/HM = W

		playsound(loc, HM.usesound, 50, 1, -1)

		if(!do_after(user,HM.cleanspeed,target = src))
			to_chat(user,"You must stand still to clean.")
			tryagain = FALSE
			return

		dugdepth += HM.cleandepth

		playsound(loc, HM.usesound, 50, 1, -1)

		if(dugdepth > itemactualdepth)
			to_chat(user,"The strange rock crumbles, destroying anything that could have been recovered.")
			qdel(src)
			return

		tryagain = FALSE

	if(istype(W, /obj/item/xenoarch/clean/brush))
		if(tryagain)
			to_chat(user,"You are already mining this.")
			return

		tryagain = TRUE

		var/obj/item/xenoarch/clean/brush/HM = W

		playsound(loc, HM.usesound, 50, 1, -1)

		if(!do_after(user,HM.brushspeed,target = src))
			to_chat(user,"You must stand still to clean.")
			tryagain = FALSE
			return

		if(dugdepth < itemactualdepth)
			dugdepth++
			playsound(loc, HM.usesound, 50, 1, -1)
			to_chat(user,"You brush away 1cm of debris.")
			tryagain = FALSE
			return

		if(dugdepth > itemactualdepth)
			to_chat(user,"You somehow managed to destroy a strange rock with a brush... good job?")
			qdel(src)
			return

		if(dugdepth == itemactualdepth)
			new chosenitem(get_turf(src))
			playsound(loc, HM.usesound, 50, 1, -1)
			to_chat(user,"You uncover an artifact!")
			qdel(src)
			return

	if(istype(W, /obj/item/xenoarch/help/measuring))
		var/obj/item/xenoarch/help/measuring/HM = W

		playsound(loc, HM.usesound, 50, 1, -1)

		if(!do_after(user,10,target = src))
			to_chat(user,"You must stand still to measure.")
			return

		if(!dugdepth)
			to_chat(user,"This rock has not been touched.")
			playsound(loc, HM.usesound, 50, 1, -1)
			return

		to_chat(user,"Current depth dug: [dugdepth] centimeters.")

		playsound(loc, HM.usesound, 50, 1, -1)

/turf/closed/mineral/strange
	mineralType = /obj/item/strangerock
	mineralAmt = 1
	scan_state = "rock_Strange"

/turf/closed/mineral/random/volcanic/New()
	mineralSpawnChanceList += list(/turf/closed/mineral/strange = 15)
	. = ..()
