/obj/item/clothing/under/colonial/nri_police
	name = "imperial police outfit"
	desc = "Fancy blue durathread shirt and a pair of cotton-blend pants with a black synthleather belt. A time-tested design first employed by the NRI police's \
	precursor organisation, Rim-world Colonial Militia, now utilised by them as a tribute."
	icon_state = "under_police"
	armor_type = /datum/armor/clothing_under/rank_security
	strip_delay = 5 SECONDS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	can_adjust = FALSE

/obj/item/clothing/neck/cloak/colonial/nri_police
	name = "imperial police cloak"
	desc = "A cloak made from heavy tarpaulin. Nigh wind- and waterproof thanks to its design. The signature white rectangle of the NRI police covers the garment's back."
	icon_state = "cloak_police"

/obj/item/clothing/head/hats/colonial/nri_police
	name = "imperial police cap"
	desc = "A puffy cap made out of tarpaulin covered by some textile. It is sturdy and comfortable, and seems to retain its form very well. <br>\
		Silver NRI police insignia is woven right above its visor."
	icon_state = "cap_police"
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/mask/gas/nri_police
	name = "imperial police mask"
	desc = "A close-fitting tactical mask."
	icon = 'modular_skyrat/modules/novaya_ert/icons/mask.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/wornmask.dmi'
	worn_icon_digi = 'modular_skyrat/modules/novaya_ert/icons/wornmask_digi.dmi'
	icon_state = "nri_police"
	inhand_icon_state = "swat"
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	visor_flags_inv = 0
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF

/obj/item/clothing/head/helmet/nri_police
	name = "imperial police helmet"
	desc = "Thick-looking tactical helmet made out of shaped Plasteel. Colored dark blue, similar to one imperial police is commonly using."
	icon_state = "police_helmet"
	icon = 'modular_skyrat/modules/novaya_ert/icons/armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/wornarmor.dmi'

/obj/item/clothing/suit/armor/vest/nri_police
	name = "imperial police plate carrier"
	desc = "A reasonably heavy, yet comfortable armor vest comprised of a bunch of dense plates. Colored dark blue and bears a reflective stripe on the front and back."
	icon_state = "police_vest"
	icon = 'modular_skyrat/modules/novaya_ert/icons/armor.dmi'
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/wornarmor.dmi'
