/datum/action/item_action/mod/sprite_accessories
	name = "Hide/Show mutant parts"
	desc = "LMB: Deploy/Undeploy part. RMB: Deploy/Undeploy all parts."
	button_icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/radial.dmi' // What a great var name
	button_icon_state = "open"

/datum/action/item_action/mod/sprite_accessories/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/obj/item/mod/control/mod = target
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		mod.quick_sprite_accessories(usr)
	else
		mod.choose_sprite_accessories(usr)

/obj/item/mod/control/proc/quick_sprite_accessories(mob/living/carbon/human/user)
	playsound(user, 'sound/mecha/mechmove03.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
	user.mutant_part_visibility(quick_toggle = TRUE)

/obj/item/mod/control/proc/choose_sprite_accessories(mob/living/carbon/human/user)
	user.mutant_part_visibility(quick_toggle = FALSE)
