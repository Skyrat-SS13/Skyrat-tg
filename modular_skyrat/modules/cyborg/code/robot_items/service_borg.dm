#define BASE_SHAKER_JUICE_REAGENTS list(\
		/datum/reagent/consumable/orangejuice,\
		/datum/reagent/consumable/tomatojuice,\
		/datum/reagent/consumable/limejuice,\
		/datum/reagent/consumable/carrotjuice,\
		/datum/reagent/consumable/berryjuice,\
		/datum/reagent/consumable/applejuice,\
		/datum/reagent/consumable/watermelonjuice,\
		/datum/reagent/consumable/lemonjuice,\
		/datum/reagent/consumable/banana,\
		/datum/reagent/consumable/potato_juice,\
		/datum/reagent/consumable/grapejuice,\
		/datum/reagent/consumable/parsnipjuice,\
		/datum/reagent/consumable/pineapplejuice,\
		/datum/reagent/consumable/aloejuice,\
		/datum/reagent/consumable/pumpkinjuice,\
		/datum/reagent/consumable/blumpkinjuice,\
		/datum/reagent/consumable/lemon_lime,\
		/datum/reagent/consumable/peachjuice\
	)

#define BASE_SHAKER_ALCOHOL_REAGENTS list(\
		/datum/reagent/consumable/ethanol,\
		/datum/reagent/consumable/ethanol/beer,\
		/datum/reagent/consumable/ethanol/beer/maltliquor,\
		/datum/reagent/consumable/ethanol/kahlua,\
		/datum/reagent/consumable/ethanol/whiskey,\
		/datum/reagent/consumable/ethanol/vodka,\
		/datum/reagent/consumable/ethanol/gin,\
		/datum/reagent/consumable/ethanol/rum,\
		/datum/reagent/consumable/ethanol/tequila,\
		/datum/reagent/consumable/ethanol/vermouth,\
		/datum/reagent/consumable/ethanol/wine,\
		/datum/reagent/consumable/ethanol/lizardwine,\
		/datum/reagent/consumable/ethanol/amaretto,\
		/datum/reagent/consumable/ethanol/cognac,\
		/datum/reagent/consumable/ethanol/absinthe,\
		/datum/reagent/consumable/ethanol/hooch,\
		/datum/reagent/consumable/ethanol/ale,\
		/datum/reagent/consumable/ethanol/applejack,\
		/datum/reagent/consumable/ethanol/champagne,\
		/datum/reagent/consumable/ethanol/creme_de_menthe,\
		/datum/reagent/consumable/ethanol/creme_de_cacao,\
		/datum/reagent/consumable/ethanol/sake,\
		/datum/reagent/consumable/ethanol/triple_sec,\
		/datum/reagent/consumable/ethanol/creme_de_coconut,\
		/datum/reagent/consumable/nothing,\
		/datum/reagent/consumable/laughter,\
		/datum/reagent/consumable/ethanol/synthanol\
	)

#define BASE_SHAKER_SODA_REAGENTS list(\
		/datum/reagent/consumable/space_cola,\
		/datum/reagent/consumable/dr_gibb,\
		/datum/reagent/consumable/space_up,\
		/datum/reagent/consumable/sodawater,\
		/datum/reagent/consumable/grape_soda,\
		/datum/reagent/consumable/sol_dry,\
		/datum/reagent/consumable/spacemountainwind,\
		/datum/reagent/consumable/pwr_game,\
		/datum/reagent/consumable/shamblers,\
		/datum/reagent/consumable/sugar\
	)

#define BASE_SHAKER_MISC_REAGENTS list(\
		/datum/reagent/consumable/milk,\
		/datum/reagent/consumable/soymilk,\
		/datum/reagent/consumable/coco,\
		/datum/reagent/consumable/cream,\
		/datum/reagent/toxin/coffeepowder,\
		/datum/reagent/toxin/teapowder,\
		/datum/reagent/consumable/ice,\
		/datum/reagent/consumable/menthol,\
		/datum/reagent/consumable/grenadine,\
		/datum/reagent/consumable/tonic,\
		/datum/reagent/consumable/vanilla,\
		/datum/reagent/consumable/blackpepper,\
		/datum/reagent/toxin/mushroom_powder,\
		/datum/reagent/consumable/enzyme,\
		/datum/reagent/blood,\
		/datum/reagent/water,\
		/datum/reagent/consumable/eggyolk,\
		/datum/reagent/consumable/nutriment,\
		/datum/reagent/consumable/honey,\
		/datum/reagent/iron,\
		/datum/reagent/pax/catnip\
	)


/obj/item/reagent_containers/borghypo/borgshaker/specific
	icon = 'modular_skyrat/modules/cyborg/icons/items_cyborg.dmi'
	icon_state = "shaker"

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



/*
*	CYBORG COOKING TOOL
*/

/obj/item/cooking/cyborg/power
	name =	"automated cooking tool"
	desc = "A cyborg fitted module resembling the rolling pins and Knifes"
	icon = 'modular_skyrat/modules/cyborg/icons/items_cyborg.dmi'
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


