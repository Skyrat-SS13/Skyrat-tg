/datum/job/skyratghostrole/syndicate
	paycheck_department = ACCOUNT_INT //Interdyne is the most prominent syndicate ghostrole.

//OPERATVIES / ASSISTANTS//
/datum/job/skyratghostrole/syndicate/operative
	title = "Operative"
	total_positions = 5
	supervisors = "absolutely everyone"
	outfit = /datum/outfit/job/assistant
	plasmaman_outfit = /datum/outfit/plasmaman //TEMP
	paycheck = PAYCHECK_ASSISTANT

	liver_traits = list(TRAIT_GREYTIDE_METABOLISM)

	family_heirlooms = list(/obj/item/storage/toolbox/mechanical/old/heirloom, /obj/item/clothing/gloves/cut/heirloom)

/datum/outfit/job/skyratghostrole/syndicate/operative //This is intended both as the operative outfit and as a base for all others.
	name = "DS-2 Operative"
	jobtype = /datum/job/skyratghostrole/syndicate/operative
	id_trim = /datum/id_trim/syndicom/skyrat/assault/assistant
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/interdyne
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth) //TO-DO - When the access update rolls out, strip these out to be the mindshield equivalent.

//BOTANISTS / CHEFS / SERVICE STAFF//
// Technically these have dedicated equivalents too, but rolling them into one role helps considering how far apart they are and is totally not at all a lazy holdover from DS-1 :)

/datum/job/skyratghostrole/syndicate/service
	title = "Service Staff"
	total_positions = 4
	supervisors = "the corporate liaison"
	selection_color = "#bbe291"
	outfit = /datum/outfit/job/cook
	plasmaman_outfit = /datum/outfit/plasmaman/chef //TEMP
	paycheck = PAYCHECK_EASY

	liver_traits = list(TRAIT_CULINARY_METABOLISM)

	family_heirlooms = list(/obj/item/reagent_containers/food/condiment/saltshaker, /obj/item/kitchen/rollingpin, /obj/item/clothing/head/chefhat)

/datum/outfit/job/skyratghostrole/syndicate/operative/service
	name = "DS-2 Staff"
	uniform = /obj/item/clothing/under/utility/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/syndicatestaff
