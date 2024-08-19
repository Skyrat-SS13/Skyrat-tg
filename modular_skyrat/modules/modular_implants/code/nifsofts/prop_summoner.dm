#define SUMMONED_ITEM_ALPHA 180
#define SUMMONED_ITEM_LIGHT 2

/obj/item/disk/nifsoft_uploader/summoner
	name = "Grimoire Caeruleam"
	loaded_nifsoft = /datum/nifsoft/summoner
	custom_price = PAYCHECK_CREW * 3

/obj/item/disk/nifsoft_uploader/summoner/ghost
	custom_price = 0

/datum/nifsoft/summoner
	name = "Grimoire Caeruleam"
	program_desc = "The Grimoire Caeruleam is an open-source, virtual decentralized directory of summonable objects originally developed by the Altspace Coven, a post-pagan group of witches first digitized into engrams in the year 2544. These summonable constructs, or 'Icons,' are comprised of delicate patterns of nanomachines serving as a framework and projector for hardlight; the name 'Caeruleam' referencing the blue light an Icon casts in the summoner's hand. While the Grimoire has served thousands thus far, Corporate interests have blocked all access to Icons capable of harming their assets."
	cooldown = TRUE
	activation_cost = 100 // Around 1/10th the energy of a standard NIF
	buying_category = NIFSOFT_CATEGORY_FUN
	ui_icon = "book-open"
	able_to_keep = TRUE // These NIFSofts are mostly for comsetic/fun reasons anyways.

	/// Does the resulting object have a holographic like filter appiled to it?
	var/holographic_filter = TRUE
	/// Is there any special tag added at the begining of the resulting object name?
	var/name_tag = "cerulean "
	purchase_price = 175

	///The list of items that can be summoned from the NIFSoft.
	var/list/summonable_items = list(
		/obj/item/toy/katana/nanite,
		/obj/item/cane/nanite,
		/obj/item/storage/dice/nanite,
		/obj/item/toy/cards/deck/nanite,
		/obj/item/toy/cards/deck/tarot/nanite, //The arcana is the means by which all is revealed
		/obj/item/toy/cards/deck/kotahi/nanite,
		/obj/item/toy/foamblade/nanite,
		/obj/item/cane/white/nanite,
		/obj/item/lighter/nanite,
		/obj/item/holocigarette/nanite,
	)

	///The objects currently summoned by the NIFSoft
	var/list/summoned_items = list()
	///What is the maximum amount of items that can be suummoned?
	var/max_summoned_items = 5

/datum/nifsoft/summoner/activate()
	. = ..()
	if(!.)
		return FALSE

	if(tgui_alert(linked_mob, "Do you wish to summon a new item or dispel an already existing item?", program_name, list("Summon", "Dispel")) == "Dispel")
		refund_activation_cost()
		if(!length(summoned_items))
			linked_mob.balloon_alert(linked_mob, "You have no summoned items!")
			return FALSE

		var/obj/item/choice = tgui_input_list(linked_mob, "Chose an object to desummon.", program_name, summoned_items)

		if(!choice)
			linked_mob.balloon_alert(linked_mob, "You did not chose an item!")
			return FALSE

		summoned_items -= choice
		qdel(choice)
		return TRUE

	if(length(summoned_items) >= max_summoned_items)
		linked_mob.balloon_alert(linked_mob, "You have the max ammount of items summoned!")
		refund_activation_cost()
		return FALSE

	var/list/summon_choices = list()
	for(var/obj/item/summon_item as anything in summonable_items)
		var/image/obj_icon = image(icon = initial(summon_item.icon), icon_state = initial(summon_item.icon_state))

		summon_choices[summon_item] = obj_icon

	var/obj/item/choice = show_radial_menu(linked_mob, linked_mob, summon_choices, radius = 42, custom_check = CALLBACK(src, PROC_REF(check_menu), linked_mob))
	if(!choice)
		refund_activation_cost()
		return FALSE

	var/obj/item/new_item = new choice
	new_item.name = name_tag + new_item.name

	if(!linked_mob.put_in_hands(new_item))
		linked_mob.balloon_alert(linked_mob, "[new_item] fails to materialize in your hands!")
		qdel(new_item)
		refund_activation_cost()
		return FALSE

	apply_custom_properties(new_item)
	summoned_items += new_item
	new_item.AddComponent(/datum/component/summoned_item, holographic_filter)

