/*
	The snare node is a necromorph trap. It will attempt to trip a human who walks over it. This is not luck based though.
	If successful, the human is knocked down for a significant period, and all the necromorphs are alerted to the location.
	Snares are single use and delete themselves on a successful trip

	Snare is avoidable, quite easily. If a player interacts with it in any manner to indicate that they've noticed it, they become immune
	to that particular snare for several minutes.

	It's main design goal is to act as a chilling effect. To force crew players to slow down and pay attention to their environment
*/
#define SNARE_PLACEMENT_BUFFER	3
/obj/structure/corruption_node/snare
	name = "snare"
	desc = "<span class='notice'>That looks dangerous, good thing you noticed before tripping over it! Should be safe to step over it now</span>"
	icon_state = "snare"
	max_health = 50

	//Stores ref = time of players who interact with this
	var/aware = list()

	//Players who notice it are immune for this long
	var/awareness_timeout = 3 MINUTES

	default_alpha = 250
	alpha = 250

	//The snare's alpha gradually decreases over time, as it gets harder and harder to spot
	var/minimum_alpha = 150
	var/fade_chance = 10	//Roughly once every 10 seconds it drops a point
	random_rotation = TRUE
	randpixel = 4

/obj/structure/corruption_node/snare/get_blurb()
	. = "Places a trap on the floor which attempts to trip crewmembers who walk over it.<br>\
	If successful, the victim is knocked down for a few seconds and takes some damage, while an alert is sent notifying necromorphs and signals that the trap caught someone. Snares are single use, and will vanish after successfully tripping someone<br>\<br>\
	Although snare can be placed near live crew, it must be placed at least [SNARE_PLACEMENT_BUFFER] tiles away<br><br>\
	The snare can only trip people as long as they don't notice it. If a human clicks on it or examines it, that specific snare becomes unable to trip them for the next few minutes, allowing them to harmlessly walk over it.<br>\
	<br>\
	Snares should be placed somewhere that people are likely to walk over them without noticing. However, if a snare is left alone for a long time, it gradually fades out and becomes harder to see. Eventually becoming nearly invisible.<br>\
	While snares can have some utility, their real benefit is a chilling effect.<br>\
	The potential threat of invisible snares around every corner can be used to wage psychological warfare, and curb crew aggression into corrupted areas"

/obj/structure/corruption_node/snare/update_icon()
	alpha = default_alpha
	.=..()

/obj/structure/corruption_node/snare/Process()
	if (prob(fade_chance) && default_alpha > minimum_alpha)
		default_alpha -= 1
		update_icon()

	.=..()

/obj/structure/corruption_node/snare/Destroy()
	for (var/reference in aware)
		var/mob/M = locate(reference)
		if (M)
			unregister_awareness(M)

	.=..()

/obj/structure/corruption_node/snare/can_stop_processing()
	if (alpha > minimum_alpha)
		return FALSE

	return ..()


/obj/structure/corruption_node/snare/Crossed(var/atom/movable/AM)
	if (ishuman(AM) && !AM.is_necromorph())
		attempt_trip(AM)


/obj/structure/corruption_node/snare/proc/attempt_trip(var/mob/living/carbon/human/H)

	if (LAZYLEN(H.grabbed_by) || LAZYLEN(H.pulledby) || H.lying)
		return FALSE	//Dont trip people who are crawling or being dragged

	var/reference = "\ref[H]"
	var/last_time = aware[reference]
	if (isnum(last_time) && world.time - last_time < awareness_timeout)
		H.visible_message("[H] carefully steps over \the [src]")
		return FALSE



	//Success!
	trip(H)

/obj/structure/corruption_node/snare/proc/trip(var/mob/living/carbon/human/H)
	H.visible_message(SPAN_DANGER("[H] trips over \the [src]"))
	H.take_overall_damage(20)
	playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
	H.Weaken(5)
	H.Stun(2)
	link_necromorphs_to(SPAN_NOTICE("[H] tripped over snare at LINK"), src)
	shake_camera(H, 30, 2)
	qdel(src)




/*
	Interaction
*/
/obj/structure/corruption_node/snare/Click(var/location, var/control, var/params)
	register_awareness(usr)
	.=..()

