#define BASE_SHAKER_JUICE_REAGENTS list(\
		/datum/reagent/consumable/aloejuice,\
		/datum/reagent/consumable/applejuice,\
		/datum/reagent/consumable/banana,\
		/datum/reagent/consumable/berryjuice,\
		/datum/reagent/consumable/blumpkinjuice,\
		/datum/reagent/consumable/carrotjuice,\
		/datum/reagent/consumable/grapejuice,\
		/datum/reagent/consumable/lemonjuice,\
		/datum/reagent/consumable/lemon_lime,\
		/datum/reagent/consumable/limejuice,\
		/datum/reagent/consumable/parsnipjuice,\
		/datum/reagent/consumable/peachjuice,\
		/datum/reagent/consumable/pineapplejuice,\
		/datum/reagent/consumable/potato_juice,\
		/datum/reagent/consumable/pumpkinjuice,\
		/datum/reagent/consumable/orangejuice,\
		/datum/reagent/consumable/tomatojuice,\
		/datum/reagent/consumable/watermelonjuice\
	)

#define BASE_SHAKER_ALCOHOL_REAGENTS list(\
		/datum/reagent/consumable/ethanol/absinthe,\
		/datum/reagent/consumable/ethanol/ale,\
		/datum/reagent/consumable/ethanol/amaretto,\
		/datum/reagent/consumable/ethanol/applejack,\
		/datum/reagent/consumable/ethanol/beer,\
		/datum/reagent/consumable/ethanol/cognac,\
		/datum/reagent/consumable/ethanol/champagne,\
		/datum/reagent/consumable/ethanol/creme_de_cacao,\
		/datum/reagent/consumable/ethanol/creme_de_coconut,\
		/datum/reagent/consumable/ethanol/creme_de_menthe,\
		/datum/reagent/consumable/ethanol,\
		/datum/reagent/consumable/ethanol/gin,\
		/datum/reagent/consumable/ethanol/hooch,\
		/datum/reagent/consumable/ethanol/kahlua,\
		/datum/reagent/consumable/laughter,\
		/datum/reagent/consumable/ethanol/lizardwine,\
		/datum/reagent/consumable/ethanol/beer/maltliquor,\
		/datum/reagent/consumable/nothing,\
		/datum/reagent/consumable/ethanol/rum,\
		/datum/reagent/consumable/ethanol/sake,\
		/datum/reagent/consumable/ethanol/synthanol,\
		/datum/reagent/consumable/ethanol/tequila,\
		/datum/reagent/consumable/ethanol/triple_sec,\
		/datum/reagent/consumable/ethanol/vermouth,\
		/datum/reagent/consumable/ethanol/vodka,\
		/datum/reagent/consumable/ethanol/whiskey,\
		/datum/reagent/consumable/ethanol/wine\
	)

#define BASE_SHAKER_SODA_REAGENTS list(\
		/datum/reagent/consumable/dr_gibb,\
		/datum/reagent/consumable/grape_soda,\
		/datum/reagent/consumable/pwr_game,\
		/datum/reagent/consumable/shamblers,\
		/datum/reagent/consumable/sodawater,\
		/datum/reagent/consumable/sol_dry,\
		/datum/reagent/consumable/space_up,\
		/datum/reagent/consumable/space_cola,\
		/datum/reagent/consumable/spacemountainwind\
	)

#define BASE_SHAKER_MISC_REAGENTS list(\
		/datum/reagent/consumable/blackpepper,\
		/datum/reagent/blood,\
		/datum/reagent/pax/catnip,\
		/datum/reagent/consumable/coco,\
		/datum/reagent/toxin/coffeepowder,\
		/datum/reagent/consumable/cream,\
		/datum/reagent/consumable/enzyme,\
		/datum/reagent/consumable/eggyolk,\
		/datum/reagent/consumable/honey,\
		/datum/reagent/consumable/grenadine,\
		/datum/reagent/consumable/ice,\
		/datum/reagent/iron,\
		/datum/reagent/consumable/menthol,\
		/datum/reagent/consumable/milk,\
		/datum/reagent/toxin/mushroom_powder,\
		/datum/reagent/consumable/nutriment,\
		/datum/reagent/consumable/soymilk,\
		/datum/reagent/consumable/sugar,\
		/datum/reagent/toxin/teapowder,\
		/datum/reagent/consumable/tonic,\
		/datum/reagent/consumable/vanilla,\
		/datum/reagent/water\
	)


/obj/item/reagent_containers/borghypo/borgshaker/specific
	icon = 'modular_skyrat/modules/borg_buffs/icons/items_cyborg.dmi'
	icon_state = "misc"

/obj/item/reagent_containers/borghypo/borgshaker/specific/juice
	name = "cyborg juice shaker"
	icon_state = "juice"
	default_reagent_types = BASE_SHAKER_JUICE_REAGENTS

/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol
	name = "cyborg alcohol shaker"
	icon_state = "alcohol"
	default_reagent_types = BASE_SHAKER_ALCOHOL_REAGENTS

