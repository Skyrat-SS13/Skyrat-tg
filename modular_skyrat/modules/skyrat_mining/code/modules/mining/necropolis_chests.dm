//boss chests
//gladiator
/obj/structure/closet/crate/necropolis/gladiator
	name = "gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/crusher
	name = "dreadful gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/PopulateContents()
	new /obj/item/shield/riot/tower/swat/gladiator(src)
	new /obj/item/borg/upgrade/modkit/shielding(src)

/obj/structure/closet/crate/necropolis/gladiator/crusher/PopulateContents()
	new /obj/item/shield/riot/tower/swat/gladiator(src)
	new /obj/item/melee/zweihander(src)

/obj/item/shield/riot/tower/swat/gladiator
	name = "\proper Gladiator's shield"
	desc = "A very powerful and near indestructible shield, reinforced with drake and goliath hide. Can be used as a raft on lava."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	righthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/shields_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/shields_lefthand.dmi'
	icon_state = "gladiator"
	inhand_icon_state = "gladiator"
	resistance_flags = FIRE_PROOF | UNACIDABLE | INDESTRUCTIBLE
	max_integrity = 350
	block_chance = 50
	w_class = WEIGHT_CLASS_BULKY

/obj/item/shield/riot/tower/swat/gladiator/AltClick(mob/user)
	if(isliving(user))
		if(do_after(user, 20, target = src))
			new /obj/vehicle/ridden/lavaboat/dragon/gladiator(get_turf(user))
			qdel(src)

/obj/vehicle/ridden/lavaboat/dragon/gladiator
	name = "\proper Gladiator's surfboard"
	desc = "This thing can be used to cross lava rivers... I guess. Alt-click to turn into back into a shield."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "raft"

/obj/vehicle/ridden/lavaboat/dragon/gladiator/Initialize()
	..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.vehicle_move_delay = 1
	D.allowed_turf_typecache = typecacheof(/turf/open)
	D.keytype = null

/obj/vehicle/ridden/lavaboat/dragon/gladiator/AltClick(mob/user)
	..()
	if(isliving(user))
		if(do_after(user, 20, target = src))
			new /obj/item/shield/riot/tower/swat/gladiator(get_turf(user))
			qdel(src)

/obj/structure/closet/crate/necropolis/bubblegum/PopulateContents()
	new /obj/item/clothing/suit/space/hostile_environment(src)
	new /obj/item/clothing/head/helmet/space/hostile_environment(src)
	new /obj/item/gun/magic/staff/spellblade(src)

/obj/structure/closet/crate/necropolis/bubblegum/crusher/PopulateContents()
	new /obj/item/clothing/suit/space/hostile_environment(src)
	new /obj/item/clothing/head/helmet/space/hostile_environment(src)
	new /obj/item/crusher_trophy/demon_claws(src)
	new /obj/item/gun/magic/staff/spellblade(src)

/mob/living/simple_animal/hostile/megafauna/bubblegum/hard
	name = "enraged bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/hard/PopulateContents()
	new /obj/item/crucible(src)
	new /obj/item/gun/ballistic/revolver/doublebarrel/super(src)
	new /obj/item/clothing/suit/space/hardsuit/deathsquad/praetor(src)

/obj/structure/closet/crate/necropolis/bubblegum/hard/crusher
	name = "enraged bloody bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/hard/crusher/PopulateContents()
	new /obj/item/crucible(src)
	new /obj/item/gun/ballistic/revolver/doublebarrel/super(src)
	new /obj/item/clothing/suit/space/hardsuit/deathsquad/praetor(src)
	new /obj/item/crusher_trophy/demon_claws(src)

//super shotty changes (meat hook instead of bursto)

/obj/item/gun/ballistic/revolver/doublebarrel/super
	burst_size = 1
	actions_types = list(/datum/action/item_action/toggle_hook)
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "heckgun"
	lefthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/guns_righthand.dmi'
	inhand_icon_state = "heckgun"
	sharpness = SHARP_NONE
	force = 15
	inhand_x_dimension = 0
	inhand_y_dimension = 0
	var/recharge_rate = 4
	var/charge_tick = 0
	var/toggled = FALSE
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine

/obj/item/gun/ballistic/revolver/doublebarrel/super/Initialize()
	. = ..()
	if(!alternate_magazine)
		alternate_magazine = new /obj/item/ammo_box/magazine/internal/shot/dual/heck/hook(src)
	START_PROCESSING(SSobj, src)

/obj/item/gun/ballistic/revolver/doublebarrel/super/attack_self(mob/living/user)
	if(toggled)
		return 0
	else
		..()

/obj/item/gun/ballistic/revolver/doublebarrel/super/process()
	if(toggled)
		charge_tick++
		if(charge_tick < recharge_rate)
			return 0
		charge_tick = 0
		chambered.newshot()
		return 1
	else
		..()

/obj/item/ammo_box/magazine/internal/shot/dual/heck/hook
	name = "hookshot internal magazine"
	max_ammo = 1
	ammo_type = /obj/item/ammo_casing/magic/hook/heck

/obj/item/ammo_casing/magic/hook/heck
	projectile_type = /obj/projectile/heckhook

/obj/projectile/heckhook //had to create a separate, non-child projectile because otherwise there would be conflicts when calling parent procs.
	name = "hook"
	icon_state = "hook"
	icon = 'icons/obj/lavaland/artefacts.dmi'
	pass_flags = PASSTABLE
	damage = 10
	armour_penetration = 100
	damage_type = BRUTE
	hitsound = 'sound/effects/splat.ogg'
	knockdown = 0
	var/chain