/// This proc is called while an item is being summoned, use this to modifiy aspects of the item that aren't modified by the component.
/datum/nifsoft/summoner/proc/apply_custom_properties(obj/item/target_item)
	if(!target_item)
		return FALSE

	return TRUE

/datum/nifsoft/summoner/Destroy()
	QDEL_LIST(summoned_items)
	return ..()

///Can the person using the NIFSoft summon an item?
/datum/nifsoft/summoner/proc/check_menu(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE

	return TRUE

/datum/component/summoned_item
	///What items were contained, if any, inside of the summoned item? These are deleted when the item is desummoned.
	var/list/sub_items = list()

/datum/component/summoned_item/Initialize(holographic_filter = TRUE)
	. = ..()
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

	var/obj/item/summoned_item = parent
	if(holographic_filter)
		summoned_item.alpha = SUMMONED_ITEM_ALPHA
		summoned_item.set_light(SUMMONED_ITEM_LIGHT)
		summoned_item.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)

		if(istype(summoned_item, /obj/item/storage))
			for(var/obj/item/stored_item as anything in summoned_item)
				stored_item.alpha = SUMMONED_ITEM_ALPHA
				stored_item.set_light(SUMMONED_ITEM_LIGHT)
				stored_item.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)
				sub_items += stored_item

		if(istype(summoned_item, /obj/item/toy/cards/deck))
			var/obj/item/toy/cards/deck/summoned_deck = summoned_item
			var/list/cardlist = summoned_deck.fetch_card_atoms()
			if(!cardlist)
				return FALSE

			for(var/obj/item/toy/single_card in cardlist)
				single_card.alpha = SUMMONED_ITEM_ALPHA
				single_card.set_light(SUMMONED_ITEM_LIGHT)
				single_card.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)
				sub_items += single_card

/datum/component/summoned_item/Destroy(force, silent)
	for(var/obj/item in sub_items)
		sub_items -= item
		qdel(item)

	return ..()

//Summonable Items
///A somehow wekaer version of the toy katana
/obj/item/toy/katana/nanite
	name = "hexblade"
	special_desc = "One of the first groups to contribute to the Caeruleam Grimoire's repository were the Malatestan Duelists, a group of mercenary-philosophers seeking to become undisputed masters of the principal art of Cutting. Originally intended as a means of generating perfectly sharp, perfectly unbreakable, and perfectly capable of the Sanctioned Action: to cut. However, these 'blunted' prop Icons are only a mere shadow of what the Duelists originally developed, the only version of the Icon permitted by interstellar law to civilians; normally seen on convention floors or in the hands of those wishing to spar without risk."
	force = 0
	throwforce = 0

/obj/item/storage/dice/nanite
	name = "dice set"
	special_desc = "A gorgeous replication of a gorgeous set of dice. These were modeled after a set of dice originally in the possession of the Selenian Wargaming Society, carved from rare lunar crystals over two hundred years ago. While no one but the Prime Game Master may ever roll even a single piece from the original set, the Society has graciously donated virtual replicas to the Altspace Coven's repo, as a token of their appreciation for aid in more live-action forms of roleplay."

/obj/item/toy/cards/deck/nanite
	name = "main deck"
	special_desc = "Another piece of gaming equipment graciously donated from the Selenian Wargaming Society, these cards employ a localized field of near-invisible nanites equipped with advanced eye tracking software; to ensure the display on the cards does not allow for peeking. Additionally, over five hundred thousand variations of the standard fifty two card deck are supported, in all known forms of writing."

