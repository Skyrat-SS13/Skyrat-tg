/*

MODULAR FOLDER. HANDLES MINDSHIELDS BEING BROKEN

*/
#define TRAIT_BROKEN_MINDSHIELD "brokenmindshield"

	
	
/obj/item/implant/mindshield
	var/health = 1
	var/broken = FALSE //Not used right now, but included so future people can indeed modify it



/obj/item/implant/mindshield/proc/takedamage()
	health -= 1
	if(health <= 0)
		broken = TRUE
		Break()

/obj/item/implant/mindshield/proc/Break()
	ADD_TRAIT(imp_in,TRAIT_BROKEN_MINDSHIELD,IMPLANT_TRAIT)
	REMOVE_TRAIT(imp_in, TRAIT_MINDSHIELD, IMPLANT_TRAIT)
	imp_in.sec_hud_set_implants()
	imp_in.visible_message(span_deconversion_message("[imp_in] Looks far dizzier and uncertain than they did moments ago."))

/obj/item/implant/mindshield/removed()
	broken = FALSE //RESET BROKEN STATUS
	health = 1 //RESET BROKEN STATUS
	REMOVE_TRAIT(imp_in,TRAIT_BROKEN_MINDSHIELD,IMPLANT_TRAIT)
