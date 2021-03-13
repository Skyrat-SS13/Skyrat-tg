/obj/item/electropack/shockcollar
	name = "shock collar"
	desc = "A reinforced metal collar. It seems to have some form of wiring near the front. Strange.."
	icon = 'modular_skyrat/modules/nsfw/shockcollar/icons/collar.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/neck.dmi'
	icon_state = "shock_collar"
	worn_icon_state = "shock_collar"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK //no more pocket shockers. Now done without lazyness
	w_class = WEIGHT_CLASS_SMALL
	strip_delay = 60
	equip_delay_other = 60
	custom_materials = list(/datum/material/iron = 5000, /datum/material/glass = 2000)
	var/random = TRUE
	var/freq_in_name = TRUE
	var/tagname = null

/datum/design/electropack/shockcollar
	name = "Shockcollar"
	id = "shockcollar"
	build_type = AUTOLATHE
	build_path = /obj/item/electropack/shockcollar
	materials = list(/datum/material/iron = 5000, /datum/material/glass =2000)
	category = list("hacked", "Misc")

/obj/item/electropack/shockcollar/attack_hand(mob/user, list/modifiers)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK))
		to_chat(user, "<span class='warning'>The collar is fastened tight! You'll need help taking this off!</span>")
		return
	return ..()

/obj/item/electropack/shockcollar/receive_signal(datum/signal/signal) //we have to override this because of text
	if(!signal || signal.data["code"] != code)
		return

	if(isliving(loc) && on) //the "on" arg is currently useless
		var/mob/living/L = loc
		if(!L.get_item_by_slot(ITEM_SLOT_NECK)) //**properly** stops pocket shockers
			return
		if(shock_cooldown == TRUE)
			return
		shock_cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, shock_cooldown, FALSE), 100)
		step(L, pick(GLOB.cardinals))

		to_chat(L, "<span class='danger'>You feel a sharp shock from [src]!</span>")
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(3, 1, L)
		s.start()

		L.Paralyze(100)

	if(master)
		if(isassembly(master))
			var/obj/item/assembly/master_as_assembly = master
			master_as_assembly.pulsed()
		master.receive_signal()

/obj/item/electropack/shockcollar/attackby(obj/item/W, mob/user, params) //moves it here because on_click is being bad
	if(istype(W, /obj/item/pen))
		var/t = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", tagname ? tagname : "Spot", MAX_NAME_LEN)
		if(t)
			tagname = t
			name = "[initial(name)] - [t]"
		return
	if(istype(W, /obj/item/clothing/head/helmet)) //lazy method of denying this
		return
	else
		return ..()

/obj/item/electropack/shockcollar/Initialize()
	if (random)
		code = rand(1,100)
		frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
	if (freq_in_name)
		name = initial(name) + " - freq: [frequency/10] code: [code]"
	. = ..()

/obj/item/electropack/shockcollar/pacify
	name = "pacifying collar"
	desc = "A reinforced metal collar that latches onto the wearer and halts any harmful thoughts."

/obj/item/electropack/shockcollar/pacify/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_NECK)
		ADD_TRAIT(user, TRAIT_PACIFISM, "pacifying-collar")

/obj/item/electropack/shockcollar/pacify/dropped(mob/living/carbon/human/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_PACIFISM, "pacifying-collar")

