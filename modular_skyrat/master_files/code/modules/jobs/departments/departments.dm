/datum/job_department/central_command
	department_name = DEPARTMENT_CENTRAL_COMMAND
	department_bitflags = DEPARTMENT_BITFLAG_CENTRAL_COMMAND
	department_head = /datum/job/captain
	department_experience_type = EXP_TYPE_CENTRAL_COMMAND
	display_order = 1
	label_class = "command"
	latejoin_color = "#ccccff"

/datum/job_department/syndicate
	department_name = DEPARTMENT_SYNDICATE
	department_bitflags = DEPARTMENT_BITFLAG_SYNDICATE
	department_head = /datum/job/skyratghostrole/syndicate/station_admiral
	display_order = 15 //Want this relatively late compared to everything else.
	label_class = "security"
	latejoin_color = "#eb4034"
