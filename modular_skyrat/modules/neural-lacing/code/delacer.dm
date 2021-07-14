/obj/item/stackremover
	name = "cortical stack remover"
	desc = "A pair of tweezer-like knives, used to quickly extract a stack after death."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "shears"
	flags_1 = CONDUCT_1
	item_flags = SURGICAL_TOOL
	toolspeed  = 1
	force = 12
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 6
	throw_speed = 2
	throw_range = 5
	custom_materials = list(/datum/material/iron=8000, /datum/material/titanium=6000)
	attack_verb_continuous = list("shears", "snips")
	attack_verb_simple = list("shear", "snip")
	sharpness = SHARP_EDGED
	custom_premium_price = PAYCHECK_MEDIUM * 14

/obj/item/stackremover/syndicate
	name = "blood-red cortical stack remover"
	desc = "A pair of tweezer-like knives, used to quickly extract a stack after death. This one is shaped like a double-helix with blood-red blades. Are you a believer?"
	toolspeed  = 0.5
	force = 27
	armour_penetration = 40

/datum/uplink_item/device_tools/corticalstackremover
	name = "Blood-Red Cortical Stack Remover"
	desc = "For those who wont be quiet... Are you a believer?"
	item = /obj/item/stackremover/syndicate
	cost = 15 //Support item. Dangerous


/obj/item/stackremover/attack(mob/living/M, mob/living/user)
	var/mob/living/carbon/patient = M
	if(!iscarbon(M) || user.combat_mode)
		return ..()
	if(!patient.getorganslot("stack"))
		return ..()
	var/amputation_speed_mod = 1
	var/obj/item/organ/corticalstack/CSTACK = patient.getorganslot("stack")
	patient.visible_message(span_danger("[user] begins to secure [src] around [patient]'s neck."), span_userdanger("[user] begins to secure [src] around your neck"))
	playsound(get_turf(patient), 'sound/items/ratchet.ogg', 20, TRUE)
	if(patient.stat >= UNCONSCIOUS || HAS_TRAIT(patient, TRAIT_INCAPACITATED)) //if you're incapacitated (due to paralysis, a stun, being in staminacrit, etc.), critted, unconscious, or dead, it's much easier to properly line up a snip
		amputation_speed_mod *= 0.5
	if(patient.stat != DEAD && patient.jitteriness) //jittering will make it harder to secure the shears, even if you can't otherwise move
		amputation_speed_mod *= 1.5 //15*0.5*1.5=11.25, so staminacritting someone who's jittering (from, say, a stun baton) won't give you enough time to snip their head off, but staminacritting someone who isn't jittering will

	if(do_after(user,  toolspeed * 5 SECONDS * amputation_speed_mod, target = patient))
		playsound(get_turf(patient), 'sound/weapons/bladeslice.ogg', 250, TRUE)
		CSTACK.Remove(patient)
		CSTACK.forceMove(get_turf(patient))
		user.visible_message(span_danger("[src] violently spears in, ripping out [patient]'s [CSTACK]."), span_notice("You rip out [patient]'s [CSTACK] with [src]."))
