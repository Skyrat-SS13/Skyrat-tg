/obj/item/gun/energy/sizegun
	name = "sizegun"
	icon = 'modular_skyrat/modules/sizeplay/icons/obj/sizegun.dmi'
	lefthand_file = 'modular_skyrat/modules/sizeplay/icons/mob/sizegun_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/sizeplay/icons/mob/sizegun_righthand.dmi'
	icon_state = "sizegun"
	charge_sections = 4
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/sizeray)

	var/size_setting = 50

/obj/item/gun/energy/sizegun/attack_self(mob/living/user as mob)
	var/setting_min = CONFIG_GET(number/body_size_sizegun_min)*100
	var/setting_max = CONFIG_GET(number/body_size_sizegun_max)*100
	var/sizeinput = input(user, "Input desired size ([setting_min]%-[setting_max]%). Current setting: [size_setting]%", "Size ray power") as null|num

	if(isnull(sizeinput))
		return

	size_setting = clamp(sizeinput,setting_min,setting_max)
	update_icon()

/obj/item/gun/energy/sizegun/update_icon_state()
	var/ratio = get_charge_ratio()
	var/temp_icon_to_use = initial(icon_state)

	temp_icon_to_use += (size_setting>100) ? "-grow" : "-shrink"
	icon_state = temp_icon_to_use
	temp_icon_to_use += "[ratio]"
	inhand_icon_state = temp_icon_to_use
	worn_icon_state = temp_icon_to_use


/obj/item/ammo_casing/energy/sizeray
	projectile_type = /obj/projectile/beam/sizeray
	select_name = "beam"
	e_cost = 100 //10 shots with the default 1000 cap cell
	fire_sound = 'sound/weapons/pulse2.ogg'

/obj/projectile/beam/sizeray
	icon_state = ""
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/tracer/beam_rifle
	damage = 0
	damage_type = STAMINA
	hitsound = 'sound/weapons/ZapBang.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	flag = LASER
	eyeblur = 0

	impact_effect_type = /obj/effect/temp_visual/impact_effect/shrink
	hitscan_light_intensity = 1
	hitscan_light_range = 1
	hitscan_light_color_override = COLOR_GREEN_GRAY
	ricochets_max = 5
	reflectable = REFLECT_NORMAL

/obj/projectile/beam/sizeray/on_hit(atom/target)
	if(!isliving(target))
		return
	if(is_type_in_typecache(target, GLOB.mob_type_sizeplay_blacklist))
		return
	if(QDELETED(fired_from))
		return

	var/mob/living/L = target

	//let's prepare for the inevitable possibility that someone puts this in a turret and fired_from will point to said turret
	var/resize_to = CONFIG_GET(number/body_size_sizegun_min)
	if(istype(fired_from, /obj/item/gun/energy/sizegun))
		var/obj/item/gun/energy/sizegun/SG = fired_from
		resize_to = SG.size_setting/100

	L.set_size(resize_to)
