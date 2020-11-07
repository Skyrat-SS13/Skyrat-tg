/datum/radial_menu/gunpoint
	var/uniqueid
	var/datum/callback/select_proc_callback
	icon_path = 'modular_skyrat/modules/gunpoint/icons/radial_gunpoint.dmi'

/datum/radial_menu/gunpoint/New()


/datum/radial_menu/gunpoint/element_chosen(choice_id,mob/user)
	select_proc_callback.Invoke(choices_values[choice_id])


/datum/radial_menu/gunpoint/proc/change_choices(list/newchoices, tooltips)
	if(!newchoices.len)
		return
	Reset()
	set_choices(newchoices,tooltips)

/datum/radial_menu/gunpoint/Destroy()
	QDEL_NULL(select_proc_callback)
	GLOB.radial_menus -= uniqueid
	Reset()
	hide()
	. = ..()

/proc/show_radial_menu_gunpoint(mob/user, atom/anchor, list/choices, datum/callback/select_proc, uniqueid, radius, tooltips = FALSE)
	if(!user || !anchor || !length(choices) || !select_proc)
		return
	if(!uniqueid)
		uniqueid = "defmenu_[REF(user)]_[REF(anchor)]"

	if(GLOB.radial_menus[uniqueid])
		return

	var/datum/radial_menu/gunpoint/menu = new
	menu.uniqueid = uniqueid
	GLOB.radial_menus[uniqueid] = menu
	if(radius)
		menu.radius = radius
	menu.select_proc_callback = select_proc
	menu.anchor = anchor
	menu.check_screen_border(user) //Do what's needed to make it look good near borders or on hud
	menu.set_choices(choices, tooltips)
	menu.show_to(user)
	return menu