/obj/item/reagent_containers/borghypo/borgshaker/specific/soda
	name = "cyborg soda shaker"
	icon_state = "soda"
	default_reagent_types = BASE_SHAKER_SODA_REAGENTS

/obj/item/reagent_containers/borghypo/borgshaker/specific/misc
	name = "cyborg misc shaker"
	icon_state = "misc"
	default_reagent_types = BASE_SHAKER_MISC_REAGENTS

/obj/item/cooking/cyborg/power
	name =	"automated cooking tool"
	desc = "A cyborg fitted module resembling the rolling pins and Knifes"
	icon = 'modular_skyrat/modules/borg_buffs/icons/items_cyborg.dmi'
	icon_state = "knife_screw_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	tool_behaviour = TOOL_KNIFE

/obj/item/cooking/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_KNIFE ? "knife" : "rolling pin"] head."

/obj/item/cooking/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour != TOOL_ROLLINGPIN)
		tool_behaviour = TOOL_ROLLINGPIN
		to_chat(user, span_notice("You attach the rolling pin bit to [src]."))
		icon_state = "rolling_bolt_cyborg"
	else
		tool_behaviour = TOOL_KNIFE
		to_chat(user, span_notice("You attach the knife bit to [src]."))
		icon_state = "knife_screw_cyborg"

/obj/item/inducer/cyborg
	name = "Cyborg Inducer"
	desc = "A tool for inductively charging internal power cells using the battery of a cyborg"
	powertransfer = 250
	var/power_safety_threshold = 1000



/obj/item/inducer/cyborg/attackby(obj/item/weapon, mob/user)
	return

/obj/item/inducer/cyborg/recharge(atom/movable/target_atom, mob/user)
	if(!iscyborg(user))
		return
	var/mob/living/silicon/robot/borg_user = user
	cell = borg_user.cell
	if(!isturf(target_atom) && user.loc == target_atom)
		return FALSE
	if(recharging)
		return TRUE
	else
		recharging = TRUE
	var/obj/item/stock_parts/cell/target_cell = target_atom.get_cell()
	var/obj/target_object
	var/coefficient = 1
	if(istype(target_atom, /obj/item/gun/energy))
		to_chat(user, span_alert("Error unable to interface with device."))
		return FALSE
	if(istype(target_atom, /obj/item/clothing/suit/space))
		to_chat(user, span_alert("Error unable to interface with device."))
		return FALSE
	if(cell.charge <= power_safety_threshold ) // Cyborg charge safety. Prevents a borg from inducing themself to death.
		to_chat(user, span_alert("Unable to charge device. User battery safety engaged."))
		return
	if(istype(target_atom, /obj))
		target_object = target_atom
	if(target_cell)
		var/done_any = FALSE
		if(target_cell.charge >= target_cell.maxcharge)
			to_chat(user, span_notice("[target_atom] is fully charged!"))
			recharging = FALSE
			return TRUE
		user.visible_message(span_notice("[user] starts recharging [target_atom] with [src]."), span_notice("You start recharging [target_atom] with [src]."))
		while(target_cell.charge < target_cell.maxcharge)
			if(do_after(user, 1 SECONDS, target = user) && cell.charge > (power_safety_threshold + powertransfer))
				done_any = TRUE
				induce(target_cell, coefficient)
				do_sparks(1, FALSE, target_atom)
				if(target_object)
					target_object.update_appearance()
			else
				break
		if(done_any) // Only show a message if we succeeded at least once
			user.visible_message(span_notice("[user] recharged [target_atom]!"), span_notice("You recharged [target_atom]!"))
		recharging = FALSE
		return TRUE
	recharging = FALSE


/obj/item/inducer/attack(mob/target_mob, mob/living/user)
	if(user.combat_mode)
		return ..()

	if(cantbeused(user))
		return

	if(recharge(target_mob, user))
		return
	return ..()

/obj/item/inducer/cyborg/attack_self(mob/user)
	return

// Wirebrush for janiborg
/datum/design/borg_wirebrush
	name = "Wire-brush Module"
	id = "borg_upgrade_brush"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/wirebrush
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 40
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR)

/obj/item/borg/upgrade/wirebrush
	name = "janitor cyborg wire-brush"
	desc = "A tool to remove rust from walls."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

/obj/item/borg/upgrade/wirebrush/action(mob/living/silicon/robot/cyborg)
	. = ..()
	if(.)
		for(var/obj/item/wirebrush/brush in cyborg.model.modules)
			cyborg.model.remove_module(brush, TRUE)

		var/obj/item/wirebrush/brush = new /obj/item/wirebrush(cyborg.model)
		cyborg.model.basic_modules += brush
		cyborg.model.add_module(brush, FALSE, TRUE)

/obj/item/borg/upgrade/wirebrush/deactivate(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/wirebrush/brush in cyborg.model.modules)
			cyborg.model.remove_module(brush, TRUE)

		var/obj/item/wirebrush/brush = new (cyborg.model)
		cyborg.model.basic_modules += brush
		cyborg.model.add_module(brush, FALSE, TRUE)