/obj/projectile/heckhook/fire(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state = "chain", time = INFINITY, maxdistance = INFINITY)
	..()

/obj/projectile/heckhook/on_hit(atom/target)
	. = ..()
	var/atom/A = target
	A.visible_message("<span class='danger'>[A] is snagged by [firer]'s hook!</span>")
	new /datum/forced_movement(firer, get_turf(A), 1, TRUE)

/obj/projectile/heckhook/Destroy()
	qdel(chain)
	return ..()

/datum/action/item_action/toggle_hook
	name = "Toggle Hook"

/obj/item/gun/ballistic/revolver/doublebarrel/super/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_hook))
		toggle_hook(user)
	else
		..()

/obj/item/gun/ballistic/revolver/doublebarrel/super/proc/toggle_hook(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		to_chat(user, "You will now fire a hookshot.")
	else
		to_chat(user, "You will now fire normal shotgun rounds.")

/obj/item/gun/ballistic/revolver/doublebarrel/super/sawoff(mob/user)
	to_chat(user, "<span class='warning'>Why would you mutilate this work of art?</span>")
	return

/obj/item/gun/ballistic/revolver/doublebarrel/super/upgraded
	desc = "It was fearsome before, now it's even worse with an internal system that makes it fire both barrels at once."
	burst_size = 2
	fire_delay = 1

//crucible
/obj/item/crucible
	name = "Crucible Sword"
	desc = "Made from pure argent energy, this sword can cut through flesh like butter."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/1x2.dmi'
	icon_state = "crucible0"
	var/icon_state_on = "crucible1"
	lefthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/swords_righthand.dmi'
	inhand_icon_state = "crucible0"
	force = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	var/w_class_on = WEIGHT_CLASS_HUGE
	hitsound = "swing_hit"
	var/hitsound_on = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 50
	light_color = "#ff0000"//BLOOD RED
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "teart", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slashe", "stab", "slice", "tear", "rip", "dice", "cut")
	block_chance = 0
	var/block_chance_on = 50
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100, "wound" = 35)
	resistance_flags = FIRE_PROOF
	var/brightness_on = 6
	var/wielded
	var/item_state_on = "crucible1"

/obj/item/crucible/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/unwield)

/obj/item/crucible/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=25, icon_wielded="crucible1", wieldsound = 'sound/weapons/saberon.ogg', unwieldsound = 'sound/weapons/saberoff.ogg')

/obj/item/crucible/suicide_act(mob/living/carbon/user)
	if(wielded)
		user.visible_message("<span class='suicide'>[user] DOOMs themselves with the [src]!</span>")

		var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)//stole from chainsaw code
		var/obj/item/organ/brain/B = user.getorganslot(ORGAN_SLOT_BRAIN)
		B.organ_flags &= ~ORGAN_VITAL	//this cant possibly be a good idea
		var/randdir
		for(var/i in 1 to 24)//like a headless chicken!
			if(user.is_holding(src))
				randdir = pick(GLOB.alldirs)
				user.Move(get_step(user, randdir),randdir)
				user.emote("spin")
				if (i == 3 && myhead)
					myhead.drop_limb()
				sleep(3)
			else
				user.visible_message("<span class='suicide'>[user] panics and starts choking to death!</span>")
				return OXYLOSS


	else
		user.visible_message("<span class='suicide'>[user] begins beating [user.p_them()]self to death with \the [src]'s handle! It probably would've been cooler if [user.p_they()] turned it on first!</span>")
	return BRUTELOSS

/obj/item/crucible/update_icon_state()
	if(wielded)
		icon_state = "crucible[wielded]"
	else
		icon_state = "crucible0"
	wash(CLEAN_TYPE_BLOOD)

/obj/item/crucible/attack(mob/target, mob/living/carbon/human/user)
	var/def_zone = user.zone_selected
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.getarmor(def_zone, "melee") < 35)
			if((user.zone_selected != BODY_ZONE_CHEST) && (user.zone_selected != BODY_ZONE_HEAD) && (user.zone_selected != BODY_ZONE_PRECISE_GROIN))
				..()
				var/obj/item/bodypart/bodyp= H.get_bodypart(def_zone)
				bodyp.dismember()
		else if(user.zone_selected == BODY_ZONE_PRECISE_GROIN && HAS_TRAIT_FROM(H, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT))
			..()
			var/obj/item/bodypart/bodyp= H.get_bodypart(def_zone)
			if(istype(bodyp))
				bodyp.dismember()
		else if(user.zone_selected == BODY_ZONE_HEAD && HAS_TRAIT_FROM(H, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT))
			..()
			var/obj/item/bodypart/bodyp= H.get_bodypart(def_zone)
			if(istype(bodyp))
				bodyp.dismember()
		else
			..()
	else
		..()

/obj/item/crucible/proc/wield(mob/living/carbon/M)
	wielded = TRUE
	sharpness = SHARP_EDGED
	w_class = w_class_on
	hitsound = hitsound_on
	inhand_icon_state = item_state_on
	block_chance = block_chance_on
	START_PROCESSING(SSobj, src)
	set_light(brightness_on)

