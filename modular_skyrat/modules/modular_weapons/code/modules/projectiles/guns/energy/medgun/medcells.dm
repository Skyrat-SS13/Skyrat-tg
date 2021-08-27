//Medigun Cells/
/obj/item/stock_parts/cell/medigun/ //This is the cell that mediguns from cargo will come with//
	name = "Basic Medigun Cell"
	maxcharge = 1200
	chargerate = 40

/obj/item/stock_parts/cell/medigun/upgraded
	name = "Upgraded Medigun Cell"
	maxcharge = 1500
	chargerate = 80

/obj/item/stock_parts/cell/medigun/experimental //This cell type is meant to be used in self charging mediguns like CMO and ERT one.//
	name = "Experiemental Medigun Cell"
	maxcharge = 1800
	chargerate = 100
//End of cells

/obj/item/ammo_casing/energy/medical
	projectile_type = /obj/projectile/energy/medical/default
	select_name = "oxygen"
	fire_sound = 'sound/effects/stealthoff.ogg'
	e_cost = 120
	delay = 8
	harmful = FALSE

/obj/projectile/energy/medical
	name = "medical heal shot"
	icon_state = "blue_laser"
	damage = 0

/obj/projectile/energy/medical/upgraded
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE

/obj/item/ammo_casing/energy/medical/default
	name = "oxygen heal shot"

/obj/projectile/energy/medical/default/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	target.adjustOxyLoss(-10)

//T1 Healing Projectiles//
//The Basic Brute Heal Projectile//
/obj/item/ammo_casing/energy/medical/brute1
	projectile_type = /obj/projectile/energy/medical/brute1
	select_name = "brute"

/obj/projectile/energy/medical/brute1
	name = "brute heal shot"
	icon_state = "red_laser"

/obj/projectile/energy/medical/brute1/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	//DISGUST 
	if(target.getBruteLoss() > 49)
		target.adjust_disgust(1.5) 
	if(target.getBruteLoss() > 99)
		target.adjust_disgust(1.5)
	target.adjust_disgust(3)
	//CLONE
	if(target.getBruteLoss() > 49 && target.getBruteLoss() < 100 )
		target.adjustCloneLoss(2.45)
	if(target.getBruteLoss() > 99)
		target.adjustCloneLoss(4.9)
	target.adjustBruteLoss(-7.5)
//The Basic Burn Heal//
/obj/item/ammo_casing/energy/medical/burn1
	projectile_type = /obj/projectile/energy/medical/burn1
	select_name = "burn"

/obj/projectile/energy/medical/burn1
	name = "burn heal shot"
	icon_state = "yellow_laser"

/obj/projectile/energy/medical/burn1/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	//DISGUST 
	if(target.getFireLoss() > 49)
		target.adjust_disgust(1.5) 
	if(target.getFireLoss() > 99)
		target.adjust_disgust(1.5)
	target.adjust_disgust(3)
	//CLONE
	if(target.getFireLoss() > 49 && target.getFireLoss() < 100 )
		target.adjustCloneLoss(2.45)
	if(target.getFireLoss() > 99)
		target.adjustCloneLoss(4.9)
	target.adjustFireLoss(-7.5)

//Basic Toxin Heal//
/obj/item/ammo_casing/energy/medical/toxin1
	projectile_type = /obj/projectile/energy/medical/toxin1
	select_name = "toxin"

/obj/projectile/energy/medical/toxin1
	name = "toxin heal shot"
	icon_state = "green_laser"

/obj/projectile/energy/medical/toxin1/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	target.adjustToxLoss(-5)
	target.radiation = max(target.radiation - 40, 0)//Toxin is treatable, but inefficent//
//T2 Healing Projectiles//
//Tier II Brute Projectile//
/obj/item/ammo_casing/energy/medical/brute2
	projectile_type = /obj/projectile/energy/medical/upgraded/brute2
	select_name = "brute II"

/obj/projectile/energy/medical/upgraded/brute2
	name = "strong brute heal shot"
	icon_state = "red_laser"


/obj/projectile/energy/medical/upgraded/brute2/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	//DISGUST 
	if(target.getBruteLoss() > 49)
		target.adjust_disgust(1.5) 
	if(target.getBruteLoss() > 99)
		target.adjust_disgust(1.5)
	target.adjust_disgust(2)
	//CLONE
	if(target.getBruteLoss() > 49 && target.getBruteLoss() < 100 )
		target.adjustCloneLoss(1.9)
	if(target.getBruteLoss() > 99)
		target.adjustCloneLoss(3.8)
	target.adjustBruteLoss(-11.25)
