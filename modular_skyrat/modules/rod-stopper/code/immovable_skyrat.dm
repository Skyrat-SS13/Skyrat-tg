#define ROD_RIFT_LIFESPAN 2 SECONDS
#define ROD_RIFT_RADIUS_CONSUME 2
#define ROD_RIFT_RADIUS_PULL 4

/obj/effect/immovablerod/Bump(atom/clong)
	var/should_self_destroy = FALSE
	if(istype(clong, /obj/machinery/rodstopper))
		should_self_destroy = TRUE
	. = ..()
	if(should_self_destroy)
		visible_message("<span class='boldwarning'>The rod tears into the rodstopper with a reality-rending screech!</span>")
		playsound(loc,'sound/effects/supermatter.ogg', 200, TRUE)
		new/obj/rod_rift(loc)
		qdel(src)

/obj/rod_rift
	name = "tear in the fabric of reality"
	desc = "Your own comprehension of reality starts bending as you stare this."
	anchored = TRUE
	appearance_flags = LONG_GLIDE
	density = TRUE
	icon = 'icons/effects/96x96.dmi'
	icon_state = "boh_tear"
	plane = MASSIVE_OBJ_PLANE
	plane = ABOVE_LIGHTING_PLANE
	light_range = 6
	move_resist = INFINITY
	obj_flags = CAN_BE_HIT | DANGEROUS_POSSESSION
	pixel_x = -32
	pixel_y = -32
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = SUPERMATTER_IGNORES_1

/obj/rod_rift/examine(mob/living/user)
	. = ..()
	if(!istype(user))
		return
	. += span_warning("You see a rod... AND ITS COMING TOWARDS YOU!")
	addtimer(CALLBACK(src, .proc/punish_examiner, user), 0.2 SECONDS)

/obj/rod_rift/proc/punish_examiner(mob/living/user)
	to_chat(user, span_userdanger("You suddenly collapse over in pain as you hallucinate a rod going right through you!"))
	user.emote("scream")
	user.Paralyze(3 SECONDS, TRUE)

/obj/rod_rift/proc/punish_dumbass(mob/living/dumbass)
	to_chat(dumbass, span_userdanger("Your last thought before fading out of existance: 'That was a terrible idea.'"))
	dumbass.visible_message(span_danger("Flashes brightly before dissapearing from reality... did they ever exist to begin with?"), \
						span_userdanger("Your last thought before you flash out of reality: 'That was a terrible idea.'"))
	dumbass.ghostize()
	qdel(dumbass)

/obj/rod_rift/Initialize()
	. = ..()
	QDEL_IN(src, ROD_RIFT_LIFESPAN)

	AddComponent(
		/datum/component/singularity, \
		consume_range = ROD_RIFT_RADIUS_CONSUME, \
		grav_pull = ROD_RIFT_RADIUS_PULL, \
		roaming = FALSE, \
		singularity_size = STAGE_TWO, \
	)

/obj/rod_rift/attackby(mob/user, damage_amount, damage_type, damage_flag, sound_effect, armor_penetration)
	if(!isliving(user))
		return FALSE
	punish_dumbass(user)
	return TRUE

/obj/rod_rift/attack_tk(mob/user)
	if(isliving(user))
		punish_dumbass(user)
	return COMPONENT_CANCEL_ATTACK_CHAIN
