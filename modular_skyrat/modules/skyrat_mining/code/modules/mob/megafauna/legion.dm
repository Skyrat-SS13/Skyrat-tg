/mob/living/simple_animal/hostile/megafauna/legion
	loot = list(/obj/item/stack/sheet/bone = 3)
	songs = list("3550" = sound(file = 'modular_skyrat/modules/skyrat_mining/sound/ambience/mastermind.ogg', repeat = 0, wait = 0, volume = 70, channel = CHANNEL_JUKEBOX), "1360" = sound(file = 'modular_skyrat/modules/skyrat_mining/sound/ambience/terrariaboss1.ogg', repeat = 0, wait = 0, volume = 70, channel = CHANNEL_JUKEBOX), "1560" = sound('modular_skyrat/modules/skyrat_mining/sound/ambience/megalovania.ogg', repeat = 0, wait = 0, volume = 70, channel = CHANNEL_JUKEBOX)) //Threading on some lines here with the DOOM 16 OST. But terraria should be fine, megalovania too.
	glorymessageshand = list("punches into the Legion's maw and rips off a floating skull, which they then proceed to use to bash the Legion until it dies!", "punches through both of the Legion's eyeholes with both hands, ripping out a bunch of tiny skulls and killing it!")
	glorymessagescrusher = list("slashes the Legion's maw, which falls on the ground as it dies!")
	glorymessagespka = list("parries a floating legion skulls with a pka shoot, which goes flying violently into the Legion, bursting through them and killing them in the process!")
	glorymessagespkabayonet = list("repeatedly stabs through the Legion's eyesocket, pulling out a bunch of dead skulls in the process and killing it!")
	glorythreshold = 50

/mob/living/simple_animal/hostile/megafauna/legion/death()
	if(health > 0)
		return
	if(size > 1)
		adjustHealth(-maxHealth) //heal ourself to full in prep for splitting
		var/mob/living/simple_animal/hostile/megafauna/legion/L = new(loc)

		L.maxHealth = round(maxHealth * 0.6,DAMAGE_PRECISION)
		maxHealth = L.maxHealth

		L.health = L.maxHealth
		health = maxHealth

		size--
		L.size = size

		L.resize = L.size * 0.2
		transform = initial(transform)
		resize = size * 0.2

		L.update_transform()
		update_transform()

		L.faction = faction.Copy()

		L.GiveTarget(target)

		visible_message("<span class='boldannounce'>[src] splits in twain!</span>")
	else
		var/last_legion = TRUE
		for(var/mob/living/simple_animal/hostile/megafauna/legion/other in GLOB.mob_living_list)
			if(other != src)
				last_legion = FALSE
				break
		if(last_legion)
			loot = list(/obj/structure/closet/crate/necropolis/legion)
			elimination = 0
		else if(prob(20))
			loot = list(/obj/structure/closet/crate/necropolis/tendril/legion_loot)
		..()
