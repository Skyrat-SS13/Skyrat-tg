/// Self Destructing Bodyparts, For Augmentation. I'm leaving out heads + chests as, while it would be cool for synths, I also don't want people to start the round unrevivable sans botany because they're dumb as heck. You know who and what you are.
/obj/item/bodypart/arm/left/selfdestruct/try_attach_limb(mob/living/carbon/limb_owner, special)
	. = ..()
	drop_limb()
	qdel(src)

/obj/item/bodypart/arm/right/selfdestruct/try_attach_limb(mob/living/carbon/limb_owner, special)
	. = ..()
	drop_limb()
	qdel(src)

/obj/item/bodypart/leg/left/selfdestruct/try_attach_limb(mob/living/carbon/limb_owner, special)
	. = ..()
	drop_limb()
	qdel(src)

/obj/item/bodypart/leg/right/selfdestruct/try_attach_limb(mob/living/carbon/limb_owner, special)
	. = ..()
	drop_limb()
	qdel(src)
