/obj/projectile/bullet/reusable/arrow
	var/faction_bonus_force = 0 //Bonus force dealt against certain factions
	var/list/nemesis_factions //Any mob with a faction that exists in this list will take bonus damage/effects

/obj/projectile/bullet/reusable/arrow/on_hit(mob/living/target, mob/living/carbon/human/user)
    var/nemesis_faction = faction_check(target.faction, nemesis_factions)
    . = ..()
    if(nemesis_faction)
        playsound(target.loc,'sound/weapons/blade1.ogg', rand(30,50), TRUE)
        damage += faction_bonus_force

/obj/projectile/bullet/reusable/arrow/proc/nemesis_effects(mob/living/user, mob/living/target)
	return

/obj/projectile/bullet/reusable/arrow/wood
	name = "Wooden arrow"
	desc = "Woosh!"
	damage = 30
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow/wood

/obj/projectile/bullet/reusable/arrow/ash
	name = "Ashen arrow"
	desc = "An arrow made of hardened ash."
	faction_bonus_force = 50
	damage = 30//lower me to 20 or 15
	nemesis_factions = list("mining", "boss")
	ammo_type = /obj/item/ammo_casing/caseless/arrow/ash

/obj/projectile/bullet/reusable/arrow/bone 
	name = "Bone arrow"
	desc = "An arrow made from bone and sinew."
	faction_bonus_force = 50
	damage = 30
	armour_penetration = 40
	nemesis_factions = list("mining", "boss")
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bone

/obj/projectile/bullet/reusable/arrow/bronze
	name = "Bronze arrow"
	desc = "A bronze-tipped arrow."
	faction_bonus_force = 90
	damage = 30
	armour_penetration = 10
	nemesis_factions = list("boss")
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bronze
