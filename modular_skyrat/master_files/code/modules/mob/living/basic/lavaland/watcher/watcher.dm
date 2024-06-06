/mob/living/basic/mining/watcher/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/crusher_loot, trophy_type = /obj/item/crusher_trophy/watcher_eye, drop_mod = 5, drop_immediately = FALSE)
