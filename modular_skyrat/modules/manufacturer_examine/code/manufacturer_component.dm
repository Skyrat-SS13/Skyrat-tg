/// Component that will tell anyone who examines the parent what company made it
/datum/component/manufacturer_examine
	/// Bitflag for what company produces this, do not give it more than one
	var/company_flag

/datum/component/manufacturer_examine/Initialize(given_company_flag)
	. = ..()

	// Obviously gun safety should only apply to guns
	if(!given_company_flag)
		return COMPONENT_INCOMPATIBLE

	src.company_flag = given_company_flag

/datum/component/manufacturer_examine/RegisterWithParent()
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))

/datum/component/manufacturer_examine/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_PARENT_EXAMINE,
	))

/// Reads the company flag and sticks a message in the examine list appropriate to the given flag. TODO EVENTUALLY: MAKE THIS NOT A HUGE SWITCH CASE
/datum/component/manufacturer_examine/proc/on_examine(obj/item/source, mob/examiner, list/examine_list)
	SIGNAL_HANDLER

	switch(company_flag)
		if(COMPANY_CANTALAN)
			examine_list += "<br>It has <b>[span_purple("Cantalan Federal Arms")]</b> etched into the grip."
		if(COMPANY_ARMADYNE)
			examine_list += "<br>It has <b>[span_red("Armadyne Corporation")]</b> etched into the barrel."
		if(COMPANY_SCARBOROUGH)
			examine_list += "<br>It has <b>[span_orange("Scarborough Arms")]</b> stamped onto the grip."
		if(COMPANY_DONK)
			examine_list += "<br>It has a <b>[span_green("Donk Corporation")]</b> label visible in the plastic."
		if(COMPANY_BOLT)
			examine_list += "<br>It has <b>[span_yellow("Bolt Fabrications")]</b> stamped onto the reciever."
		if(COMPANY_OLDARMS)
			examine_list += "<br>It has <b><i>[span_red("Armadyne Oldarms")]</i></b> etched into the barrel."
		if(COMPANY_IZHEVSK)
			examine_list += "<br>It has <b>[span_brown("Izhevsk Coalition")]</b> cut in above the magwell."
		if(COMPANY_NANOTRASEN)
			examine_list += "<br>It has <b>[span_blue("Nanotrasen Armories")]</b> etched into the reciever."
		if(COMPANY_ALLSTAR)
			examine_list += "<br>It has <b>[span_red("Allstar Lasers Inc.")]</b> stamped on the front grip."
		if(COMPANY_MICRON)
			examine_list += "<br>It has <b>[span_cyan("Micron Control Sys.")]</b> cut in above the cell slot."
		if(COMPANY_INTERDYNE)
			examine_list += "<br>It has <b>[span_cyan("Interdyne Pharmaceuticals")]</b> stamped onto the barrel."
		if(COMPANY_ABDUCTOR)
			examine_list += "<br>It has <b>[span_abductor("✌︎︎♌︎︎♎︎︎◆︎︎♍︎︎⧫︎︎❄︎♏︎♍︎♒︎")]</b> engraved into the photon accelerator."
		if(COMPANY_REMOVED)
			examine_list += "<br>It has had <b>[span_grey("all identifying marks scrubbed off")].</b>"
		if(COMPANY_TKACH)
			examine_list += "<br>It has <b>[span_robot("Tkach Design Bureau")] stamped onto the reciever.</b>"
