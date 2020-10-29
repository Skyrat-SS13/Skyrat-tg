/mob/living/simple_animal/hostile/megafauna/dragon
	songs = list("1860" = sound(file = 'modular_skyrat/modules/skyrat_mining/sound/ambience/duskcreations.ogg', repeat = 0, wait = 0, volume = 70, channel = CHANNEL_JUKEBOX), "2350" = sound(file = 'modular_skyrat/modules/skyrat_mining/sound/ambience/dragonborn.ogg', repeat = 0, wait = 0, volume = 70, channel = CHANNEL_JUKEBOX)) // Andrew is a nice guy, he'll let it slide. Taken from the DUSK OST. Not sure about the skyrim theme though...
	glorymessageshand = list("climbs atop the drake's head as it dangles weakly near the ground, ripping its left horn off and jumping down before swinging it at the drake's face full force, cracking its maw!", "goes around the dragon and rips off their tail, using it's spiked end to beat the dragon's bloodied face until it cracks open and it dies!")
	glorymessagescrusher = list("chops off the dragon's head by the neck, and it falls down with a strong thud!", "rams into the dragon's skull with the hilt of their crusher repeatedly and cracking holes into their skull each time, turning it's brain into mush!")
	glorymessagespka = list("shoots at the dragon's wings with their PKA, exploding them into bizarre giblets! They then finish the poor creature off with a point-blank blast to the head, exploding it!")
	glorymessagespkabayonet = list("goes around the drake and chops off their tail's spike with their bayonet, then climbs onto their head and makes them eat it!")

/mob/living/simple_animal/hostile/megafauna/dragon/lesser/akatosh
	name = "Holy Dragon"
	desc = "Destroyer of the gates."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/lavaland/drake_greyscale.dmi'
	icon_state = "dragon"
	maxHealth = 350
	health = 350
	color = "#FFFF00"
	light_range = 3
	light_color = "#FFFF00"
	light_power = 2
	faction = list("neutral")