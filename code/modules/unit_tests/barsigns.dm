/**
 * Test if icon states for each datum actually exist in the DMI.
 */
/datum/unit_test/barsigns_icon
	var/list/blacklisted_sign_types = list(/datum/barsign/skyrat, /datum/barsign/skyrat/large) // SKYRAT EDIT ADDITION - Modular barsigns

/datum/unit_test/barsigns_icon/Run()
	var/obj/machinery/barsign_type = /obj/machinery/barsign
	var/icon/barsign_icon = initial(barsign_type.icon)
	var/list/barsign_icon_states = icon_states(barsign_icon)
	barsign_icon_states += icon_states(SKYRAT_BARSIGN_FILE) // SKYRAT EDIT ADDITION - Need to check modular barsigns
	barsign_icon_states += icon_states(SKYRAT_LARGE_BARSIGN_FILE) // SKYRAT EDIT ADDITION - Need to check modular  barsigns

	// Check every datum real bar sign
	for(var/sign_type in (subtypesof(/datum/barsign) - /datum/barsign/hiddensigns))
		// SKYRAT EDIT ADDITION BEGIN - MODULAR BARSIGNS
		if(sign_type in blacklisted_sign_types)
			continue
		// SKYRAT EDIT ADDITION END
		var/datum/barsign/sign = new sign_type()

		if(!(sign.icon_state in barsign_icon_states))
			TEST_FAIL("Icon state for [sign_type] does not exist in [barsign_icon].")

/**
 * Check that bar signs have a name and desc, and that the name is unique.
 */
/datum/unit_test/barsigns_name
	var/list/blacklisted_sign_types = list(/datum/barsign/skyrat, /datum/barsign/skyrat/large) // SKYRAT EDIT ADDITION - Modular barsigns

/datum/unit_test/barsigns_name/Run()
	var/list/existing_names = list()

	for(var/sign_type in (subtypesof(/datum/barsign) - /datum/barsign/hiddensigns))
		// SKYRAT EDIT ADDITION BEGIN - MODULAR BARSIGNS
		if(sign_type in blacklisted_sign_types)
			continue
		// SKYRAT EDIT ADDITION END
		var/datum/barsign/sign = new sign_type()

		if(!sign.name)
			TEST_FAIL("[sign_type] does not have a name.")
		if(!sign.desc)
			TEST_FAIL("[sign_type] does not have a desc.")

		if(sign.name in existing_names)
			TEST_FAIL("[sign_type] does not have a unique name.")

		existing_names += sign.name
