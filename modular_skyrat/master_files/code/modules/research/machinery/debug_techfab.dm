/obj/item/circuitboard/machine/techfab/debug
	name = "\improper CreaTech Omnilathe (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rnd/production/techfab/debug

/obj/machinery/rnd/production/techfab/debug
	name = "\improper CreaTech(TM) Technology Fabricator"
	desc = "<i>\"Create to your heart's content! (Batteries not included).\"</i>\n\
		A unique techfab, coming with all of the research technology and mechanical upgrades built-in, \
		granting interface and near-unlimited access to fabricating new technology."
	allowed_buildtypes = ALL
	department_tag = "CreaTech"

/obj/machinery/rnd/production/techfab/debug/Initialize(mapload)
	. = ..()
	stored_research = SSresearch.admin_tech
	materials.mat_container.max_amount = INFINITY

/obj/machinery/rnd/production/techfab/debug/calculate_efficiency()
	efficiency_coeff = 10000
