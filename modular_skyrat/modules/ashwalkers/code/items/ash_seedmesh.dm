/obj/item/seed_mesh
	name = "seed mesh"
	desc = "A little mesh that, when paired with sand, has the possibility of filtering out large seeds."
	icon = 'modular_skyrat/modules/ashwalkers/icons/misc_tools.dmi'
	icon_state = "mesh"
	var/list/static/seeds_blacklist = list(
		/obj/item/seeds/lavaland,
	)

/obj/item/seed_mesh/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/ore/glass))
		var/obj/item/stack/stack_item = attacking_item

		while(stack_item.amount >= 5)
			if(!do_after(user, 5 SECONDS, src))
				user.balloon_alert(user, "have to stand still!")
				return

			if(!stack_item.use(5))
				user.balloon_alert(user, "unable to use five of [stack_item]!")
				return

			if(prob(70))
				user.balloon_alert(user, "[stack_item] reveals nothing!")
				continue

			var/spawn_seed = pick(subtypesof(/obj/item/seeds) - seeds_blacklist)
			new spawn_seed(get_turf(src))
			user.balloon_alert(user, "[stack_item] revealed something!")

	return ..()
