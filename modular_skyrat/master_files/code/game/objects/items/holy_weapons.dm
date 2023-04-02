/obj/item/clothing/head/helmet/chaplain/bland
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	icon_state = "knight_generic"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	worn_icon_state = "knight_generic"

/obj/item/clothing/head/helmet/chaplain/bland/horned
	name = "horned crusader helmet"
	desc = "Helfen, Wehren, Heilen."
	icon_state = "knight_horned"
	worn_icon_state = "knight_horned"

/obj/item/clothing/head/helmet/chaplain/bland/winged
	name = "winged crusader helmet"
	desc = "Helfen, Wehren, Heilen."
	icon_state = "knight_winged"
	worn_icon_state = "knight_winged"

/obj/item/clothing/suit/chaplainsuit/armor/teutonic
	desc = "Help, Defend, Heal!"
	icon_state = "knight_teutonic"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_state = "knight_teutonic"

/obj/item/clothing/suit/chaplainsuit/armor/teutonic/alt
	icon_state = "knight_teutonic_alt"
	worn_icon_state = "knight_teutonic_alt"

/obj/item/clothing/suit/chaplainsuit/armor/hospitaller
	icon_state = "knight_hospitaller"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_state = "knight_hospitaller"

/obj/item/storage/box/holy/teutonic
	name = "teutonic kit"

/obj/item/storage/box/holy/teutonic/PopulateContents()
	pick(new /obj/item/clothing/head/helmet/chaplain/bland/horned(src), new /obj/item/clothing/head/helmet/chaplain/bland/winged(src))
	pick(new /obj/item/clothing/suit/chaplainsuit/armor/teutonic(src), new /obj/item/clothing/suit/chaplainsuit/armor/teutonic/alt(src))

/obj/item/storage/box/holy/hospitaller
	name = "hospitaller kit"

/obj/item/storage/box/holy/hospitaller/PopulateContents()
	new /obj/item/clothing/head/helmet/chaplain/bland(src)
	new /obj/item/clothing/suit/chaplainsuit/armor/hospitaller(src)

/obj/item/clothing/suit/hooded/cultlain_robe
	name = "ancient robes"
	desc = "A ragged, dusty set of robes."
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "cultrobes"
	inhand_icon_state = "cultrobes"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor_type = /datum/armor/hooded_cultlain_robe
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/cup/glass/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/flashlight/flare/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	hoodtype = /obj/item/clothing/head/hooded/cultlain_hood

/datum/armor/hooded_cultlain_robe
	melee = 50
	bullet = 10
	laser = 10
	energy = 10
	fire = 80
	acid = 80
	wound = 20

/obj/item/clothing/head/hooded/cultlain_hood
	name = "ancient hood"
	desc = "A torn, dust-caked hood."
	icon_state = "culthood"
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	body_parts_covered = HEAD
	flags_inv = HIDEFACE|HIDEHAIR|HIDEEARS
	flags_cover = HEADCOVERSEYES
	armor_type = /datum/armor/hooded_cultlain_hood

/datum/armor/hooded_cultlain_hood
	melee = 50
	bullet = 10
	laser = 10
	energy = 10
	fire = 80
	acid = 80

/obj/item/storage/box/holy/narsian
	name = "ancient kit"

/obj/item/storage/box/holy/narsian/PopulateContents()
	new /obj/item/clothing/suit/hooded/cultlain_robe(src)
	new /obj/item/clothing/shoes/cult/alt(src)

/obj/item/nullrod/cultdagger
	name = "ritual dagger"
	desc = "A strange dagger said to be once used by a sinister group.. "
	icon = 'icons/obj/cult/items_and_weapons.dmi'
	icon_state = "render"
	inhand_icon_state = "cultdagger"
	worn_icon_state = "render"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_CHAPLAIN)
	special_desc = "Activate it to receive the language of a forgotten cult."
	var/narsian = FALSE

