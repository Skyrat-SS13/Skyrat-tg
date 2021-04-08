/obj/machinery/sleeper/clockwork
	name = "soothing sleeper"
	desc = "A large cryogenics unit built from brass. Its surface is pleasantly cool the touch."
	icon_state = "sleeper_clockwork"
	enter_message = "<span class='bold inathneq_small'>You hear the gentle hum and click of machinery, and are lulled into a sense of peace.</span>"
	possible_chems = list(
		list(/datum/reagent/medicine/epinephrine, /datum/reagent/medicine/morphine, /datum/reagent/medicine/c2/convermol, /datum/reagent/medicine/c2/libital, /datum/reagent/medicine/c2/aiuri),
		list(/datum/reagent/medicine/oculine,/datum/reagent/medicine/inacusiate),
		list(/datum/reagent/medicine/c2/multiver, /datum/reagent/medicine/mutadone, /datum/reagent/medicine/mannitol, /datum/reagent/medicine/salbutamol, /datum/reagent/medicine/pen_acid),
		list(/datum/reagent/medicine/omnizine)
	)

/turf/open/indestructible/reebe_void
	name = "void"
	icon_state = "reebemap"
	layer = SPACE_LAYER
	baseturfs = /turf/open/indestructible/reebe_void
	planetary_atmos = TRUE
	bullet_bounce_sound = null //forever falling
	tiled_dirt = FALSE
	flags_1 = NOJAUNT_1

/turf/open/indestructible/reebe_void/Initialize(mapload)
	. = ..()
	icon_state = "reebegame"

/turf/open/indestructible/reebe_void/spawning
	icon_state = "reebespawn"

/turf/open/indestructible/reebe_void/spawning/Initialize(mapload)
	. = ..()
	if(mapload)
		for(var/i in 1 to 3)
			if(prob(1))
				new /obj/item/clockwork/alloy_shards/large(src)
			if(prob(2))
				new /obj/item/clockwork/alloy_shards/medium(src)
			if(prob(3))
				new /obj/item/clockwork/alloy_shards/small(src)

/turf/open/indestructible/reebe_void/spawning/lattices
	icon_state = "reebelattice"

/turf/open/indestructible/reebe_void/spawning/lattices/Initialize(mapload)
	. = ..()
	if(mapload)
		if(prob(2.5))
			new /obj/structure/lattice/catwalk/clockwork(src)
		else if(prob(5))
			new /obj/structure/lattice/clockwork(src)

/turf/open/indestructible/reebe_void/Enter(atom/movable/AM, atom/old_loc)
	if(!..())
		return FALSE
	else
		if(istype(AM, /obj/structure/window))
			return FALSE
		if(istype(AM, /obj/projectile))
			return TRUE
		if((locate(/obj/structure/lattice) in src))
			return TRUE
		return FALSE

/obj/machinery/telecomms/relay/preset/reebe
	id = "Hierophant Relay"
	hide = 1
	autolinkers = list("h_relay")
	icon = 'icons/obj/clockwork_objects.dmi'
	icon_state = "relay"
	broadcasting = FALSE	//It only receives


/obj/item/clothing/under/chameleon/ratvar
	name = "ratvarian jumpsuit"
	desc = "A tough jumpsuit woven from alloy threads. It can take on the appearance of other jumpsuits."

/obj/item/wrench/brass
	name = "brass wrench"
	desc = "A brass wrench. It's faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "wrench_brass"
	toolspeed = 0.5

/obj/item/screwdriver/brass
	name = "brass screwdriver"
	desc = "A screwdriver made of brass. The handle feels freezing cold."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "screwdriver_brass"
	toolspeed = 0.5
	random_color = FALSE

/obj/item/weldingtool/experimental/brass
	name = "brass welding tool"
	desc = "A brass welder that seems to constantly refuel itself. It is faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "brasswelder"

