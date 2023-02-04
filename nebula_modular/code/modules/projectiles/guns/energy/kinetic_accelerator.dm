//BDM pka
/obj/item/gun/energy/kinetic_accelerator/bdminer
	name = "bloody accelerator"
	desc = "A modded premium kinetic accelerator with an increased mod capacity as well as lesser cooldown."
	icon = 'nebula_modular/icons/obj/guns/energy.dmi'
	icon_state = "bdpka"
	overheat_time = 14.5
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/bdminer)
	max_mod_capacity = 125

/obj/item/gun/energy/kinetic_accelerator/bdminer/attackby(obj/item/I, mob/user) //Intelligent solutions didn't work, i had to shitcode.
	if(istype(I, /obj/item/borg/upgrade/modkit))
		var/obj/item/borg/upgrade/modkit/MK = I
		switch(MK.type)
			if(/obj/item/borg/upgrade/modkit/chassis_mod)
				to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [src]!</span>")
				return FALSE
			if(/obj/item/borg/upgrade/modkit/chassis_mod/orange)
				to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [src]!</span>")
				return FALSE
			if(/obj/item/borg/upgrade/modkit/tracer)
				to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [src]!</span>")
				return FALSE
			if(/obj/item/borg/upgrade/modkit/tracer/adjustable)
				to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [src]!</span>")
				return FALSE
		MK.install(src, user)
	else
		..()

/obj/item/borg/upgrade/modkit/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/gun/energy/kinetic_accelerator))
		if(istype(A, /obj/item/gun/energy/kinetic_accelerator/bdminer)) //Read above.
			var/obj/item/borg/upgrade/modkit/MK = src
			switch(MK.type)
				if(/obj/item/borg/upgrade/modkit/chassis_mod)
					to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [A]!</span>")
					return FALSE
				if(/obj/item/borg/upgrade/modkit/chassis_mod/orange)
					to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [A]!</span>")
					return FALSE
				if(/obj/item/borg/upgrade/modkit/tracer)
					to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [A]!</span>")
					return FALSE
				if(/obj/item/borg/upgrade/modkit/tracer/adjustable)
					to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [A]!</span>")
					return FALSE
		install(A, user)
	else
		..()

/obj/item/ammo_casing/energy/kinetic/bdminer
	projectile_type = /obj/projectile/kinetic/bdminer

/obj/projectile/kinetic/bdminer
	name = "bloody kinetic force"
	icon_state = "ka_tracer"
	color = "#FF0000"
	damage = 50
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	log_override = TRUE

//blood drunk miner's "new" modkit ;)
/obj/item/borg/upgrade/modkit/lifesteal/miner
	name = "resonant lifesteal crystal"
	desc = "Causes kinetic accelerator shots to heal the firer on striking a living target."
	modifier = 4
	cost = 30
	denied_type = /obj/item/borg/upgrade/modkit/lifesteal/miner
	maximum_of_type = 2
