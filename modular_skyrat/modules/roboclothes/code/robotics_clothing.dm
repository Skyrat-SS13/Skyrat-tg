/obj/item/clothing/suit/toggle/labcoat/roboticist
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "labcoat_robo_sr"

/obj/item/storage/backpack/science/robo
	name = "robotics backpack"
	desc = "A sleek, industrial-strength backpack issued to robotics personnel. Smells faintly of oil."
	icon = 'modular_skyrat/modules/roboclothes/icons/robobag_item.dmi'
	worn_icon = 'modular_skyrat/modules/roboclothes/icons/robobag_onmob.dmi'
	icon_state = "robopack"

/obj/item/storage/backpack/satchel/tox/robo
	name = "robotics satchel"
	desc = "A sleek, industrial-strength satchel issued to robotics personnel. Smells faintly of oil."
	icon = 'modular_skyrat/modules/roboclothes/icons/robobag_item.dmi'
	worn_icon = 'modular_skyrat/modules/roboclothes/icons/robobag_onmob.dmi'
	icon_state = "satchel-robo"

/obj/item/storage/backpack/duffelbag/robo
	name = "robotics duffelbag"
	desc = "A sleek, industrial-strength duffelbag issued to robotics personnel. Smells faintly of oil."
	icon = 'modular_skyrat/modules/roboclothes/icons/robobag_item.dmi'
	worn_icon = 'modular_skyrat/modules/roboclothes/icons/robobag_onmob.dmi'
	icon_state = "duffel-robo"

/obj/item/storage/backpack/duffelbag/robo/surgery
	name = "robotics surgery duffelbag"
	desc = "A sleek, industrial-strength duffelbag issued to robotics personnel. This one seems to be designed for holding surgical tools."

/obj/item/storage/backpack/duffelbag/robo/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/suit/toggle/labcoat/hospitalgown(src)	//SKYRAT EDIT ADDITION
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/razor(src)
	new /obj/item/blood_filter(src)