/*
*	CYBORG SNACK DISPENSER
*/

/obj/item/borg_snack_dispenser
	name = "\improper Automated Borg Snack Dispenser"
	desc = "Has the ability to automatically print many differnt forms of snacks. Now Lizard approved!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "rsf"
	/// Contains the PATH of the selected snack
	var/atom/selected_snack
	/// Whether snacks are launched when targeted at a distance
	var/launch_mode = FALSE
	/// A list of all valid snacks
	var/list/valid_snacks = list(
		/obj/item/food/cookie/bacon,
		/obj/item/food/cookie/cloth,
		/obj/item/food/cookie/sugar,
		/obj/item/food/lollipop/cyborg
	)
	/// Minimum amount of charge a borg can have before snack printing is disallowed
	var/borg_charge_cutoff = 200
	/// The amount of charge used per print of a snack
	var/borg_charge_usage = 50

/obj/item/borg_snack_dispenser/Initialize(mapload)
	. = ..()
	selected_snack = selected_snack ||  LAZYACCESS(valid_snacks, 1)

/obj/item/borg_snack_dispenser/examine(mob/user)
	. = ..()
	. += "It is currently set to dispense [initial(selected_snack.name)]."
	. += "You can AltClick it to [(launch_mode ? "disable" : "enable")] launch mode."

/obj/item/borg_snack_dispenser/attack_self(mob/user, modifiers)
	var/list/choices = list()
	for(var/atom/snack as anything in valid_snacks)
		choices[initial(snack.name)] = snack
	if(!length(choices))
		to_chat(user, span_warning("No valid snacks in database."))
	if(length(choices) == 1)
		selected_snack = choices[1]
	else
		var/selected = tgui_input_list(user, "Select Snack", "Snack Selection", choices)
		if(!selected)
			return
		selected_snack = choices[selected]
	var/snack_name = initial(selected_snack.name)
	to_chat(user, span_notice("[src] is now dispensing [snack_name]."))

/obj/item/borg_snack_dispenser/attack(mob/living/patron, mob/living/silicon/robot/user, params)
	var/empty_hand = LAZYACCESS(patron.get_empty_held_indexes(), 1)
	if(!empty_hand)
		to_chat(user, span_warning("[patron] has no free hands!"))
		return
	if(!selected_snack)
		to_chat(user, span_warning("No snack selected."))
		return
	if(!istype(user))
		CRASH("[src] being used by non borg [user]")
	if(user.cell.charge < borg_charge_cutoff)
		to_chat(user, span_danger("Automated Safety Measures restrict the operation of [src] while under [borg_charge_cutoff]!"))
		return
	if(!user.cell.use(borg_charge_usage))
		to_chat(user, span_danger("Failure printing snack: power failure!"))
		return
	var/atom/snack = new selected_snack(src)
	patron.put_in_hand(snack, empty_hand)
	user.do_item_attack_animation(patron, null, snack)
	playsound(loc, 'sound/machines/click.ogg', 10, TRUE)
	to_chat(patron, span_notice("[user] dispenses [snack] into your empty hand and you reflexively grasp it."))
	to_chat(user, span_notice("You dispense [snack] into the hand of [user]."))

/obj/item/borg_snack_dispenser/AltClick(mob/user)
	launch_mode = !launch_mode
	to_chat(user, span_notice("[src] is [(launch_mode ? "now" : "no longer")] launching snacks at a distance."))

/obj/item/borg_snack_dispenser/afterattack(atom/target, mob/living/silicon/robot/user, proximity_flag, click_parameters)
	if(Adjacent(target) || !launch_mode)
		return ..()
	if(!selected_snack)
		to_chat(user, span_warning("No snack selected."))
		return
	if(!istype(user))
		CRASH("[src] being used by non borg [user]")
	if(user.cell.charge < borg_charge_cutoff)
		to_chat(user, span_danger("Automated Safety Measures restrict the operation of [src] while under [borg_charge_cutoff]!"))
		return
	if(!user.cell.use(borg_charge_usage))
		to_chat(user, span_danger("Failure printing snack: power failure!"))
		return
	var/atom/movable/snack = new selected_snack(get_turf(src))
	snack.throw_at(target, 7, 2, user, TRUE, FALSE)
	playsound(loc, 'sound/machines/click.ogg', 10, TRUE)
	user.visible_message(span_notice("[src] launches [snack] at [target]!"))

/obj/item/food/cookie/bacon
	name = "strip of bacon"
	desc = "BACON!!!"
	icon = 'modular_skyrat/master_files/icons/obj/food/snacks.dmi'
	icon_state = "bacon_strip"
	foodtypes = MEAT

/obj/item/food/cookie/cloth
	name = "odd cookie"
	desc = "A cookie that appears to be made out of... some form of cloth?"
	icon = 'modular_skyrat/master_files/icons/obj/food/snacks.dmi'
	icon_state = "cookie_cloth"
	foodtypes = CLOTH
