#define BSRPD_CAPACITY_MAX 500
#define BSRPD_CAPACITY_USE 10
#define BSRPD_CAPACITY_NEW 250

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
	var/bluespace_capacity = BSRPD_CAPACITY_MAX
	var/bluespace_usage = BSRPD_CAPACITY_USE
	var/bluespace_progress = FALSE

/obj/item/pipe_dispenser/bluespace/attackby(obj/item/item, mob/user, param)
	if(istype(item, /obj/item/stack/sheet/bluespace_crystal))
		if(BSRPD_CAPACITY_NEW > (BSRPD_CAPACITY_MAX - bluespace_capacity) || bluespace_usage == 0)
			to_chat(user, span_warning("You cannot recharge [src] anymore!"))
			return
		item.use(1)
		to_chat(user, span_notice("You recharge the bluespace capacitor inside of [src]"))
		bluespace_capacity += BSRPD_CAPACITY_NEW
		return
	if(istype(item, /obj/item/assembly/signaler/anomaly/bluespace))
		if(bluespace_usage)
			to_chat(user, span_notice("You slot [item] into [src]; supercharging the bluespace capacitor!"))
			bluespace_usage = 0
			qdel(item)
		else
			to_chat(user, span_warning("You cannot improve the [src] further."))
		return
	return ..()

/obj/item/pipe_dispenser/bluespace/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		. += "Currently has [bluespace_usage == 0 ? "infinite" : bluespace_capacity / bluespace_usage] charges remaining."
		if(bluespace_usage != 0)
			. += "The Bluespace Anomaly Core slot is empty."
	else
		. += "You cannot see the charge capacity."

/obj/item/pipe_dispenser/bluespace/afterattack(atom/target, mob/user, prox)
	if(prox) // If we are in proximity to the target, don't use charge and don't call this shitcode.
		return ..()
	if(bluespace_capacity < (bluespace_usage * (bluespace_progress + 1)))
		to_chat(user, span_warning("The [src] lacks the charge to do that."))
		return FALSE
	if(!bluespace_progress)
		user.Beam(target, icon_state = "rped_upgrade", time = 1 SECONDS)
		bluespace_progress = TRUE // So people can't just spam click and get more uses
		addtimer(VARSET_CALLBACK(src, bluespace_progress, FALSE),  1 SECONDS, TIMER_UNIQUE)
		if(pre_attack(target, user))
			bluespace_capacity -= bluespace_usage
			return TRUE

	return FALSE

#undef BSRPD_CAPACITY_MAX
#undef BSRPD_CAPACITY_USE
#undef BSRPD_CAPACITY_NEW
