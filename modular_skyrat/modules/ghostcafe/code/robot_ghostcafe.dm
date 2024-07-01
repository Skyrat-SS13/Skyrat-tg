/mob/living/silicon/robot/model/roleplay
	lawupdate = FALSE
	scrambledcodes = TRUE // Roleplay borgs aren't real
	set_model = /obj/item/robot_model/roleplay
	radio = null

/mob/living/silicon/robot/model/roleplay/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/power_store/cell/infinite(src, 30000)
	laws = new /datum/ai_laws/roleplay()
	//This part is because the camera stays in the list, so we'll just do a check
	if(!QDELETED(builtInCamera))
		QDEL_NULL(builtInCamera)

/mob/living/silicon/robot/model/roleplay/binarycheck()
	return FALSE //Roleplay borgs aren't truly borgs

/obj/item/modular_computer/pda/silicon/cyborg/roleplay
	starting_programs = list( //Imaginary cyborgs do not get a PDA
		/datum/computer_file/program/filemanager,
		/datum/computer_file/program/robotact,
	)

/mob/living/silicon/robot/model/roleplay/create_modularInterface()
	if(!modularInterface)
		modularInterface = new /obj/item/modular_computer/pda/silicon/cyborg/roleplay(src)
		modularInterface.saved_job = "Cyborg"
	return ..()

/datum/ai_laws/roleplay
	name = "Roleplay"
	id = "roleplay"
	zeroth = "Roleplay as you'd like!"
	inherent = list()

/obj/item/robot_model/roleplay
	name = "Roleplay"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/borg/cyborg_omnitool/engineering,
		/obj/item/borg/cyborg_omnitool/engineering,
		/obj/item/multitool/cyborg,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/iron,
		/obj/item/stack/cable_coil,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/rsf/cyborg,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/juice, // They can make glasses, and have their own, let them serve drinks!
		/obj/item/reagent_containers/borghypo/borgshaker/specific/soda,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/misc,
		/obj/item/borg/apparatus/beaker,
		/obj/item/borg/apparatus/beaker,
		/obj/item/soap/nanotrasen,
		/obj/item/mop/cyborg, // Soap's good and all, but a mop is good, too
		/obj/item/lightreplacer,
		/obj/item/borg/cyborghug,
		/obj/item/quadborg_nose,
		/obj/item/quadborg_tongue,
		/obj/item/reagent_containers/borghypo,
		/obj/item/borg_shapeshifter/stable)
	hat_offset = -3

/obj/item/borg_shapeshifter/stable
	signalCache = list()
	activationCost = 0
	activationUpkeep = 0

/obj/item/robot_model/roleplay/respawn_consumable(mob/living/silicon/robot/cyborg, coeff = 1)
	..()
	var/obj/item/lightreplacer/light_replacer = locate(/obj/item/lightreplacer) in basic_modules
	if(light_replacer)
		light_replacer.Charge(cyborg, coeff) // Make Roleplay Borg Light Replacer recharge, isntead of requiring Glass
