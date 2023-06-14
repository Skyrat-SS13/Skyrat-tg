/obj/item/disk/nifsoft_uploader/money_sense
	name = "Automatic Apprasial"
	loaded_nifsoft = /datum/nifsoft/money_sense

/datum/nifsoft/money_sense
	name = "Automatic Appraisal"
	program_desc = "Connects the user's brain to a database containing the current monetary values for most items, allowing them to determine their value in realtime"
	active_mode = TRUE
	active_cost = 0.5
	compatible_nifs = list(/obj/item/organ/internal/cyberimp/brain/nif/standard)
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = "coins"

/datum/nifsoft/money_sense/activate()
	. = ..()
	if(active)
		linked_mob.AddComponent(/datum/component/money_sense)
		return

	var/found_component = linked_mob.GetComponent(/datum/component/money_sense)
	if(found_component)
		qdel(found_component)

///Added whenever the money_sense NIFSoft is active
/datum/component/money_sense

/datum/component/money_sense/New()
	. = ..()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_MOB_EXAMINATE, .proc/add_examine)

/datum/component/money_sense/Destroy(force, silent)
	. = ..()
	UnregisterSignal(parent, COMSIG_MOB_EXAMINATE)

///Scans the item the user is looking at and generates the cargo value of it.
/datum/component/money_sense/proc/add_examine(mob/user, atom/target)
	SIGNAL_HANDLER

	var/obj/item/examined_item = target
	if(!examined_item || !isobj(examined_item))
		return FALSE

	//This is the code from the cargo scanner, but without the ability to scan and get tips from items.
	var/datum/export_report/export = export_item_and_contents(examined_item, dry_run = TRUE)
	var/price = 0
	var/export_text

	for(var/x in export.total_amount)
		price += export.total_value[x]
	if(price)
		export_text = span_noticealien("This item has an export value of: <b>[price] credits.")
	else
		export_text = span_warning("This item has no export value.")

	to_chat(parent, export_text)
