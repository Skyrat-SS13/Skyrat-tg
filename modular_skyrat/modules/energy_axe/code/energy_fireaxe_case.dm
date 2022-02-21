/obj/structure/closet/secure_closet/ds2atmos
	name = "energy axe cabinet"
	desc = "A cabinet storing an energy fire axe along with basic firefighting tools."
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "riot"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/secure_closet/ds2atmos/PopulateContents()
	..()
	new /obj/item/fireaxe/energy(src)
	new /obj/item/extinguisher/advanced(src)
	new /obj/item/extinguisher/advanced(src)
	new /obj/item/clothing/suit/fire/atmos(src)
	new /obj/item/tank/internals/oxygen/red(src)
