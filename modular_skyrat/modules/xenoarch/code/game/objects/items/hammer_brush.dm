/obj/item/xenoarch
	name = "Parent Xenoarch"
	desc = "Debug. Parent Clean"
	icon = 'modular_skyrat/modules/xenoarch/icons/obj/tools.dmi'

/obj/item/xenoarch/Initialize()
	..()

/obj/item/xenoarch/clean/hammer
	name = "Parent hammer"
	desc = "Debug. Parent Hammer."
	var/cleandepth = 15
	var/cleanspeed = 15
	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')

/obj/item/xenoarch/clean/hammer/cm1
	name = "mining hammer cm1"
	desc = "removes 1cm of material."
	icon_state = "pick1"
	cleandepth = 1
	cleanspeed = 5

/obj/item/xenoarch/clean/hammer/cm2
	name = "mining hammer cm2"
	desc = "removes 2cm of material."
	icon_state = "pick2"
	cleandepth = 2
	cleanspeed = 10

/obj/item/xenoarch/clean/hammer/cm3
	name = "mining hammer cm3"
	desc = "removes 3cm of material."
	icon_state = "pick3"
	cleandepth = 3
	cleanspeed = 15

/obj/item/xenoarch/clean/hammer/cm4
	name = "mining hammer cm4"
	desc = "removes 4cm of material."
	icon_state = "pick4"
	cleandepth = 4
	cleanspeed = 20

/obj/item/xenoarch/clean/hammer/cm5
	name = "mining hammer cm5"
	desc = "removes 5cm of material."
	icon_state = "pick5"
	cleandepth = 5
	cleanspeed = 25

/obj/item/xenoarch/clean/hammer/cm6
	name = "mining hammer cm6"
	desc = "removes 6cm of material."
	icon_state = "pick6"
	cleandepth = 6
	cleanspeed = 30

/obj/item/xenoarch/clean/hammer/cm15
	name = "mining hammer cm15"
	desc = "removes 15cm of material."
	icon_state = "pick_hand"
	cleandepth = 15
	cleanspeed = 75

/obj/item/xenoarch/clean/hammer/advanced
	name = "advanced hammer"
	desc = "Removes a custom amount of debris."
	icon_state = "advpick"
	cleandepth = 30
	cleanspeed = 30
	usesound = 'sound/weapons/drill.ogg'

/obj/item/xenoarch/clean/hammer/advanced/attack_self(mob/living/carbon/user)
	var/depthchoice = input(user, "What depth would you like to mine with? (1-30)", "Change Dig Depth") as null|num
	if(depthchoice && (depthchoice > 0 && depthchoice <= 30))
		cleandepth = depthchoice
		cleanspeed = depthchoice
		desc = "Removes a custom amount of debris. It will dig [cleandepth] centimeters."
		to_chat(user, "<span class='notice'>You set the dig depth of the hammer to [cleandepth] centimeters.</span>")
//

/obj/item/xenoarch/clean/brush
	name = "mining brush"
	desc = "cleans off the remaining debris."
	icon_state = "pick_brush"
	var/brushspeed = 100
	usesound = 'sound/items/poster_ripped.ogg'

/obj/item/xenoarch/clean/brush/basic
	brushspeed = 50

/obj/item/xenoarch/clean/brush/adv
	name = "advanced mining brush"
	icon_state = "advbrush"
	brushspeed = 10

/obj/item/xenoarch/help/measuring
	name = "measuring tape"
	desc = "Measures how far a rock has been dug into."
	icon_state = "measuring"
	usesound = 'sound/items/poster_ripped.ogg'
