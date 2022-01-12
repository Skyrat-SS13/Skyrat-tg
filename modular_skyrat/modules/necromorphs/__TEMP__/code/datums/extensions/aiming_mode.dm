/*
	Aiming mode extensions are one of a four part system to allow mobs to aim down the sights of guns. These parts are:
		The aiming mode extension (this)
		The aiming click handler (optional, used for RMB capture)
		The gun which is being used to aim: It must be held in a hand
		The mob doing the aiming, they must remain able bodied and upright
*/
/datum/extension/aim_mode
	name = "Iron Sights"
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE
	base_type = /datum/extension/aim_mode
	var/mob/living/user	//Who is aiming
	var/obj/item/weapon/gun/gun	//What gun are they aiming

	var/active = FALSE	//Prevents double applying things
	var/removed = FALSE	//Set during the process of deletion
	/*
		When aiming down the sights, this aim mode modifies he user in various ways
	*/
	var/view_offset	=	1*WORLD_ICON_SIZE	//How far ahead can the user see?
	var/view_range	=	0	//Modifier to the size of their view area
	//This should generally be a negative value, but any value between -1 and infinity is valid. Positive numbers will make the user move faster while aiming
	//That's dumb, don't do that
	var/accuracy_mod	=	10	//How much more accurate is the user at shooting, while in this aim mode. This should be positive but not too high, it is an added-percentage
	var/damage_mod	=	0	//A percentage of penalty/bonus damage applied to the gun while aiming. Generally -1 to 1 range. 0.1 = 10% bonus
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.6,
	STATMOD_RANGED_ACCURACY = 10)
	auto_register_statmods = FALSE


/datum/extension/aim_mode/New(var/atom/holder, var/obj/item/weapon/gun/_gun)
	.=..()
	user = holder
	gun = _gun
	activate()

/*
	Aiming Mode Types
*/
//Default, when no other is specified. Used for pistols
/datum/extension/aim_mode/basic
	view_offset	=	2*WORLD_ICON_SIZE
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.7,
	STATMOD_RANGED_ACCURACY = 10)

//Light aiming mode, for SMGs and the like. no accuracy bonus, but longer shooting and mild move penalty
/datum/extension/aim_mode/light
	view_offset	=	3*WORLD_ICON_SIZE
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.4,
	STATMOD_RANGED_ACCURACY = 5)

//Heavy guns suck at this
/datum/extension/aim_mode/heavy
	view_offset = 1*WORLD_ICON_SIZE
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.7,
	STATMOD_RANGED_ACCURACY = 10)

//Long guns are better at this
/datum/extension/aim_mode/rifle
	view_offset	=	4*WORLD_ICON_SIZE
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.6,
	STATMOD_RANGED_ACCURACY = 15)

//Sniper rifles are REALLY good at this, but the move penalty is crippling
/datum/extension/aim_mode/sniper
	name = "Scope"
	view_offset	=	8*WORLD_ICON_SIZE
	view_range = -2
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.85,
	STATMOD_RANGED_ACCURACY = 40)


/*
	Core Code
*/

/datum/extension/aim_mode/proc/safety()
	//Run periodically
	if (user && gun)
		if(gun.loc == user && gun.is_held())
			return TRUE

	//if we get here, fail, delete the extension, deactivate
	remove()
	return FALSE

/datum/extension/aim_mode/proc/activate()
	if (active || !safety())
		return FALSE


	active = TRUE
	user.view_range += src.view_range
	user.view_offset += src.view_offset
	register_statmods()
	user.reset_view()

	gun.damage_factor += damage_mod



/datum/extension/aim_mode/proc/deactivate()
	if (!active)	//Make sure we don't deactivate multiple times and give user negative stats
		return

	active = FALSE
	if (user)
		user.view_range -= src.view_range
		user.view_offset -= src.view_offset
		unregister_statmods()
		user.reset_view()

	if (gun)
		gun.damage_factor -= damage_mod


/datum/extension/aim_mode/proc/remove()
	removed = TRUE

	//Ends this extension.
	if (active)
		deactivate()

	if (user && !QDELETED(src))
		remove_extension(user, /datum/extension/aim_mode)	//This calls qdel


/datum/extension/aim_mode/Destroy()
	if (!removed)	//Make sure we only remove once
		remove()
	.=..()