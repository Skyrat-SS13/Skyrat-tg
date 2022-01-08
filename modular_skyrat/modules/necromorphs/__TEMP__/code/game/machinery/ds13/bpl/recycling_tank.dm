/*
	Recycling tanks recieve objects and chemicals which are organic in nature.
	These are gradually broken down into a chemical called Purified Biomass

	PB is used as food for the growth tank
*/
/obj/machinery/recycling_tank
	name = "recycling tank"
	desc = "A organic-breakdown machine that takes organic matter and turns it into a substance known simply as 'biomass' which it then automatically feeds into the storage tank next to it."
	icon = 'icons/obj/machines/ds13/bpl.dmi'
	icon_state = "biogen-empty"

	var/list/content_atoms = list()


	var/breakdown_rate = 0.002	//Remove this many units of biomass per tick, and convert it into purified biomass
	var/reagent_breakdown_rate = 0.065	//Remove this many units of reagents per tick and convert to biomass

	var/obj/structure/reagent_dispensers/biomass/storage
	density = TRUE
	anchored = TRUE

/obj/machinery/recycling_tank/Initialize()
	var/obj/structure/reagent_dispensers/biomass/temp = (locate(/obj/structure/reagent_dispensers/biomass) in orange(1, src))
	if(temp.recycle)
		storage = null
	else
		storage = temp
		storage.recycle = src
	create_reagents(1000)
	.=..()

/obj/machinery/recycling_tank/update_icon()
	if (stat)
		icon_state = "biogen-empty"
		return

	icon_state = "biogen-work"

/obj/machinery/recycling_tank/proc/turn_off()
	BITSET(stat, POWEROFF)
	update_icon()

/obj/machinery/recycling_tank/proc/turn_on()

	//We can't operate if our storage tank is full
	if (!get_biomass_space())
		return

	BITRESET(stat, POWEROFF)
	START_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)
	update_icon()

/obj/machinery/recycling_tank/Process()
	if (stat & POWEROFF)
		return PROCESS_KILL

	for (var/atom/A as anything in content_atoms)
		var/change = A.adjust_biomass(-breakdown_rate)
		add_purified_biomass(abs(change)*BIOMASS_TO_REAGENT)

		//Is valid will be false if we just consumed the last of the biomass
		if (!is_valid(A))
			content_atoms.Remove(A)
			qdel(A)
		if (stat & POWEROFF)
			break

	for (var/datum/reagent/R as anything in reagents.reagent_list)
		var/biomass_mult = R.biomass	//Cache this because R is likely to be deleted in the next step
		var/change = reagents.remove_reagent(R.type, reagent_breakdown_rate)
		if(biomass_mult)
			add_purified_biomass(abs(change)*biomass_mult*BIOMASS_TO_REAGENT)

	//If we've run out of things to breakdown, lets turn off
	if (!content_atoms.len && !reagents.reagent_list.len)
		turn_off()

/obj/machinery/recycling_tank/proc/add_purified_biomass(var/quantity)
	if (!storage)
		return FALSE

	storage.reagents.add_reagent(/datum/reagent/nutriment/biomass, quantity)
	if (storage.reagents.last_added_quantity != quantity)
		//If these don't match, the storage is full, we have overflow!
		turn_off()
		return FALSE

/obj/machinery/recycling_tank/is_open_container()
	return TRUE




/obj/machinery/recycling_tank/proc/is_valid(var/atom/test, var/mob/user)
	if (test.get_biomass())
		return TRUE
	else
		if (user)
			to_chat(user, "[test] is not organic, or contains no recoverable biomass.")
		return FALSE



/obj/machinery/recycling_tank/attackby(var/obj/item/I, var/mob/user)
	if(!I || !user)
		return

	add_fingerprint(user, 0, I)

	if(istype(I, /obj/item/weapon/storage))
		var/obj/item/weapon/storage/T = I
		for(var/obj/item/O in T.contents)
			if (is_valid(O, user))
				T.remove_from_storage(O,src)
				insert_atom(O, user)
		T.update_icon()

		return

	//With containers, you pour in the contents, assuming the container itself is non-organic
	//Requires there to be some organic component in the contents
	if (I.is_open_container() && !I.get_biomass() && I.reagents && I.reagents.get_biomass())
		var/obj/item/weapon/reagent_containers/RC = I
		RC.standard_pour_into(user, src, I.reagents.maximum_volume)
		turn_on()
		return

	try_insert_atom(I, user)



/obj/machinery/recycling_tank/proc/try_insert_atom(var/atom/A, var/mob/user)
	if(!is_valid(A, user))
		return

	if (A.loc == user)
		if(!user.unEquip(A, src))
			return

	insert_atom(A, user)


//This one doesnt do safety checks, and assumes the atom is on a turf or already in us
/obj/machinery/recycling_tank/proc/insert_atom(var/atom/movable/A, var/mob/user)
	A.forceMove(src)
	content_atoms |= A
	playsound(src, 'sound/machines/tankbiorecycle.ogg', VOLUME_LOW)
	if (user)
		user.visible_message("[user] places \the [A] into \the [src].")

	update_icon()

	turn_on()

/obj/machinery/recycling_tank/proc/get_biomass_space()
	if (!storage)
		return 0

	return storage.reagents.get_free_space()