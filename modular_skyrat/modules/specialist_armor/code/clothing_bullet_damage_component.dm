/// Component that lets clothing be damaged in zones by piercing bullets. The parent MUST have limb_integrity set.
/datum/component/clothing_damaged_by_bullets
	/// How much of the incoming projectile damage is taken, multiplier
	var/projectile_damage_multiplier
	/// Who is wearing the target?
	var/mob/living/wearer

/datum/component/clothing_damaged_by_bullets/Initialize(projectile_damage_multiplier = 1)
	if(!istype(parent, /obj/item/clothing)) // Just in case someone loses it and tries to put this on something that's not clothing
		return COMPONENT_INCOMPATIBLE
		message_admins("PASSED THE CLOTHING CHECK")

	var/obj/item/clothing/parent_clothing = parent

	src.projectile_damage_multiplier = projectile_damage_multiplier

	if(ismob(parent_clothing.loc))
		var/mob/holder = parent_clothing.loc
		message_admins("IT WAS ON A MOB")
		if(holder.is_holding(parent_clothing))
			message_admins("NVM THEY WERE HOLDING IT")
			return
		set_wearer(holder)

/datum/component/clothing_damaged_by_bullets/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipped))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(lost_wearer))

/datum/component/clothing_damaged_by_bullets/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ATOM_EXAMINE, COMSIG_ITEM_DROPPED, COMSIG_ITEM_EQUIPPED, COMSIG_QDELETING, COMSIG_ATOM_BULLET_ACT))

/// Check if we've been equipped to a valid slot to shield
/datum/component/clothing_damaged_by_bullets/proc/on_equipped(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	message_admins("PICKED UP")
	if((slot & ITEM_SLOT_HANDS))
		lost_wearer(source, user)
		message_admins("NVM THEY WERE HOLDING IT")
		return
	set_wearer(user)

/// Either we've been dropped or our wearer has been QDEL'd. Either way, they're no longer our problem
/datum/component/clothing_damaged_by_bullets/proc/lost_wearer(datum/source, mob/user)
	SIGNAL_HANDLER

	message_admins("WEARER LOST WOMP WOMP")
	wearer = null
	UnregisterSignal(parent, list(COMSIG_QDELETING, COMSIG_ATOM_BULLET_ACT))

/// Sets the wearer and registers the appropriate signals for them
/datum/component/clothing_damaged_by_bullets/proc/set_wearer(mob/user)
	if(wearer == user)
		return
	if(!isnull(wearer))
		CRASH("[type] called set_wearer with [user] but [wearer] was already the wearer!")

	wearer = user
	RegisterSignal(wearer, COMSIG_QDELETING, PROC_REF(lost_wearer))
	RegisterSignal(wearer, COMSIG_ATOM_BULLET_ACT, PROC_REF(hit_by_projectile))
	message_admins("WE HAVE A WEARER [wearer] NOW YIPPIE!")

/// Checks an incoming projectile to see if it should damage the thing we're attached to,
/datum/component/clothing_damaged_by_bullets/proc/hit_by_projectile(mob/living/dude_getting_hit, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER

	var/obj/item/clothing/clothing_parent = parent

	message_admins("THE BODY PARTS COVERED ARE [english_list(cover_flags2body_zones(clothing_parent.body_parts_covered))]")
	if(!(def_zone in cover_flags2body_zones(clothing_parent.body_parts_covered)))
		message_admins("AND THE DEF ZONE [def_zone] WASNt IN THAT")
		return
	if(hitting_projectile.sharpness == SHARP_EDGED)
		message_admins("SHARP THING, WE IGNORE IT")
		return
	if(hitting_projectile.damage_type != BRUTE)
		message_admins("WASNT BRUTE DAMAGE, BYE")
		return

	/// This seems complex but the actual math is simple, the damage of the projectile * vest damage multiplier, divided by two if the projectile is weak to armour, then modified by wound bonus
	var/total_damage = ((hitting_projectile.damage * projectile_damage_multiplier) * (hitting_projectile.weak_against_armour ? 0.5 : 1) * (1 + (hitting_projectile.wound_bonus / 10)))
	message_admins("TOTAL DAMAGE TURNED OUT TO BE [total_damage]")
	var/damage_dealt = clothing_parent.take_damage(total_damage, BRUTE, armour_penetration = hitting_projectile.armour_penetration)
	message_admins("AND DAMAGE DEALT RETURNED [damage_dealt]")

	if(clothing_parent.limb_integrity)
		clothing_parent.take_damage_zone(def_zone, damage_dealt, BRUTE)
		message_admins("IT SHOULD HAVE TAKEN LIMB DAMAGE TOO")

/// Warns any examiner that the clothing we're stuck to will be damaged by piercing bullets
/datum/component/clothing_damaged_by_bullets/proc/on_examine(obj/item/source, mob/examiner, list/examine_list)
	SIGNAL_HANDLER

	examine_list += "<br>[span_warning("This will be <b>damaged</b> when it protects you from bullets, taking <b>[projectile_damage_multiplier]</b> times the damage that the bullet deals.")]"
