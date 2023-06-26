/obj/item/stamp/cat
	name = "\improper Official Cat Stamp"
	desc = "A rubber stamp for stamping documents of questionable importance."
	icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi'
	icon_state = "stamp-cat_blue"
	inhand_icon_state = "stamp"
// Radial menu options
	var/static/cat_blue = image(icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi', icon_state = "radial_cat_blue")
	var/static/paw_blue = image(icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi', icon_state = "radial_paw_blue")
	var/static/cat_red = image(icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi', icon_state = "radial_cat_red")
	var/static/paw_red = image(icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi', icon_state = "radial_paw_red")
	var/static/cat_orange = image(icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi', icon_state = "radial_cat_orange")
	var/static/paw_orange = image(icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi', icon_state = "radial_paw_orange")
	var/static/cat_green = image(icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi', icon_state = "radial_cat_green")
	var/static/paw_green = image(icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi', icon_state = "radial_paw_green")
// Choices for the radial menu
	var/static/list/radial_options = list(
		"cat_blue" = cat_blue,
		"paw_blue" = paw_blue,
		"cat_red" = cat_red,
		"paw_red" = paw_red,
		"cat_orange" = cat_orange,
		"paw_orange" = paw_orange,
		"cat_green" = cat_green,
		"paw_green" = paw_green
	)

/obj/item/stamp/cat/ui_interact(mob/user)
	. = ..()
	var/choice = show_radial_menu(user, src, radial_options)
	switch(choice)
		if("cat_blue")
			icon_state = "stamp-cat_blue"
			dye_color = DYE_HOP
			name = "\improper Official Cat Stamp"
		if("paw_blue")
			icon_state = "stamp-paw_blue"
			dye_color = DYE_HOP
			name = "\improper Paw Stamp"

		if("cat_red")
			icon_state = "stamp-cat_red"
			dye_color = DYE_HOS
			name = "\improper Official Cat Stamp"
		if("paw_red")
			icon_state = "stamp-paw_red"
			dye_color = DYE_HOS
			name = "\improper Paw Stamp"

		if("cat_orange")
			icon_state = "stamp-cat_orange"
			dye_color = DYE_QM
			name = "\improper Official Cat Stamp"
		if("paw_orange")
			icon_state = "stamp-paw_orange"
			dye_color = DYE_QM
			name = "\improper Paw Stamp"

		if("cat_green")
			icon_state = "stamp-cat_green"
			dye_color = DYE_CENTCOM
			name = "\improper Official Cat Stamp"
		if("paw_green")
			icon_state = "stamp-paw_green"
			dye_color = DYE_CENTCOM
			name = "\improper Paw Stamp"

		else
			return

/obj/item/stamp/nri
	name = "\improper Novaya Rossiyskaya Imperia stamp"
	desc = "A rubber stamp for stamping important documents. Used in various NRI documents."
	icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi'
	icon_state = "stamp-nri"
	dye_color = DYE_CENTCOM

/obj/item/stamp/solfed
	name = "\improper Solar Federation stamp"
	icon = 'modular_skyrat/master_files/icons/obj/bureaucracy.dmi'
	icon_state = "stamp-solfed"
	dye_color = DYE_CE
