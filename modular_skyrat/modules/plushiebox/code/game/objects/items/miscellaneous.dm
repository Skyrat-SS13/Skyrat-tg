/obj/item/choice_beacon/box/plushie
	name = "choice beacon (plushie)"
	desc = "Summons a plushie with this beacon"
	icon_state = "gangtool-blue"

/obj/item/choice_beacon/box/spawn_option(choice,mob/living/M)
	..()

/obj/item/choice_beacon/box/plushie/generate_display_names() // Lol, I'm not touching that.
	var/list/plushie_list = list()
	//plushie set 1: just subtypes of /obj/item/toy/plush
	var/list/plushies_set_one = subtypesof(/obj/item/toy/plush) - list(/obj/item/toy/plush/narplush, /obj/item/toy/plush/awakenedplushie, /obj/item/toy/plush/ratplush)
	for(var/V in plushies_set_one)
		var/atom/A = V
		plushie_list[initial(A.name)] = A
	return plushie_list