/obj/item/nullrod/cultdagger/attack_self(mob/user)
	if(narsian)
	else if(user.mind && (user.mind.holy_role))
		to_chat(user, span_cultlarge("\"Partake in the language of blood..\""))
		user.grant_language(/datum/language/narsie, TRUE, TRUE, LANGUAGE_MIND)
		special_desc_requirement = NONE // No point in keeping something that can't no longer be used
		narsian = TRUE

/obj/item/nullrod/claymore/darkblade
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_CHAPLAIN)
	special_desc = "Activate it to receive the language of a forgotten cult."
	var/narsian = FALSE

/obj/item/nullrod/claymore/darkblade/attack_self(mob/user)
	if(narsian)
	else if(user.mind && (user.mind.holy_role))
		to_chat(user, span_cultlarge("\"Partake in the language of blood..\""))
		user.grant_language(/datum/language/narsie, TRUE, TRUE, LANGUAGE_MIND)
		special_desc_requirement = NONE // No point in keeping something that can't no longer be used
		narsian = TRUE

/obj/item/nullrod/spear
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_CHAPLAIN)
	special_desc = "Activate it to receive the language of a forgotten cult."
	var/ratvarian = FALSE

/obj/item/nullrod/spear/attack_self(mob/user)
	if(ratvarian)
		return ..()
	else if(user.mind?.holy_role)
		to_chat(user, span_bigbrass("The sound of cogs permeates your head..."))
		user.grant_language(/datum/language/ratvar, TRUE, TRUE, LANGUAGE_MIND)
		special_desc_requirement = NONE // No point in keeping something that can't no longer be used
		ratvarian = TRUE

/obj/item/nullrod/rosary
	name = "prayer beads"
	desc = "A set of prayer beads used by many of the more traditional religions in space"
	icon = 'modular_skyrat/modules/chaplain/icons/holy_weapons.dmi'
	icon_state = "rosary"
	worn_icon_state = "nullrod"
	force = 4
	throwforce = 0
	attack_verb_simple = list("whipped", "repented", "lashed", "flagellated")
	attack_verb_continuous = list("whipped", "repented", "lashed", "flagellated")
	slot_flags = ITEM_SLOT_BELT
	var/praying = FALSE
	var/deity_name = "Coderbus" // This is the default, hopefully won't actually appear if the religion subsystem is running properly

/obj/item/nullrod/rosary/Initialize(mapload)
	.=..()
	if(GLOB.deity)
		deity_name = GLOB.deity

/obj/item/nullrod/rosary/attack(mob/living/target, mob/living/user, params)
	if(!user.mind || !user.mind.holy_role)
		balloon_alert(user, "not holy enough!")
		return
	if(user.combat_mode)
		return ..()
	if(praying)
		balloon_alert(user, "already in use!")
		return

	user.visible_message(span_info("[user] kneels[target == user ? null : " next to [target]"] and begins to utter a prayer to [deity_name]."), \
		span_info("You kneel[target == user ? null : " next to [target]"] and begin a prayer to [deity_name]."))

	praying = TRUE
	if(do_after(user, 5 SECONDS, target = target))
		target.reagents?.add_reagent(/datum/reagent/water/holywater, 5)
		to_chat(target, span_notice("[user]'s prayer to [deity_name] has eased your pain!"))
		target.adjustToxLoss(-5, TRUE, TRUE)
		target.adjustOxyLoss(-5)
		target.adjustBruteLoss(-5)
		target.adjustFireLoss(-5)
		praying = FALSE
	else
		balloon_alert(user, "interrupted!")
		praying = FALSE

/obj/item/nullrod/scythe/sickle
	name = "damned sickle"
	desc = "A green crescent blade, decorated with an ornamental eye. The pupil has faded..."
	icon = 'icons/obj/eldritch.dmi'
	icon_state = "eldritch_blade"
	inhand_icon_state = "eldritch_blade"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "rends")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "rend")

/obj/item/nullrod/scythe/sickle/void
	name = "crystal sickle"
	desc = "Made of clear crystal, the blade refracts the light slightly. Purity, so close yet unattainable in this form."
	icon_state = "void_blade"
	inhand_icon_state = "void_blade"
	worn_icon_state = "dark_blade"
