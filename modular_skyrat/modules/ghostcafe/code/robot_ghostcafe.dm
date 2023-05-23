/mob/living/silicon/robot/model/roleplay
	lawupdate = FALSE
	scrambledcodes = TRUE // Roleplay borgs aren't real
	set_model = /obj/item/robot_model/roleplay
	radio = null

/mob/living/silicon/robot/model/roleplay/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/cell/infinite(src, 30000)
	laws = new /datum/ai_laws/roleplay()
	//This part is because the camera stays in the list, so we'll just do a check
	if(!QDELETED(builtInCamera))
		QDEL_NULL(builtInCamera)

/mob/living/silicon/robot/model/roleplay/binarycheck()
	return FALSE //Roleplay borgs aren't truly borgs

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
		/obj/item/screwdriver/cyborg,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
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
		/obj/item/reagent_containers/cup/glass/drinkingglass,
		/obj/item/soap/nanotrasen,
		/obj/item/mop/cyborg, // Soap's good and all, but a mop is good, too
		/obj/item/lightreplacer, // Lights go out sometimes, or get broken, let the Borg help fix them
		/obj/item/borg/cyborghug,
		/obj/item/dogborg_nose,
		/obj/item/dogborg_tongue,
		/obj/item/reagent_containers/borghypo, // Let Roleplay Borgs heal visitors
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
		for(var/charge in 1 to coeff)
			light_replacer.Charge(cyborg) // Make Roleplay Borg Light Replacer recharge, isntead of requiring Glass
