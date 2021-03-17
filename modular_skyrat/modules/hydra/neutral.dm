/datum/quirk/hydra
	name = "Trio Hydra Heads!"
	desc = "As a hydra, you speak through your independant heads. Or rather, as yourselves. (Seperate the names like Name - Name2 - Name3 without the brackets. MAKE SURE TO PRESERVE SPACING)"
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = "<span class='notice'>You have minds that can speak independantly.</span>"
	lose_text = "<span class='danger'>All your minds has merged into one.</span>"
	medical_record_text = "There are multiple minds inhabiting one body."
	var/selected_head

/datum/action/innate/hydra
	name = "Switch head"
	desc = "Switch between each of the heads on your body."
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydra/Activate(mob/living/carbon/human/H)	//I would hope putting this here is fine.
	var/list/names = splittext(H.real_name," - ") //FUCK FUCK FUCK FUCK
	var/choice = alert(src, "Select Hydra Head", "", names[1], names[2], names[3])

	if(choice == names[1])
		H.name = names[1]

	else if(choice == names[2])
		H.name = names[2]

	else if(choice == names[3]) //CODER NOTE. NEVER DO THIS UNLESS YOU DO NOT WANT THE ALTERNATIVE, WHICH IS STORING THIS IN A VARIABLE INSTEAD OF A LIST.
		H.name = names[3]

	else
		to_chat(src, "<span class='notice'>You lack any other heads!.</span>")


