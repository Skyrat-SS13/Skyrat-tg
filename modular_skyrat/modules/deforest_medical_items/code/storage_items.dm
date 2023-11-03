// Bottle of painkiller pills

/obj/item/storage/pill_bottle/painkiller
	name = "amollin pill bottle"
	desc = "It's an airtight container for storing medication. This one is all-white and has labels for containing amollin, a common painkiller."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "painkiller_bottle"

/obj/item/storage/pill_bottle/painkiller/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/amollin(src)

/obj/item/reagent_containers/pill/amollin
	name = "amollin pill"
	desc = "Neutralizes many common pains and ailments."
	icon_state = "pill9"
	list_reagents = list(
		/datum/reagent/medicine/mine_salve = 10,
		/datum/reagent/medicine/lidocaine = 5,
		/datum/reagent/consumable/sugar = 5,
	)

// Pre-packed civil defense medkit, with items to heal low damages inside, and painkillers as a treat

/obj/item/storage/medkit/civil_defense
	name = "civil defense medical kit"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "poisoning_kit"
	inhand_icon_state = "medkit-ointment"
	desc = "A small sized kit that should hopefully come pre-packed with anti-poisoning equipment of various types, as well as treatment for low level damage."

/obj/item/storage/medkit/civil_defense/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5

/obj/item/storage/medkit/civil_defense/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 1,
		/obj/item/storage/pill_bottle/painkiller = 1,
	)
	generate_items_inside(items_inside,src)

// Pre-packed frontier medkit, with supplies to repair most common frontier health issues

/obj/item/storage/medkit/frontier
	name = "frontier medical kit"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "frontier"
	inhand_icon_state = "medkit-tactical"
	desc = "A handy roll-top waterproof medkit often seen alongside those on the frontier, where medical support is less than optimal."

/obj/item/storage/medkit/frontier/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 1,
		/obj/item/stack/medical/wound_recovery/rapid_coagulant = 1,
		/obj/item/stack/medical/suture/coagulant = 1,
		/obj/item/stack/medical/gauze/sterilized = 1,
		/obj/item/storage/pill_bottle/painkiller = 1,
	)
	generate_items_inside(items_inside,src)

// Pre-packed combat surgeon medkit, with items for fixing more specific injuries and wounds

/obj/item/storage/medkit/combat_surgeon
	name = "combat surgeon medical kit"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "surgeon"
	inhand_icon_state = "medkit-tactical"
	desc = "A folding kit that is ideally filled with surgical tools and specialized treatment options for many harder-to-treat wounds."

/obj/item/storage/medkit/combat_surgeon/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL

/obj/item/storage/medkit/combat_surgeon/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/bonesetter = 1,
		/obj/item/hemostat = 1,
		/obj/item/cautery = 1,
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/suture/coagulant = 1,
		/obj/item/stack/medical/gauze/sterilized = 1,
		/obj/item/storage/pill_bottle/painkiller = 1,
	)
	generate_items_inside(items_inside,src)
