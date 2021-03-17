/datum/quirk/hydra
	name = "Hydra Heads"
	desc = "You are a tri-headed creature. To use, format name like (Fucks-Sucks-Ducks)"
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = "<span class='notice'>You hear two other voices inside of your head(s).</span>"
	lose_text = "<span class='danger'>All of your minds become singular.</span>"
	medical_record_text = "There are multiple heads and personalities affixed to one body."

/datum/quirk/hydra/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/action/innate/hydra/A = new
	var/datum/action/innate/hydrareset/B = new
	A.Grant(H)
	A.owner = H
	B.Grant(H)
	B.owner = H
	H.name_archive = H.real_name


/datum/action/innate/hydra
	name = "Switch head"
	desc = "Switch between each of the heads on your body."
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydrareset
	name = "Reset Speech"
	desc = "Go back to speaking as a whole."
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydrareset/Activate()
	var/mob/living/carbon/human/H = owner
	H.real_name = H.name_archive
	H.visible_message("<span class='notice'>[H.name] pushes all three heads forwards; they seem to be talking as a collective.</span>", \
							"<span class='notice'>You are now talking as [H.name_archive]!</span>", ignored_mobs=owner)

/datum/action/innate/hydra/Activate() //Oops, all hydra!
	var/mob/living/carbon/human/H = owner
	var/list/names = splittext(H.name_archive,"-")
	var/selhead = input("Who would you like to speak as?","Heads:") in names
	switch(names.Find(selhead))
		if(1)
			H.real_name = names[1]
		if(2)
			H.real_name = names[2]
		if(3)
			H.real_name = names[3]

	to_chat(H, "<span class='warning'>You are now talking as [selhead]</span>")
	H.visible_message("<span class='notice'>[H.name] pulls the rest of their heads back; and puts [selhead]'s forward.</span>", \
							"<span class='notice'>You are now talking as [selhead]!</span>", ignored_mobs=owner)
