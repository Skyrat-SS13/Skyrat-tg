/**
 * Called from subsystem's PreInit and builds sprite_accessories list with (almost) all existing sprite accessories
 */
/datum/controller/subsystem/accessories/proc/make_sprite_accessory_references()
	for(var/path in subtypesof(/datum/sprite_accessory))
		var/datum/sprite_accessory/P = path
		if(initial(P.key) && initial(P.name))
			P = new path()
			if(!sprite_accessories[P.key])
				sprite_accessories[P.key] = list()
			sprite_accessories[P.key][P.name] = P
			if(P.genetic)
				if(!dna_mutant_bodypart_blocks[P.key])
					dna_mutant_bodypart_blocks[P.key] = dna_total_feature_blocks+1
				if(!genetic_accessories[P.key])
					genetic_accessories[P.key] = list()
					for(var/color_block in 1 to DNA_FEATURE_COLOR_BLOCKS_PER_FEATURE)
						features_block_lengths["[dna_mutant_bodypart_blocks[P.key] + color_block]"] = DNA_BLOCK_SIZE_COLOR
					dna_total_feature_blocks += DNA_BLOCKS_PER_FEATURE

				genetic_accessories[P.key] += P.name
			//TODO: Replace "generic" definitions with something better
			if(P.generic && !generic_accessories[P.key])
				generic_accessories[P.key] = P.generic