/obj/item/crucible/proc/unwield()
	wielded = FALSE
	sharpness = initial(sharpness)
	w_class = initial(w_class)
	hitsound = "swing_hit"
	block_chance = initial(block_chance)
	inhand_icon_state = initial(inhand_icon_state)
	STOP_PROCESSING(SSobj, src)
	set_light(0)

/obj/item/crucible/process()
	if(wielded)
		open_flame()
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/crucible/ignition_effect(atom/A, mob/user)
	if(!wielded)
		return FALSE
	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [user.p_their()] nose"
	. = "<span class='warning'>[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.</span>"
	playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	add_fingerprint(user)


//praetor suit and helmet
/obj/item/clothing/suit/space/hardsuit/deathsquad/praetor
	name = "Praetor Suit"
	desc = "And those that tasted the bite of his sword named him... The Doom Slayer."
	armor = list("melee" = 75, "bullet" = 55, "laser" = 55, "energy" = 45, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100, "wound" = 40)
	strip_delay = 130
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/suits.dmi'
	icon_state = "praetor"
	worn_icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/clothing/suit.dmi'
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/deathsquad/praetor
	slowdown = 0
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/helmet/space/hardsuit/deathsquad/praetor
	name = "Praetor Suit helmet"
	desc = "That's one doomed space marine."
	armor = list("melee" = 75, "bullet" = 55, "laser" = 55, "energy" = 45, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100, "wound" = 37)
	strip_delay = 130
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/hats.dmi'
	icon_state = "praetor"
	worn_icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/clothing/head.dmi'
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//drake
/obj/structure/closet/crate/necropolis/dragon/PopulateContents()
	new /obj/item/borg/upgrade/modkit/knockback(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/dragon/crusher/PopulateContents()
	new /obj/item/crusher_trophy/tail_spike(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/dragon/hard
	name = "enraged dragon chest"

/obj/structure/closet/crate/necropolis/dragon/hard/PopulateContents()
	new /obj/item/melee/ghost_sword(src)
	new /obj/item/lava_staff(src)
	new /obj/item/book/granter/spell/sacredflame(src)
	new /obj/item/gun/magic/wand/fireball(src)
	new /obj/item/borg/upgrade/modkit/knockback(src)
	new /obj/item/dragons_blood(src)
	new /obj/item/clothing/neck/necklace/memento_mori/king(src)

/obj/structure/closet/crate/necropolis/dragon/hard/crusher
	name = "enraged fiery dragon chest"

/obj/structure/closet/crate/necropolis/dragon/hard/crusher/PopulateContents()
	new /obj/item/melee/ghost_sword(src)
	new /obj/item/lava_staff(src)
	new /obj/item/book/granter/spell/sacredflame(src)
	new /obj/item/gun/magic/wand/fireball(src)
	new /obj/item/dragons_blood(src)
	new /obj/item/clothing/neck/necklace/memento_mori/king(src)
	new /obj/item/crusher_trophy/tail_spike(src)

//ghost sword buff because it is dogshit
/obj/item/melee/ghost_sword
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/melee/ghost_sword/attack(mob/living/target, mob/living/carbon/human/user)
	. = ..()
	force = 0
	throwforce = 0
	armour_penetration = 0
	var/ghost_counter = ghost_check()
	force = clamp((ghost_counter * 2.5), 15, 25)
	throwforce = clamp((ghost_counter * 2), 5, 18)
	armour_penetration = clamp((ghost_counter * 3), 0, 35)
	sharpness = SHARP_NONE
	if(ghost_counter >= 4)
		sharpness = SHARP_EDGED
	user.visible_message("<span class='danger'>[user] strikes with the force of [ghost_counter] vengeful spirits!</span>")

/obj/item/melee/ghost_sword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/ghost_counter = ghost_check()
	final_block_chance = clamp((ghost_counter * 5), 10, 50)
	owner.visible_message("<span class='danger'>[owner] is protected by a ring of [ghost_counter] ghosts!</span>")
	return ..()

/obj/item/clothing/neck/necklace/memento_mori/king
	name = "amulet of kings"
	desc = "An amulet that shows everyone who the true emperor is."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/neck.dmi'
	icon_state = "dragon_amulet"
	worn_icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/clothing/neck.dmi'
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

//colossus
/obj/structure/closet/crate/necropolis/colossus/PopulateContents()
	new /obj/item/bluecrystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)
	new /obj/item/borg/upgrade/modkit/bolter(src)

/obj/structure/closet/crate/necropolis/colossus/crusher/PopulateContents()
	new /obj/item/bluecrystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)
	new /obj/item/crusher_trophy/blaster_tubes(src)

//crystal choosing thing from colosssus
/obj/item/bluecrystal
	name = "\improper blue crystal"
	desc = "It's very shiny... one may wonder what it does."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "bluecrystal"
	w_class = WEIGHT_CLASS_SMALL
	var/list/choices = list(
	"Clown" = /obj/machinery/anomalous_crystal/honk,
	"Theme Warp" = /obj/machinery/anomalous_crystal/theme_warp,
	"Bolter" = /obj/machinery/anomalous_crystal/emitter,
	"Dark Revival" = /obj/machinery/anomalous_crystal/dark_reprise,
	"Lightgeist Healers" = /obj/machinery/anomalous_crystal/helpers,
	"Refresher" = /obj/machinery/anomalous_crystal/refresher,
	"Possessor" = /obj/machinery/anomalous_crystal/possessor
	)
	var/list/methods = list(
	"touch",
	"speech",
	"heat",
	"bullet",
	"energy",
	"bomb",
	"bumping",
	"weapon",
	"magic"
	)

