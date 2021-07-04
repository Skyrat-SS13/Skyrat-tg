/obj/item/storage/firstaid/expeditionary
	name = "combat medical kit"
	desc = "I hope you've got insurance."
	icon_state = "bezerk"
	damagetype_healed = "all"

/obj/item/storage/firstaid/expeditionary/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/firstaid/expeditionary/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/defibrillator/compact/combat/loaded/nanotrasen(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
    new /obj/item/stack/medical/mesh/advanced(src)
    new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/clothing/glasses/hud/health/night(src)