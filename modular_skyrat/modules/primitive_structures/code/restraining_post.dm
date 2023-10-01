/obj/structure/restraint_post
	name = "restraining post"
	desc = "A simple post, well anchored to the ground, that a person in restraints can be tied to. \
		It'll keep whoever it is limited to moving a short area around the post, handy! \
		There's tieoff spots for maybe <b>three</b> things, if you find yourself needing that much prisoner capacity."
	icon = 'modular_skyrat/modules/primitive_structures/icons/restraint.dmi'
	icon_state = "post"
	anchored = TRUE
	density = FALSE
	can_buckle = TRUE
	buckle_requires_restraints = TRUE
	max_buckled_mobs = 3
	buckle_prevents_pull = FALSE

// This is a copy of the original buckle code, except the mob isn't immobilized and is simply given the leash component to the post
/obj/structure/restraint_post/buckle_mob(mob/living/prisoner, force = FALSE, check_loc = TRUE, buckle_mob_flags= NONE)
	if(!buckled_mobs)
		buckled_mobs = list()

	if(!is_buckle_possible(prisoner, force, check_loc))
		return FALSE

	if(SEND_SIGNAL(src, COMSIG_MOVABLE_PREBUCKLE, prisoner, force, buckle_mob_flags) & COMPONENT_BLOCK_BUCKLE)
		return FALSE

	if(prisoner.pulledby)
		if(buckle_prevents_pull)
			prisoner.pulledby.stop_pulling()
		else if(isliving(prisoner.pulledby))
			var/mob/living/L = prisoner.pulledby
			L.reset_pull_offsets(prisoner, TRUE)

	if(!length(buckled_mobs))
		RegisterSignal(src, COMSIG_MOVABLE_SET_ANCHORED, PROC_REF(on_set_anchored))
	prisoner.set_buckled(src)
	buckled_mobs |= prisoner
	prisoner.throw_alert(ALERT_BUCKLED, /atom/movable/screen/alert/buckled)
	prisoner.set_glide_size(glide_size)
	prisoner.AddComponent(
		/datum/component/leash,
		owner = src,
		distance = 2,
		force_teleport_out_effect = null,
		force_teleport_in_effect = null,
	)

	//Something has unbuckled us in reaction to the above movement
	if(!prisoner.buckled)
		return FALSE

	post_buckle_mob(prisoner)

	SEND_SIGNAL(src, COMSIG_MOVABLE_BUCKLE, prisoner, force)
	return TRUE

// We need to remove the leash component from whatever's buckled to us
/obj/structure/restraint_post/post_unbuckle_mob(mob/living/unbuckled_mob)
	RemoveComponentSource(REF(unbuckled_mob), /datum/component/leash)
