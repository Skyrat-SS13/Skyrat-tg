//armor
/obj/item/clothing/suit/armor/reagent_clothing
	name = "chain armor"
	desc = "A piece of armor made out of chains, ready to be imbued with a chemical."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "chain_armor"
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing.dmi'
	resistance_flags = FIRE_PROOF
	var/list/imbued_reagent = list()
	var/world_pausing = 0
	mutant_variants = NONE

/obj/item/clothing/suit/armor/reagent_clothing/Initialize()
	. = ..()
	create_reagents(500, INJECTABLE | REFILLABLE)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/armor/reagent_clothing/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/suit/armor/reagent_clothing/process()
	if(world_pausing >= world.time)
		return
	world_pausing = world.time + 2 SECONDS
	if(!imbued_reagent.len || !ishuman(loc))
		return
	var/mob/living/carbon/human/humanMob = loc
	if(!humanMob.wear_suit != src)
		return
	for(var/reagentList in imbued_reagent)
		humanMob.reagents.add_reagent(reagentList, 0.5)

//gloves
/obj/item/clothing/gloves/reagent_clothing
	name = "chain gloves"
	desc = "A set of gloves made out of chains, ready to be imbued with a chemical."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_clothing.dmi'
	icon_state = "chain_glove"
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_clothing.dmi'
	resistance_flags = FIRE_PROOF
	var/list/imbued_reagent = list()
	var/world_pausing = 0
	mutant_variants = NONE

/obj/item/clothing/gloves/reagent_clothing/Initialize()
	. = ..()
	create_reagents(500, INJECTABLE | REFILLABLE)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/gloves/reagent_clothing/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/gloves/reagent_clothing/process()
	if(world_pausing >= world.time)
		return
	world_pausing = world.time + 2 SECONDS
	if(!imbued_reagent.len || !ishuman(loc))
		return
	var/mob/living/carbon/human/humanMob = loc
	if(humanMob.gloves != src)
		return
	for(var/reagentList in imbued_reagent)
		humanMob.reagents.add_reagent(reagentList, 0.5)
