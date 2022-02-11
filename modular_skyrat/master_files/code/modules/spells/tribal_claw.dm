/obj/effect/proc_holder/spell/aoe_turf/repulse/lizard_tail
	name = "Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail."
	sound = 'sound/magic/tail_swing.ogg'
	charge_max = 150
	clothes_req = FALSE
	antimagic_allowed = TRUE
	range = 1
	cooldown_min = 150
	invocation_type = "none"
	sparkle_path = /obj/effect/temp_visual/disarm
	action_icon = 'icons/mob/actions/actions_xeno.dmi' // I lack anything better for this, but you shouldn't be seeing this anyway
	action_icon_state = "tailsweep"
	action_background_icon_state = "bg_alien"
	anti_magic_check = FALSE
	maxthrow = 4

/obj/effect/proc_holder/spell/aoe_turf/repulse/lizard_tail/cast(list/targets, mob/user = usr)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		playsound(C.loc,'sound/effects/hit_punch.ogg', 80, 1, 1)
		C.spin(6,1)
	..(targets, user, 60)
