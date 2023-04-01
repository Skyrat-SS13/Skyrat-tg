/datum/opposing_force_equipment/bomb
	category = OPFOR_EQUIPMENT_CATEGORY_EXPLOSIVES

/datum/opposing_force_equipment/bomb/henade
	item_type = /obj/item/grenade/syndieminibomb/concussion
	description = "A grenade intended to concuss and incapacitate enemies. Still rather explosive."

/datum/opposing_force_equipment/bomb/fragnade
	item_type = /obj/item/grenade/frag
	description = "A fragmentation grenade that looses pieces of shrapnel after detonating for maximum injury."

/datum/opposing_force_equipment/bomb/radnade
	item_type = /obj/item/grenade/gluon
	description = "A prototype grenade that freezes the target area and unleashes a wave of deadly radiation."
	admin_note = "WARNING: Makes a giant square of ice, and also, does rad damage in the same AOE."

/datum/opposing_force_equipment/bomb/c4
	item_type = /obj/item/grenade/c4
	description = "A brick of plastic explosives, for breaking open walls, doors, and optionally people."

/datum/opposing_force_equipment/bomb/x4
	item_type = /obj/item/grenade/c4/x4
	description = "Similar to C4, but with a stronger blast that is directional instead of circular."

/datum/opposing_force_equipment/bomb/syndicate
	name = "Syndicate Bomb"
	item_type = /obj/item/sbeacondrop/bomb
	description = "A large, powerful bomb that can be wrenched down and armed with a variable timer."
	admin_note = "WARNING: This is a pretty big bomb, it can take out entire rooms."

/datum/opposing_force_equipment/bomb/syndicate_emp
	name = "Syndicate EMP Bomb"
	item_type = /obj/item/sbeacondrop/emp
	description = "A modified version of the Syndicate Bomb that releases a large EMP instead."

/datum/opposing_force_equipment/bomb/minibomb
	name = "Syndicate Minibomb"
	item_type = /obj/item/grenade/syndieminibomb
	description = "The minibomb is a grenade with a five-second fuse. Upon detonation, it will create a small hull breach \
			in addition to dealing high amounts of damage to nearby personnel."

/datum/opposing_force_equipment/bomb/pizza
	name = "Pizza Bomb"
	item_type = /obj/item/pizzabox/bomb
	description = "A pizza box with a bomb cunningly attached to the lid. The timer needs to be set by opening the box; afterwards, \
			opening the box again will trigger the detonation after the timer has elapsed. Comes with free pizza, for you or your target!"

/datum/opposing_force_equipment/bomb/nukedelivery
	name = "Nuclear Delivery Grenade"
	item_type = /obj/item/grenade/spawnergrenade/therealnuke
	description = "A very confusing grenade containing 2 dehydrated nuclear operatives. Stand back when primed."

/datum/opposing_force_equipment/bomb/viscerator
	name = "Viscerator Delivery Grenade"
	item_type = /obj/item/grenade/spawnergrenade/manhacks
	description = "A unique grenade that deploys a swarm of viscerators upon activation, which will chase down and shred \
			any non-operatives in the area."

/datum/opposing_force_equipment/bomb/buzzkill
	name = "Buzzkill Grenade"
	item_type = /obj/item/grenade/spawnergrenade/buzzkill
	description = "A grenade that release a swarm of angry bees upon activation. These bees indiscriminately attack friend or foe \
			with random toxins. Courtesy of the BLF and Tiger Cooperative."
	admin_note = "WARNING: The bee's from this grenade can have almost anything chem-wise into them, and just a few can make a massive swarm of bees(10 bees per!!)"

/datum/opposing_force_equipment/bomb/bonebang
	name = "Bonebang"
	item_type = /obj/item/grenade/stingbang/bonebang
	description = "A horrifying grenade filled with what looks to be bone and gore, which upon detonation will fill the room you're in with bone fragments."

/datum/opposing_force_equipment/bomb/flashbang
	name = "Flashbang"
	item_type = /obj/item/grenade/flashbang
	description = "A flash-and-sonic stun grenade, useful for non-lethally incapacitating crowds."
