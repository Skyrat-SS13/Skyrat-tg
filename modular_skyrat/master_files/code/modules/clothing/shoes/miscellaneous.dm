/obj/item/clothing/shoes/jackboots/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/suitstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/suitstep2.ogg'=1), 50, falloff_exponent = 20)

/obj/item/clothing/shoes/jackboots/attackby(obj/item/W, mob/user, params)
	if(!can_interact(user))
		return
	if(istype(W, /obj/item/stack/sticky_tape))
		var/obj/item/stack/sticky_tape/T = W
		var/datum/component/squeak/annoyance = GetComponent(/datum/component/squeak)
		if(!annoyance)
			to_chat(user, "<span class='notice'>[src] have already been silenced!")
			return
		if(T.use(5))
			to_chat(user, "<span class='notice'>You tape [src] tightly together, reducing the sound they make as you walk.</span>")
			qdel(annoyance)
