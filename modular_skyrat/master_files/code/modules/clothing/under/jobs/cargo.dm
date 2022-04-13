/obj/item/clothing/under/rank/cargo
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo_digi.dmi' //Anything that was in the cargo.dmi, should be in the cargo_digi.dmi

/obj/item/clothing/under/rank/cargo/tech/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'

/obj/item/clothing/under/rank/cargo/qm/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'

//Add a /obj/item/clothing/under/rank/cargo/miner/skyrat if you add miner uniforms

////////////////////////////////////////
////////////// CARGO TECH //////////////
/obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'
	name = "supply utility uniform"
	desc = "A utility uniform worn by Supply and Delivery services."
	icon_state = "util_cargo"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/utility/syndicate
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40) //Same stats as the tactical turtleneck.
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/cargo/tech/skyrat/long
	name = "cargo technician's long jumpsuit"
	desc = "For crate-pushers who'd rather protect their legs than show them off."
	icon_state = "cargo_long"
	alt_covers_chest = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/gorka
	name = "supply gorka"
	desc = "A fancy gorka worn by Supply and Delivery services."
	icon_state = "gorka_cargo"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck
	name = "supply turtleneck"
	desc = "A snug turtleneck sweater worn by Supply and Delivery services."
	icon_state = "turtleneck_cargo"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/evil
	name = "black cargo uniform"
	desc = "Yep, here’s your problem. Someone set this thing to evil."
	icon_state = "qmsynd"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/casualman
	name = "cargo tech casual wear"
	desc = "A Cargonium brown with matching trousers. It's adjusted for pushing crates."
	icon_state = "cargotechjean"
	can_adjust = FALSE

/////////////////////////////////////////
///////////// QUARTERMASTER /////////////

/obj/item/clothing/under/rank/cargo/qm/skyrat/gorka
	name = "quartermaster's gorka"
	desc = "A fancy gorka worn by Supply and Delivery's head of staff, as shown by the fancy silver badge."
	icon_state = "gorka_qm"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck
	name = "quartermaster's turtleneck"
	desc = "A snug turtleneck sweater worn by Supply and Delivery's head of staff, as shown by the fancy silver badge."
	icon_state = "turtleneck_qm"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/syndie
	name = "deck officer's jumpsuit"
	desc = "A dark suit with a classic cargo vest. For the ultimate master of all things paper."
	icon_state = "qmsynd"
	has_sensor = NO_SENSORS
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40)
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/formal
	name = "quartermaster's formal jumpsuit"
	desc = "A white shirt with some Cargoium Brown trousers. Expect to see a shotgun wrapped around it."
	icon_state = "supply_chief"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/formal/skirt
	name = "quartermaster's formal jumpskirt"
	desc = "A white shirt with a Cargoium Brown skirt. Expect to see a shotgun wrapped around it."
	icon_state = "supply_chief"
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/cargo/qm/skyrat/casual
	name = "quartermaster's casual wear"
	desc = "A Cargonium brown jacket with matching trousers. Expect to see a shotgun shells in the pockets."
	icon_state = "qmc"
	inhand_icon_state = "lb_suit"
