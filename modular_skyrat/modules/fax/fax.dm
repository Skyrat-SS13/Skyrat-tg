/area
	var/nt_fax_department = null

/area/station/command/heads_quarters/cmo
	nt_fax_department = "CC Medical Emergencies"

/area/station/command/heads_quarters/hos
	nt_fax_department = "CC Security Command"

/area/station/command/heads_quarters/ce
	nt_fax_department = "CC Engineering Support"

/area/station/command/heads_quarters/hop
	nt_fax_department = "CC Personnel Division"

/area/station/command/heads_quarters/rd
	nt_fax_department = "CC Research Wing"

/area/station/command/heads_quarters/qm
	nt_fax_department = "CC Supply Logistics"

/area/station/lawoffice
	nt_fax_department = "CC Legal Department"

/area/command/heads_quarters/captain/private/nt_rep
	nt_fax_department = "Central Command"

/area/station/command/bridge
	nt_fax_department = "Central Command"

/area/station/command/heads_quarters/captain
	nt_fax_department = "Central Command"

/obj/machinery/fax/Initialize(mapload)
	. = ..()
	var/area/machine_area = get_area(src)

	if(machine_area.nt_fax_department)
		special_networks["nanotrasen"]["fax_name"] = machine_area.nt_fax_department