/obj/item/crowbar/brass
	name = "brass crowbar"
	desc = "A brass crowbar. It feels faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "crowbar_brass"
	toolspeed = 0.5

/obj/item/wirecutters/brass
	name = "brass wirecutters"
	desc = "A pair of wirecutters made of brass. The handle feels freezing cold to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "cutters_brass"
	random_color = FALSE
	toolspeed = 0.5

/obj/item/storage/belt/utility/servant
	var/slab = null
	var/replicator = null

/obj/item/storage/belt/utility/servant/drone
	slab = /obj/item/clockwork/clockwork_slab
	replicator = /obj/item/clockwork/replica_fabricator

/obj/item/storage/belt/utility/servant/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 25
	STR.max_items = 7
	var/static/list/can_hold = typecacheof(list(
		/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/weldingtool,
		/obj/item/wirecutters,
		/obj/item/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/geiger_counter,
		/obj/item/extinguisher/mini,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/holosign_creator/atmos,
		/obj/item/holosign_creator/engineering,
		/obj/item/forcefield_projector,
		/obj/item/assembly/signaler,
		/obj/item/lightreplacer,
		/obj/item/construction/rcd,
		/obj/item/pipe_dispenser,
		/obj/item/inducer,
		/obj/item/plunger,
		/obj/item/clockwork/clockwork_slab,
		/obj/item/clockwork/replica_fabricator
		))
	STR.can_hold = can_hold

/obj/item/storage/belt/utility/servant/PopulateContents()
	if(slab)
		new slab(src)
	else
		new/obj/item/multitool(src)
	if(replicator)
		new replicator(src)

	new /obj/item/screwdriver/brass(src)
	new /obj/item/wirecutters/brass(src)
	new /obj/item/wrench/brass(src)
	new /obj/item/crowbar/brass(src)
	new /obj/item/weldingtool/experimental/brass(src)


/obj/structure/chair/brass
	name = "brass chair"
	desc = "A spinny chair made of brass. It looks uncomfortable."
	icon_state = "brass_chair"
	max_integrity = 150
	buildstacktype = /obj/item/stack/tile/brass
	buildstackamount = 1
	item_chair = null
	var/turns = 0

/obj/structure/chair/brass/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	. = ..()

/obj/structure/chair/brass/process()
	setDir(turn(dir,-90))
	playsound(src, 'sound/effects/servostep.ogg', 50, FALSE)
	turns++
	if(turns >= 8)
		STOP_PROCESSING(SSfastprocess, src)

/obj/structure/chair/brass/relaymove(mob/user, direction)
	if(!direction)
		return FALSE
	if(direction == dir)
		return
	setDir(direction)
	playsound(src, 'sound/effects/servostep.ogg', 50, FALSE)
	return FALSE

/obj/structure/chair/brass/AltClick(mob/living/user)
	turns = 0
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!(datum_flags & DF_ISPROCESSING))
		user.visible_message("<span class='notice'>[user] spins [src] around, and Ratvarian technology keeps it spinning FOREVER.</span>", \
		"<span class='notice'>Automated spinny chairs. The pinnacle of Ratvarian technology.</span>")
		START_PROCESSING(SSfastprocess, src)
	else
		user.visible_message("<span class='notice'>[user] stops [src]'s uncontrollable spinning.</span>", \
		"<span class='notice'>You grab [src] and stop its wild spinning.</span>")
		STOP_PROCESSING(SSfastprocess, src)

/obj/machinery/door/window/clockwork
	name = "brass windoor"
	desc = "A thin door with translucent brass paneling."
	icon_state = "clockwork"
	base_state = "clockwork"
	shards = 0
	rods = 0
	max_integrity = 50
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 70, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/made_glow = FALSE

/obj/machinery/door/window/clockwork/Initialize(mapload, set_dir)
	. = ..()
	for(var/i in 1 to 2)
		debris += new/obj/item/clockwork/alloy_shards/medium/gear_bit/large(src)

