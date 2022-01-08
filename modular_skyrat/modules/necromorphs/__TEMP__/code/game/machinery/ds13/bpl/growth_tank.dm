
/*
	The growth tank is where organs are created

	Fetuses can be grown using only biomass
	Limbs and organs require stem cells, which are harvested from fetuses (as well as more biomass)
*/
/obj/machinery/growth_tank
	name = "growth tank"
	desc = "A vat for growing organic components."
	icon = 'icons/obj/machines/ds13/bpl.dmi'
	icon_state = "base"

	var/max_biomass = 150	//1.5 Litre
	var/current_biomass

	var/obj/item/organ/current_growth_atom

	//If true, we are currently growing something
	//This is false when the tank is empty, and also false when the contained organ has finished its growth and is just being maintained
	var/forming = FALSE

	//The growth tank can only contain certain kinds of reagents, got to remain pure
	var/list/valid_reagents = list(/datum/reagent/nutriment/biomass,
	/datum/reagent/nutriment/stemcells)	//TODO: Add stem cells and blood to this

	var/growth_rate = 1.2	//This many units of refined biomass are added to the forming organ each tick

	var/efficiency = 0.9	//Some of the biomass is wasted

	//Two tanks can be stacked vertically
	var/upper = FALSE

	var/ticks = 0
	density = TRUE
	anchored = TRUE

	var/icon_updating = FALSE


/obj/machinery/growth_tank/Initialize()
	create_reagents(max_biomass)
	//If we find another tank in our turf, put ourselves ontop of it
	for (var/obj/machinery/growth_tank/GT in loc)
		if (GT != src && GT.upper == FALSE)
			upper = TRUE
			default_pixel_y = 24
			pixel_y = 24
			break

	turn_off()
	.=..()

/obj/machinery/growth_tank/examine(var/mob/user)
	.=..()
	if (current_growth_atom)
		if (forming)
			var/obj/item/organ/forming/F = current_growth_atom
			to_chat(user, "It is currently growing [F]")
			var/growth_progress = growth_progress()
			to_chat(user, "Growth progress is [round(growth_progress*100,0.1)]%")
			var/total_time = (F.target_biomass / (growth_rate * REAGENT_TO_BIOMASS)) * SSmachines.wait
			var/remaining_time = total_time * (1 - growth_progress)
			to_chat(user, "Estimated time remaining is [time2text(remaining_time, "mm:ss")]")


		var/biomass_percent = get_stored_biomass() / max_biomass
		if (biomass_percent <= 0.6)
			if (biomass_percent > 0.3)
				to_chat(user, SPAN_WARNING("The yellow warning light indicates biomass is below 60% and should be replenished."))
			else if (biomass_percent > 0)
				to_chat(user, SPAN_WARNING("The orange warning light indicates biomass is below 30% and must be replenished urgently."))
			else
				//The blinking red light appears when biomass has completely run out. At this point, the contained atom takes damage until it starves to death
				to_chat(user, SPAN_DANGER("The red warning light indicates there is no biomass remaining, the organ inside is starving to death and will lose viability soon."))
		else
			//If biomass is fine, then lets show some other lights
			if (istype(current_growth_atom, /obj/item/organ/forming))
				//If the current growth thing is not done growing, then lets display a non-attention-grabbing still green light
				to_chat(user, "The green light indicates it is functioning normally, no action needed.")
			else
				//Its finished growing, lets have a flashy light to attract attention
				to_chat(user, SPAN_NOTICE("The flashing green light indicates that growth is complete, the organ within is ready for harvesting or implantation"))
	else
		to_chat(user, "The light is off, it is not currently operating.")


/obj/machinery/growth_tank/is_open_container()
	return TRUE

/obj/machinery/growth_tank/on_reagent_change(var/reagent_type, var/delta)
	. = ..()
	update_current_biomass()
	playsound(src, "bubble_small", VOLUME_LOW)

/obj/machinery/growth_tank/proc/update_current_biomass()
	current_biomass = reagents.get_reagent_amount(/datum/reagent/nutriment/biomass)
	if (stat && current_biomass && forming)
		if (!turn_on())
			update_icon()
		return
	update_icon()


/obj/machinery/growth_tank/proc/growth_progress()
	if (!current_growth_atom)
		return 0.0

	if (forming && istype(current_growth_atom, /obj/item/organ/forming))
		var/obj/item/organ/forming/F = current_growth_atom
		return (F.biomass / F.target_biomass)
	else
		return 1.0

