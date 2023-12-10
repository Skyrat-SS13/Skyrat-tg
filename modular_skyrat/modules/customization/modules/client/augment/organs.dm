/datum/augment_item/organ
	category = AUGMENT_CATEGORY_ORGANS

/datum/augment_item/organ/apply(mob/living/carbon/human/human_holder, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return

	var/obj/item/organ/organ_path = path // cast this to an organ so we can get the slot from it using initial()
	var/obj/item/organ/new_organ = new path()
	new_organ.copy_traits_from(human_holder.get_organ_slot(initial(organ_path.slot)))
	new_organ.Insert(human_holder, special = TRUE, drop_if_replaced = FALSE)

//HEARTS
/datum/augment_item/organ/heart
	slot = AUGMENT_SLOT_HEART

/datum/augment_item/organ/heart/cybernetic
	name = "Cybernetic heart"
	path = /obj/item/organ/internal/heart/cybernetic

//LUNGS
/datum/augment_item/organ/lungs
	slot = AUGMENT_SLOT_LUNGS

/datum/augment_item/organ/lungs/hot
	name = "Lungs Adapted to Heat"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/internal/lungs/hot
	cost = 1

/datum/augment_item/organ/lungs/cold
	name = "Cold-Adapted Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/internal/lungs/cold
	cost = 1
/datum/augment_item/organ/lungs/toxin
	name = "Lungs Adapted to Toxins"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/internal/lungs/toxin
	cost = 1
/datum/augment_item/organ/lungs/oxy
	name = "Low-Pressure Adapted Lungs"
	slot = AUGMENT_SLOT_LUNGS
	path = /obj/item/organ/internal/lungs/oxy
	cost = 1
/datum/augment_item/organ/lungs/cybernetic
	name = "Cybernetic lungs"
	path = /obj/item/organ/internal/lungs/cybernetic

//LIVERS
/datum/augment_item/organ/liver
	slot = AUGMENT_SLOT_LIVER

/datum/augment_item/organ/liver/cybernetic
	name = "Cybernetic liver"
	path = /obj/item/organ/internal/liver/cybernetic

//STOMACHES
/datum/augment_item/organ/stomach
	slot = AUGMENT_SLOT_STOMACH

/datum/augment_item/organ/stomach/cybernetic
	name = "Cybernetic stomach"
	path = /obj/item/organ/internal/stomach/cybernetic

//EYES
/datum/augment_item/organ/eyes
	slot = AUGMENT_SLOT_EYES

/datum/augment_item/organ/eyes/cybernetic
	name = "Cybernetic eyes"
	path = /obj/item/organ/internal/eyes/robotic

/datum/augment_item/organ/eyes/cybernetic/moth
	name = "Cybernetic moth eyes"
	path = /obj/item/organ/internal/eyes/robotic/moth

/datum/augment_item/organ/eyes/highlumi
	name = "High-luminosity eyes"
	path = /obj/item/organ/internal/eyes/robotic/glow
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	cost = 1

/datum/augment_item/organ/eyes/highlumi/moth
	name = "High Luminosity Moth Eyes"
	path = /obj/item/organ/internal/eyes/robotic/glow/moth
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	cost = 1

//TONGUES
/datum/augment_item/organ/tongue
	slot = AUGMENT_SLOT_TONGUE

/datum/augment_item/organ/tongue/normal
	name = "Organic tongue"
	path = /obj/item/organ/internal/tongue/human

/datum/augment_item/organ/tongue/robo
	name = "Robotic voicebox"
	path = /obj/item/organ/internal/tongue/robot

/datum/augment_item/organ/tongue/cybernetic
	name = "Cybernetic tongue"
	path = /obj/item/organ/internal/tongue/cybernetic

/datum/augment_item/organ/tongue/forked
	name = "Forked tongue"
	path = /obj/item/organ/internal/tongue/lizard
