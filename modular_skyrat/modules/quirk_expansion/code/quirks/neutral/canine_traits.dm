/datum/quirk/item_quirk/canine
	name = "Canidae Traits"
	desc = "Bark. You seem to act like a canine for whatever reason."
	icon = "canine"
	value = 0
	medical_record_text = "Patient was seen digging through the trash can. Keep an eye on them."

/datum/quirk/item_quirk/canine/add_unique()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/internal/tongue/old_tongue = human_holder.getorganslot(ORGAN_SLOT_TONGUE)
	old_tongue.Remove(human_holder)
	qdel(old_tongue)

	var/obj/item/organ/internal/tongue/dog/new_tongue = new(get_turf(human_holder))
	new_tongue.Insert(human_holder)
