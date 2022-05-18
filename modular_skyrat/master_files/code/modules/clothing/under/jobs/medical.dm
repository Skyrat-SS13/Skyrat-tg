/obj/item/clothing/under/rank/medical
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/medical_digi.dmi'	// Anything that was in the medical.dmi, should be in the medical_digi.dmi

/obj/item/clothing/under/rank/medical/doctor/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/rank/medical/chemist/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/rank/medical/scrubs/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'
	icon_state = "scrubswhite" // Because for some reason TG's scrubs dont have an icon on their basetype
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one seems to be the original Scrub." // Just an easter-egg

/obj/item/clothing/under/rank/medical/paramedic/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'

// Add a 'medical/chief_medical_officer/skyrat' or 'medical/virologist/skyrat' if you make CMO or Virologist uniforms

/obj/item/clothing/under/rank/medical/doctor/skyrat/utility
	name = "medical utility uniform"
	desc = "A utility uniform worn by Medical doctors."
	icon_state = "util_med"

/obj/item/clothing/under/rank/medical/doctor/skyrat/utility/syndicate
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40) // Same stats as the tactical turtleneck.
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/medical/chemist/skyrat/formal
	name = "chemist's formal jumpsuit"
	desc = "A white shirt with left-aligned buttons and an orange stripe, lined with protection against chemical spills."
	icon_state = "pharmacologist"

/obj/item/clothing/under/rank/medical/chemist/skyrat/formal/skirt
	name = "chemist's formal jumpskirt"
	icon_state = "pharmacologist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/medical/scrubs/skyrat/red
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in a deep red."
	icon_state = "scrubsred"

/obj/item/clothing/under/rank/medical/scrubs/skyrat/white
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in a cream white colour."
	icon_state = "scrubswhite"

/obj/item/clothing/under/rank/medical/paramedic/skyrat/dark
	name = "dark paramedic jumpsuit"
	desc = "It's covered in reflective strips and made of a special fiber that provides minor protection against biohazards. It has a reflective white cross on the back denoting that the wearer is a trained paramedic."
	icon_state = "paramedic_dark"

/obj/item/clothing/under/rank/medical/paramedic/skyrat/dark/skirt
	name = "dark paramedic jumpskirt"
	icon_state = "paramedic_skirt_dark"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
