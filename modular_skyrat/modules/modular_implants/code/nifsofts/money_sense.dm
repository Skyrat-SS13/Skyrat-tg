/obj/item/disk/nifsoft_uploader/money_sense
	loaded_nifsoft = /datum/nifsoft/money_sense

/datum/nifsoft/money_sense
	name = "Automatic Appraisal" //Placeholder name until I figure out something cooler
	program_desc = "Connects the user's brain to a database containing the current monetary values for most items, allowing them to determine their value in realtime"
	active_mode = TRUE
	active_cost = 2.5

/datum/nifsoft/money_sense/activate()
	. = ..()
	if(active)
		linked_mob.money_sense = TRUE
		return

	if(linked_mob.money_sense)
		linked_mob.money_sense = FALSE

/mob/living/carbon
	///Is the mob able to see the monetary value of items by examining them?
	var/money_sense = FALSE

/obj/item/examine(mob/living/carbon/user)
	. = ..()

	if(user.money_sense)
		var/export_text
		var/scanned_item = src

		//This is the code from the cargo scanner, but without the ability to scan and get tips from items.
		var/datum/export_report/ex = export_item_and_contents(scanned_item, dry_run=TRUE)
		var/price = 0

		for(var/x in ex.total_amount)
			price += ex.total_value[x]
		if(price)
			export_text = "Scanned [scanned_item], value: <b>[price]."
		else
			export_text = "Scanned [scanned_item], no export value."

		. += export_text
