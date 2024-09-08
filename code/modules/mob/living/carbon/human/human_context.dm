/mob/living/carbon/human/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()

	if (!ishuman(user))
		return .

	if (user == src)
		return .

	if (pulledby == user)
		switch (user.grab_state)
			if (GRAB_PASSIVE)
				context[SCREENTIP_CONTEXT_CTRL_LMB] = "Grip"
			if (GRAB_AGGRESSIVE)
				context[SCREENTIP_CONTEXT_CTRL_LMB] = "Choke"
			if (GRAB_NECK)
				context[SCREENTIP_CONTEXT_CTRL_LMB] = "Strangle"
			else
				return .
		// SKYRAT EDIT START - screentips for grab interactions (slams/suplexes/dislocations)
		if(user.combat_mode && user.grab_state > GRAB_PASSIVE)
			switch(deprecise_zone(user.zone_selected))
				if (BODY_ZONE_HEAD)
					if (src.body_position == LYING_DOWN)
						context[SCREENTIP_CONTEXT_ALT_LMB] = "Headslam"
				if (BODY_ZONE_CHEST)
					context[SCREENTIP_CONTEXT_ALT_LMB] = "Suplex"
				else
					context[SCREENTIP_CONTEXT_ALT_LMB] = "Dislocate"
		// SKYRAT EDIT END
	else
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "Pull"

	return CONTEXTUAL_SCREENTIP_SET
