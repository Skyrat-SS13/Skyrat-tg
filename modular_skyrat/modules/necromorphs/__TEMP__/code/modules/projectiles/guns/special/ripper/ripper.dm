
/obj/item/weapon/gun/projectile/ripper
	name = "RC-DS Remote Control Disc Ripper"
	desc = "Suspends a spinning sawblade in the air with a mini gravity tether."
	w_class = ITEM_SIZE_HUGE
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	icon_state = "ripper"
	item_state = "ripper"
	max_shells = 8
	caliber = "saw"
	handle_casings = CLEAR_CASINGS
	fire_delay = 10
	fire_sound = 'sound/weapons/tablehit1.ogg'
	load_sound = 'sound/weapons/guns/interaction/shotgun_instert.ogg'

	firemodes = list(
		list(mode_name="remote control", mode_type = /datum/firemode/remote/ripper),
		list(mode_name="saw launcher",       burst=1, fire_delay=10,    move_delay=null, one_hand_penalty=0, burst_accuracy=null, dispersion=null, projectile_type = /obj/item/projectile/sawblade)
		)


	//Holds a reference to the currently projected sawblade we have out, if any.
	var/obj/item/projectile/remote/sawblade/blade = null





	has_safety = TRUE	//This thing is too dangerous to lack safety

/obj/item/weapon/gun/projectile/ripper/update_icon()
	overlays.Cut()
	var/ammonum = get_remaining_ammo()
	if(ammonum > max_shells)
		ammonum = max_shells
	var/progress = ammonum
	var/goal = max_shells
	progress = CLAMP(progress, 0, goal)
	progress = round(((progress / goal) * 100), 25)//Round it down to 25s.
	var/state = "ripper_[progress]"
	overlays += image(icon,state)

/obj/item/weapon/gun/projectile/ripper/loaded
	ammo_type = /obj/item/ammo_casing/sawblade

/obj/item/weapon/gun/projectile/ripper/loaded/diamond
	ammo_type = /obj/item/ammo_casing/sawblade/diamond



//Set the health of the projectile to the health of the ammo version. This ensures that picked up and reused blades dont get a free repair
/obj/item/weapon/gun/projectile/ripper/consume_next_projectile()
	.=..()
	if (.)
		var/obj/item/projectile/P = .
		var/obj/item/ammo_casing/sawblade/ammo = chambered
		if (istype(ammo))
			P.health = ammo.health



/datum/firemode/remote/ripper

	tether_type = /obj/effect/projectile/tether/gravity
	max_range	=	112	//3.5 tiles
