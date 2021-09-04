/*

MODULAR FOLDER. HANDLES MINDSHIELDS BEING BROKEN

*/

/mob/living/sec_hud_set_implants()
	.=..()
	if(HAS_TRAIT(src, TRAIT_BROKEN_MINDSHIELD))
		holder = hud_list[IMPLOYAL_HUD]
		var/icon/IC = icon(icon, icon_state, dir)
		holder.icon = 'modular_skyrat/modules/modularcult/mindshields/icons/brokenmindshield.dmi'
		holder.pixel_y = IC.Height() - world.icon_size
		holder.icon_state = "hud_imp_loyal_broken"


/obj/item/implant/mindshield
	var/health = 3
	var/broken = FALSE



/obj/item/implant/mindshield/proc/takedamage()
	health - 1
	if(health <= 0)
		broken = TRUE
		Break()

/obj/item/implant/mindshield/proc/Break()
	REMOVE_TRAIT(target, TRAIT_MINDSHIELD, IMPLANT_TRAIT)
	ADD_TRAIT(target,TRAIT_BROKEN_MINDSHIELD,IMPLANT_TRAIT)
	target.sec_hud_set_implants()
