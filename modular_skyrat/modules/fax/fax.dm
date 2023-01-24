/area
	var/nt_fax_department = null

/area/station/command/heads_quarters/cmo
	nt_fax_department = "medical"

/area/station/command/heads_quarters/hos
	nt_fax_department = "security"

/area/station/command/heads_quarters/ce
	nt_fax_department = "engineering"

/area/station/command/heads_quarters/hop
	nt_fax_department = "service"

/area/station/command/heads_quarters/rd
	nt_fax_department = "research"

/area/station/command/heads_quarters/qm
	nt_fax_department = "supply"

/area/station/lawoffice
	nt_fax_department = "legal"

/area/command/heads_quarters/captain/private/nt_rep
	nt_fax_department = "command"

/area/station/command/heads_quarters/captain
	nt_fax_department = "command"

/obj/machinery/fax
	var/rare_network = 0
	special_networks = list(
		nanotrasen = list(fax_name = "NT HR Department", fax_id = "central_command", color = "teal", emag_needed = FALSE),
		syndicate = list(fax_name = "Sabotage Department", fax_id = "syndicate", color = "red", emag_needed = TRUE),
		external = list(fax_name = "Pencil Pushers Anonymous", fax_id = "external_company", color = "yellow", emag_needed = FALSE)
	)

/obj/machinery/fax/Initialize(mapload)
	. = ..()
	var/area/machine_area = get_area(src)

	switch(machine_area.nt_fax_department)
		if("security")
			special_networks["nanotrasen"]["fax_name"] = pick("CC Security Reporting", "SolFed Police Report", "Armadyne Security Inquires")
		if("medical")
			special_networks["nanotrasen"]["fax_name"] = pick("CC Medical Wing", "Veymed Support", "SolFed Medical Support", "Frontier Medical Clinic", "Solfed EMT")
		if("engineering")
			special_networks["nanotrasen"]["fax_name"] = pick("CC Engineering Inquires", "SolFed Enginner Technical Support", "Frontier Engineering Anonymous", "Nakamura Engineering")
		if("service")
			special_networks["nanotrasen"]["fax_name"] = pick("CC Personal Management", "CC Food Court", "Frontier Cooking Union", "Frontier Bartending United")
		if("research")
			special_networks["nanotrasen"]["fax_name"] = pick("CC Research Division",  "Ghost Writing", "NT Physics Quarterly", "Mining Corps", "Defense Partnership")
		if("supply")
			special_networks["nanotrasen"]["fax_name"] = pick("Supply Union Association", "FTU-TV Rhapsody Requisitions", "Armadyne Supply Support", "Frontier Logistics Hub", "Mining Corps")
		if("legal")
			special_networks["nanotrasen"]["fax_name"] = pick("CC Legal Department", "CC Legal Inquires", "SolFed Legal Reports", "Solfed Law Office")
		if("command")
			special_networks["nanotrasen"]["fax_name"] = pick("Central Command", "CC Fleet Dispatch")

	special_networks["external"]["fax_name"] = pick("Pencil Pushers Anonymous", "Legalese and you", "Legal Advice Helpline", "Corpo Cubical Collective", "Frontier News Network", "Peoples Union", "Corporate Jargon", "Alcoholics Anonymous")

/obj/machinery/fax/attack_hand()
	. = ..()
	var/random = rand(1, 300)

	if(random == 95 && rare_network == 0)
		special_networks["external"]["fax_name"] = "John Nanotrasen"
		rare_network = 1
		message_admins("[ADMIN_FLW(src)] Rare Fax Avalaible: John Nanotrasen")
	else if(random == 5 && rare_network == 0)
		special_networks["external"]["fax_name"] = "Syndicate Recruitment"
		rare_network = 1
		message_admins("[ADMIN_FLW(src)] Rare Fax Avalaible: Syndicate Recruitment")
	else if(random == 4 && rare_network == 0)
		special_networks["external"]["fax_name"] = "Santa Claus"
		rare_network = 1
		message_admins("[ADMIN_FLW(src)] Rare Fax Avalaible: Santa Claus")
	else if(random == 69 && rare_network == 0)
		special_networks["external"]["fax_name"] = "Joe's Strip Club"
		rare_network = 1
		message_admins("[ADMIN_FLW(src)] Rare Fax Avalaible: Joe's Strip Club")
	else if(random == 90 && rare_network == 0)
		special_networks["external"]["fax_name"] = "Doggino's Coperate Fax"
		rare_network = 1
		message_admins("[ADMIN_FLW(src)] Rare Fax Avalaible: Doggino's Coperate Fax")
	else if(random == 32 && rare_network == 0)
		special_networks["external"]["fax_name"] = "Nanotrasen CEO Office"
		rare_network = 1
		message_admins("[ADMIN_FLW(src)] Rare Fax Avalaible: Nanotrasen CEO Office")
	else if(random == 50 && rare_network == 0)
		special_networks["external"]["fax_name"] = "NT Fleet Admiral"
		rare_network = 1
		message_admins("[ADMIN_FLW(src)] Rare Fax Avalaible: NT Fleet Admiral")
	else if(random == 10 && rare_network == 0)
		special_networks["external"]["fax_name"] = "Jerry's Corner Store"
		rare_network = 1
		message_admins("[ADMIN_FLW(src)] Rare Fax Avalaible: Jerry's Corner Store")
	else if (rare_network == 1)
		special_networks["external"]["fax_name"] = pick("Pencil Pushers Anonymous", "Legalese and you", "Legal Advice Helpline", "Corpo Cubical Collective", "Frontier News Network", "Peoples Union", "Corporate Jargon", "Alcoholics Anonymous")
		rare_network = 0
