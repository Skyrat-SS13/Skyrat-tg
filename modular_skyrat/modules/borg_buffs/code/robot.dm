/obj/item/reagent_containers/borghypo/borgshaker/specific
	icon = 'modular_skyrat/modules/borg_buffs/icons/items_cyborg.dmi'
	icon_state = "shaker"

/obj/item/reagent_containers/borghypo/borgshaker/specific/juice
	name = "cyborg juice shaker"
	icon_state = "juice"
	reagent_ids = list(/datum/reagent/consumable/orangejuice,
					/datum/reagent/consumable/tomatojuice,
					/datum/reagent/consumable/limejuice,
					/datum/reagent/consumable/carrotjuice,
					/datum/reagent/consumable/berryjuice,
					/datum/reagent/consumable/applejuice,
					/datum/reagent/consumable/watermelonjuice,
					/datum/reagent/consumable/lemonjuice,
					/datum/reagent/consumable/banana,
					/datum/reagent/consumable/potato_juice,
					/datum/reagent/consumable/grapejuice,
					/datum/reagent/consumable/parsnipjuice,
					/datum/reagent/consumable/pineapplejuice,
					/datum/reagent/consumable/aloejuice,
					/datum/reagent/consumable/pumpkinjuice,
					/datum/reagent/consumable/blumpkinjuice,
					/datum/reagent/consumable/lemon_lime,
					/datum/reagent/consumable/peachjuice,)

/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol
	name = "cyborg alcohol shaker"
	icon_state = "alcohol"
	reagent_ids = list(/datum/reagent/consumable/ethanol,
					/datum/reagent/consumable/ethanol/beer,
					/datum/reagent/consumable/ethanol/beer/maltliquor,
					/datum/reagent/consumable/ethanol/kahlua,
					/datum/reagent/consumable/ethanol/whiskey,
					/datum/reagent/consumable/ethanol/vodka,
					/datum/reagent/consumable/ethanol/gin,
					/datum/reagent/consumable/ethanol/rum,
					/datum/reagent/consumable/ethanol/tequila,
					/datum/reagent/consumable/ethanol/vermouth,
					/datum/reagent/consumable/ethanol/wine,
					/datum/reagent/consumable/ethanol/lizardwine,
					/datum/reagent/consumable/ethanol/amaretto,
					/datum/reagent/consumable/ethanol/cognac,
					/datum/reagent/consumable/ethanol/absinthe,
					/datum/reagent/consumable/ethanol/hooch,
					/datum/reagent/consumable/ethanol/ale,
					/datum/reagent/consumable/ethanol/applejack,
					/datum/reagent/consumable/ethanol/champagne,
					/datum/reagent/consumable/ethanol/creme_de_menthe,
					/datum/reagent/consumable/ethanol/creme_de_cacao,
					/datum/reagent/consumable/ethanol/sake,
					/datum/reagent/consumable/ethanol/triple_sec,
					/datum/reagent/consumable/ethanol/creme_de_coconut,
					/datum/reagent/consumable/nothing,
					/datum/reagent/consumable/laughter,)

/obj/item/reagent_containers/borghypo/borgshaker/specific/soda
	name = "cyborg soda shaker"
	icon_state = "soda"
	reagent_ids = list(/datum/reagent/consumable/space_cola,
					/datum/reagent/consumable/dr_gibb,
					/datum/reagent/consumable/space_up,
					/datum/reagent/consumable/sodawater,
					/datum/reagent/consumable/grape_soda,
					/datum/reagent/consumable/sol_dry,
					/datum/reagent/consumable/spacemountainwind,
					/datum/reagent/consumable/pwr_game,
					/datum/reagent/consumable/shamblers,)

/obj/item/reagent_containers/borghypo/borgshaker/specific/misc
	name = "cyborg misc shaker"
	icon_state = "misc"
	reagent_ids = list(/datum/reagent/consumable/milk,
					/datum/reagent/consumable/soymilk,
					/datum/reagent/consumable/cream,
					/datum/reagent/toxin/coffeepowder,
					/datum/reagent/toxin/teapowder,
					/datum/reagent/consumable/ice,
					/datum/reagent/consumable/menthol,
					/datum/reagent/consumable/grenadine,
					/datum/reagent/consumable/tonic,
					/datum/reagent/consumable/sugar,
					/datum/reagent/consumable/vanilla,
					/datum/reagent/consumable/blackpepper,
					/datum/reagent/toxin/mushroom_powder,
					/datum/reagent/consumable/enzyme,
					/datum/reagent/blood,
					/datum/reagent/water,
					/datum/reagent/consumable/eggyolk,
					/datum/reagent/consumable/nutriment,
					/datum/reagent/consumable/coco,
					/datum/reagent/consumable/honey,
					/datum/reagent/iron,)

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



/obj/item/inducer/cyborg/attackby(obj/item/Weapon, mob/user)
	if(Weapon.tool_behaviour == TOOL_SCREWDRIVER)
		return
	if(istype(Weapon, /obj/item/stock_parts/cell))
		return

/obj/item/inducer/cyborg/recharge(atom/movable/TargetAtom, mob/user)
	if(!iscyborg(user))
		return
	var/mob/living/silicon/robot/borgUser = user
	cell = borgUser.cell
	if(!isturf(TargetAtom) && user.loc == TargetAtom)
		return FALSE
	if(recharging)
		return TRUE
	else
		recharging = TRUE
	var/obj/item/stock_parts/cell/targetCell = TargetAtom.get_cell()
	var/obj/targetObject
	var/coefficient = 1
	if(istype(TargetAtom, /obj/item/gun/energy))
		to_chat(user, span_alert("Error unable to interface with device."))
		return FALSE
	if(istype(TargetAtom, /obj/item/clothing/suit/space))
		to_chat(user, span_alert("Error unable to interface with device."))
		return FALSE
	if(cell.charge <= 1000 ) // Cyborg charge safety. Prevents a borg from inducing themself to death.
		to_chat(user, span_alert("Unable to charge device. User battery safety engaged."))
		return
	if(istype(TargetAtom, /obj))
		targetObject = A
	if(targetCell)
		var/done_any = FALSE
		if(targetCell.charge >= targetCell.maxcharge)
			to_chat(user, span_notice("[targetAtom] is fully charged!"))
			recharging = FALSE
			return TRUE
		user.visible_message(span_notice("[user] starts recharging [targetAtom] with [src]."), span_notice("You start recharging [targetAtom] with [src]."))
		while(targetCell.charge < targetCell.maxcharge)
			if(do_after(user, 10, target = user) && cell.charge)
				done_any = TRUE
				induce(targetCell, coefficient)
				do_sparks(1, FALSE, targetAtom)
				if(targetObject)
					targetObject.update_appearance()
			else
				break
		if(done_any) // Only show a message if we succeeded at least once
			user.visible_message(span_notice("[user] recharged [targetAtom]!"), span_notice("You recharged [targetAtom]!"))
		recharging = FALSE
		return TRUE
	recharging = FALSE


/obj/item/inducer/attack(mob/M, mob/living/user)
	if(user.combat_mode)
		return ..()

	if(cantbeused(user))
		return

	if(recharge(M, user))
		return
	return ..()

/obj/item/inducer/cyborg/attack_self(mob/user)
	return