//Tier II Burn Projectile//
/obj/item/ammo_casing/energy/medical/burn2
	projectile_type = /obj/projectile/energy/medical/upgraded/burn2
	select_name = "burn II"

/obj/projectile/energy/medical/upgraded/burn2
	name = "strong burn heal shot"
	icon_state = "yellow_laser"

/obj/projectile/energy/medical/upgraded/burn2/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	//DISGUST 
	if(target.getFireLoss() > 49)
		target.adjust_disgust(1.5) 
	if(target.getFireLoss() > 99)
		target.adjust_disgust(1.5)
	target.adjust_disgust(2)
	//CLONE
	if(target.getFireLoss() > 49 && target.getFireLoss() < 100 )
		target.adjustCloneLoss(1.9)
	if(target.getFireLoss() > 99)
		target.adjustCloneLoss(3.8)
	target.adjustFireLoss(-11.25)
//Tier II Oxy Projectile//
/obj/item/ammo_casing/energy/medical/oxy2
	projectile_type = /obj/projectile/energy/medical/upgraded/oxy2
	select_name = "oxygen II"

/obj/projectile/energy/medical/upgraded/oxy2
	name = "strong oxygen heal shot"

/obj/projectile/energy/medical/upgraded/oxy2/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	target.adjustOxyLoss(-20)
//Tier II Toxin Projectile//
/obj/item/ammo_casing/energy/medical/toxin2
	projectile_type = /obj/projectile/energy/medical/upgraded/toxin2
	select_name = "toxin II"

/obj/projectile/energy/medical/upgraded/toxin2
	name = "strong toxin heal shot"
	icon_state = "green_laser"

/obj/projectile/energy/medical/upgraded/toxin2/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	target.adjustToxLoss(-7.5)
	target.radiation = max(target.radiation - 60, 0)
//T3 Healing Projectiles//
//Tier III Brute Projectile//
/obj/item/ammo_casing/energy/medical/brute3
	projectile_type = /obj/projectile/energy/medical/upgraded/brute3
	select_name = "brute III"

/obj/projectile/energy/medical/upgraded/brute3
	name = "powerful brute heal shot"
	icon_state = "red_laser"

/obj/projectile/energy/medical/upgraded/brute3/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	//DISGUST 
	if(target.getBruteLoss() > 49)
		target.adjust_disgust(1.5) 
	if(target.getBruteLoss() > 99)
		target.adjust_disgust(1.5)
	target.adjust_disgust(1)
	//CLONE
	if(target.getBruteLoss() > 49 && target.getBruteLoss() < 100 )
		target.adjustCloneLoss(1.125)
	if(target.getBruteLoss() > 99)
		target.adjustCloneLoss(2.25)
	target.adjustBruteLoss(-15)
//Tier III Burn Projectile//
/obj/item/ammo_casing/energy/medical/burn3
	projectile_type = /obj/projectile/energy/medical/upgraded/burn3
	select_name = "burn III"

/obj/projectile/energy/medical/upgraded/burn3
	name = "powerful burn heal shot"
	icon_state = "yellow_laser"

/obj/projectile/energy/medical/upgraded/burn3/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	//DISGUST 
	if(target.getFireLoss() > 49)
		target.adjust_disgust(1.5) 
	if(target.getFireLoss() > 99)
		target.adjust_disgust(1.5)
	target.adjust_disgust(1)
	//CLONE
	if(target.getFireLoss() > 49 && target.getFireLoss() < 100 )
		target.adjustCloneLoss(1.125)
	if(target.getFireLoss() > 99)
		target.adjustCloneLoss(2.25)
	target.adjustFireLoss(-15)
//Tier III Oxy Projectile//
/obj/item/ammo_casing/energy/medical/oxy3
	projectile_type = /obj/projectile/energy/medical/upgraded/oxy3
	select_name = "oxygen III"

/obj/projectile/energy/medical/upgraded/oxy3
	name = "powerful oxygen heal shot"

/obj/projectile/energy/medical/upgraded/oxy3/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	target.adjustOxyLoss(-30)
//Tier III Toxin Projectile//
/obj/item/ammo_casing/energy/medical/toxin3
	projectile_type = /obj/projectile/energy/medical/upgraded/toxin3
	select_name = "toxin III"

/obj/projectile/energy/medical/upgraded/toxin3
	name = "powerful toxin heal shot"
	icon_state = "green_laser"

/obj/projectile/energy/medical/upgraded/toxin3/on_hit(mob/living/target)
	. = ..()
	if(!istype(target, /mob/living/carbon/human))
		return
	if(target.stat == DEAD)
		return
	target.adjustToxLoss(-5)
	target.radiation = max(target.radiation - 80, 0)

//End of Basic Tiers of cells.//
