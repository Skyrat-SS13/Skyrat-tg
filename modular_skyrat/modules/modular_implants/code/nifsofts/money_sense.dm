/obj/item/disk/nifsoft_uploader/money_sense
	name = "Automatic Apprasial"
	loaded_nifsoft = /datum/nifsoft/money_sense

/datum/nifsoft/money_sense
	name = "Automatic Appraisal" //Placeholder name until I figure out something cooler
	program_desc = "Connects the user's brain to a database containing the current monetary values for most items, allowing them to determine their value in realtime"
	active_mode = TRUE
	active_cost = 0.5
	compatible_nifs = list(/obj/item/organ/internal/cyberimp/brain/nif/standard)

/datum/nifsoft/money_sense/activate()
	. = ..()
	if(active)
		ADD_TRAIT(linked_mob, TRAIT_EXPORT_VALUE_VIEWER, NIFSOFT_TRAIT)
		return

	if(HAS_TRAIT(linked_mob, TRAIT_EXPORT_VALUE_VIEWER))
		REMOVE_TRAIT(linked_mob, TRAIT_EXPORT_VALUE_VIEWER, NIFSOFT_TRAIT)

/obj/item/examine(mob/user)
	. = ..()

	if(HAS_TRAIT(user, TRAIT_EXPORT_VALUE_VIEWER)) //This nesting isn't ideal, but early returning may cause issues.
		var/export_text
		var/scanned_item = src

		//This is the code from the cargo scanner, but without the ability to scan and get tips from items.
		var/datum/export_report/export = export_item_and_contents(scanned_item, dry_run=TRUE)
		var/price = 0

		for(var/x in export.total_amount)
			price += export.total_value[x]
		if(price)
			export_text = span_noticealien("This item has an export value of: <b>[price] credits.")
		else
			export_text = span_warning("This item has no export value.")

		. += export_text


