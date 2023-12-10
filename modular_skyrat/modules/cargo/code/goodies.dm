/*
*	EMERGENCY RACIAL EQUIPMENT
*/

/datum/supply_pack/goody/airsuppliesnitrogen
	name = "Emergency Air Supplies (Nitrogen)"
	desc = "A vox breathing mask and nitrogen tank."
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/nitrogen/belt,
		/obj/item/clothing/mask/breath/vox,
	)

/datum/supply_pack/goody/airsuppliesoxygen
	name = "Emergency Air Supplies (Oxygen)"
	desc = "A breathing mask and emergency oxygen tank."
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/clothing/mask/breath,
	)

/datum/supply_pack/goody/airsuppliesplasma
	name = "Emergency Air Supplies (Plasma)"
	desc = "A breathing mask and plasmaman plasma tank."
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/plasmaman/belt,
		/obj/item/clothing/mask/breath,
	)

/*
*	ENGINEERING STUFF
*/

/datum/supply_pack/goody/improvedrcd
	name = "Improved RCD"
	desc = "An upgraded RCD featuring superior material storage. Comes with complimentary frames and circuitry upgrades to boot!"
	cost = PAYCHECK_CREW * 38
	contains = list(/obj/item/construction/rcd/improved)

/*
*	MISC
*/

/datum/supply_pack/goody/crayons
	name = "Box of Crayons"
	desc = "Colorful!"
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/storage/crayons)

/datum/supply_pack/goody/diamondring
	name = "Diamond Ring"
	desc = "Show them your love is like a diamond: unbreakable and everlasting. No refunds."
	cost = PAYCHECK_CREW * 50
	contains = list(/obj/item/storage/fancy/ringbox/diamond)
	crate_name = "diamond ring crate"

/datum/supply_pack/goody/paperbin
	name = "Paper Bin"
	desc = "Pushing paperwork is always easier when you have paper to push!"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/paper_bin)

/datum/supply_pack/goody/xenoarch_intern
	name = "Xenoarchaeology Intern Skillchip"
	desc = "A skillchip with all the information required to start dabbling in the fine art of interpreting xenoarchaeological finds. \
			Does not come with actual xenoarchaeological tools, nor the ability to actually make anyone pay attention to one's \
			attempts at intellectual posturing, nor any actual job experience as a curator."
	cost = PAYCHECK_CREW * 35 // 1750 credit goody? do bounties
	contains = list(/obj/item/skillchip/xenoarch_magnifier)

/datum/supply_pack/goody/scratching_stone
	name = "Scratching Stone"
	desc = "A high-grade sharpening stone made of specialized alloys, meant to sharpen razor-claws. Unfortunately, this particular one has by far seen better days."
	cost = CARGO_CRATE_VALUE * 4 //800 credits
	contains = list(/obj/item/scratching_stone)
	contraband = TRUE

/*
*	CARPET PACKS
*/

/datum/supply_pack/goody/carpet
	name = "Classic Carpet Single-Pack"
	desc = "Plasteel floor tiles getting on your nerves? This 50 units stack of extra soft carpet will tie any room together."
	cost = PAYCHECK_CREW * 3
	contains = list(/obj/item/stack/tile/carpet/fifty)

/datum/supply_pack/goody/carpet/black
	name = "Black Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/black/fifty)

/datum/supply_pack/goody/carpet/premium
	name = "Royal Black Carpet Single-Pack"
	desc = "Exotic carpets for all your decorating needs. This 50 unit stack of extra soft carpet will tie any room together."
	cost = PAYCHECK_CREW * 3.5
	contains = list(/obj/item/stack/tile/carpet/royalblack/fifty)

/datum/supply_pack/goody/carpet/premium/royalblue
	name = "Royal Blue Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/royalblue/fifty)

/datum/supply_pack/goody/carpet/premium/red
	name = "Red Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/red/fifty)

/datum/supply_pack/goody/carpet/premium/purple
	name = "Purple Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/purple/fifty)

/datum/supply_pack/goody/carpet/premium/orange
	name = "Orange Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/orange/fifty)

/datum/supply_pack/goody/carpet/premium/green
	name = "Green Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/green/fifty)

/datum/supply_pack/goody/carpet/premium/cyan
	name = "Cyan Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/cyan/fifty)

/datum/supply_pack/goody/carpet/premium/blue
	name = "Blue Carpet Single-Pack"
	contains = list(/obj/item/stack/tile/carpet/blue/fifty)

/*
* NIF STUFF
*/
/datum/supply_pack/goody/standard_nif
	name = "Standard Type NIF"
	desc = "Contains a single standard NIF by itself, surgery is required."
	cost = CARGO_CRATE_VALUE * 15
	contains = list(
		/obj/item/organ/internal/cyberimp/brain/nif/standard,
	)

/datum/supply_pack/goody/cheap_nif
	name = "Econo-Deck Type NIF"
	desc = "Contains a single Econo-Deck NIF by itself, surgery is required."
	cost = CARGO_CRATE_VALUE * 7.5
	contains = list(
		/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model,
	)

/datum/supply_pack/goody/nif_repair_kit
	name = "Cerulean NIF Regenerator"
	desc = "Contains a single container of NIF repair fluid, good for up to 5 uses."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/nif_repair_kit,
	)

/datum/supply_pack/goody/money_sense_nifsoft
	name = "Automatic Appraisal NIFSoft"
	desc = "Contains a single Automatic Appraisal NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/money_sense,
	)

/datum/supply_pack/goody/shapeshifter_nifsoft
	name = "Polymorph NIFSoft"
	desc = "Contains a single Polymorph NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/shapeshifter,
	)

/datum/supply_pack/goody/hivemind_nifsoft
	name = "Hivemind NIFSoft"
	desc = "Contains a single Hivemind NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/hivemind,
	)

/datum/supply_pack/goody/summoner_nifsoft
	name = "Grimoire Caeruleam NIFSoft"
	desc = "Contains a single Grimoire Caeruleam NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 0.75
	contains = list(
		/obj/item/disk/nifsoft_uploader/summoner,
	)

/datum/supply_pack/goody/firstaid_pouch
	name = "Mini-Medkit First Aid Pouch"
	desc = "Contains a single surplus first-aid pouch, complete with pocket clip. Repackaged with station-standard medical supplies, \
	but nothing's stopping you from repacking it yourself, though."
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/storage/pouch/medical/firstaid/loaded,
	)

/datum/supply_pack/goody/stabilizer_pouch
	name = "Stabilizer First Aid Pouch"
	desc = "Contains a single surplus first-aid pouch, complete with pocket clip. Repackaged with a wound stabilizing-focused loadout, \
	but nothing's stopping you from repacking it yourself, though."
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/storage/pouch/medical/firstaid/stabilizer,
	)
