/mob/living/silicon/robot
	var/sitting = FALSE
	var/bellyup = FALSE
	var/dogborg = FALSE
	var/disabler
	var/laser
	var/sleeper_g
	var/sleeper_r
	var/sleeper_nv

/mob/living/silicon/robot/proc/rest_style()
	set name = "Switch Rest Style"
	set category = "Robot Commands"
	set desc = "Select your resting pose."
	sitting = FALSE
	bellyup = FALSE
	var/choice = alert(src, "Select resting pose", "", "Resting", "Sitting", "Belly up")
	switch(choice)
		if("Resting")
			update_icons()
			return FALSE
		if("Sitting")
			sitting = TRUE
		if("Belly up")
			bellyup = TRUE
	update_icons()

/mob/living/silicon/robot/proc/robot_lay_down()
	set name = "Lay down"
	set category = "Robot Commands"
	if(stat != CONSCIOUS) //Make sure we don't enable movement when not concious
		return
	if(resting)
		to_chat(src, "<span class='notice'>You are now getting up.</span>")
		resting = FALSE
		mobility_flags = MOBILITY_FLAGS_DEFAULT
	else
		to_chat(src, "<span class='notice'>You are now laying down.</span>")
		resting = TRUE
		mobility_flags &= ~MOBILITY_MOVE
	update_icons()

/mob/living/silicon/robot/update_mobility()
	..()
	if(dogborg)
		resting = FALSE
		update_icons()

/mob/living/silicon/robot/update_module_innate()
	..()
	hands.icon = (module.moduleselect_alternate_icon ? module.moduleselect_alternate_icon : initial(hands.icon))

/mob/living/silicon/robot/modules/miner/skyrat
	set_module = /obj/item/robot_module/miner/skyrat

/mob/living/silicon/robot/modules/butler/skyrat
	set_module = /obj/item/robot_module/butler/skyrat

/mob/living/silicon/robot/pick_module()
	if(module.type != /obj/item/robot_module)
		return

	if(wires.is_cut(WIRE_RESET_MODULE))
		to_chat(src,"<span class='userdanger'>ERROR: Module installer reply timeout. Please check internal connections.</span>")
		return

	var/list/skyratmodule = list(
	"Skyrat Service(alt skins)" = /obj/item/robot_module/butler/skyrat,
	"Skyrat Miner(alt skins)" = /obj/item/robot_module/miner/skyrat,
	"Next page" = "next"
	)
	var/input_module_sk = input("Please select a skyrat module if you want one, otherwise select next page.", "Robot", null, null) as null|anything in sortList(skyratmodule)
	if(input_module_sk == "Next page" || !input_module_sk || module.type != /obj/item/robot_module)
		return ..()
	else
		module.transform_to(skyratmodule[input_module_sk])
		return