/obj/item/toy/cards/deck/tarot/nanite
	name = "tarot deck"
	special_desc = "The seventy eight card deck historically used by occultists and esotericists, such as the witches of the Altspace Coven. Containing both the greater secrets of the Major Arcana and the lesser secrets of the Minor Arcana, the full deck is employed as a key tool in cartomancy; and it's said these cards are able to gain insight into the past, present, and future. People who use them for divination ask all sorts of topics, ranging from health to economic issues, but the Coven uses to use them as a guide for traversing their spiritual path, claiming that the non-physical nature of these digitally summonable cards allows readers higher sensitivity to fate itself."

/obj/item/toy/cards/deck/kotahi/nanite
	name = "kotahi deck"
	special_desc = "Kotahi in long-haul freighters! Kotahi in low orbit! Kotahi on the floor! Kotahi like never before! For nearly six hundred years, Kotahi has dominated the card gaming category as the galaxy's #1 shedding-type card game! But how do you take a brand beloved by thousands of sophonts to the next level? With the cooperation of the Selenian Wargaming Society, we've elevated Kotahi to a brand new playing field: digitally summonable Kotahi cards, for the low low cost of 200cr, Now you know why we call it number one."

/obj/item/cane/nanite
	name = "staff"
	special_desc = "This program was contributed by a mutual aid group, the Sapient Rights Recovery Association located in many regions across the eastern continents of Earth. Cerulean staffs employ more nanomachines than holograms, giving them a solid core and steady tip for use by the disabled. Through ample usage of sound cues to help summoners navigate the menu, a pattern was also developed for sightless individuals both by incident, birth, and biology."

	force = 0
	throwforce = 0

/obj/item/cane/white/nanite
	name = "white staff"
	special_desc = "This program was contributed by a mutual aid group, the Sapient Rights Recovery Association located in many regions across the eastern continents of Earth. Cerulean staffs employ more nanomachines than holograms, giving them a solid core and steady tip for use by the disabled. Through ample usage of sound cues to help summoners navigate the menu, a pattern was also developed for sightless individuals both by incident, birth, and biology."

	force = 0
	throwforce = 0

/obj/item/toy/foamblade/nanite
	name = "armblade"
	special_desc = "This Icon was leaked onto the Grimoire somewhat illegally. It was originally uploaded by a departing member of the Tiger Cooperative, the download text informing the summoner that this Icon was first used by the cultists for use as 'training for their biological Ascension' into shape-shifting entities. Within hours, several variants for all sorts of sapient limb configurations were forked and uploaded, this one an entirely nonlethal one."

/obj/item/lighter/nanite
	name = "catchflame"
	special_desc = "A work of art by the standards of normal Icons, this one was worked on for five continuous years by a single summoner; now known as Neophyte Inverse after adoption of the Icon by the few physically-bodied members of the Altspace Coven. The engram's work involves the use of nanites to ignite atmospheric hydrogen molecules, the blue glow from the Icon arising from perfect and complete combustion. This allows the lighter to function exactly as a normal zippo would, the description reading '...useful for lighting hearth fires, candles, and incense; try white sage if you can order some off the net, just pray it doesn't dispel engrams lol.'"

/obj/item/holocigarette/nanite
	name = "cloudstick"
	special_desc = "One of mankind's many attempts at ending the legacy of Big Tobacco. Contributed by a fully anonymous engram and then forked countless times into countless replications of brands and flavors, the 'Cloudstick' is more of a genre than a single Icon. Most downloadable ones even allow the summoner to change the pixelation of the smoke, to grant them a more 'detached' experience from the real thing. Several summoners report these to help them in quitting smoking, others simply commenting 'It's why I first downloaded the Catchflame.'"


#undef SUMMONED_ITEM_ALPHA
#undef SUMMONED_ITEM_LIGHT
