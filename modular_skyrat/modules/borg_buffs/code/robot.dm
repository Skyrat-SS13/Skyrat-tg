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

/obj/item/cooking/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_KNIFE ? "screw" : "bolt"] head."

/obj/item/cooking/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour != TOOL_ROLLINGPIN)
		tool_behaviour = TOOL_ROLLINGPIN
		to_chat(user, "<span class='notice'>You attach the rolling pin bit to [src].</span>")
		icon_state = "rolling_bolt_cyborg"
	else
		tool_behaviour = TOOL_KNIFE
		to_chat(user, "<span class='notice'>You attach the knife bit to [src].</span>")
		icon_state = "knife_screw_cyborg"

/obj/item/borg/upgrade/robot_ewelder
	name = "electrical welding tool"
	desc = "An experimental welding tool capable of welding functionality through the use of electricity. The flame seems almost cold."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/robot_ewelder/action(mob/living/silicon/robot/targeted_robot, user = usr)
	. = ..()
	if (!.)
		return
	var/obj/item/weldingtool/electric/e_welding = locate() in targeted_robot.model.modules
	if (e_welding)
		to_chat(user, span_warning("This borg already has an electric welding tool!"))
		return FALSE
	e_welding = new(targeted_robot.model)
	targeted_robot.model.basic_modules += e_welding
	targeted_robot.model.add_module(e_welding, FALSE, TRUE)

/obj/item/borg/upgrade/robot_ewelder/deactivate(mob/living/silicon/robot/targeted_robot, user = usr)
	. = ..()
	if (!.)
		return
	var/obj/item/weldingtool/electric/e_welding = locate() in targeted_robot.model.modules
	if (e_welding)
		targeted_robot.model.remove_module(e_welding, TRUE)

/datum/design/robot_ewelder
	name = "Cyborg Upgrade (Electric Welding Tool)"
	id = "borg_upgrade_ewelder"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/robot_ewelder
	materials = list(/datum/material/iron = 4000, /datum/material/glass = 500, /datum/material/plasma = 500)
	construction_time = 120
	category = list("Cyborg Upgrade Modules")
