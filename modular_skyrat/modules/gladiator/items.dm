/obj/item/crusher_trophy/gladiator
	name = "ashen bones"
	desc = "A set of soot-coated ribs from a worthy warrior. Suitable as a trophy for a kinetic crusher."
	icon_state = "demon_claws"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/gladiator
	bonus_value = 10

/obj/item/crusher_trophy/gladiator/effect_desc()
	return "the crusher to have a <b>[bonus_value]%</b> chance to block any incoming attack."

/obj/item/crusher_trophy/gladiator/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.block_chance += bonus_value

/obj/item/crusher_trophy/gladiator/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.block_chance -= bonus_value

/obj/item/gun/magic/staff/spellblade/agateram
	name = "ancient blade agateram"
	desc = "A millenia-old blade from a material that you can't even begin to fathom. It flows with the power of the Marked One who once held it."
	fire_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/spellblade
	icon_state = "agateram"
	inhand_icon_state = "agateram"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	hitsound = 'sound/weapons/rapierhit.ogg'
	force = 25
  var/faction_bonus_force = 50
  var/static/list/nemesis_factions = list("mining", "boss")
	armour_penetration = 20
	block_chance = 50
	sharpness = SHARP_EDGED
	max_charges = 3

/obj/item/gun/magic/staff/spellblade/agateram/attack(mob/living/target, mob/living/carbon/human/user)
	var/is_nemesis_faction = FALSE
	for(var/found_faction in target.faction)
		if(found_faction in nemesis_factions)
			is_nemesis_faction = TRUE
			force += faction_bonus_force
			break
	. = ..()
	if(is_nemesis_faction)
		force -= faction_bonus_force

/obj/structure/closet/crate/necropolis/gladiator
	name = "gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/crusher
	name = "dreadful gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/PopulateContents()
	new /obj/item/gun/magic/staff/spellblade/agateram(src)

/obj/structure/closet/crate/necropolis/gladiator/crusher/PopulateContents()
	new /obj/item/gun/magic/staff/spellblade/agateram(src)
	new /obj/item/crusher_trophy/gladiator(src)