/obj/machinery/growth_tank/proc/turn_off()
	//We're already turned off
	if (HAS_FLAGS(stat, POWEROFF))
		return

	SET_FLAGS(stat, POWEROFF)

	//Tell the organ to start dying
	if (current_growth_atom)
		current_growth_atom.preserved = FALSE

	update_icon()

/obj/machinery/growth_tank/proc/turn_on()
	//If stat is 0 we're turned on
	if (!stat)
		return FALSE

	//We're only on when something is inside us and we have a nonzero quantity of biomass
	if (!current_growth_atom || !current_biomass)
		turn_off()
		return FALSE

	CLEAR_FLAGS(stat, POWEROFF)
	START_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)

	update_icon()
	return TRUE

/obj/machinery/growth_tank/Process()
	ticks++
	if (HAS_FLAGS(stat, POWEROFF))
		return PROCESS_KILL

	//If we have no biomass we do nothing
	if (!current_biomass || !current_growth_atom)
		turn_off()
		return

	//If we're growing something, try to consume some biomass and add it to the growing attom
	if (forming)
		var/change = reagents.remove_reagent(/datum/reagent/nutriment/biomass, growth_rate)

		if (change)
			current_growth_atom.adjust_biomass(abs(change) * REAGENT_TO_BIOMASS * efficiency)

		if (change != growth_rate)
			biomass_exhausted()

		//We'll update the icon once every ten seconds to save processing
		if (!(ticks % 10))
			update_icon()

		if (growth_progress() >= 1.0)
			finish_growing()



//Called if we run out of biomass while growing things
/obj/machinery/growth_tank/proc/biomass_exhausted()
	turn_off()


/obj/machinery/growth_tank/update_icon()
	if (icon_updating)
		return
	icon_updating = TRUE
	sleep(rand(10,30))
	overlays.Cut()
	underlays.Cut()

	var/biomass_percent = get_stored_biomass() / max_biomass
	var/liquid_color = BlendRGB("#e5ffb2", COLOR_BIOMASS_GREEN, biomass_percent)

	var/image/I

	if (current_growth_atom)
		//TODO here: Atom for the thing growing in the tank
		I = image(icon, src, current_growth_atom.get_growth_state())

		//Partially grown things are smaller
		if (forming && istype(current_growth_atom, /obj/item/organ/forming))
			var/obj/item/organ/forming/F = current_growth_atom
			var/growth_progress = F.biomass / F.target_biomass
			I.transform = I.transform.Scale(Interpolate(0.2, 1, growth_progress))
		I.transform = I.transform.Turn(rand_between(-10, 10))	//Slight random rotation
		I.pixel_x += rand_between(-3, 3)
		I.pixel_y += rand_between(-3, 3)
		I.alpha = 220	//Slightly less than full opacity so some of the green liquid is visible
		underlays += I


		//First of all, biomass warning lights
		if (biomass_percent <= 0.6)
			if (biomass_percent > 0.3)
				overlays += image(icon, src, "light_yellow")
			else if (biomass_percent > 0)
				overlays += image(icon, src, "light_orange")
			else
				//The blinking red light appears when biomass has completely run out. At this point, the contained atom takes damage until it starves to death
				overlays += image(icon, src, "light_red")
				playsound(src, 'sound/machines/tankdanger.ogg', VOLUME_MID)
		else
			//If biomass is fine, then lets show some other lights
			if (istype(current_growth_atom, /obj/item/organ/forming))
				//If the current growth thing is not done growing, then lets display a non-attention-grabbing still green light
				overlays += image(icon, src, "light_green")
			else
				//Its finished growing, lets have a flashy light to attract attention
				overlays += image(icon, src, "light_green_flashing")
	else
		//Nothing currently growing, the light turns off
		overlays += image(icon, src, "light_off")

	//The liquid becomes more sickly pale as biomass depletes
	I = image(icon, src, "pod_liquid_grayscale")
	I.color = liquid_color
	underlays += I



	I = image(icon, src, "gradient_grayscale")
	I.color = liquid_color
	I.alpha = 190
	overlays += I

	I = image(icon, src, pick("bubbles1", "bubbles2", "bubbles3"))
	I.color = liquid_color
	overlays += I

	I = image(icon, src, "shine")
	I.color = liquid_color
	I.alpha = 220
	overlays += I


	icon_updating = FALSE


/obj/machinery/growth_tank/proc/get_stored_biomass()
	return reagents.get_reagent_amount(/datum/reagent/nutriment/biomass)


