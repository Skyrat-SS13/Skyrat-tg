/obj/item/organ/internal/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	gender = PLURAL
	organ_tag = BP_KIDNEYS
	parent_organ = BP_GROIN
	min_bruised_damage = 25
	min_broken_damage = 45
	max_damage = 70

/obj/item/organ/internal/kidneys/robotize()
	. = ..()
	icon_state = "kidneys-prosthetic"


//Undead version for necromorphs
/obj/item/organ/internal/kidneys/undead
	parent_organ = BP_CHEST

/obj/item/organ/internal/kidneys/undead/Initialize()
	.=..()
	die()

/obj/item/organ/internal/kidneys/undead/is_broken()
	return FALSE //This prevents necromorphs taking damage


/obj/item/organ/internal/kidneys/undead/is_bruised()
	return FALSE //This prevents necromorphs taking damage

/obj/item/organ/internal/kidneys/undead/is_usable()
	return TRUE

/obj/item/organ/internal/kidneys/undead/getToxLoss()
	return 0



/obj/item/organ/internal/kidneys/Process()
	..()

	if(!owner)
		return

	var/bruised = is_bruised()
	var/broken = is_broken()
	if (!bruised && !broken)
		return

	// Coffee is really bad for you with busted kidneys.
	// This should probably be expanded in some way, but fucked if I know
	// what else kidneys can process in our reagent list.
	var/datum/reagent/coffee = locate(/datum/reagent/drink/coffee) in owner.reagents.reagent_list
	if(coffee)
		if(bruised)
			owner.adjustToxLoss(0.1)
		else if(broken)
			owner.adjustToxLoss(0.3)

	if(bruised)
		if(prob(5) && reagents.get_reagent_amount(/datum/reagent/potassium) < 5)
			reagents.add_reagent(/datum/reagent/potassium, REM*5)
	if(broken)
		if(owner.reagents.get_reagent_amount(/datum/reagent/potassium) < 15)
			owner.reagents.add_reagent(/datum/reagent/potassium, REM*2)

	//If your kidneys aren't working, your body's going to have a hard time cleaning your blood.
	if(!owner.chem_effects[CE_ANTITOX])
		if(prob(33))
			if(broken)
				owner.adjustToxLoss(0.5)
			if(status & ORGAN_DEAD)
				owner.adjustToxLoss(1)


