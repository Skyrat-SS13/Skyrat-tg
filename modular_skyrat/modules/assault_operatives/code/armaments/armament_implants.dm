#define ARMAMENT_CATEGORY_IMPLANTS "Implants and Skills"
#define ARMAMENT_CATEGORY_IMPLANTS_LIMIT 3
#define ARMAMENT_SUBCATEGORY_IMPLANTS "Implanters"
#define ARMAMENT_SUBCATEGORY_BOOKS "Books"

/datum/armament_entry/assault_operatives/skills_implants
	category = ARMAMENT_CATEGORY_IMPLANTS
	category_item_limit = ARMAMENT_CATEGORY_IMPLANTS_LIMIT

/datum/armament_entry/assault_operatives/skills_implants/implant
	subcategory = ARMAMENT_SUBCATEGORY_IMPLANTS

/datum/armament_entry/assault_operatives/implant/adrenaline
	item_type = /obj/item/implanter/storage
	cost = 3

/datum/armament_entry/assault_operatives/implant/nodrop
	item_type = /obj/item/implanter/explosive
	cost = 1



/datum/armament_entry/assault_operatives/skills_implants/books
	subcategory = ARMAMENT_SUBCATEGORY_BOOKS

/datum/armament_entry/assault_operatives/skills_implants/books/summonitem
	name = "Summon Item"
	item_type = /obj/item/book/granter/spell/summonitem
	description = "This spell can be used to recall a previously marked item to your hand from anywhere in the universe."
	cost = 4

/datum/armament_entry/assault_operatives/skills_implants/books/cqc
	item_type = /obj/item/book/granter/martial/cqc
	cost = 10
