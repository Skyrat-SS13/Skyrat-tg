//TECHARMOR
/obj/item/clothing/head/helmet/space/hardsuit/security_armor //No, this isn't spaceproof. Yes, the sprite reflects that this is not spaceproof properly. I made it a hardsuit subtype to make things easier and more readable.
	name = "type I techhelmet"
	desc = "A specialized exoskeleton armor helmet built into a suit of armor; offers decent protection, and comes with a flash-resistant HUD visor and headlamp."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	flash_protect = FLASH_PROTECTION_FLASH //The visor protects from flashes, but you're still going to go blind if you try to weld something.
	icon_state = "hardsuit-secexo"
	icon_state = "hardsuit0-secexo"
	inhand_icon_state = "hardsuit0-secexo"
	hardsuit_type = "secexo"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 0, "fire" = 50, "acid" = 75, "wound" = 10)
	clothing_flags = THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEHAIR
	mutant_variants = STYLE_MUZZLE

/obj/item/clothing/suit/space/hardsuit/security_armor
	name = "type I full-body techarmor"
	desc = "A specialized exoskeleton armor suit, comprised of flexible protective shielding. Comes equipped with a retractable helmet which offers a flash-resistant HUD visor, along with a headlamp."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit-secexo"
	inhand_icon_state = "hardsuit-secexo"
	max_integrity = 250
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 0, "fire" = 50, "acid" = 75, "wound" = 10)
	allowed = list(/obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/flashlight, /obj/item/gun/ballistic, /obj/item/gun/energy, /obj/item/kitchen/knife/combat, /obj/item/melee/baton, /obj/item/melee/classic_baton/telescopic, /obj/item/reagent_containers/spray/pepper, /obj/item/restraints/handcuffs, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman) //I had to do this all snowflake style because it just would not accept any sort of global list, fucking kill me
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security_armor
	clothing_flags = THICKMATERIAL
	mutant_variants = STYLE_DIGITIGRADE
	slowdown = 0
	flags_inv = NONE
/*Let me just put a big fucking note right here because I know somebody is going to complain about this:
No, this does not let you stack the helmet-given flash resistance and Nightvision or Thermal glasses with no consequence.
Sure, you can do it 100%, but it will invalidate the helmet-given flash protection and render you vulnerable
just as if you were wearing them separate. Stop screaming to me about this. Please.*/

/obj/item/clothing/suit/space/hardsuit/security_armor/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed

/obj/item/clothing/head/helmet/space/hardsuit/security_armor/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
		DHUD.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/security_armor/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
		DHUD.remove_hud_from(user)

/obj/item/clothing/head/helmet/space/hardsuit/security_armor/hos
	name = "head of security's techhelmet"
	desc = "A specialized exoskeleton armor helmet built into a suit of armor; offers decent protection, and comes with a flash-resistant HUD visor and headlamp."
	icon_state = "hardsuit0-hosexo"
	inhand_icon_state = "hardsuit0-hosexo"
	hardsuit_type = "hosexo"
	mutant_variants = STYLE_MUZZLE
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR

/obj/item/clothing/suit/space/hardsuit/security_armor/hos
	name = "head of security's techarmor"
	desc = "A specialized exoskeleton armor suit comprised of flexible protective shielding. This particular suit has been designed specifically for the station security commander."
	icon_state = "hardsuit-hosexo"
	inhand_icon_state = "hardsuit-hosexo"
	max_integrity = 300
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 0, "fire" = 70, "acid" = 90, "wound" = 10)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security_armor/hos
	mutant_variants = STYLE_DIGITIGRADE
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
