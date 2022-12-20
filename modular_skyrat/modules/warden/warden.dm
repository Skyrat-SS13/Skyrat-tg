/obj/item/skillchip/job/warden
	name = "Krav Maga Skillchip"
	desc = "Teaches you the arts of Krav Maga in 5 short instructional videos beamed directly into your eyeballs."
	skill_name = "Krav Maga"
	skill_description = "A specialised form of Martial Arts, allowing you to swiftly disable attackers."
	skill_icon = "brain"
	activate_message = "<span class='notice'>You can visualize how to defend yourself with martial arts.</span>"
	deactivate_message = "<span class='notice'>You forget how to control your muscles to execute the arts of Krav Maga.</span>"
	var/datum/action/krav_activate/krav_activate = new

/datum/action/krav_activate
	name = "Activate Krav Maga."
	button_icon = 'icons/obj/wizard.dmi'
	button_icon_state = "scroll2"

/datum/action/krav_activate/Trigger(trigger_flags)
	if(!ishuman(owner))
		return
	if(!owner.mind)
		return
	if(owner.mind.has_martialart(MARTIALART_KRAVMAGA))
		var/datum/martial_art/default = owner.mind.default_martial_art
		default.teach(owner)
	else
		var/datum/martial_art/krav_maga/style = new
		style.teach(owner, TRUE)

/obj/item/skillchip/job/warden/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	krav_activate.Grant(user)

/obj/item/skillchip/job/warden/on_deactivate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	if(user.mind.has_martialart(MARTIALART_KRAVMAGA))
		krav_activate.Trigger()
	krav_activate.Remove(user)
	return ..()

/obj/item/skillchip/job/warden/Destroy()
	QDEL_NULL(krav_activate)
	return ..()

/datum/outfit/job/warden
	skillchips = list(/obj/item/skillchip/job/warden)