//Trying to remove snares with your hands is a bad idea, they will latch on and pull you in or steal the tool you used
/obj/structure/corruption_node/snare/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (prob(25))
		if (yank_item(user, W))
			return

	if (prob(25))
		if (pull_in(user))
			return
	.=..()

/obj/structure/corruption_node/snare/attack_hand(mob/user as mob)
	if (prob(50))
		if (pull_in(user))
			return
	.=..()

//Someone tried to cut or pull out the snare, it doesn't like that and it's going to teach them a lesson
/obj/structure/corruption_node/snare/proc/pull_in(var/mob/user)
	//They need to be within reach
	if (get_dist(src, user) > 1)
		return

	//Don't hurt allies
	if (user.is_necromorph())
		return

	//Alright we're clear
	//First of all we strip awareness, this caught them by surprise
	unregister_awareness(user)

	//If they're not standing on our tile, we pull them onto us
	if (get_turf(user) != get_turf(src))
		user.visible_message(SPAN_DANGER("The [src] pulls [user] in!"),SPAN_DANGER("The [src] pulls you in!"))
		user.forceMove(get_turf(src))
	//Else just trigger crossed as is
	else
		user.visible_message(SPAN_DANGER("The [src] pulls [user] down!"),SPAN_DANGER("The [src] pulls you down!"))
		Crossed(user)

	return TRUE

//Someone tried to attack the snare with an item. Yoink!
/obj/structure/corruption_node/snare/proc/yank_item(var/mob/user, var/obj/item/I)
	//They need to be within reach
	if (get_dist(src, user) > 1)
		return

	//Don't hurt allies
	if (user.is_necromorph())
		return

	//First, remove the item from their hand
	user.unEquip(I)
	//Check that succeeded
	if (I.loc != user)
		src.visible_message(SPAN_DANGER("The [src] pulls [I] out of [user]'s hands!"),SPAN_DANGER("The [src] pulls [I] out of your hands!"))
		var/push_direction = Vector2.DirectionBetween(user, src)	//Get direction to throw it
		I.apply_impulse(push_direction, 30) //Woosh!
		shake_camera(user, 20, 2)
	return TRUE


//Record that this user indicated awareness of us at this time. They wont trip over this snare for a few minutes
/obj/structure/corruption_node/snare/proc/register_awareness(var/mob/user)


	//We dont register necros, they cant be tripped anyway
	if (user.is_necromorph())
		return

	var/reference = "\ref[user]"
	aware[reference] = world.time

	if (user.client)
		var/obj/screen/movable/tracker/tracker = null
		for (var/obj/screen/movable/tracker/snare_highlight/T in user.client.screen)
			if (T.tracked == src)
				tracker = T
				tracker.set_lifetime(awareness_timeout)
				break

		if (!tracker)
			tracker = new /obj/screen/movable/tracker/snare_highlight(user, src, awareness_timeout)


/obj/structure/corruption_node/snare/proc/unregister_awareness(var/mob/user)
	var/reference = "\ref[user]"
	aware -= reference

	if (user.client)
		for (var/obj/screen/movable/tracker/snare_highlight/T in user.client.screen)
			if (T.tracked == src)
				qdel(T)












//Snare highlight, used to show where a seen snare is
/obj/screen/movable/tracker/snare_highlight
	alpha = 255

/obj/screen/movable/tracker/snare_highlight/setup()
	appearance = new /mutable_appearance(tracked)
	alpha = 255
	mouse_opacity = 0
	var/newfilter = filter(type="outline", size=1, color=COLOR_NECRO_YELLOW)
	filters.Add(newfilter)









/*
	Signal Ability
*/
/datum/signal_ability/placement/corruption/snare
	name = "Snare"
	id = "snare"
	desc = ""
	energy_cost = 50
	LOS_block = FALSE
	placement_atom = /obj/structure/corruption_node/snare
	click_handler_type = /datum/click_handler/placement/ability/snare



/*
	Mostly copypaste of above clickhandler
*/
/datum/click_handler/placement/ability/snare
	rotate_angle = 0

//Check we have a surface to place it on
/datum/click_handler/placement/ability/snare/placement_blocked(var/turf/candidate)
	for (var/mob/living/carbon/human/H in orange(SNARE_PLACEMENT_BUFFER, candidate))
		if (!H.is_necromorph() && !H.stat)
			return "Cannot be placed within [SNARE_PLACEMENT_BUFFER] tiles of a conscious crewmember."

	.=..()

