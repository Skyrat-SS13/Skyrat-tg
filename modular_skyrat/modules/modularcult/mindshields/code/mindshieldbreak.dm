/*

MODULAR FOLDER. HANDLES MINDSHIELDS BEING BROKEN

*/
#define TRAIT_BROKEN_MINDSHIELD "brokenmindshield"


/mob/living/sec_hud_set_implants()
	var/image/holder
	if(HAS_TRAIT(src, TRAIT_BROKEN_MINDSHIELD))
		holder = hud_list[IMPLOYAL_HUD]
		var/icon/IC = icon(icon, icon_state, dir)
		holder.icon = 'modular_skyrat/modules/modularcult/mindshields/icons/brokenmindshield.dmi'
		holder.pixel_y = IC.Height() - world.icon_size
		holder.icon_state = "hud_imp_loyal_broken"
	..()

/obj/item/implant/mindshield
	var/health = 3
	var/broken = FALSE //Not used right now, but included so future people can indeed modify it



/obj/item/implant/mindshield/proc/takedamage()
	health -= 1
	if(health <= 0)
		broken = TRUE
		Break()

/obj/item/implant/mindshield/proc/Break(mob/target)
	ADD_TRAIT(target,TRAIT_BROKEN_MINDSHIELD,IMPLANT_TRAIT)
	var/mob/living/L = target
	REMOVE_TRAIT(L, TRAIT_MINDSHIELD, IMPLANT_TRAIT)
	L.sec_hud_set_implants()
	L.current.visible_message(span_deconversion_message("[L] Looks far dizzier and uncertain than they did moments ago."), null, null, null, L.current)

/obj/item/implant/mindshield/removed()
	broken = FALSE //RESET BROKEN STATUS
	health = 3 //RESET BROKEN STATUS