/obj/item/bluecrystal/attack_self(mob/user)
	var/choice = input(user, "Choose your destiny", "Crystal") as null|anything in choices
	var/method = input(user, "Choose your activation method", "Crystal") as null|anything in methods
	if(!choice || !method)
		return
	playsound(user.loc, 'sound/effects/hit_on_shattered_glass.ogg', 100, TRUE)
	var/choosey = choices[choice]
	var/obj/machinery/anomalous_crystal/A = new choosey(user.loc)
	A.activation_method = method
	to_chat(user, "<span class='userdanger'>[A] appears under your feet as the [src] breaks apart!</span>")
	qdel(src)

/obj/structure/closet/crate/necropolis/tendril/PopulateContents()
	var/loot = rand(1,35)
	new /obj/item/stock_parts/cell/high/plus/argent(src)
	switch(loot)
		if(1)
			new /obj/item/shared_storage/red(src)
			return list(/obj/item/shared_storage/red)
		if(2)
			new /obj/item/clothing/suit/space/hardsuit/cult(src)
			return list(/obj/item/clothing/suit/space/hardsuit/cult)
		if(3)
			new /obj/item/soulstone/anybody(src)
			return list(/obj/item/soulstone/anybody)
		if(4)
			new /obj/item/katana/cursed(src)
			return list(/obj/item/katana/cursed)
		if(5)
			new /obj/item/clothing/glasses/godeye(src)
			return list(/obj/item/clothing/glasses/godeye)
		if(6)
			new /obj/item/reagent_containers/glass/bottle/potion/flight(src)
			return list(/obj/item/reagent_containers/glass/bottle/potion/flight)
		if(7)
			new /obj/item/pickaxe/diamond(src)
			return list(/obj/item/pickaxe/diamond)
		if(8)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/resonator_blast(src)
				return list(/obj/item/disk/design_disk/modkit_disc/resonator_blast)
			else
				new /obj/item/disk/design_disk/modkit_disc/rapid_repeater(src)
				return list(/obj/item/disk/design_disk/modkit_disc/rapid_repeater)
		if(9)
			new /obj/item/rod_of_asclepius(src)
			return list(/obj/item/rod_of_asclepius)
		if(10)
			new /obj/item/organ/heart/cursed/wizard(src)
			return list(/obj/item/organ/heart/cursed/wizard)
		if(11)
			new /obj/item/ship_in_a_bottle(src)
			return list(/obj/item/ship_in_a_bottle)
		if(12)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker/damaged(src)
			return list(/obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker)
		if(13)
			new /obj/item/jacobs_ladder(src)
			return list(/obj/item/jacobs_ladder)
		if(14)
			new /obj/item/nullrod/scythe/talking(src)
			return list(/obj/item/nullrod/scythe/talking)
		if(15)
			new /obj/item/nullrod/armblade(src)
			return list(/obj/item/nullrod/armblade)
		if(16)
			new /obj/item/guardiancreator(src)
			return list(/obj/item/guardiancreator)
		if(17)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe(src)
				return list(/obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe)
			else
				new /obj/item/disk/design_disk/modkit_disc/bounty(src)
				return list(/obj/item/disk/design_disk/modkit_disc/bounty)
		if(18)
			new /obj/item/warp_cube/red(src)
			return list(/obj/item/warp_cube/red)
		if(19)
			new /obj/item/wisp_lantern(src)
			return list(/obj/item/wisp_lantern)
		if(20)
			new /obj/item/immortality_talisman(src)
			return list(/obj/item/immortality_talisman)
		if(21)
			new /obj/item/gun/magic/hook(src)
			return list(/obj/item/gun/magic/hook)
		if(22)
			new /obj/item/voodoo(src)
			return list(/obj/item/voodoo)
		if(23)
			new /obj/item/grenade/clusterbuster/inferno(src)
			return list(/obj/item/grenade/clusterbuster/inferno)
		if(24)
			new /obj/item/reagent_containers/food/drinks/bottle/holywater/hell(src)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor/damaged(src)
			return list(/obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor, /obj/item/reagent_containers/food/drinks/bottle/holywater/hell)
		if(25)
			new /obj/item/book/granter/spell/summonitem(src)
			return list(/obj/item/book/granter/spell/summonitem)
		if(26)
			new /obj/item/book_of_babel(src)
			return list(/obj/item/book_of_babel)
		if(27)
			new /obj/item/borg/upgrade/modkit/lifesteal(src)
			new /obj/item/bedsheet/cult(src)
			return list(/obj/item/borg/upgrade/modkit/lifesteal, /obj/item/bedsheet/cult)
		if(28)
			new /obj/item/clothing/neck/necklace/memento_mori(src)
			return list(/obj/item/clothing/neck/necklace/memento_mori)
		if(29)
			new /obj/item/gun/magic/staff/door(src)
			return list(/obj/item/gun/magic/staff/door)
		if(30)
			new /obj/item/katana/necropolis(src)
			return list(/obj/item/katana/necropolis)
		if(31)
			new /obj/item/gun/ballistic/rifle/boltaction(src)
			return list(/obj/item/gun/ballistic/rifle/boltaction)
		if(32)
			new /obj/item/gun/magic/staff/locker/trashy
			return list(/obj/item/gun/magic/staff/locker)
		if(33)
			new /obj/item/clothing/accessory/fireresist(src)
			return list(/obj/item/clothing/accessory/fireresist)
		if(34)
			new /obj/item/clothing/accessory/lavawalk(src)
			return list(/obj/item/clothing/accessory/lavawalk)
		if(35)
			new /obj/item/gun/energy/kinetic_accelerator/premiumka/ashenka(src)
			return list(/obj/item/gun/energy/kinetic_accelerator/premiumka/ashenka)

