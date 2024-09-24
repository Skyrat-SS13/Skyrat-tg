/obj/item/clothing/under/item_ctrl_click(mob/user)
	. = ..()
	if(has_sensor == HAS_SENSORS)
		sensor_mode = SENSOR_COORDS
		to_chat(usr, span_notice("Your suit will now report your exact vital lifesigns as well as your coordinate position."))
