/obj/item/dyespray
	name = "hair dye spray"
<<<<<<< HEAD
	desc = "A spray to dye hair as well as giving it any gradient you'd like." // SKYRAT EDIT - Making the dyespray change hair color
=======
	desc = "A spray to dye your hair any gradients you'd like."
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/cosmetic.dmi'
	icon_state = "dyespray"

<<<<<<< HEAD
	var/uses = 40 //SKYRAT EDIT ADDITION

=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/obj/item/dyespray/attack_self(mob/user)
	dye(user, user)

/obj/item/dyespray/pre_attack(atom/target, mob/living/user, params)
	dye(target, user)
	return ..()

/**
 * Applies a gradient and a gradient color to a mob.
 *
 * Arguments:
 * * target - The mob who we will apply the gradient and gradient color to.
 */
<<<<<<< HEAD
/* SKYRAT EDIT REMOVAL - MOVED TO MODULAR (modular_skyrat\master_files\code\game\objects\items\dyekit.dm)
/obj/item/dyespray/proc/dye(mob/target, mob/user)
	if(!ishuman(target))
		return

	if(!uses) //SKYRAT EDIT ADDITION
		return //SKYRAT EDIT ADDITION

=======

/obj/item/dyespray/proc/dye(mob/target, mob/user)
	if(!ishuman(target))
		return
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	var/mob/living/carbon/human/human_target = target
	var/beard_or_hair = tgui_alert(user, "What do you want to dye?", "Character Preference", list("Hair", "Facial Hair"))
	if(!beard_or_hair || !user.can_perform_action(src, NEED_DEXTERITY))
		return

	var/list/choices = beard_or_hair == "Hair" ? SSaccessories.hair_gradients_list : SSaccessories.facial_hair_gradients_list
	var/new_grad_style = tgui_input_list(user, "Choose a color pattern", "Character Preference", choices)
	if(isnull(new_grad_style))
		return
	if(!user.can_perform_action(src, NEED_DEXTERITY))
		return

	var/new_grad_color = input(user, "Choose a secondary hair color:", "Character Preference",human_target.grad_color) as color|null
	if(!new_grad_color || !user.can_perform_action(src, NEED_DEXTERITY) || !user.CanReach(target))
		return

	to_chat(user, span_notice("You start applying the hair dye..."))
	if(!do_after(user, 3 SECONDS, target))
		return
	if(beard_or_hair == "Hair")
		human_target.set_hair_gradient_style(new_grad_style, update = FALSE)
		human_target.set_hair_gradient_color(new_grad_color, update = TRUE)
	else
		human_target.set_facial_hair_gradient_style(new_grad_style, update = FALSE)
		human_target.set_facial_hair_gradient_color(new_grad_color, update = TRUE)
	playsound(src, 'sound/effects/spray.ogg', 10, vary = TRUE)
<<<<<<< HEAD
*/
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
