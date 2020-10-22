//Original file is unticked from the DME, due to subtype changes would cause the whole file to be changed anyways
/mob/living/simple_animal/hostile/construct/shade
	name = "Shade"
	real_name = "Shade"
	desc = "A bound spirit."
	icon_state = "shade"
	icon_living = "shade"
	mob_biotypes = MOB_SPIRIT
	maxHealth = 40
	health = 40
	healable = FALSE
	emote_hear = list("wails.","screeches.")
	response_help_continuous = "puts their hand through"
	response_help_simple = "put your hand through"
	melee_damage_lower = 5
	melee_damage_upper = 12
	attack_verb_continuous = "metaphysically strikes"
	attack_verb_simple = "metaphysically strike"
	speed = -1 //they don't have to lug a body made of runed metal around
	movement_type = FLYING
	loot = list(/obj/item/ectoplasm)
	ventcrawler = VENTCRAWLER_ALWAYS
	playstyle_string = "<span class='big bold'>You are a shade!</span><b> Your job is to survive until you are granted a shell, and help out cultists with casting runes!</b>"

/mob/living/simple_animal/hostile/construct/shade/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)

/mob/living/simple_animal/hostile/construct/shade/death()
	deathmessage = "lets out a contented sigh as [p_their()] form unwinds."
	..()

/mob/living/simple_animal/hostile/construct/shade/canSuicide()
	if(istype(loc, /obj/item/soulstone)) //do not suicide inside the soulstone
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/construct/shade/attack_animal(mob/living/simple_animal/M)
	if(isconstruct(M))
		var/mob/living/simple_animal/hostile/construct/C = M
		if(!C.can_repair_constructs)
			return
		if(health < maxHealth)
			adjustHealth(-25)
			Beam(M,icon_state="sendbeam",time=4)
			M.visible_message("<span class='danger'>[M] heals \the <b>[src]</b>.</span>", \
					   "<span class='cult'>You heal <b>[src]</b>, leaving <b>[src]</b> at <b>[health]/[maxHealth]</b> health.</span>")
		else
			to_chat(M, "<span class='cult'>You cannot heal <b>[src]</b>, as [p_theyre()] unharmed!</span>")
	else if(src != M)
		return ..()

/mob/living/simple_animal/hostile/construct/shade/attackby(obj/item/O, mob/user, params)  //Marker -Agouri
	if(istype(O, /obj/item/soulstone))
		var/obj/item/soulstone/SS = O
		SS.transfer_soul("SHADE", src, user)
	else
		. = ..()
