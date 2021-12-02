#define BSRPD_CAPAC_MAX 500
#define BSRPD_CAPAC_USE 10
#define BSRPD_CAPAC_NEW 250

/obj/item/pipe_dispenser/bluespace
	name = "bluespace RPD"
	desc = "State of the art technology being tested by NT scientists; this is their only working prototype."
	icon = 'modular_skyrat/modules/bsrpd/icons/bsrpd.dmi'
	icon_state = "bsrpd"
	lefthand_file = 'modular_skyrat/modules/bsrpd/icons/bsrpd_left.dmi'
	righthand_file = 'modular_skyrat/modules/bsrpd/icons/bsrpd_right.dmi'
	inhand_icon_state = "bsrpd"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	custom_materials = null
	var/bs_capac = BSRPD_CAPAC_MAX
	var/bs_use = BSRPD_CAPAC_USE
	var/bs_prog = 0

/obj/item/pipe_dispenser/bluespace/attackby(obj/item/item, mob/user, param)
	if(istype(item, /obj/item/stack/sheet/bluespace_crystal))
		if(BSRPD_CAPAC_NEW > (BSRPD_CAPAC_MAX - bs_capac) || bs_use == 0)
			to_chat(user, span_warning("You cannot recharge [src] anymore!"))
			return
		item.use(1)
		to_chat(user, span_notice("You recharge the bluespace capacitor inside of [src]"))
		bs_capac += BSRPD_CAPAC_NEW
		return
	if(istype(item, /obj/item/assembly/signaler/anomaly/bluespace))
		if(bs_use)
			to_chat(user, span_notice("You slot [item] into [src]; supercharging the bluespace capacitor!"))
			bs_use = 0
			qdel(item)
		else
			to_chat(user, span_warning("You cannot improve the [src] further."))
		return
	return ..()

/obj/item/pipe_dispenser/bluespace/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		. += "Currently has [bs_use == 0 ? "infinite" : bs_capac / bs_use] charges remaining."
		if(bs_use != 0)
			. += "The Bluespace Anomaly Core slot is empty."
	else
		. += "You cannot see the charge capacity."

/obj/item/pipe_dispenser/bluespace/afterattack(atom/target, mob/user, prox)
	if(prox) // If we are in proximity to the target, don't use charge and don't call this shitcode.
		return ..()
	if(bs_capac < (bs_use * (bs_prog + 1)))
		to_chat(user, span_warning("The [src] lacks the charge to do that."))
		return FALSE
	bs_prog++ // So people can't just spam click and get more uses
	user.Beam(target, icon_state = "rped_upgrade", time = 1 SECONDS)
	if(pre_attack(target, user))
		bs_prog--
		bs_capac -= bs_use
		return TRUE
	bs_prog--
	return FALSE

#undef BSRPD_CAPAC_MAX
#undef BSRPD_CAPAC_USE
#undef BSRPD_CAPAC_NEW
