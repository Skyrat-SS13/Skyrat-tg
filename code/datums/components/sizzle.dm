/datum/component/sizzle
	var/mutable_appearance/sizzling
	var/sizzlealpha = 0
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/sizzle/Initialize()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	setup_sizzle()

/datum/component/sizzle/InheritComponent(datum/component/C, i_am_original)
	var/atom/food = parent
	sizzlealpha += 5
	sizzling.alpha = sizzlealpha
	food.cut_overlay(sizzling)
	food.add_overlay(sizzling)

/datum/component/sizzle/proc/setup_sizzle()
	var/atom/food = parent
	var/icon/grill_marks = icon(food.icon, food.icon_state)
	grill_marks.Blend("#fff", ICON_ADD) //fills the icon_state with white (except where it's transparent)
	grill_marks.Blend(icon('icons/obj/machines/kitchenmachines.dmi', "grillmarks"), ICON_MULTIPLY) //adds grill marks and the remaining white areas become transparent
	sizzling = new(grill_marks)
	sizzling.alpha = sizzlealpha
	food.add_overlay(sizzling)

