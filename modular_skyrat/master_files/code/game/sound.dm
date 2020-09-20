/proc/get_sfx_skyrat(soundin)
	if(istext(soundin))
		switch(soundin)
			if ("explosion_creaking") // Skyrat addition
				soundin = pick('modular_skyrat/modules/explosions/sound/effects/explosioncreak1.ogg', 'modular_skyrat/modules/explosions/sound/effects/explosioncreak2.ogg')
			if ("hull_creaking") // Skyrat addition
				soundin = pick('modular_skyrat/modules/explosions/sound/effects/creak1.ogg', 'modular_skyrat/modules/explosions/sound/effects/creak2.ogg', 'modular_skyrat/modules/explosions/sound/effects/creak3.ogg')
	return soundin