/obj/item/gun/magic/staff/locker/trashy
	max_charges = 1
	recharge_rate = 150 //should take a literal 5 minutes to recharge a single shot

/obj/item/clothing/accessory/fireresist
	name = "fire resistance medal"
	desc = "A golden medal. Capable of making any jumpsuit able to withstand fire."
	icon_state = "gold"
	var/stored_name = ""
	var/stored_desc = ""
	var/stored_resistance_flags = 0
	var/stored_heat_protection = 0
	var/stored_max_heat_protection_temperature = 0

/obj/item/clothing/accessory/fireresist/attach(obj/item/clothing/under/U, user)
	. = ..()
	stored_name = U.name
	stored_desc = U.desc
	stored_resistance_flags = U.resistance_flags
	stored_max_heat_protection_temperature = U.max_heat_protection_temperature
	stored_heat_protection = U.heat_protection
	U.name = "fireproofed " + U.name
	U.desc += " It has been fireproofed with [src]."
	U.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	U.heat_protection = FULL_BODY
	U.resistance_flags |= FIRE_PROOF

/obj/item/clothing/accessory/fireresist/detach(obj/item/clothing/under/U, user)
	. = ..()
	U.name = stored_name
	U.desc = stored_desc
	U.max_heat_protection_temperature = stored_max_heat_protection_temperature
	U.heat_protection = stored_heat_protection
	U.resistance_flags = stored_resistance_flags

/obj/item/clothing/accessory/lavawalk
	name = "lava walking medal"
	desc = "A golden medal. Capable of making any jumpsuit completely lava proof for a brief window of time."
	icon_state = "gold"
	actions_types = list(/datum/action/item_action/lavawalk)
	var/cool_down = 0
	var/cooldown_time = 1200 //two full minutes
	var/effectduration = 100 //10 seconds of lava walking
	var/storedimmunities = list()

/obj/item/clothing/accessory/lavawalk/on_uniform_equip(obj/item/clothing/under/U, user)
	. = ..()
	var/mob/living/L = U.loc
	if(L && istype(L))
		for(var/datum/action/A in actions_types)
			A.Grant(L)

/obj/item/clothing/accessory/lavawalk/on_uniform_dropped(obj/item/clothing/under/U, user)
	. = ..()
	var/mob/living/L = U.loc
	if(L && istype(L))
		for(var/datum/action/A in actions_types)
			A.Remove(L)

/datum/action/item_action/lavawalk
	name = "Lava Walk"
	desc = "Become immune to lava for a brief period of time."

/obj/item/clothing/accessory/lavawalk/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/lavawalk))
		if(world.time >= cool_down)
			var/mob/living/L = user
			if(istype(L))
				storedimmunities = L.weather_immunities.Copy()
				L.weather_immunities |= list("ash", "lava")
				cool_down = world.time + cooldown_time
				addtimer(CALLBACK(src, .proc/reset_user, L), effectduration)

/obj/item/clothing/accessory/lavawalk/proc/reset_user(mob/living/user)
	user.weather_immunities = storedimmunities
	storedimmunities = list()

//Nerfing those on the chest because too OP yada yada
/obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor/damaged
	name = "damaged inquisitor's hardsuit"
	desc = "It's not really in good shape, but still serves decent protection."
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/paranormal/inquisitor/damaged
	armor = list("melee" = 65, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 40)

/obj/item/clothing/head/helmet/space/hardsuit/ert/paranormal/inquisitor/damaged
	name = "damaged inquisitor's hardsuit helmet"
	armor = list("melee" = 65, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 40)

/obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker/damaged
	name = "damaged berserker's hardsuit"
	desc = "It's not really in good shape, but still serves decent protection."
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/paranormal/beserker/damaged
	clothing_flags = THICKMATERIAL // no space protection
	armor = list("melee" = 65, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 40)

/obj/item/clothing/head/helmet/space/hardsuit/ert/paranormal/beserker/damaged
	name = "damaged berserker's hardsuit helmet"
	armor = list("melee" = 65, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 40)

/obj/item/stock_parts/cell/high/plus/argent
	name = "Argent Energy Cell"
	desc = "Harvested from the necropolis, this autocharging energy cell can be crushed to provide a temporary 90% damage reduction bonus. Also useful for research."
	maxcharge = 50000 //only barely better than a normal power cell now
	chargerate = 5000 //good recharge time doe
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "argentcell"
	ratingdesc = FALSE
	rating = 6
	custom_materials = list(/datum/material/glass=500, /datum/material/uranium=250, /datum/material/plasma=1000, /datum/material/diamond=500)
	var/datum/status_effect/onuse = /datum/status_effect/blooddrunk/argent

/obj/item/stock_parts/cell/high/plus/argent/attack_self(mob/user)
	..()
	user.visible_message("<span class='danger'>[user] crushes the [src] in his hands, absorbing it's energy!</span>")
	playsound(user.loc, 'sound/effects/hit_on_shattered_glass.ogg', 100, TRUE)
	var/mob/living/M = user
	M.apply_status_effect(onuse)
	qdel(src)