/obj/machinery/door/window/clockwork/setDir(direct)
	if(!made_glow)
		var/obj/effect/E = new /obj/effect/temp_visual/ratvar/door/window(get_turf(src))
		E.setDir(direct)
		made_glow = TRUE
	..()

/obj/machinery/door/window/clockwork/Destroy()
	return ..()

/obj/machinery/door/window/clockwork/emp_act(severity)
	if(prob(80/severity))
		open()

/obj/machinery/door/window/clockwork/hasPower()
	return TRUE //yup that's power all right

/obj/machinery/door/window/clockwork/allowed(mob/M)
	if(is_servant_of_ratvar(M))
		return TRUE
	return FALSE

/obj/machinery/door/window/clockwork/narsie_act()
	take_damage(rand(30, 60), BRUTE)
	if(src)
		var/previouscolor = color
		color = "#960000"
		animate(src, color = previouscolor, time = 8)
		addtimer(CALLBACK(src, /atom/proc/update_atom_colour), 8)

/obj/machinery/door/window/clockwork/attackby(obj/item/I, mob/living/user, params)

	if(operating)
		return

	add_fingerprint(user)
	if(!(flags_1&NODECONSTRUCT_1))
		if(I.tool_behaviour == TOOL_SCREWDRIVER)
			I.play_tool_sound(src)
			panel_open = !panel_open
			to_chat(user, "<span class='notice'>You [panel_open ? "open":"close"] the maintenance panel of the [name].</span>")
			return

		if(I.tool_behaviour == TOOL_CROWBAR)
			if(panel_open && !density && !operating)
				user.visible_message("[user] begins to deconstruct [name].", \
									 "<span class='notice'>You start to deconstruct from the [name]...</span>")
				if(I.use_tool(src, user, 40, volume=50))
					if(panel_open && !density && !operating && loc)
						qdel(src)
				return
	return ..()

/obj/structure/table_frame/brass
	name = "brass table frame"
	desc = "Four pieces of brass arranged in a square. It's slightly warm to the touch."
	icon_state = "brass_frame"
	icon = 'icons/obj/structures.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	framestack = /obj/item/stack/tile/brass
	framestackamount = 1

/obj/structure/table_frame/brass/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/tile/brass))
		var/obj/item/stack/tile/brass/W = I
		if(W.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one brass sheet to do this!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [W] to [src]...</span>")
		if(do_after(user, 20, target = src) && W.use(1))
			make_new_table(/obj/structure/table/brass)
	else
		return ..()

/obj/structure/table_frame/brass/narsie_act()
	..()
	if(src) //do we still exist?
		var/previouscolor = color
		color = "#960000"
		animate(src, color = previouscolor, time = 8)
		addtimer(CALLBACK(src, /atom/proc/update_atom_colour), 8)

/obj/structure/table/brass
	name = "brass table"
	desc = "A solid, slightly beveled brass table."
	icon = 'modular_skyrat/modules/clockworkcult/icons/obj/brass_table.dmi'
	icon_state = "brass_table"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	frame = /obj/structure/table_frame/brass
	framestack = /obj/item/stack/tile/brass
	buildstack = /obj/item/stack/tile/brass
	framestackamount = 1
	buildstackamount = 1
	canSmoothWith = list(/obj/structure/table/brass, /obj/structure/table/bronze)

/obj/structure/table/brass/tablepush(mob/living/user, mob/living/pushed_mob)
	. = ..()
	playsound(src, 'sound/magic/clockwork/fellowship_armory.ogg', 50, TRUE)

/obj/structure/table/brass/narsie_act()
	take_damage(rand(15, 45), BRUTE)
	if(src) //do we still exist?
		var/previouscolor = color
		color = "#960000"
		animate(src, color = previouscolor, time = 8)
		addtimer(CALLBACK(src, /atom/proc/update_atom_colour), 8)
