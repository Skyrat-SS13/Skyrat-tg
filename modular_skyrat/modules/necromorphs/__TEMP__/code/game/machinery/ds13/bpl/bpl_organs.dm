/obj/item/organ/proc/get_growth_state()
	for (var/thing in GLOB.bpl_growth_organs)
		var/list/data = GLOB.bpl_growth_organs[thing]
		if (islist(data["type"]))
			var/list/types = data["type"]
			for (var/t in types)
				if (istype(src, types[t]))
					return data["icon"]
		else
			if (istype(src, data["type"]))
				return data["icon"]


/*
	A generic organ used to represent something in the growth tank which hasn't finished growing yet
*/

/obj/item/organ/forming
	var/template	//Name of the limb we're growing into, used to draw data from GLOB.bpl_growth_organs
	var/target_biomass	//When our biomass is equal to this value, we have finished growing
	icon = 'icons/obj/machines/ds13/bpl.dmi'
	preserved = TRUE
	var/selected_variant = null	//Used in cases where there are multiple possible results, This can't finish growing until a user selects which variant to grow it into


/obj/item/organ/forming/New(var/location, var/template)

	src.template = template

	.=..()

/obj/item/organ/forming/Initialize()
	var/list/data = GLOB.bpl_growth_organs[template]
	icon_state = data ["icon"]
	name = data["name"]
	//Lets cache the target biomass
	var/obj/item/organ/O = data["type"]

	//In case of multiple variants, we will assume they all have the same biomass cost
	//We cache just the first one
	if (islist(data["type"]))
		var/list/types = data["type"]
		O = types[types[1]]
	target_biomass = initial(O.biomass)

/obj/item/organ/forming/adjust_biomass(var/change)
	biomass += change

/obj/item/organ/forming/get_growth_state()
	return icon_state



/obj/item/organ/fetus
	name = "fetus"
	desc = "a bundle of cells, probably nonsentient. You can use a syringe to extract stem cells from the spinal fluid"
	icon = 'icons/obj/machines/ds13/bpl.dmi'
	icon_state = "thing_still"
	biomass = 1


/obj/item/organ/fetus/Initialize()
	create_reagents(15)
	reagents.add_reagent(/datum/reagent/nutriment/stemcells, 15)
	.=..()