/obj/item/stock_parts/cell/high/plus/argent/ComponentInitialize()
	. = ..()
	AddElement(/datum/component/empprotection, EMP_PROTECT_SELF)

/datum/status_effect/blooddrunk/argent
	id = "argent"
	duration = 100
	tick_interval = 0
	alert_type = /obj/screen/alert/status_effect/argent

/obj/screen/alert/status_effect/argent
	name = "Argent Energized"
	desc = "Argent energy rushes through your body! You'll only take 10% damage for the duration of the energy rush!"
	icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/screen_alert.dmi'
	icon_state = "argent"

/obj/item/katana/necropolis
	force = 25 //Wouldn't want a miner walking around with a 40 damage melee around now, would we?
	armour_penetration = 33
	block_chance = 0 //blocky bad

obj/item/immortality_talisman
	w_class = WEIGHT_CLASS_SMALL //why the fuck are they large anyways

//legion
/obj/structure/closet/crate/necropolis/tendril/legion_loot
	name = "screeching legion crate"

/obj/structure/closet/crate/necropolis/tendril/legion_loot/PopulateContents()
	var/obj/structure/closet/crate/necropolis/tendril/N = new /obj/structure/closet/crate/necropolis/tendril()
	var/list/weedeater = N.PopulateContents()
	for(var/loot in weedeater)
		new loot(src)
	qdel(N)

/obj/structure/closet/crate/necropolis/legion
	name = "echoing legion crate"

/obj/structure/closet/crate/necropolis/legion/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/crusher_trophy/golden_skull(src)
	new /obj/item/borg/upgrade/modkit/skull(src)

/obj/structure/closet/crate/necropolis/legion/hard
	name = "enraged echoing legion crate"

/obj/structure/closet/crate/necropolis/legion/hard/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/clothing/mask/gas/dagoth(src)
	new /obj/item/crusher_trophy/golden_skull(src)
	new /obj/item/borg/upgrade/modkit/skull(src)
	var/obj/structure/closet/crate/necropolis/tendril/T = new /obj/structure/closet/crate/necropolis/tendril //Yup, i know, VERY spaghetti code.
	var/obj/item/L
	for(var/i = 0, i < 3, i++)
		L = T.PopulateContents()
		for(var/loot in L)
			new loot(src)
	qdel(T)

//dagoth ur mask
/obj/item/clothing/mask/gas/dagoth
	name = "Golden Mask"
	desc = "Such a grand and intoxicating innocence."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/clothing/mask.dmi'
	icon_state = "dagoth"
	actions_types = list(/datum/action/item_action/ashstorm)
	flash_protect = 2
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10,"energy" = 10, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100, "wound" = 25) //HOW CAN YOU KILL A GOD?
	var/static/list/excluded_areas = list()
	var/storm_type = /datum/weather/ash_storm
	var/storm_cooldown = 0
	w_class = WEIGHT_CLASS_BULKY //its a fucking full metal mask man

/datum/action/item_action/ashstorm
	name = "Summon Ash Storm"
	desc = "Bring the wrath of the sixth house upon the area where you stand."

/obj/item/clothing/mask/gas/dagoth/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/ashstorm))
		if(storm_cooldown > world.time)
			to_chat(user, "<span class='warning'>The [src] is still recharging!</span>")
			return

		var/area/user_area = get_area(user)
		var/turf/user_turf = get_turf(user)
		if(!user_area || !user_turf || (user_area.type in excluded_areas))
			to_chat(user, "<span class='warning'>Something is preventing you from using the [src] here.</span>")
			return
		var/datum/weather/A
		for(var/V in SSweather.processing)
			var/datum/weather/W = V
			if((user_turf.z in W.impacted_z_levels) && W.area_type == user_area.type)
				A = W
				break

		if(A)
			if(A.stage != END_STAGE)
				if(A.stage == WIND_DOWN_STAGE)
					to_chat(user, "<span class='warning'>The storm is already ending! It would be a waste to use the [src] now.</span>")
					return
				user.visible_message("<span class='warning'>[user] gazes into the sky with [src], seemingly repelling the current storm!</span>", \
				"<span class='notice'>You gaze intently skyward, dispelling the storm!</span>")
				playsound(user, 'sound/magic/staff_change.ogg', 200, 0)
				A.wind_down()
				log_game("[user] ([key_name(user)]) has dispelled a storm at [AREACOORD(user_turf)]")
				return
		else
			A = new storm_type(list(user_turf.z))
			A.name = "staff storm"
			log_game("[user] ([key_name(user)]) has summoned [A] at [AREACOORD(user_turf)]")
			if (is_special_character(user))
				message_admins("[A] has been summoned in [ADMIN_VERBOSEJMP(user_turf)] by [user] ([key_name_admin(user)], a non-antagonist")
			A.area_type = user_area.type
			A.telegraph_duration = 100
			A.end_duration = 100

		user.visible_message("<span class='warning'>[user] gazes skyward with his [src], terrible red lightning strikes seem to accompany them!</span>", \
		"<span class='notice'>You gaze skyward with [src], calling down a terrible storm!</span>")
		playsound(user, 'sound/magic/staff_change.ogg', 200, 0)
		A.telegraph()
		storm_cooldown = world.time + 200
	else
		..()


