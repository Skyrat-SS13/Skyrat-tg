
/datum/objective/interrogate
	name = "interrogate"
	var/target_role_type = FALSE
	martyr_compatible = TRUE
	/// Has a goldeneye key linked to this objective been uploaded?
	var/goldeneye_key_uploaded = FALSE
	/// A ref to our printed key, to prevent abuse by duplicating keys.
	var/obj/item/goldeneye_key/linked_key

/datum/objective/interrogate/check_completion()
	return goldeneye_key_uploaded

/datum/objective/interrogate/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Interrogate [target.name], the [!target_role_type ? target.assigned_role.title : target.special_role] using the interrorgator."
	else
		explanation_text = "Free Objective"
