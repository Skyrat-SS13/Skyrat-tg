/obj/item/forging
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	var/work_time = 2 SECONDS

/obj/item/forging/tongs
	name = "forging tongs"
	desc = "A set of tongs specifically crafted for use in forging. A wise man once said 'I lift things up and put them down.'"
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "tong_empty"

/obj/item/forging/tongs/primitive
	name = "primitive forging tongs"
	work_time = 3 SECONDS

/obj/item/forging/tongs/attack_self(mob/user, modifiers)
	. = ..()
	var/obj/search_obj = locate(/obj) in contents
	if(search_obj)
		search_obj.forceMove(get_turf(src))
		icon_state = "tong_empty"
		return

/obj/item/forging/hammer
	name = "forging hammer"
	desc = "A hammer specifically crafted for use in forging. Used to slowly shape metal; careful, you could break something with it!"
	icon_state = "hammer"

/obj/item/forging/hammer/primitive
	name = "primitive forging hammer"

/obj/item/forging/billow
	name = "forging billow"
	desc = "A billow specifically crafted for use in forging. Used to stoke the flames and keep the forge lit."
	icon_state = "billow"

/obj/item/forging/billow/primitive
	name = "primitive forging billow"
	work_time = 3 SECONDS

//incomplete pre-complete items
/obj/item/forging/incomplete
	name = "parent dev item"
	desc = "An incomplete forge item, continue to work hard to be rewarded for your efforts."
	//the compare of when it gets too cold to hammer
	COOLDOWN_DECLARE(heating_remainder)
	//the compare so you cant just keep hitting
	COOLDOWN_DECLARE(striking_cooldown)
	///the amount of times it takes for the item to become ready
	var/average_hits = 30
	///the amount of times the item has been hit currently
	var/times_hit = 0
	///the required time before each strike to prevent spamming
	var/average_wait = 1 SECONDS
	///the path of the item that will be spawned upon completion
	var/spawn_item

/obj/item/forging/incomplete/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/forging/tongs))
		var/obj/search_obj = locate(/obj) in I.contents
		if(search_obj)
			to_chat(user, span_warning("The tongs are already holding something, make room."))
			return
		forceMove(I)
		I.icon_state = "tong_full"
		return

/obj/item/forging/incomplete/chain
	name = "incomplete chain"
	icon_state = "hot_chain"
	average_hits = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/chain

/obj/item/forging/incomplete/plate
	name = "incomplete plate"
	icon_state = "hot_plate"
	average_hits = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/plate

/obj/item/forging/incomplete/sword
	name = "incomplete sword blade"
	icon_state = "hot_blade"
	spawn_item = /obj/item/forging/complete/sword

/obj/item/forging/incomplete/katana
	name = "incomplete katana blade"
	icon_state = "hot_katanablade"
	spawn_item = /obj/item/forging/complete/katana

/obj/item/forging/incomplete/dagger
	name = "incomplete dagger blade"
	icon_state = "hot_daggerblade"
	spawn_item = /obj/item/forging/complete/dagger

/obj/item/forging/incomplete/staff
	name = "incomplete staff head"
	icon_state = "hot_staffhead"
	spawn_item = /obj/item/forging/complete/staff

/obj/item/forging/incomplete/spear
	name = "incomplete spear head"
	icon_state = "hot_spearhead"
	spawn_item = /obj/item/forging/complete/spear

/obj/item/forging/incomplete/axe
	name = "incomplete axe head"
	icon_state = "hot_axehead"
	spawn_item = /obj/item/forging/complete/axe

/obj/item/forging/incomplete/hammer
	name = "incomplete hammer head"
	icon_state = "hot_hammerhead"
	spawn_item = /obj/item/forging/complete/hammer

//"complete" pre-complete items
/obj/item/forging/complete
	///the path of the item that will be created
	var/spawning_item
	///the path of the item required for the spawning_item
	var/required_item = /obj/item/stack/sheet/mineral/wood
	///the amount of required_item to make the spawning_item
	var/stack_use = 1
	///the amount of experience awarded for successfully creating the spawning_item
	var/experience_amount = 15

/obj/item/forging/complete/attackby(obj/item/attacking_item, mob/user, params)
	if(!spawning_item)
		return ..()
	if(!istype(attacking_item, required_item))
		return ..()
	if(istype(attacking_item, /obj/item/stack))
		var/obj/item/stack/attacking_stack = attacking_item
		if(!attacking_stack.use(stack_use))
			to_chat(user, span_warning("Unable to use [attacking_stack] on [src]!"))
			return
	else
		qdel(attacking_item)
	new spawning_item(get_turf(src))
	user.mind.adjust_experience(/datum/skill/smithing, experience_amount) //creating things gives experience
	qdel(src)
	return

/obj/item/forging/complete/chain
	name = "chain"
	desc = "A singular chain, best used in combination with multiple chains."
	icon_state = "chain"
	required_item = /obj/item/forging/complete/chain
	spawning_item = /obj/item/forging/coil
	experience_amount = 5

/obj/item/forging/complete/plate
	name = "plate"
	desc = "A plate, best used in combination with multiple plates."
	icon_state = "plate"

/obj/item/forging/complete/sword
	name = "sword blade"
	desc = "A sword blade, ready to get some wood for completion."
	icon_state = "blade"
	spawning_item = /obj/item/forging/reagent_weapon/sword

/obj/item/forging/complete/katana
	name = "katana blade"
	desc = "A katana blade, ready to get some wood for completion."
	icon_state = "katanablade"
	spawning_item = /obj/item/forging/reagent_weapon/katana

/obj/item/forging/complete/dagger
	name = "dagger blade"
	desc = "A dagger blade, ready to get some wood for completion."
	icon_state = "daggerblade"
	spawning_item = /obj/item/forging/reagent_weapon/dagger

/obj/item/forging/complete/staff
	name = "staff head"
	desc = "A staff head, ready to get some wood for completion."
	icon_state = "staffhead"
	spawning_item = /obj/item/forging/reagent_weapon/staff

/obj/item/forging/complete/spear
	name = "spear head"
	desc = "A spear head, ready to get some wood for completion."
	icon_state = "spearhead"
	spawning_item = /obj/item/forging/reagent_weapon/spear

/obj/item/forging/complete/axe
	name = "axe head"
	desc = "An axe head, ready to get some wood for completion."
	icon_state = "axehead"
	spawning_item = /obj/item/forging/reagent_weapon/axe

/obj/item/forging/complete/hammer
	name = "hammer head"
	desc = "A hammer head, ready to get some wood for completion."
	icon_state = "hammerhead"
	spawning_item = /obj/item/forging/reagent_weapon/hammer

/obj/item/forging/coil
	name = "coil"
	desc = "A simple coil, comprised of coiled iron rods."
	icon_state = "coil"

/obj/item/stock_parts/cell/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/forging/coil))
		var/obj/item/stock_parts/cell/crank/new_crank = new(get_turf(src))
		new_crank.maxcharge = maxcharge
		new_crank.charge = charge
		qdel(attacking_item)
		qdel(src)
		return
	return ..()
