/obj/item/twohanded/clockwork
	name = "Clockwork Weapon"
	desc = "Something"
	icon = 'modular_skyrat/modules/clockworkcult/icons/obj/clockwork_objects.dmi'
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi';
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 20
	throw_speed = 4
	armour_penetration = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacked", "poked", "jabbed", "torn", "gored")
	sharpness = SHARP_EDGED
	max_integrity = 200
	var/clockwork_hint = ""
	var/obj/effect/proc_holder/spell/targeted/summon_spear/SS
	var/wielded = FALSE // track wielded status on item

/obj/item/twohanded/clockwork/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/twohanded/clockwork/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=15, force_wielded=5)

/// triggered on wield of two handed item
/obj/item/twohanded/clockwork/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE
	if(is_servant_of_ratvar(user))
		SS = new
		SS.marked_item = src
		user.mind.AddSpell(SS)

/// triggered on unwield of two handed item
/obj/item/twohanded/clockwork/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/twohanded/clockwork/examine(mob/user)
	. = ..()
	if(is_servant_of_ratvar(user) && clockwork_hint)
		. += clockwork_hint

/obj/item/twohanded/clockwork/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!is_reebe(user.z))
		return
	if(!QDELETED(target) && target.stat != DEAD && !is_servant_of_ratvar(target) && !target.anti_magic_check() && wielded)
		hit_effect(target, user)

/obj/item/twohanded/clockwork/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!is_reebe(z))
		return
	if(isliving(hit_atom))
		var/mob/living/target = hit_atom
		if(!.)
			if(!target.anti_magic_check() && !is_servant_of_ratvar(target))
				hit_effect(target, throwingdatum.thrower, TRUE)

/obj/item/twohanded/clockwork/proc/hit_effect(mob/living/target, mob/living/user, thrown=FALSE)
	return

/obj/item/twohanded/clockwork/brass_spear
	name = "brass spear"
	desc = "A razor-sharp spear made of brass. It thrums with barely-contained energy."
	icon_state = "ratvarian_spear"
	throwforce = 36
	sharpness = SHARP_EDGED
	armour_penetration = 24
	clockwork_hint = "Throwing the spear will deal bonus damage while on Reebe."

/obj/item/twohanded/clockwork/brass_spear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=15, force_wielded=24)

/obj/item/twohanded/clockwork/brass_battlehammer
	name = "brass battle-hammer"
	desc = "A brass hammer glowing with energy."
	icon_state = "ratvarian_hammer"
	throwforce = 25
	armour_penetration = 6
	attack_verb_continuous = list("bashed", "smitted", "hammered", "attacked")
	clockwork_hint = "Enemies hit by this will be flung back while on Reebe."

/obj/item/twohanded/clockwork/brass_battlehammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=15, force_wielded=25)

/obj/item/twohanded/clockwork/brass_battlehammer/hit_effect(mob/living/target, mob/living/user, thrown=FALSE)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, thrown ? 2 : 1, 4)

/obj/item/twohanded/clockwork/brass_sword
	name = "brass longsword"
	desc = "A large sword made of brass."
	icon_state = "ratvarian_sword"
	throwforce = 20
	armour_penetration = 12
	attack_verb_continuous = list("attacked", "slashed", "cut", "torn", "gored")
	clockwork_hint = "Targets will be struck with a powerful electromagnetic pulse while on Reebe."
	var/emp_cooldown = 0

/obj/item/twohanded/clockwork/brass_sword/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=15, force_wielded=26)

/obj/item/twohanded/clockwork/brass_sword/hit_effect(mob/living/target, mob/living/user, thrown)
	if(world.time > emp_cooldown)
		target.emp_act(EMP_LIGHT)
		emp_cooldown = world.time + 300
		addtimer(CALLBACK(src, .proc/send_message, user), 300)
		to_chat(user, "<span class='brass'>You strike [target] with an electromagnetic pulse!</span>")
		playsound(user, 'sound/magic/lightningshock.ogg', 40)

/obj/item/twohanded/clockwork/brass_sword/proc/send_message(mob/living/target)
	to_chat(target, "<span class='brass'>[src] glows, indicating the next attack will disrupt electronics of the target.</span>")

/obj/item/gun/ballistic/bow/clockwork
	name = "Brass Bow"
	desc = "A bow made from brass and other components that you can't quite understand. It glows with a deep energy and frabricates arrows by itself."
	icon_state = "bow_clockwork"
	force = 10
	mag_type = /obj/item/ammo_box/magazine/internal/bow/clockcult
	var/recharge_time = 15

/obj/item/gun/ballistic/bow/clockwork/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	addtimer(CALLBACK(src, .proc/recharge_bolt), recharge_time)

/obj/item/gun/ballistic/bow/clockwork/attack_self(mob/living/user)
	if (chambered)
		chambered = null
		to_chat(user, "<span class='notice'>You dispell the arrow.</span>")
	else if (get_ammo())
		var/obj/item/I = user.get_active_held_item()
		if (do_mob(user,I,5))
			to_chat(user, "<span class='notice'>You draw back the bowstring.</span>")
			playsound(src, 'modular_skyrat/modules/clockworkcult/sounds/weapons/bowdraw.ogg', 75, 0) //gets way too high pitched if the freq varies
			chamber_round()
	update_icon()

/obj/item/gun/ballistic/bow/clockwork/proc/recharge_bolt()
	if(magazine.get_round(TRUE))
		return
	var/obj/item/ammo_casing/caseless/arrow/clockbolt/CB = new
	magazine.give_round(CB)
	update_icon()

/obj/item/gun/ballistic/bow/clockbolt/attackby(obj/item/I, mob/user, params)
	return

/obj/item/ammo_box/magazine/internal/bow/clockcult
	ammo_type = /obj/item/ammo_casing/caseless/arrow/clockbolt
	start_empty = FALSE

/obj/item/ammo_casing/caseless/arrow/clockbolt
	name = "energy bolt"
	desc = "An arrow made from a strange energy."
	icon_state = "arrow_redlight"
	projectile_type = /obj/projectile/energy/clockbolt

/obj/projectile/energy/clockbolt
	name = "energy bolt"
	icon_state = "arrow_energy"
	damage = 24
	damage_type = BURN
	nodamage = FALSE
