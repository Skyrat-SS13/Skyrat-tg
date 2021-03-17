/datum/quirk/hydra
	name = "Hydra Heads"
	desc = "You are a tri-headed creature. To use, format name like (Fucks-Sucks-Ducks)"
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = "<span class='notice'>You hear two other voices inside of your head(s).</span>"
	lose_text = "<span class='danger'>All of your minds become singular.</span>"
	medical_record_text = "There are multiple minds inhabiting one body."
	var/selected_head

/datum/quirk/hydra/on_spawn(mob/living/carbon/human/H)
	var/datum/action/innate/hydra/A = new
	A.owner = H
	A.Grant(H)

/datum/action/innate/hydra
	name = "Switch head"
	desc = "Switch between each of the heads on your body."
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydra/Activate(mob/living/carbon/human/H)	//I would hope putting this here is fine.
	var/list/names = splittext(H.real_name,"-") //FUCK FUCK FUCK FUCK
	var/selhead = input("Who would you like to speak as?","Heads:") in names
	switch(names.Find(selhead))
		if(1)
			H.name = names[1]
		if(2)
			H.name = names[2]
		if(3)
			H.name = names[3]
	return