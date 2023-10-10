/obj/item/clothing/under/costume
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'

/obj/item/clothing/under/costume/russian_officer
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/costume/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/costume.dmi'
	can_adjust = FALSE

//My least favorite file. Just... try to keep it sorted. And nothing over the top

/*
*	UNSORTED
*/
/obj/item/clothing/under/costume/skyrat/cavalry
	name = "cavalry uniform"
	desc = "Dedicate yourself to something better. To loyalty, honour, for it only dies when everyone abandons it."
	icon_state = "cavalry" //specifically an 1890s US Army Cavalry Uniform

/obj/item/clothing/under/costume/deckers/alt //not even going to bother re-pathing this one because its such a unique case of 'TGs item has something but this alt doesnt'
	name = "deckers maskless outfit"
	desc = "A decker jumpsuit with neon blue coloring."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "decking_jumpsuit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/skyrat/bathrobe
	name = "bathrobe"
	desc = "A warm fluffy bathrobe, perfect for relaxing after finally getting clean."
	icon = 'modular_skyrat/modules/GAGS/icons/suit/suit.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/suit/suit.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/suit/suit_teshari.dmi'
	icon_state = "robes"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_colors = "#ffffff"
	greyscale_config = /datum/greyscale_config/bathrobe
	greyscale_config_worn = /datum/greyscale_config/bathrobe/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/bathrobe/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/bathrobe/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/bathrobe/worn/oldvox
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#434d7a" //THATS RIGHT, FUCK YOU! THE BATHROBE CAN BE RECOLORED!
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/costume/skyrat/vic_dresscoat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "victorian dresscoat"
	desc = "An elaborate coat to go over an old-Earth Victorian Period dress. Much thinner fabric than you'd expected."
	icon_state = "vickyred"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator // special coat for niko
	name = "nobility dresscoat"
	desc = "An elaborate coat composed of a silky yet firm material that feels quite pleasant to wear."
	special_desc = "It's buttons are pressed with some kind of sigil - which, to those knowledgable in Tiziran politics or nobility, would be recognizable as the <b>Kor'Yesh emblem</b>, \
	a relatively <i>minor house of nobility</i> within <i>Tizira</i>.\
	\n\
	\n\
	It has a strange structure, with many internal clasps, velcro straps, and attachment points. It looks like you could put some other article of clothing into it..."
	/// The article of clothing we have absorbed and are emulating the effects of. Nullable.
	var/obj/item/clothing/suit/absorbed_clothing
	/// Any subtype of a typepath entered here will be insertable into the jacket.
	var/static/list/obj/item/clothing/suit/clothing_we_can_absorb = list(
		/obj/item/clothing/suit/toggle/labcoat,
	)
	// TODO: make it so that its NOT nullspaced, and rather put in here, and just use signals to hook taking it out into drop_clothing or some shit

/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator/Destroy()
	drop_clothing()

	return ..()


/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator/examine(mob/user)
	. = ..()

	if (!isnull(absorbed_clothing))
		. += "\nIt seems to have [absorbed_clothing] inside of it... you could try [span_notice("using it")] to remove the clothing!"


/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator/attack_self(mob/user, modifiers)
	if (isnull(absorbed_clothing) || !isliving(user))
		return ..()

	var/mob/living/living_user = user

	living_user.visible_message(span_notice("[living_user] starts removing [absorbed_clothing] from [src]..."), span_notice("You start removing [absorbed_clothing] from [src]..."))
	if (!do_after(living_user, 3 SECONDS, src))
		return
	living_user.visible_message(span_notice("[living_user] removes [absorbed_clothing] from [src]!"), span_notice("You remove [absorbed_clothing] from [src]!"))
	drop_clothing(user)


