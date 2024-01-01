/datum/latejoin_menu/ui_data(mob/user)
	. = ..()
	var/color = SSsecurity_level.get_current_level_as_text()
	switch(color)
		if("delta", "gamma")
			color = "red"

	.["alert_level"] = list("name" = capitalize(SSsecurity_level.get_current_level_as_text()), "color" = color)