/obj/item/melee/sword_of_the_forsaken
	name = "Sword of the Forsaken"
	desc = "A glowing giant heavy blade that grows and slightly shrinks in size depending on the wielder's strength."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/sif.dmi'
	icon_state = "sword_of_the_forsaken"
	inhand_icon_state = "sword_of_the_forsaken"
	lefthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 20 //slight buff because 15 just doesn't cut it for megafauna loot... hehe "cut it"
	throwforce = 10
	block_chance = 20 //again, slight buff
	armour_penetration = 200 //the armor penetration is really what makes this unique and actually worth it so boomp it
	hitsound = 'modular_skyrat/modules/skyrat_mining/sound/sif/sif_slash.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "teart", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slashe", "stab", "slice", "tear", "rip", "dice", "cut")
	sharpness = SHARP_POINTY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

//Enables the sword to butcher bodies
/obj/item/melee/sword_of_the_forsaken/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 50, 100, 10)

//Sword blocking attacks, really hard to block projectiles but still possible.
/obj/item/shield/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type != MELEE_ATTACK)
		final_block_chance = 10 //half as much what you get in melee
	return ..()


/obj/item/clothing/neck/necklace/necklace_of_the_forsaken
	name = "Necklace of the Forsaken"
	desc = "A rose gold necklace with a small static ember that burns inside of the black gem stone, making it warm to the touch."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/sif.dmi'
	icon_state = "necklace_forsaken_active"
	actions_types = list(/datum/action/item_action/hands_free/necklace_of_the_forsaken)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/mob/living/carbon/active_owner
	var/numUses = 1

/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/item_action_slot_check(slot)
	return (..() && (slot == ITEM_SLOT_NECK))

/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/dropped(mob/user)
	..()
	if(active_owner)
		remove_necklace()

//Apply a temp buff until the necklace is used
/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/proc/temp_buff(mob/living/carbon/human/user)
	to_chat(user, "<span class='warning'>You feel as if you have a second chance at something, but you're not sure what.</span>")
	if(do_after(user, 40, target = user))
		to_chat(user, "<span class='notice'>The ember warms you...</span>")
		ADD_TRAIT(user, TRAIT_NOHARDCRIT, "necklace_of_the_forsaken")//less chance of being gibbed
		active_owner = user

//Revive the user and remove buffs
/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/proc/second_chance()
	icon_state = "necklace_forsaken_active"
	if(!active_owner)
		return
	var/mob/living/carbon/C = active_owner
	active_owner = null
	to_chat(C, "<span class='userdanger'>You feel a scorching burn fill your body and limbs!</span>")
	C.revive(TRUE, FALSE)
	remove_necklace() //remove buffs

//Remove buffs
/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/proc/remove_necklace()
	icon_state = "necklace_forsaken_active"
	if(!active_owner)
		return
	REMOVE_TRAIT(active_owner, TRAIT_NOHARDCRIT, "necklace_of_the_forsaken")
	active_owner = null //just in case

//Add action
/datum/action/item_action/hands_free/necklace_of_the_forsaken
	check_flags = NONE
	name = "Necklace of the Forsaken"
	desc = "Bind the necklaces ember to yourself, so that next time you activate it, it will revive or fully heal you whether dead or knocked out. (Beware of being gibbed)"

//What happens when the user clicks on datum
/datum/action/item_action/hands_free/necklace_of_the_forsaken/Trigger()
	var/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/MM = target
	if(MM.numUses <= 0)//skip if it has already been used up
		return
	if(!MM.active_owner)//apply bind if there is no active owner
		if(iscarbon(owner))
			MM.temp_buff(owner)
		src.desc = "Revive or fully heal yourself, but you can only do this once! Can be used when knocked out or dead."
		to_chat(MM.active_owner, "<span class='userdanger'>You have binded the ember to yourself! The next time you use the necklace it will heal you!</span>")
	else if(MM.numUses >= 1 && MM.active_owner)//revive / heal then remove usage
		MM.second_chance()
		MM.numUses = 0
		MM.icon_state = "necklace_forsaken"
		MM.desc = "A rose gold necklace that used to have a bright burning ember inside of it."
		src.desc = "The necklaces ember has already been used..."

/obj/structure/closet/crate/necropolis/sif
	name = "Great Brown Wolf Sif's chest"

/obj/structure/closet/crate/necropolis/sif/PopulateContents()
	new /obj/item/melee/sword_of_the_forsaken(src)
	new /obj/item/clothing/neck/necklace/necklace_of_the_forsaken(src)
	new /obj/item/borg/upgrade/modkit/critical(src)

/obj/structure/closet/crate/necropolis/sif/crusher
	name = "Great Brown Wolf Sif's infinity chest"

/obj/structure/closet/crate/necropolis/sif/crusher/PopulateContents()
	new /obj/item/melee/sword_of_the_forsaken(src)
	new /obj/item/clothing/neck/necklace/necklace_of_the_forsaken(src)
	new /obj/item/crusher_trophy/dark_energy(src)

//Rogue process loot
/obj/structure/closet/crate/necropolis/rogue
	name = "Rogue's chest"

/obj/structure/closet/crate/necropolis/rogue/PopulateContents()
	new /obj/item/gun/energy/kinetic_accelerator/premiumka/bdminer(src)
	new /obj/item/rogue(src)

/obj/structure/closet/crate/necropolis/rogue/crusher
	name = "Corrupted Rogue's chest"

