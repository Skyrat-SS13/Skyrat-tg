//Donator reward for UltramariFox
/obj/item/clothing/mask/cigarette/khi
	name = "\improper Kitsuhana Singularity cigarette"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "khioff"
	icon_on = "khion"
	icon_off = "khioff"
	type_butt = /obj/item/cigbutt/khi
	list_reagents = list(/datum/reagent/drug/nicotine = 10, /datum/reagent/toxin/mindbreaker = 5)

/obj/item/cigbutt/khi
	icon = 'modular_skyrat/master_files/icons/obj/cigarettes_khi.dmi'
	icon_state = "khibutt"

/obj/item/storage/fancy/cigarettes/khi
	name = "\improper Kitsuhana Singularity packet"
	icon = 'modular_skyrat/master_files/icons/obj/cigarettes_khi.dmi'
	icon_state = "khi_cig_packet"
	base_icon_state = "khi_cig_packet"
	spawn_type = /obj/item/clothing/mask/cigarette/khi

//Donator reward for Stonetear
/obj/item/hairbrush/switchblade
	name = "switchcomb"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "switchblade"
	base_icon_state = "switchblade"
	desc = "A sharp, concealable, spring-loaded comb."
	hitsound = 'sound/weapons/genhit.ogg'
	resistance_flags = FIRE_PROOF
	var/extended = FALSE

/obj/item/hairbrush/switchblade/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_HANDS)

//This is called when you transform it
/obj/item/hairbrush/switchblade/attack_self(mob/user, modifiers)
	extended = !extended
	icon_state = "switchblade[extended ? "_on" : ""]"

	playsound(user || src, 'sound/weapons/batonextend.ogg', 30, TRUE)


// This makes it so you have to extend it.
/obj/item/hairbrush/switchblade/attack(mob/target, mob/user)
	if(src.extended == FALSE)
		to_chat(usr, span_warning("Try extending the blade first, silly!"))
		return
	if(target.stat == DEAD)
		to_chat(usr, span_warning("There isn't much point brushing someone who can't appreciate it!"))
		return
	brush(target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN
