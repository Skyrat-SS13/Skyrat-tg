///A datum for chef ordering options from the chef's computer.
/datum/orderable_item
	///Name of the item shown in the shop.
	var/name
	///Description shown in the shop, set automatically unless it's hard set by the subtype
	var/desc
	///Path of the item that is purchased when ordering us.
	var/obj/item/item_path
	///The category this item will be displayed in.
	var/category_index = NONE
	///How much this item costs to order.
	var/cost_per_order = 10

/datum/orderable_item/New()
	. = ..()
	if(!category_index)
		CRASH("[type] doesn't have a category_index assigned!")
	if(!item_path)
		CRASH("[type] orderable item datum with no item path was created!")
	if(!name)
		name = initial(item_path.name)
	if(!desc)
		desc = initial(item_path.desc)

/datum/orderable_item/Destroy(force)
	if(item_path)
		qdel(item_path)
	return ..()
