#define SYNTH_EMP_BRAIN_DAMAGE 20
#define SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM 75
#define SYNTH_BRAIN_WAKE_THRESHOLD 50
#define SYNTH_BRAIN_DAMAGE_MESSAGE_INTERVAL 20 SECONDS

/obj/item/organ/internal/brain/synth
	name = "compact positronic brain"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC | ORGAN_SYNTHETIC_FROM_SPECIES
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"
	/// The last time (in ticks) a message about brain damage was sent. Don't touch.
	var/last_message_time = 0

/obj/item/organ/internal/brain/synth/Insert(mob/living/carbon/user, special = FALSE, drop_if_replaced = TRUE, no_id_transfer = FALSE)
	. = ..()

	if(user.stat != DEAD || !ishuman(user))
		return

	var/mob/living/carbon/human/user_human = user
	if(user_human?.dna?.species && (REVIVES_BY_HEALING in user_human.dna.species.species_traits) && user_human.health > SYNTH_BRAIN_WAKE_THRESHOLD)
		user_human.revive(FALSE)

/obj/item/organ/internal/brain/synth/emp_act(severity)
	// This value is the protection value!
	. = ..()

	// If EMP protected, or light EMPed, don't emp_act.
	if(. & EMP_PROTECT_SELF || severity != EMP_HEAVY)
		return

	apply_organ_damage(SYNTH_EMP_BRAIN_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM)

/obj/item/organ/internal/brain/synth/apply_organ_damage(damage_amount, maximumm, required_organtype)
	. = ..()

	if(owner && damage > 0 && (world.time - last_message_time) > SYNTH_BRAIN_DAMAGE_MESSAGE_INTERVAL)
		last_message_time = world.time

		if(damage > BRAIN_DAMAGE_SEVERE)
			to_chat(owner, span_warning("Alert: Severe corruption in central processing unit."))
			return

		if(damage > BRAIN_DAMAGE_MILD)
			to_chat(owner, span_warning("Alert: Minor corruption in central processing unit."))

/obj/item/organ/internal/brain/synth/circuit
	name = "compact AI circuit"
	desc = "A compact and extremely complex circuit, perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/alt_silicon_brains.dmi'
	icon_state = "circuit-occupied"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/organ/internal/brain/synth/mmi
	name = "compact man-machine interface"
	desc = "A compact man-machine interface, perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. Unfortunately, the brain seems to be permanently attached to the circuitry, and it seems relatively sensitive to it's environment. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "mmi-ipc"

#undef SYNTH_EMP_BRAIN_DAMAGE
#undef SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM
#undef SYNTH_BRAIN_WAKE_THRESHOLD
#undef SYNTH_BRAIN_DAMAGE_MESSAGE_INTERVAL