/*
	If empty, allows selecting a thing to grow
	Otherwise, allows ejecting the currently growing organ
*/
/obj/machinery/growth_tank/proc/show_menu(var/mob/user)

	if (current_growth_atom)
		//Lets check if the thing we're growing is a multiple-variant thing
		var/obj/item/organ/forming/F = current_growth_atom
		var/ready = TRUE
		if (istype(F))
			ready = FALSE
			var/list/data = GLOB.bpl_growth_organs[F.template]
			if (islist(data["type"]))
				var/list/choices = data["type"]
				var/choice = input(user, "The [current_growth_atom] can grow in one of several ways, you must choose one to complete it.\
There's no need to make this choice right now, if you cancel it will carry on growing, and the decision can be made just before you take it out of the tank",
"Choose Growth Variant") as null|anything in choices
				if(!choice)
					return


				//Set the selected variant
				F.selected_variant = choice

				//If we were just waiting on ths final answer, finish the growth now
				if (F.biomass >= F.target_biomass)
					finish_growing()

				return
			else
				ready = FALSE

		//We spawn a new completed organ to replace the forming one
		var/choice = tgui_alert(user, "The [current_growth_atom] is [ready? "finished growing and ready for use" : "not yet at a viable growth stage.\n If you remove it now, it will just be a useless lump of biomass."]\n\
		Do you wish to eject it?", "Eject Growth Product", list("Remove from Tank", "Leave it in"))
		if (choice == "Remove from Tank")
			remove_product(user)
			playsound(src, "bubble", VOLUME_LOW)

	else
		//Selecting a product to grow!
		var/choice = input(user,"Choose an organ to grow. All organs require biomass and stem cells.","Organ Growth Selection") as null|anything in GLOB.bpl_growth_organs
		if (!choice)
			return

		start_growing(choice, user)


/obj/machinery/growth_tank/proc/start_growing(var/choice, var/mob/user)
	if (!QDELETED(current_growth_atom) && current_growth_atom.loc == src)
		return

	var/list/data = GLOB.bpl_growth_organs[choice]
	var/stemcell_cost = data["stemcells"]
	if (isnum(stemcell_cost))
		if (!pay_stemcells(stemcell_cost))
			to_chat(user, "This product requires [stemcell_cost]u of stem cells, grow, harvest and pour in some first!")
			return FALSE
	current_growth_atom = new /obj/item/organ/forming(src, choice)
	forming = TRUE
	playsound(src, "bubble", VOLUME_LOW)
	turn_on()


/obj/machinery/growth_tank/proc/finish_growing()
	var/obj/item/organ/forming/F = current_growth_atom
	forming = FALSE
	playsound(src, 'sound/machines/tankconfirm.ogg', VOLUME_MID)
	if (istype(F))	//Should never be false but just in case

		//We spawn a new completed organ to replace the forming one
		var/list/data = GLOB.bpl_growth_organs[F.template]
		var/newtype = data["type"]

		//Type may be a list of variants
		if (islist(newtype))
			//If the user hasn't selected a variant, abort for now. They will be asked to select one when they attempt to eject it
			if(!F.selected_variant)
				update_icon()
				return

			var/list/types = data["type"]
			newtype = types[F.selected_variant]


		var/obj/item/organ/O = new newtype(src)
		O.biomass = F.biomass
		F = null
		QDEL_NULL(current_growth_atom)
		current_growth_atom = O


	update_icon()

/obj/machinery/growth_tank/proc/remove_product(var/mob/living/carbon/human/user)
	forming = FALSE
	if (!current_growth_atom)
		return

	if (user)
		current_growth_atom.forceMove(user.loc)
		user.put_in_hands(current_growth_atom)
	else
		current_growth_atom.forceMove(loc)


	//No longer being kept alive
	current_growth_atom.preserved = FALSE
	current_growth_atom = null
	turn_off()
	update_icon()

/obj/machinery/growth_tank/proc/pay_stemcells(stemcell_cost)
	if (!stemcell_cost)
		return TRUE

	var/current_stemcells = reagents.get_reagent_amount(/datum/reagent/nutriment/stemcells)
	if (current_stemcells < stemcell_cost)
		return FALSE

	reagents.remove_reagent(/datum/reagent/nutriment/stemcells, stemcell_cost)
	return TRUE


/*
	Interaction
*/
/obj/machinery/growth_tank/attack_hand(var/mob/living/carbon/human/user)
	show_menu(user)



/obj/machinery/growth_tank/can_harvest_biomass()
	return MASS_READY

/obj/machinery/growth_tank/harvest_biomass()
	return BIOMASS_HARVEST_LARGE



/obj/item/weapon/reagent_containers/glass/bucket/infinite_biomass/Initialize()
	. = ..()
	reagents.maximum_volume = 1000000
	reagents.add_reagent(/datum/reagent/nutriment/biomass, 100000)