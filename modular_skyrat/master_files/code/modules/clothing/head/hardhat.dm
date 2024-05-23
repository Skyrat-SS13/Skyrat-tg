/obj/item/clothing/head/utility/hardhat/welding
	/// The path to the visor sprite, used for muzzled visors
	var/visor_sprite_path

// Lets the visor not smush the snout
/obj/item/clothing/head/utility/hardhat/welding/adjust_visor(mob/living/user)
	. = ..()
	var/mob/living/carbon/carbon_user = user
	if(carbon_user.dna.species.mutant_bodyparts["snout"])
		visor_sprite_path = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	else
		visor_sprite_path = 'icons/mob/clothing/head/utility.dmi'
