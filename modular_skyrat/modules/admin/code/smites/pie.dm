//Drops a pie into the face of your victim
/datum/smite/pie
	name = "Pie"

/datum/smite/pie/effect(client/user, mob/living/target)
	. = ..()
	var/obj/item/food/pie/cream/nostun/creamy = new(get_turf(target))
	var/datum/component/splat/splat_handler = creamy.GetComponent(/datum/component/splat)
	splat_handler.splat(splat_handler, target)
