/obj/item/melee/baton/abductor
	attack_cooldown = 1.5 SECONDS
	confusion_amt = 0
	stamina_loss_amt = 0
	apply_stun_delay = 0 SECONDS
	stun_time = 10 SECONDS
	stamina_loss_amt = 50

	time_to_cuff = 5 SECONDS


/obj/item/clothing/suit/armor/abductor/vest/ActivateStealth()
	if(disguise == null)
		return
	if(!ishuman(loc))
		return
	if(combat_cooldown < initial(combat_cooldown))
		to_chat(loc, span_warning("Suit power is still recharging."))
		return
	stealth_active = TRUE
	var/mob/living/carbon/human/M = loc
	new /obj/effect/temp_visual/dir_setting/ninja/cloak(get_turf(M), M.dir)
	M.name_override = disguise.name
	M.icon = disguise.icon
	M.icon_state = disguise.icon_state
	M.cut_overlays()
	M.add_overlay(disguise.overlays)
	M.update_inv_hands()
	combat_cooldown = 0
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/armor/abductor/vest/DeactivateStealth()
	if(!stealth_active)
		return
	if(!ishuman(loc))
		return
	stealth_active = FALSE
	var/mob/living/carbon/human/M = loc
	new /obj/effect/temp_visual/dir_setting/ninja(get_turf(M), M.dir)
	M.name_override = null
	M.cut_overlays()
	M.regenerate_icons()

/obj/item/clothing/suit/armor/abductor/vest/Adrenaline()
	if(!ishuman(loc))
		return
	if(combat_cooldown < initial(combat_cooldown))
		to_chat(loc, span_warning("Suit power is still recharging."))
		return
	var/mob/living/carbon/human/M = loc
	M.reagents.add_reagent(/datum/reagent/medicine/abductoradrenaline, 10) //20 seconds.
	combat_cooldown = 0
	START_PROCESSING(SSobj, src)