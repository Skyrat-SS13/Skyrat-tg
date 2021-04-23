/obj/item/clothing/suit/hooded/cultlain_robe
	name = "ancient robes"
	desc = "A ragged, dusty set of robes."
	icon_state = "cultrobes"
	inhand_icon_state = "cultrobes"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list(MELEE = 50, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 0, RAD = 0, FIRE = 80, ACID = 80, WOUND = 20) //Chaplain Riot armor
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	hoodtype = /obj/item/clothing/head/hooded/cultlain_hood

/obj/item/clothing/head/hooded/cultlain_hood
	name = "ancient hood"
	desc = "A torn, dust-caked hood."
	icon_state = "culthood"
	body_parts_covered = HEAD
	flags_inv = HIDEFACE|HIDEHAIR|HIDEEARS
	flags_cover = HEADCOVERSEYES
	armor = list(MELEE = 50, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 0, RAD = 0, FIRE = 80, ACID = 80) //Chaplain Riot Helmet

/obj/item/storage/box/holy/narsian
	name = "Ancient Kit"

/obj/item/storage/box/holy/narsian/PopulateContents()
	new /obj/item/clothing/suit/hooded/cultlain_robe(src)

/obj/item/nullrod/cultdagger
	name = "ritual dagger"
	desc = "A strange dagger said to be used by a sinister group.. "
	icon = 'icons/obj/wizard.dmi'
	icon_state = "render"
	inhand_icon_state = "cultdagger"
	worn_icon_state = "render"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Chaplain")
	special_desc = "Activate it to receive the language of a forgotten cult."
	var/narsian = FALSE

/obj/item/nullrod/cultdagger/attack_self(mob/user)
	if(narsian)
	else if(user.mind && (user.mind.holy_role))
		to_chat(user, "<span class='cultlarge'>\"Interesting.\"</span>")
		user.grant_language(/datum/language/narsie, TRUE, TRUE, LANGUAGE_MIND)
		special_desc_requirement = NONE // No point in keeping something that can't no longer be used
		narsian = TRUE

/obj/item/nullrod/claymore/darkblade
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Chaplain")
	special_desc = "Activate it to receive the language of a forgotten cult."
	var/narsian = FALSE

/obj/item/nullrod/claymore/darkblade/attack_self(mob/user)
	if(narsian)
	else if(user.mind && (user.mind.holy_role))
		to_chat(user, "<span class='cultlarge'>\"Interesting.\"</span>")
		user.grant_language(/datum/language/narsie, TRUE, TRUE, LANGUAGE_MIND)
		special_desc_requirement = NONE // No point in keeping something that can't no longer be used
		narsian = TRUE

/obj/item/nullrod/spear
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Chaplain")
	special_desc = "Activate it to receive the language of a forgotten cult."
	var/ratvarian = FALSE

/obj/item/nullrod/spear/attack_self(mob/user)
	if(ratvarian)
	else if(user.mind && (user.mind.holy_role))
		to_chat(user, "<span class='cultlarge'>\"Interesting.\"</span>")
		user.grant_language(/datum/language/narsie, TRUE, TRUE, LANGUAGE_MIND)
		special_desc_requirement = NONE // No point in keeping something that can't no longer be used
		ratvarian = TRUE

/obj/item/nullrod/rosary
	name = "prayer beads"
	desc = "A set of prayer beads used by many of the more traditional religions in space"
	icon = 'modular_skyrat/modules/chaplain/icons/obj/holy_weapons.dmi'
	icon_state = "rosary"
	force = 4
	throwforce = 0
	attack_verb_simple = list("whipped", "repented", "lashed", "flagellated")
	slot_flags = ITEM_SLOT_BELT
	var/praying = FALSE
	var/deity_name = "Coderbus" //This is the default, hopefully won't actually appear if the religion subsystem is running properly

/obj/item/nullrod/rosary/Initialize()
	.=..()
	if(GLOB.deity)
		deity_name = GLOB.deity

/obj/item/nullrod/rosary/attack_secondary(mob/living/M, mob/living/user)
	if(!user.mind || user.mind.assigned_role != "Chaplain")
		to_chat(user, "<span class='notice'>You are not close enough with [deity_name] to use [src].</span>")
		return

	if(praying)
		to_chat(user, "<span class='notice'>You are already using [src].</span>")
		return

	user.visible_message("<span class='info'>[user] kneels[M == user ? null : " next to [M]"] and begins to utter a prayer to [deity_name].</span>", \
		"<span class='info'>You kneel[M == user ? null : " next to [M]"] and begin a prayer to [deity_name].</span>")

	praying = TRUE
	if(do_after(user, 20, target = M))
		M.reagents?.add_reagent(/datum/reagent/water/holywater, 5)
		to_chat(M, "<span class='notice'>[user]'s prayer to [deity_name] has eased your pain!</span>")
		M.adjustToxLoss(-5, TRUE, TRUE)
		M.adjustOxyLoss(-5)
		M.adjustBruteLoss(-5)
		M.adjustFireLoss(-5)
		praying = FALSE
	else
		to_chat(user, "<span class='notice'>Your prayer to [deity_name] was interrupted.</span>")
		praying = FALSE
