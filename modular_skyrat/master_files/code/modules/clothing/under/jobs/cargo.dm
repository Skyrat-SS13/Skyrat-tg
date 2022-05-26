/obj/item/clothing/under/rank/cargo
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo_digi.dmi' // Anything that was in the cargo.dmi, should be in the cargo_digi.dmi

/obj/item/clothing/under/rank/cargo/tech/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'

/obj/item/clothing/under/rank/cargo/qm/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'

// Add a /obj/item/clothing/under/rank/cargo/miner/skyrat if you add miner uniforms

/*
*	CARGO TECH
*/

/obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'
	name = "supply utility uniform"
	desc = "A utility uniform worn by employees of the Supply department."
	icon_state = "util_cargo"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/utility/syndicate
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40) // Same stats as the tactical turtleneck.
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/cargo/tech/skyrat/long
	name = "cargo technician's long jumpsuit"
	desc = "For crate-pushers who'd rather protect their legs than show them off."
	icon_state = "cargo_long"
	alt_covers_chest = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/gorka
	name = "supply gorka"
	desc = "A rugged, utilitarian gorka worn by the Supply department."
	icon_state = "gorka_cargo"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck
	name = "supply turtleneck"
	desc = "A snug turtleneck sweater worn by the Supply department.."
	icon_state = "turtleneck_cargo"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck/skirt
	name = "supply skirtleneck"
	desc = "A snug turtleneck sweater worn by Supply, this time with a skirt attached!"
	icon_state = "skirtleneck"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/evil
	name = "black cargo uniform"
	desc = "A standard cargo uniform with a more... Venerable touch to it."
	icon_state = "qmsynd"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/casualman
	name = "cargo technician casualwear"
	desc = "A pair of stylish black jeans and a regular sweater for the relaxed technician."
	icon_state = "cargotechjean"
	can_adjust = FALSE

/*
*	QUARTERMASTER
*/

/obj/item/clothing/under/rank/cargo/qm/skyrat/gorka
	name = "quartermaster's gorka"
	desc = "A rugged, utilitarian gorka with silver markings. Unlike the regular employees', this one is lined with silk on the inside."
	icon_state = "gorka_qm"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck
	name = "quartermaster's turtleneck"
	desc = "A snug turtleneck sweater worn by the Quartermaster, characterized by the expensive-looking pair of suit pants."
	icon_state = "turtleneck_qm"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck/skirt
	name = "quartermaster's skirtleneck"
	desc = "A snug turtleneck sweater worn by the Quartermaster, as shown by the elegant double-lining of its silk skirt."
	icon_state = "skirtleneckQM"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/syndie
	name = "deck officer's jumpsuit"
	desc = "A dark suit with a classic cargo vest. For the ultimate master of all things paper."
	icon_state = "qmsynd"
	has_sensor = NO_SENSORS
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40)
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/formal
	name = "quartermaster's formal jumpsuit"
	desc = "A western-like alternate uniform for the old fashioned QM."
	icon_state = "supply_chief"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/formal/skirt
	name = "quartermaster's formal jumpskirt"
	desc = "A western-like alternate uniform for the old fashioned QM. Skirt included!"
	icon_state = "supply_chief"
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/cargo/qm/skyrat/casual
	name = "quartermaster's casualwear"
	desc = "A brown jacket with matching trousers for the relaxed Quartermaster."
	icon_state = "qmc"
	inhand_icon_state = "lb_suit"
