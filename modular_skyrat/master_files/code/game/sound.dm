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
			if(SFX_BULLET_IMPACT_METAL) // This is the one that will be used most, it is extensive.
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
			if("punch")
				soundin = pick('modular_skyrat/master_files/sound/weapons/punch1.ogg', 'modular_skyrat/master_files/sound/weapons/punch3.ogg')
			if ("explosion")
				soundin = pick(
					'modular_skyrat/modules/black_mesa/sound/explosions/explode1.ogg',
					'modular_skyrat/modules/black_mesa/sound/explosions/explode2.ogg',
					'modular_skyrat/modules/black_mesa/sound/explosions/explode3.ogg',
					'modular_skyrat/modules/black_mesa/sound/explosions/explode4.ogg',
					'modular_skyrat/modules/black_mesa/sound/explosions/explode5.ogg',
					'modular_skyrat/modules/black_mesa/sound/explosions/explode6.ogg',
					'modular_skyrat/modules/black_mesa/sound/explosions/explode7.ogg',
				)
	return soundin

// This is an atom level variable to prevent extensive typechecking for impacts.
/atom
	// The sound we make if hit.
	var/impact_sound = SFX_BULLET_IMPACT_METAL


// TURFS
/turf/closed/wall/ice
	impact_sound = SFX_BULLET_IMPACT_ICE

/turf/closed/wall/mineral/snow
	impact_sound = SFX_BULLET_IMPACT_ICE

/turf/closed/wall/mineral/wood
	impact_sound = SFX_BULLET_IMPACT_WOOD

/turf/closed/wall/mineral/bamboo
	impact_sound = SFX_BULLET_IMPACT_WOOD

/turf/closed/wall/mineral/sandstone
	impact_sound = SFX_BULLET_IMPACT_CONCRETE

/turf/closed/wall/vault/rock
	impact_sound = SFX_BULLET_IMPACT_CONCRETE

/turf/closed/wall/vault/sandstone
	impact_sound = SFX_BULLET_IMPACT_CONCRETE

/turf/closed/wall/rock
	impact_sound = SFX_BULLET_IMPACT_CONCRETE

/turf/closed/wall/mineral/diamond
	impact_sound = SFX_BULLET_IMPACT_GLASS

/turf/closed/wall/mineral/plasma
	impact_sound = SFX_BULLET_IMPACT_GLASS

// MOBS
/mob/living
	impact_sound = SFX_BULLET_IMPACT_FLESH

// STRUCTURES
/obj/structure/window
	impact_sound = SFX_BULLET_IMPACT_GLASS

/obj/structure/table/glass
	impact_sound = SFX_BULLET_IMPACT_GLASS

/obj/structure/table/reinforced/rglass
	impact_sound = SFX_BULLET_IMPACT_GLASS

/obj/structure/table/reinforced/plasmarglass
	impact_sound = SFX_BULLET_IMPACT_GLASS

/obj/structure/table/reinforced/plastitaniumglass
	impact_sound = SFX_BULLET_IMPACT_GLASS

/obj/structure/table/reinforced/titaniumglass
	impact_sound = SFX_BULLET_IMPACT_GLASS

/obj/structure/table/wood
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/structure/barricade/wooden
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/structure/chair/wood
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/structure/closet/crate/wooden
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/structure/door_assembly/door_assembly_wood
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/structure/falsewall/wood
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/structure/table_frame/wood
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/structure/deployable_barricade/wooden
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/structure/statue/snow
	impact_sound = SFX_BULLET_IMPACT_ICE

/obj/structure/deployable_barricade/snow
	impact_sound = SFX_BULLET_IMPACT_ICE



// MACHINERY
/obj/machinery/door/window
	impact_sound = SFX_BULLET_IMPACT_GLASS

/obj/machinery/computer
	impact_sound = SFX_BULLET_IMPACT_GLASS

/obj/machinery/door/airlock/wood
	impact_sound = SFX_BULLET_IMPACT_WOOD

/obj/machinery/computer/security/wooden_tv
	impact_sound = SFX_BULLET_IMPACT_WOOD

