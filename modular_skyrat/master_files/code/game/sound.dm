// This is an atom level variable to prevent extensive typechecking for impacts.
/atom
	// The sound we make if hit.
	var/impact_sound = SFX_BULLET_IMPACT_METAL

/proc/get_sfx_skyrat(soundin)
	if(istext(soundin))
		switch(soundin)
			if(SFX_KEYBOARD)
				soundin = pick(
					'modular_skyrat/modules/aesthetics/computer/sound/keypress1.ogg',
					'modular_skyrat/modules/aesthetics/computer/sound/keypress2.ogg',
					'modular_skyrat/modules/aesthetics/computer/sound/keypress3.ogg',
					'modular_skyrat/modules/aesthetics/computer/sound/keypress4.ogg',
					'modular_skyrat/modules/aesthetics/computer/sound/keystroke4.ogg',
				)
			if(SFX_BULLET_IMPACT_METAL) //This is the one that will be used most, it is extensive.
				soundin = pick(
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_01.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_02.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_03.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_04.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_05.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_06.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_07.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_08.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_09.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_10.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_11.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_12.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_13.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_14.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_15.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_16.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_metal_17.ogg',
				)
			if(SFX_BULLET_IMPACT_FLESH)
				soundin = pick(
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_01.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_02.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_03.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_04.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_05.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_06.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_07.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_08.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_flesh_09.ogg',
				)
			if(SFX_BULLET_IMPACT_ICE)
				soundin = pick(
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_01.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_02.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_03.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_04.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_05.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_06.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_07.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_08.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_09.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_snow_10.ogg',
				)
			if(SFX_BULLET_IMPACT_WOOD)
				soundin = pick(
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_01.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_02.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_03.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_04.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_05.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_06.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_07.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_08.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_09.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_wood_10.ogg',
				)
			if(SFX_BULLET_IMPACT_CONCRETE)
				soundin = pick(
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_01.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_02.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_03.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_04.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_05.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_06.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_07.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_08.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_09.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_masonry_10.ogg',
				)
			if(SFX_BULLET_IMPACT_GLASS)
				soundin = pick(
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_01.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_02.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_03.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_04.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_05.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_06.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_07.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_08.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_09.ogg',
					'modular_skyrat/modules/gunsgalore/sound/impact/impact_glass_10.ogg',
				)
	return soundin
