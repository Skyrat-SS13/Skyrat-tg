
/obj/structure/closet/crate/cardboard/mothic/build_your_shuttle

/obj/structure/closet/crate/cardboard/mothic/build_your_shuttle/PopulateContents()
	. = ..()
	new /obj/item/circuitboard/computer/shuttle_common_docks(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/construction/rcd(src)
	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/storage/toolbox/electrical(src)
	new /obj/item/electronics/apc(src)
	new /obj/item/electronics/airalarm(src)
	new /obj/item/circuitboard/machine/propulsion_engine(src)

/obj/structure/closet/crate/cardboard/mothic/build_your_shuttle_extra

/obj/structure/closet/crate/cardboard/mothic/build_your_shuttle_extra/PopulateContents()
	. = ..()
	new /obj/item/stack/sheet/iron/fifty(src)
	new /obj/item/stack/sheet/glass/fifty(src)
	new /obj/item/stack/sheet/mineral/titanium/fifty(src)
	new /obj/item/circuitboard/machine/propulsion_engine(src)

/obj/structure/closet/crate/large/air_can/PopulateContents()
	. = ..()
	new /obj/machinery/portable_atmospherics/canister/air(src)
