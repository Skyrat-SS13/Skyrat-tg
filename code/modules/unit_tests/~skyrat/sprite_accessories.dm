// Yea, I'm doing this. This shit annoys me too much. - Rimi
/datum/unit_test/sprite_accessories/Run()
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)
	var/datum/species/human/human_species = human.dna.species

	for(var/datum/sprite_accessory/sprite_accessory as anything in subtypesof(/datum/sprite_accessory))
		var/accessory_name = initial(sprite_accessory.name)
		var/accessory_icon_state = initial(sprite_accessory.icon_state)
		var/accessory_icon = initial(sprite_accessory.icon)
		var/accessory_key = initial(sprite_accessory.key)

		if(initial(sprite_accessory.factual) || !accessory_icon_state || accessory_icon_state == "none" || accessory_icon == 'icons/mob/species/mutant_bodyparts.dmi') // People will do custom stuff with non-factual sprites. Not touching those.
			continue

		if(!accessory_icon)
			TEST_FAIL("Null icon on factual accessory [accessory_name] ([sprite_accessory])!")
			continue
		if(!accessory_icon_state)
			TEST_FAIL("Null icon_state on factual accessory [accessory_name] ([sprite_accessory])!")
			continue
		if(!accessory_name)
			TEST_FAIL("Null name on factual accessory [accessory_name] ([sprite_accessory])!")

		for(var/gender_prefix in (initial(sprite_accessory.gender_specific)? list("m", "f") : list("m")))
			var/render_state

			if(initial(sprite_accessory.special_render_case))
				var/datum/sprite_accessory/sprite_accessory_instance = new sprite_accessory // Fine.
				render_state = sprite_accessory_instance.get_special_render_state(human)
				qdel(sprite_accessory_instance)
			else
				render_state = accessory_icon_state

			for(var/layer in initial(sprite_accessory.relevent_layers))
				var/layertext = human_species.mutant_bodyparts_layertext(layer)

				var/final_icon_state = "[gender_prefix]_[bodypart_accessory.get_special_render_key(owner)]_[render_state]_[layertext]"
				if(initial(sprite_accessory.color_src) == USE_MATRIXED_COLORS)
					final_icon_state += "_primary"

				if(!icon_exists(accessory_icon, final_icon_state))
					TEST_FAIL("Missing PRIMARY icon for [final_icon_state] in [accessory_icon_state] for factual sprite accessory [accessory_name] ([sprite_accessory])")

				if(initial(sprite_accessory.hasinner))
					final_icon_state = "[gender_prefix]_[accessory_key]inner_[accessory_icon_state]_[layertext]"

					if(!icon_exists(accessory_icon, final_icon_state))
						TEST_FAIL("Missing INNER icon for [final_icon_state] in [accessory_icon_state] for factual sprite accessory [accessory_name] ([sprite_accessory])")

				if(initial(sprite_accessory.extra))
					final_icon_state = "[gender_prefix]_[accessory_key]_extra_[accessory_icon_state]_[layertext]"
					if(!icon_exists(accessory_icon, final_icon_state))
						TEST_FAIL("Missing EXTRA icon for [final_icon_state] in [accessory_icon_state] for factual sprite accessory [accessory_name] ([sprite_accessory])")

				if(initial(sprite_accessory.extra2))
					final_icon_state = "[gender_prefix]_[accessory_key]_extra2_[accessory_icon_state]_[layertext]"
					if(!icon_exists(accessory_icon, final_icon_state))
						TEST_FAIL("Missing EXTRA2 icon for [final_icon_state] in [accessory_icon_state] for factual sprite accessory [accessory_name] ([sprite_accessory])")

