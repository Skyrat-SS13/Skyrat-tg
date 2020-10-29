/mob/living/simple_animal/hostile/megafauna/colossus
	songs = list("1170" = sound(file = 'modular_skyrat/modules/skyrat_mining/sound/ambience/theopenedway.ogg', repeat = 0, wait = 0, volume = 70, channel = CHANNEL_JUKEBOX)) //Shadow of the colossus OST
	glorymessageshand = list("grabs the colossus by the leg, and pulls them down! While downed, they climb on his neck and violently rip off their vocal cords!", "goes around the colossus and climbs them by their back, once on top of their shoulder they grab it's arm and aim the blaster at the creature's head, which finishes itself off with a penetrating death bolt that blasts off their head!")
	glorymessagescrusher = list("throws their crusher at the colossus' head, which surprisingly works! Humiliated, the angelic creature dies with a big fucking axe stuck on their skull!", "chops off one of the colossus' legs with the crusher, as it falls down they grab the leg and use it as a makeshift club on the creature's head, which explodes in differently-sized giblets on impact!")
	glorymessagespka = list("somehow parries a death bolt with a PKA blast, which goes right back to it's owner's torso, opening a hole on them and killing them!")
	glorymessagespkabayonet = list("goes around the colossus and climbs on their back, ramming their bayonet on it's spine and falling down holding it, pretty much gruesomely opening the colossus' back!")

/mob/living/simple_animal/hostile/megafauna/colossus/enrage(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.mind)
			if(istype(H.mind.martial_art, /datum/martial_art/the_sleeping_carp))
				. = TRUE
		if(is_species(H, /datum/species/golem/sand))
			. = TRUE
