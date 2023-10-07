// We just want to make sure this runs before SSAssets so that the globals are set up correctly for language menu icons
/datum/controller/subsystem/language
	init_order = INIT_ORDER_SECURITY_LEVEL
