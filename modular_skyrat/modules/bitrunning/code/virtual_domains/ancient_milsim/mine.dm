/obj/effect/mine/explosive/light/ancient_milsim
	arm_delay = 1.5 SECONDS
	light_range = 1.6
	light_power = 2
	light_color = COLOR_VIVID_RED

/obj/effect/mine/explosive/light/ancient_milsim/now_armed()
	. = ..()
	set_light_on(TRUE)

/obj/item/minespawner/ancient_milsim
	name = "deactivated low-yield landmine"
	desc = "When activated, will deploy a low-yield explosive landmine after 1.5 second passes, perfect for setting traps in tight corridors."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "landmine-inactive"

	mine_type = /obj/effect/mine/explosive/light/ancient_milsim
