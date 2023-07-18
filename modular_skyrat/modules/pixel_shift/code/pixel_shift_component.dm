/datum/component/pixel_shift
	var/mob/living/owner
	/// Whether the mob is pixel shifted or not
	var/is_shifted = FALSE
	/// If we are in the shifting setting.
	var/shifting = FALSE
	/// Takes the four cardinal direction defines. Any atoms moving into this atom's tile will be allowed to from the added directions.
	var/passthroughable = NONE
	var/maximum_pixel_shift = 16
	var/passable_shift_threshold = 8

/datum/component/pixel_shift/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	owner = parent

/datum/component/pixel_shift/RegisterWithParent()
	. = ..()
	RegisterSignal(owner, COMSIG_KB_MOB_PIXEL_SHIFT_DOWN, PROC_REF(change_shifting))
	RegisterSignal(owner, COMSIG_MOB_UNPIXEL_SHIFT, PROC_REF(unpixel_shift))
	RegisterSignal(owner, COMSIG_MOB_PIXEL_SHIFT, PROC_REF(pixel_shift))
	RegisterSignal(owner, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(pre_move_check))
	RegisterSignal(owner, COMSIG_MOB_PIXEL_SHIFT_CHECK_PASSABLE, PROC_REF(check_passable))

/datum/component/pixel_shift/UnregisterFromParent()
	. = ..()
	UnregisterSignal(owner, COMSIG_KB_MOB_PIXEL_SHIFT_DOWN)
	UnregisterSignal(owner, COMSIG_MOB_UNPIXEL_SHIFT)
	UnregisterSignal(owner, COMSIG_MOB_PIXEL_SHIFT)
	UnregisterSignal(owner, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(unpixel_shift))
	UnregisterSignal(owner, COMSIG_MOB_PIXEL_SHIFT_CHECK_PASSABLE)

/datum/component/pixel_shift/proc/pre_move_check(mob/source, new_loc, direct)
	if(shifting)
		pixel_shift(source, direct)
		return COMSIG_MOB_CLIENT_BLOCK_PRE_LIVING_MOVE
	if(is_shifted)
		unpixel_shift()

/datum/component/pixel_shift/proc/check_passable(mob/source, border_dir)
	if(passthroughable & border_dir)
		return COMPONENT_LIVING_PASSABLE

/datum/component/pixel_shift/proc/change_shifting(mob/source, active)
	shifting = active

/datum/component/pixel_shift/proc/unpixel_shift()
	passthroughable = NONE
	if(is_shifted)
		is_shifted = FALSE
		owner.pixel_x = owner.body_position_pixel_x_offset + owner.base_pixel_x
		owner.pixel_y = owner.body_position_pixel_y_offset + owner.base_pixel_y

/datum/component/pixel_shift/proc/pixel_shift(mob/source, direct)
	passthroughable = NONE
	switch(direct)
		if(NORTH)
			if(owner.pixel_y <= maximum_pixel_shift + owner.base_pixel_y)
				owner.pixel_y++
				is_shifted = TRUE
		if(EAST)
			if(owner.pixel_x <= maximum_pixel_shift + owner.base_pixel_x)
				owner.pixel_x++
				is_shifted = TRUE
		if(SOUTH)
			if(owner.pixel_y >= -maximum_pixel_shift + owner.base_pixel_y)
				owner.pixel_y--
				is_shifted = TRUE
		if(WEST)
			if(owner.pixel_x >= -maximum_pixel_shift + owner.base_pixel_x)
				owner.pixel_x--
				is_shifted = TRUE

	// Yes, I know this sets it to true for everything if more than one is matched.
	// Movement doesn't check diagonals, and instead just checks EAST or WEST, depending on where you are for those.
	if(owner.pixel_y > passable_shift_threshold)
		passthroughable |= EAST | SOUTH | WEST
	if(owner.pixel_x > passable_shift_threshold)
		passthroughable |= NORTH | SOUTH | WEST
	if(owner.pixel_y < -passable_shift_threshold)
		passthroughable |= NORTH | EAST | WEST
	if(owner.pixel_x < -passable_shift_threshold)
		passthroughable |= NORTH | EAST | SOUTH
