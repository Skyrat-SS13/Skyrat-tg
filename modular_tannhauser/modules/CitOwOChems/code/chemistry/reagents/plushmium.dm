////////////////////////////////////////////////////////////////////////////////////////////////////
//										PLUSHMIUM
///////////////////////////////////////////////////////////////////////////////////////////////////
//A chemical you can spray on plushies to turn them into a 'shell'
//Hugging the plushie turns yourself into the plushie!
/datum/reagent/OwO/plushmium
	name = "Plushmium"
	description = "A strange chemical, seeming almost fluffy, if it were not for it being a liquid. Known to have a strange effect on plushies."
	color = "#fbcbd7"
	taste_description = "the tang of a smurf in a blender"
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

///datum/reagent/OwO/plushmium/reaction_obj(obj/O, reac_volume)
/datum/reagent/OwO/plushmium/expose_obj(obj/O, reac_volume)
	if(istype(O, /obj/item/toy/plush) && reac_volume >= 5)
		O.loc.visible_message("<span class='warning'>The plushie seems to be staring back at you.</span>")
		var/obj/item/toy/plushie_shell/new_shell = new /obj/item/toy/plushie_shell(O.loc)
		new_shell.name = O.name
		new_shell.icon = O.icon
		new_shell.icon_state = O.icon_state
		new_shell.stored_plush = O
		O.forceMove(new_shell)
	. = ..()

//Extra interaction for which spraying it on an existing sentient plushie aheals them, so they can be revived!
/datum/reagent/OwO/plushmium/expose_mob(mob/living/M, method = TOUCH, reac_volume)
	if(istype(M, /mob/living/simple_animal/pet/plushie) && reac_volume >= 1)
		M.revive(full_heal = 1, admin_revive = 1)
	. = ..()