/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator/attackby(obj/item/attacking_item, mob/user, params)
	if (iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		if (carbon_user.combat_mode)
			return ..()

	for (var/obj/item/clothing/suit/absorbable_type as anything in clothing_we_can_absorb)
		if (!istype(attacking_item, absorbable_type))
			continue
		absorb_clothing(attacking_item, user)
		return FALSE

	return ..()


/// Deletes the article of clothing we are about to emulate, and applies its armor, storage, and suit storage variables to us.
/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator/proc/absorb_clothing(obj/item/clothing/suit/clothing_to_absorb, mob/living/user)
	if (!isnull(absorbed_clothing))
		balloon_alert(user, "already fitted!")
		return FALSE
	if (iscarbon(loc))
		var/mob/living/carbon/carbon_loc = loc
		if (src in carbon_loc.get_all_worn_items())
			balloon_alert(user, "take it off first!")
			return FALSE
	if (!isnull(clothing_to_absorb.atom_storage) && length(clothing_to_absorb.contents))
		clothing_to_absorb.balloon_alert(user, "take things out first!") // put it on the insertee so we go "oh THIS has stuff in it"
		return FALSE

	user.visible_message(span_notice("[user] starts putting [clothing_to_absorb] into [src]..."), span_notice("You start putting [clothing_to_absorb] into [src]..."))
	if (!do_after(user, 3 SECONDS, src))
		return FALSE
	user.visible_message(span_notice("[user] puts [clothing_to_absorb] into [src]!"), span_notice("You put [clothing_to_absorb] into [src], applying its armor and storage to it!"))
	playsound(user, clothing_to_absorb.drop_sound, 50, FALSE)

	absorbed_clothing = clothing_to_absorb
	set_armor(clothing_to_absorb.get_armor())
	allowed = clothing_to_absorb.allowed
	if (!isnull(clothing_to_absorb.atom_storage))
		clone_storage(clothing_to_absorb.atom_storage)

	clothing_to_absorb.forceMove(null)
	RegisterSignal(absorbed_clothing, COMSIG_QDELETING, PROC_REF(absorbed_clothing_deleted))


/// Spawns a new instance of the clothing we absorbed earlier, and resets out armor, storage, and suit storage to the initial values.
/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator/proc/drop_clothing(mob/target)
	if (isnull(absorbed_clothing))
		return FALSE

	if (iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		INVOKE_ASYNC(carbon_target, TYPE_PROC_REF(/mob/living/carbon, put_in_hands), absorbed_clothing)
	else
		absorbed_clothing.forceMove(get_turf(src)) // put it on the ground
	playsound(loc, absorbed_clothing.drop_sound, 50, FALSE)

	UnregisterSignal(absorbed_clothing, COMSIG_QDELETING)
	absorbed_clothing = null

	reset_variables()


/// Signal handler proc that clears our ref to absorbed_clothing if it qdels.
/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator/proc/absorbed_clothing_deleted(datum/signal_source)
	SIGNAL_HANDLER

	UnregisterSignal(absorbed_clothing, COMSIG_QDELETING)
	reset_variables()
	absorbed_clothing = null


/// Returns our absorbable variables to their initial states.
/obj/item/clothing/suit/costume/skyrat/vic_dresscoat/donator/proc/reset_variables()
	set_armor(initial(armor))
	allowed = initial(allowed)
	if (!isnull(atom_storage))
		INVOKE_ASYNC(atom_storage, TYPE_PROC_REF(/datum/storage, dump_content_at), get_turf(src))
	QDEL_NULL(atom_storage)

/*
*	LUNAR AND JAPANESE CLOTHES
*/

/obj/item/clothing/under/costume/skyrat/qipao
	name = "qipao"
	desc = "A qipao, traditionally worn in ancient Earth China by women during social events and lunar new years."
	icon_state = "qipao"
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b"
	greyscale_config = /datum/greyscale_config/qipao
	greyscale_config_worn = /datum/greyscale_config/qipao/worn
	greyscale_config_worn_digi = /datum/greyscale_config/qipao/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/costume/skyrat/cheongsam
	name = "cheongsam"
	desc = "A cheongsam, traditionally worn in ancient Earth China by men during social events and lunar new years."
	icon_state = "cheongsam"
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b"
	greyscale_config = /datum/greyscale_config/cheongsam
	greyscale_config_worn = /datum/greyscale_config/cheongsam/worn
	greyscale_config_worn_digi = /datum/greyscale_config/cheongsam/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/costume/skyrat/yukata
	name = "yukata"
	desc = "A traditional ancient Earth Japanese yukata, typically worn in casual settings."
	icon_state = "yukata"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#2b2b2b"
	greyscale_config = /datum/greyscale_config/yukata
	greyscale_config_worn = /datum/greyscale_config/yukata/worn
	greyscale_config_worn_digi = /datum/greyscale_config/yukata/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/costume/skyrat/kamishimo
	name = "kamishimo"
	desc = "A traditional ancient Earth Japanese Kamishimo."
	icon_state = "kamishimo"

/obj/item/clothing/under/costume/skyrat/kimono
	name = "fancy kimono"
	desc = "A traditional ancient Earth Japanese Kimono. Longer and fancier than a yukata."
	icon_state = "kimono"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/*
*	CHRISTMAS CLOTHES
*/

/obj/item/clothing/under/costume/skyrat/christmas
	name = "christmas costume"
	desc = "Can you believe it guys? Christmas. Just a lightyear away!" //Lightyear is a measure of distance I hate it being used for this joke :(
	icon_state = "christmas"

/obj/item/clothing/under/costume/skyrat/christmas/green
	name = "green christmas costume"
	desc = "4:00, wallow in self-pity. 4:30, stare into the abyss. 5:00, solve world hunger, tell no one. 5:30, jazzercize; 6:30, dinner with me. I can't cancel that again. 7:00, wrestle with my self-loathing. I'm booked. Of course, if I bump the loathing to 9, I could still be done in time to lay in bed, stare at the ceiling and slip slowly into madness."
	icon_state = "christmas_green"

/obj/item/clothing/under/costume/skyrat/christmas/croptop
	name = "sexy christmas costume"
	desc = "About 550 years since the release of Mariah Carey's \"All I Want For Christmas is You\", society has yet to properly recover from its repercussions. Some still keep a gun as their christmas mantlepiece, just in case she's heard singing on their rooftop late in the night..."
	icon_state = "christmas_crop"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/skyrat/christmas/croptop/green
	name = "sexy green christmas costume"
	desc = "Stupid. Ugly. Out of date. If I can't find something nice to wear I'm not going."
	icon_state = "christmas_crop_green"
