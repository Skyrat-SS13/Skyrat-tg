/*
	Can this atom be gripped by kinesis at all, ever?
*/
/atom/movable/proc/can_telegrip(var/obj/item/rig_module/kinesis/gripper)
	return TRUE


/obj/can_telegrip(var/obj/item/rig_module/kinesis/gripper)
	if(buckled_mob)
		return FALSE
	return TRUE

/mob/living/can_telegrip(var/obj/item/rig_module/kinesis/gripper)
	if (!gripper.can_grip_live() && stat != DEAD)
		return FALSE

	return TRUE


/*
	This is called for anchored objects to see if this kinesis module can pull them free of their moorings

	Return null to make it unremovable
	Return any number as a mooring health value, which will determine how long it takes to rip free.
		By default, 40 = 1 second of time with the default kinesis module
*/
/atom/movable/proc/can_rip_free(var/obj/item/rig_module/kinesis/gripper)
	return null


/*
	Called when this object is successfully gripped by kinesis.
	It may want to stop moving, start spinning aimlessly on the spot, etc
*/
/atom/movable/proc/telegripped(var/obj/item/rig_module/kinesis/gripper)


/*
	Called when this object is released from a kinesis grip.
	Projectiles will drop and hit the floor
*/
/atom/movable/proc/telegrip_released(var/obj/item/rig_module/kinesis/gripper)


//Things which should never be gripped
//Nonliving mobs
/mob/can_telegrip(var/obj/item/rig_module/kinesis/gripper)
	return FALSE

//Hud objects
/atom/movable/screen/can_telegrip(var/obj/item/rig_module/kinesis/gripper)
	return FALSE

//Lighting
/atom/movable/lighting_overlay/can_telegrip(var/obj/item/rig_module/kinesis/gripper)
	return FALSE