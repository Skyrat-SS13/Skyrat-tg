/obj/structure/sign/flag
	name = "blank flag"
	desc = "The flag of nothing. It has nothing on it. Magnificient."
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "flag_coder"

/obj/structure/sign/flag/ssc
	name = "flag of the Kingdom of Agurkrral"
	desc = "The flag of the Kingdom of Agurkrral."
	icon_state = "flag_agurk"

/obj/structure/sign/flag/terragov
	name = "flag of SolFed"
	desc = "The flag of SolFed. It's a symbol of humanity no matter where they go, or how much they wish it wasn't."
	icon_state = "flag_solfed"

/obj/structure/sign/flag/nri
	name = "flag of the Novaya Rossiyskaya Imperiya"
	desc = "The flag of the Novaya Rossiyskaya Imperiya. The yellow, black and white colours represent its sovereignity, spirituality and pureness."
	icon_state = "flag_nri"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/nri, 32)

/obj/structure/sign/flag/usa //Black Mesa stuff keeps haunting me even now.
	name = "flag of the United States of America"
	desc = "'Stars and Stripes', the flag of the United States of America. Its red color represents endurance and valor; blue one shows diligence, vigilance and justice, and the white one signs at pureness. Its thirteen red-and-white stripes show the initial thirteen founding colonies, and fifty stars designate the current fifty states."
	icon_state = "flag_usa"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/usa, 32)

/obj/structure/sign/flag/syndicate
	name = "flag of the Syndicate"
	desc = "The flag of the Syndicate. Previously used by the Sothran people as a way of declaring opposition against the Nanotrasen, it now became an intergalactic symbol of the same purpose, as more groups of interest have joined the rebellion's side."
	icon_state = "flag_syndi"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/syndicate, 32)

/obj/item/sign/flag
	name = "folded blank flag"
	desc = "The folded flag of nothing. It has nothing on it. Beautiful."
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "folded_coder"
	sign_path = /obj/structure/sign/flag
	is_editable = FALSE

/obj/item/sign/flag/ssc
	name = "folded flag of the Kingdom of Agurkrral"
	desc = "The folded flag of the Kingdom of Agurkrral."
	icon_state = "folded_agurk"
	sign_path = /obj/structure/sign/flag/ssc

/obj/item/sign/flag/terragov
	name = "folded flag of the SolFed"
	desc = "The folded flag of SolFed."
	icon_state = "folded_solfed"
	sign_path = /obj/structure/sign/flag/terragov

/obj/item/sign/flag/tizira
	name = "folded flag of the Tiziran Empire"
	desc = "The folded flag of the Tiziran Empire."
	icon_state = "folded_tizira"
	sign_path = /obj/structure/sign/flag/tizira

/obj/item/sign/flag/mothic
	name = "folded flag of the Grand Nomad Fleet"
	desc = "The folded flag of the Grand Nomad Fleet."
	icon_state = "folded_mothic"
	sign_path = /obj/structure/sign/flag/mothic

/obj/item/sign/flag/mars
	name = "folded flag of the Martian Republic"
	desc = "The folded flag of the Martian Republic."
	icon_state = "folded_mars"
	sign_path = /obj/structure/sign/flag/mars

/obj/item/sign/flag/nri
	name = "folded flag of the Novaya Rossiyskaya Imperiya"
	desc = "The folded flag of the Novaya Rossiyskaya Imperiya."
	icon_state = "folded_nri"
	sign_path = /obj/structure/sign/flag/nri

/obj/item/sign/flag/usa
	name = "folded flag of the United States of America"
	desc = "The folded flag of the United States of America."
	icon_state = "folded_usa"
	sign_path = /obj/structure/sign/flag/usa

/obj/item/sign/flag/syndicate
	name = "folded flag of the Syndicate"
	desc = "The folded flag of the United States of America."
	icon_state = "folded_syndi"
	sign_path = /obj/structure/sign/flag/syndicate
