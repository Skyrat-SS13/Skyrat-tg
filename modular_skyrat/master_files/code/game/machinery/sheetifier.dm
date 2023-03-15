/obj/machinery/sheetifier/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/material_container, list(/datum/material/hauntium), MINERAL_MATERIAL_AMOUNT * MAX_STACK_SIZE * 2, MATCONTAINER_EXAMINE|BREAKDOWN_FLAGS_SHEETIFIER, /datum/material/hauntium, list(/obj/item/photo), null, CALLBACK(src, PROC_REF(CanInsertMaterials)), CALLBACK(src, PROC_REF(AfterInsertMaterials)))
