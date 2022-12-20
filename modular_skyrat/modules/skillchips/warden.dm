/obj/item/skillchip/job/warden
	name = "Krav Maga skillchip"
	desc = "Teaches you the arts of Krav Maga in 5 short instructional videos beamed directly into your eyeballs."
	skill_name = "Krav Maga"
	skill_description = "A specialised form of Martial Arts, allowing you to swiftly disable attackers."
	skill_icon = "brain"
	activate_message = "<span class='notice'>You can visualize how to defend yourself with martial arts.</span>"
	deactivate_message = "<span class='notice'>You forget how to control your muscles to execute the arts of Krav Maga.</span>"
	var/datum/action/Krav_Activate/Krav_Activate = new/datum/action/Krav_Activate()

/datum/action/Krav_Activate
	name = "Activates your Knowledge of Krav Maga"
	button_icon = 'icons/obj/wizard.dmi'
	button_icon_state = "scroll2"

/datum/action/Krav_Activate/Trigger(trigger_flags)
	var/mob/living/carbon/human/H = owner
	var/datum/martial_art/krav_maga/style = new
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_KRAVMAGA))
		var/datum/martial_art/default = H.mind.default_martial_art
		default.teach(H)
	else
		style.teach(H, TRUE)

/obj/item/skillchip/job/warden/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	Krav_Activate.Grant(user)

/obj/item/skillchip/job/warden/on_deactivate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	Krav_Activate.Trigger()
	Krav_Activate.Remove(user)
	return ..()




