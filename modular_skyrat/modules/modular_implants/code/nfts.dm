/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model/cheap/nft
	name = "Non Fungible Trial-NIF"
	desc = "The latest and greatest in NIF technology, NFTs (Non Fungible Trial-NIFs) aim to bring the enticing concept of scarcity back to the world of NIF implants. Comes with a free limited edition primate picture."
	manufacturer_notes = "Based on NTNet 3.0, NFTs provide the user with all of the benefits of normal Trial-NIFs with the addition of a free limited edition primate picture speculatively at thousands of credits."
	var/nft_quirk

/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model/cheap/nft/Insert(mob/living/carbon/human/insertee, special, drop_if_replaced)
	. = ..()
	linked_mob.add_quirk(/datum/quirk/item_quirk/nft)

/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model/cheap/nft/Remove(mob/living/carbon/organ_owner, special)
	linked_mob.remove_quirk(/datum/quirk/item_quirk/nft)
	return ..()

// This is lazy and dumb, but I don't care lol.
/datum/quirk/item_quirk/nft
	name = "NFT owner"
	desc = "You are the current owner of an primate picture. Don't let your ape escape!"
	icon = "toolbox"
	medical_record_text = "Patient demonstrates an unnatural attachment to a primate picture."
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES|QUIRK_MOODLET_BASED
	/// A weak reference to our heirloom.
	var/datum/weakref/heirloom

/datum/quirk/item_quirk/nft/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder

	var/obj/new_heirloom = new /obj/item/photo/nft(get_turf(human_holder))
	heirloom = WEAKREF(new_heirloom)

	give_item_to_holder(
		new_heirloom,
		list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		),
		flavour_text = "You are the current owner of a primate picture. Don't let your ape escape!",
	)

/datum/quirk/item_quirk/nft/post_add()
	var/list/random_characters = list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","1","2","3","4","5","6","7","8","9","0","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O")
	var/ntnet_address = ""

	for(var/i in 1 to 10)
		ntnet_address += pick(random_characters)

	var/obj/family_heirloom = heirloom?.resolve()
	if(!family_heirloom)
		to_chat(quirk_holder, span_boldnotice("A wave of existential dread runs over you as you realize your precious primate picture is missing. Perhaps the Gods will show mercy on your cursed soul?"))
		return
	family_heirloom.AddComponent(/datum/component/heirloom, quirk_holder.mind, ntnet_address)

	return ..()

/datum/quirk/item_quirk/nft/process()
	if(quirk_holder.stat == DEAD)
		return

	var/obj/family_heirloom = heirloom?.resolve()

	if(family_heirloom && (family_heirloom in quirk_holder.get_all_contents()))
		quirk_holder.clear_mood_event("nft_missing")
		quirk_holder.add_mood_event("nft", /datum/mood_event/family_heirloom/nft)
	else
		quirk_holder.clear_mood_event("nft")
		quirk_holder.add_mood_event("nft_missing", /datum/mood_event/family_heirloom_missing/nft)

/datum/quirk/item_quirk/nft/remove()
	quirk_holder.clear_mood_event("family_heirloom_missing")
	quirk_holder.clear_mood_event("family_heirloom")

/datum/mood_event/family_heirloom/nft
	description = "My primate picture is so cool, everyone should buy one!"
	mood_change = 0

/datum/mood_event/family_heirloom_missing/nft
	description = "My ape... it has escaped..."
	mood_change = -16 //Same value as servere depression. :(

/obj/item/photo/nft
	name = "limited edition primate picture"
	desc = "they only made a million of these, extremely rare."

/obj/item/autosurgeon/organ/nif/disposable/nft
	name = "NFT Type Autosurgeon"
	starting_organ = /obj/item/organ/internal/cyberimp/brain/nif/roleplay_model/cheap/nft