/obj/structure/closet/crate/necropolis/rogue/crusher/PopulateContents()
	new /obj/item/gun/energy/kinetic_accelerator/premiumka/bdminer(src)
	new /obj/item/crusher_trophy/brokentech(src)
	new /obj/item/rogue(src)

/obj/item/rogue
	name = "\proper Rogue's Drill"
	desc = "A drill coupled with an internal mechanism that produces shockwaves on demand. Serves as a very robust melee."
	sharpness = SHARP_POINTY
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/mining.dmi'
	icon_state = "roguedrill"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	inhand_icon_state = "jackhammer"
	w_class = WEIGHT_CLASS_BULKY
	tool_behaviour = TOOL_MINING
	toolspeed = 0.1
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/diamond=10000, /datum/material/titanium=20000, /datum/material/plasma=20000)
	usesound = 'sound/weapons/drill.ogg'
	hitsound = 'sound/weapons/drill.ogg'
	attack_verb_continuous = list("drills")
	attack_verb_simple = list("drill")
	var/cooldowntime = 50
	var/cooldown = 0
	var/range = 7

/obj/item/rogue/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=20)

/obj/item/rogue/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	if(user.a_intent == INTENT_HARM)
		var/datum/component/two_handed/TH = GetComponent(/datum/component/two_handed)
		if(TH.wielded && isliving(target) && proximity_flag && cooldown <= world.time)
			cooldown = world.time + (cooldowntime * 0.5)
			playsound(src,'modular_skyrat/modules/skyrat_mining/sound/crunch.ogg', 200, 1)
			var/mob/living/M = target
			M.Knockdown(40)
			M.adjustStaminaLoss(20)
		else if(TH.wielded)
			if(cooldown < world.time)
				cooldown = world.time + cooldowntime
				playsound(src,'modular_skyrat/modules/skyrat_mining/sound/crunch.ogg', 200, 1)
				var/list/hit_things = list()
				var/turf/T = get_turf(get_step(user, user.dir))
				var/ogdir = user.dir
				var/turf/otherT = get_step(T, turn(ogdir, 90))
				var/turf/otherT2 = get_step(T, turn(ogdir, -90))
				for(var/i in 1 to range)
					new /obj/effect/temp_visual/small_smoke/halfsecond(T)
					new /obj/effect/temp_visual/small_smoke/halfsecond(otherT)
					new /obj/effect/temp_visual/small_smoke/halfsecond(otherT2)
					for(var/mob/living/L in T.contents)
						if(L != src && !(L in hit_things))
							L.Stun(20)
							L.adjustBruteLoss(10)
							hit_things += L
					for(var/mob/living/L in otherT.contents)
						if(L != src && !(L in hit_things))
							L.Stun(20)
							L.adjustBruteLoss(10)
							hit_things += L
					for(var/mob/living/L in otherT2.contents)
						if(L != src && !(L in hit_things))
							L.Stun(20)
							L.adjustBruteLoss(10)
							hit_things += L
					if(ismineralturf(T))
						var/turf/closed/mineral/M = T
						M.gets_drilled(user)
					if(ismineralturf(otherT))
						var/turf/closed/mineral/M = otherT
						M.gets_drilled(user)
					if(ismineralturf(otherT2))
						var/turf/closed/mineral/M = otherT2
						M.gets_drilled(user)
					T = get_step(T, ogdir)
					otherT = get_step(otherT, ogdir)
					otherT2 = get_step(otherT2, ogdir)
					sleep(2)

//glaurung (needs unique loot and crusher trophy)
/obj/structure/closet/crate/necropolis/glaurung
	name = "drake chest"

/obj/structure/closet/crate/necropolis/glaurung/PopulateContents()
	new /obj/item/borg/upgrade/modkit/knockback(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/glaurung/crusher
	name = "wise drake chest"

/obj/structure/closet/crate/necropolis/glaurung/crusher/PopulateContents()
	new /obj/item/crusher_trophy/tail_spike(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/colossus/hard
	name = "enraged colossus chest"

/obj/structure/closet/crate/necropolis/colossus/hard/PopulateContents()
	var/list/choices = subtypesof(/obj/machinery/anomalous_crystal)
	var/random_crystal = pick(choices)
	new random_crystal(src)
	new /obj/item/fallen_wings(src)
	new /obj/item/organ/vocal_cords/colossus(src)

	new /obj/item/borg/upgrade/modkit/bolter(src)

/obj/structure/closet/crate/necropolis/colossus/hard/crusher
	name = "enraged angelic colossus chest"

/obj/structure/closet/crate/necropolis/colossus/hard/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/blaster_tubes(src)


/obj/item/fallen_wings
	name = "wings of the fallen angel"
	desc = "A pair of white, beautiful wings. They have been cut, but looks like they can provide decent protection."
	force = 0
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 0
	throw_speed = 0

	armor = list("melee" = 25, "bullet" = 25, "laser" = 15, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0)

	body_parts_covered = CHEST | GROIN | LEGS | ARMS

/obj/item/fallen_wings/equipped(var/mob/user, var/slot)
	. = ..()
	if(slot == ITEM_SLOT_BACK)
		ADD_TRAIT(src, TRAIT_NODROP, MEGAFAUNA_TRAIT)
		armor = initial(armor)
	else
		armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0)

/obj/item/fallen_wings/dropped(var/mob/user)
	. = ..()
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0)

/obj/item/fallen_wings/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	final_block_chance += rand(5, 20)
	return ..()

