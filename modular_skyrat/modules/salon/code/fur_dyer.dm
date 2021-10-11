/obj/item/fur_dyer
	name = "electric fur dyer"
	desc = "Dye that is capable of recoloring fur in a mostly permanent way."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "fur_sprayer"

/obj/item/fur_dyer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell)

/obj/item/fur_dyer/attack(mob/living/M, mob/living/user, params)
	if(!ishuman(M))
		return ..()

	var/mob/living/carbon/human/target_human = M

	var/list/list/current_markings = target_human.dna.species.body_markings

	if(!current_markings.len)
		to_chat(user, span_danger("[target_human] has no markings!"))
		return

	if(!(item_use_power(power_use_amount, user) & COMPONENT_POWER_SUCCESS))
		to_chat(user, span_danger("A red light blinks!"))
		return

	var/selected_marking_area = user.zone_selected

	if(!current_markings[selected_marking_area])
		to_chat(user, span_danger("[target_human] has no bodymarkings on this limb!"))
		return

	var/selected_marking_id = tgui_input_list(user, "Please select which marking you'd like to color!", "Select marking", current_markings[selected_marking_area])

	if(!selected_marking_id)
		return

	var/selected_color = input(
			user,
			"Select marking color",
			null,
			COLOR_WHITE,
		) as color | null

	if(!selected_color)
		return

	selected_color = sanitize_hexcolor(selected_color)

	current_markings[selected_marking_area][selected_marking_id] = selected_color

	target_human.update_body()
	target_human.update_body_parts()


