#define MAX_BERSERK_CHARGE 200
#define BERSERK_HALF_CHARGE 100
#define PROJECTILE_HIT_MULTIPLIER 1.5
#define DAMAGE_TO_CHARGE_SCALE 1
#define CHARGE_DRAINED_PER_SECOND 3
#define BERSERK_MELEE_ARMOR_ADDED 50
#define BERSERK_ATTACK_SPEED_MODIFIER 0.25

/obj/item/crusher_trophy/gladiator
	name = "ashen bones"
	desc = "A set of soot-coated ribs from a worthy warrior. Suitable as a trophy for a kinetic crusher."
	icon_state = "demon_claws"
	color = "#808080"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/gladiator
	bonus_value = 15

/obj/item/crusher_trophy/gladiator/effect_desc()
	return "the crusher to have a <b>[bonus_value]%</b> chance to block incoming attacks."

/obj/item/crusher_trophy/gladiator/add_to(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		incomingchance.block_chance += bonus_value

/obj/item/crusher_trophy/gladiator/remove_from(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		incomingchance.block_chance -= bonus_value

/obj/item/clothing/neck/warrior_cape
	name = "\proper cloak of the marked one"
	desc = "A cloak worn by those that have faced death in the eyes and prevailed."
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	icon_state = "berk_cape"
	inhand_icon_state = "" //lul
	uses_advanced_reskins = FALSE
	resistance_flags = INDESTRUCTIBLE

/obj/item/clothing/neck/warrior_cape/examine()
	. = ..()
	. += span_warning("Struggle against the tide, no matter how strong it may be.")

/obj/item/clothing/suit/hooded/berserker/gatsu
	name = "\proper berserker armor"
	desc = "A suit of ancient body armor imbued with potent spiritual magnetism, capable of massively boosting a wearer's close combat skills at the cost of ravaging their mind and overexerting their body."
	icon_state = "berk_suit"
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	hoodtype = /obj/item/clothing/head/hooded/berserker/gatsu
	armor = list(MELEE = 45, BULLET = 40, LASER = 30, ENERGY = 30, BOMB = 80, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = INDESTRUCTIBLE

/obj/item/clothing/suit/hooded/berserker/gatsu/examine()
	. = ..()
	. += span_warning("Berserk mode requires the suit's helmet to be equipped, and can only be charged by taking damage.")

/obj/item/clothing/head/hooded/berserker/gatsu
	name = "\proper berserker helmet"
	desc = "A uniquely styled helmet with ghastly red eyes that seals it's user inside."
	icon_state = "berk_helm"
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	armor = list(MELEE = 40, BULLET = 40, LASER = 20, ENERGY = 25, BOMB = 70, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = INDESTRUCTIBLE
	actions_types = list(/datum/action/item_action/berserk_mode)
	var/overcharged = FALSE //used to see if the armor's charge exceeds 100%

/obj/item/clothing/head/hooded/berserker/gatsu/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, LOCKED_HELMET_TRAIT)
	
/obj/item/clothing/head/hooded/berserker/gatsu/examine()
	. = ..()
	. += span_warning("Berserk mode is usable at 100% charge but can gain up to 200% charge for extended duration.")

/obj/item/clothing/head/hooded/berserker/gatsu/process(delta_time)
	if(berserk_active)
		berserk_charge = clamp(berserk_charge - CHARGE_DRAINED_PER_SECOND * delta_time, 0, MAX_BERSERK_CHARGE)
	if(!berserk_charge)
		if(ishuman(loc))
			end_berserk(loc)
			overcharged = FALSE

/obj/item/clothing/head/hooded/berserker/gatsu/dropped(mob/user)
	. = ..()
	end_berserk(user)
	overcharged = FALSE

/obj/item/clothing/head/hooded/berserker/gatsu/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(berserk_active)
		return
	var/berserk_value = damage * DAMAGE_TO_CHARGE_SCALE
	if(attack_type == PROJECTILE_ATTACK)
		berserk_value *= PROJECTILE_HIT_MULTIPLIER
	berserk_charge = clamp(round(berserk_charge + berserk_value), 0, MAX_BERSERK_CHARGE)
	if(berserk_charge >= BERSERK_HALF_CHARGE & overcharged == FALSE)
		balloon_alert(owner, "berserk charged")
		overcharged = TRUE
	if(berserk_charge >= MAX_BERSERK_CHARGE)
		balloon_alert(owner, "berserk overcharged")

/obj/item/clothing/head/hooded/berserker/gatsu/IsReflect()
	if(berserk_active)
		return TRUE

/obj/item/claymore/dragonslayer
	name = "\proper Dragonslayer"
	desc = "A blade that seems too big to be called a sword. Too big, too thick, too heavy, and too rough, it's more like a large hunk of raw iron."
	icon = 'modular_skyrat/modules/gladiator/icons/dragonslayer.dmi'
	icon_state = "dragonslayer"
	inhand_icon_state = "dragonslayer"
	lefthand_file = 'modular_skyrat/modules/gladiator/icons/dragonslayer_inhand_R.dmi'
	righthand_file = 'modular_skyrat/modules/gladiator/icons/dragonslayer_inhand_L.dmi' //confusing, right? hahahaha im not fixing those fucken dmis
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = null
	force = 20
	wound_bonus = 10
	bare_wound_bonus = 5
	resistance_flags = INDESTRUCTIBLE
	armour_penetration = 50 //this boss is really hard and this sword is really big
	block_chance = 30
	sharpness = SHARP_EDGED
	// aughhghghgh this really should be elementized but this works for now
	var/faction_bonus_force = 100
	var/static/list/nemesis_factions = list("mining", "boss")
	/// how much stamina does it cost to roll
	var/roll_stamcost = 15
	/// how far do we roll?
	var/roll_range = 3

/obj/item/claymore/dragonslayer/examine()
	. = ..()
	. += span_warning("Tempered against lavaland foes and bosses through supernatural energies. Right click to dodge at the cost of stamina.")

/obj/item/claymore/dragonslayer/add_blood_DNA(list/blood_dna) //110% stain-proof! or so they tell me
	return FALSE

/obj/item/claymore/dragonslayer/attack(mob/living/target, mob/living/carbon/human/user)
	var/is_nemesis_faction = FALSE
	for(var/found_faction in target.faction)
		if(found_faction in nemesis_factions)
			is_nemesis_faction = TRUE
			force += faction_bonus_force
			break
	. = ..()
	if(is_nemesis_faction)
		force -= faction_bonus_force

/obj/item/claymore/dragonslayer/afterattack_secondary(atom/target, mob/living/user, params) // dark souls
	if(user.IsImmobilized()) // no free dodgerolls
		return
	var/turf/where_to = get_turf(target)
	user.apply_damage(damage = roll_stamcost, damagetype = STAMINA)
	user.Immobilize(0.8 SECONDS) // you dont get to adjust your roll
	user.throw_at(where_to, range = roll_range, speed = 1, force = MOVE_FORCE_NORMAL)
	user.apply_status_effect(/datum/status_effect/dodgeroll_iframes)
	playsound(user, SFX_BODYFALL, 50, TRUE)
	playsound(user, SFX_RUSTLE, 50, TRUE)
	return ..()

/datum/status_effect/dodgeroll_iframes
	id = "dodgeroll_dodging"
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH
	duration = 0.8 SECONDS // worth tweaking?

/datum/status_effect/dodgeroll_iframes/on_apply()
	RegisterSignal(owner, COMSIG_HUMAN_CHECK_SHIELDS, .proc/whiff)
	return TRUE

/datum/status_effect/dodgeroll_iframes/on_remove()
	UnregisterSignal(owner, COMSIG_HUMAN_CHECK_SHIELDS)
	return ..()

/datum/status_effect/dodgeroll_iframes/proc/whiff()
	SIGNAL_HANDLER
	owner.balloon_alert_to_viewers("MISS!")
	playsound(src, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
	return SHIELD_BLOCK

/obj/item/claymore/dragonslayer/very_fucking_loud
	name = "\proper Tempered Dragonslayer"
	desc = null
	hitsound = 'modular_skyrat/modules/gladiator/Clang_cut.ogg'

/obj/item/claymore/dragonslayer/very_fucking_loud/examine()
	. = ..()
	. += span_userdanger("CLANG")

/obj/structure/closet/crate/necropolis/gladiator
	name = "gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/crusher
	name = "dreadful gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/PopulateContents()
	if(prob(5))
		new /obj/item/claymore/dragonslayer/very_fucking_loud(src)
	else
		new /obj/item/claymore/dragonslayer(src)
	new /obj/item/clothing/suit/hooded/berserker/gatsu(src)
	new /obj/item/clothing/neck/warrior_cape(src)

/obj/structure/closet/crate/necropolis/gladiator/crusher/PopulateContents()
	if(prob(5))
		new /obj/item/claymore/dragonslayer/very_fucking_loud(src)
	else
		new /obj/item/claymore/dragonslayer(src)
	new /obj/item/clothing/suit/hooded/berserker/gatsu(src)
	new /obj/item/clothing/neck/warrior_cape(src)
	new /obj/item/crusher_trophy/gladiator(src)

#undef MAX_BERSERK_CHARGE
#undef BERSERK_HALF_CHARGE
#undef PROJECTILE_HIT_MULTIPLIER
#undef DAMAGE_TO_CHARGE_SCALE
#undef CHARGE_DRAINED_PER_SECOND
#undef BERSERK_MELEE_ARMOR_ADDED
#undef BERSERK_ATTACK_SPEED_MODIFIER
