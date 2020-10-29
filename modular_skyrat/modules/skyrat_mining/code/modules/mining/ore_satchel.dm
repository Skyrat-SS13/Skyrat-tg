/obj/item/storage/bag/ore/large
	name = "large mining satchel"
	desc = "This bag can hold three times the ore in many small pockets. Shockingly foldable and compact for its volume."

/obj/item/storage/bag/ore/large/ComponentInitialize()
	. = ..()
	var/datum/component/storage/concrete/stack/STR = GetComponent(/datum/component/storage/concrete/stack)
	STR.allow_quick_empty = TRUE
	STR.can_hold = typecacheof(list(/obj/item/stack/ore))
	STR.max_w_class = WEIGHT_CLASS_HUGE
	STR.max_combined_stack_amount = 150