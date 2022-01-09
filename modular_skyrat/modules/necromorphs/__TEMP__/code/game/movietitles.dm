#define CREDIT_ROLL_SPEED 185
#define CREDIT_SPAWN_SPEED 20
#define CREDIT_ANIMATE_HEIGHT (14 * world.icon_size)
#define CREDIT_EASE_DURATION 22

GLOBAL_LIST(end_titles)

client
	var/list/credits

/client/proc/RollCredits()
	set waitfor = FALSE

	if(get_preference_value(/datum/client_preference/show_credits) != GLOB.PREF_YES)
		return

	if(!GLOB.end_titles)
		GLOB.end_titles = generate_titles()

	LAZYINITLIST(credits)

	if(mob)
		mob.overlay_fullscreen("fishbed",/atom/movable/screen/fullscreen/fishbed)
		mob.overlay_fullscreen("fadeout",/atom/movable/screen/fullscreen/fadeout)

	sleep(50)
	var/list/_credits = credits
	add_verb(src, /client/proc/ClearCredits)
	for(var/I in GLOB.end_titles)
		if(!credits)
			return
		var/atom/movable/screen/credit/T = new(null, I, src)
		_credits += T
		T.rollem()
		sleep(CREDIT_SPAWN_SPEED)
	sleep(CREDIT_ROLL_SPEED - CREDIT_SPAWN_SPEED)

	ClearCredits()
	remove_verb(src, /client/proc/ClearCredits)

/client/proc/ClearCredits()
	set name = "Stop End Titles"
	set category = "OOC"
	remove_verb(src, /client/proc/ClearCredits)
	QDEL_NULL_LIST(credits)
	mob.clear_fullscreen("fishbed")
	mob.clear_fullscreen("fadeout")
	SEND_SOUND(mob, sound(null, channel = GLOB.lobby_sound_channel))

/atom/movable/screen/credit
	icon_state = "blank"
	mouse_opacity = 0
	alpha = 0
	screen_loc = "1,1"
	plane = HUD_PLANE
	layer = HUD_ABOVE_ITEM_LAYER
	var/client/parent
	var/matrix/target

/atom/movable/screen/credit/Initialize(mapload, credited, client/P)
	. = ..()
	parent = P
	maptext = credited
	maptext_height = world.icon_size * 2
	maptext_width = world.icon_size * 14

/atom/movable/screen/credit/proc/rollem()
	var/matrix/M = matrix(transform)
	M.Translate(0, CREDIT_ANIMATE_HEIGHT)
	animate(src, transform = M, time = CREDIT_ROLL_SPEED)
	target = M
	animate(src, alpha = 255, time = CREDIT_EASE_DURATION, flags = ANIMATION_PARALLEL)
	spawn(CREDIT_ROLL_SPEED - CREDIT_EASE_DURATION)
		if(!QDELETED(src))
			animate(src, alpha = 0, transform = target, time = CREDIT_EASE_DURATION)
			sleep(CREDIT_EASE_DURATION)
			qdel(src)
	parent.screen += src

/atom/movable/screen/credit/Destroy()
	var/client/P = parent
	if(parent)
		P.screen -= src
	LAZYREMOVE(P.credits, src)
	parent = null
	return ..()

/proc/generate_titles()
	var/list/titles = list()
	var/list/cast = list()
	var/list/chunk = list()
	var/list/possible_titles = list()
	var/chunksize = 0

	/* Establish a big-ass list of potential titles for the "episode". */
	possible_titles += "THE [pick("DOWNFALL OF", "RISE OF", "TROUBLE WITH", "FINAL STAND OF", "DARK SIDE OF")] [pick("THE MEDICAL BAY", "INCOMPETENCE", "RANDOM ARRESTS", "MURDER", "COMMAND", "CARGO VS SECURITY", "[uppertext(GLOB.using_map.station_name)]")]"
	possible_titles += "THE CREW GETS [pick("SLASHERED", "PUKED ON", "AN INCURABLE DISEASE", "CORPSED", "A VALUABLE HISTORY LESSON", "A BREAK", "HIGH", "TO LIVE", "TO RELIVE THEIR NIGHTMARES", "EMBROILED IN WAR ON THE NECRO'S", "SERIOUS ABOUT [pick("DRUG ABUSE", "CRIME", "PRODUCTIVITY", "ANCIENT AMERICAN CARTOONS", "SPACEBALL")]")]"
	possible_titles += "THE CREW LEARNS ABOUT [pick("IMPALEMENT", "NARCOTICS", "THE DANGERS OF HUGGING THE MARKER", "THE IMPORTANCE OF LIGHTS", "HARMBATONING", "SACRIFICES TO THE MARKER", "HUFFING PAINT", "CHUGGING TEN BOTTLES OF NYQUIL", "PROPER AIM", "MANAGING CARGO PROPERLY", "[pick("HUMAN", "NECROMORPH")] MATING RITUALS", "ANATOMY", "ANCIENT CHINESE MEDICINE")]"
	possible_titles += "A VERY [pick("CEC", "EDF", "EARTHGOV", "CONVERGENT")] CHRISTMAS"
	possible_titles += "[pick("GUNS, GUNS EVERYWHERE", "FIREAXES", "WHAT HAPPENS WHEN YOU MIX NECROMORPHS AND COMMERCIAL-GRADE PACKING FOAM", "ATTACK! ATTACK! ATTACK!", "SEX BOMB")]"
	possible_titles += "[pick("SPACE", "SEXY", "DRAGON", "WARLOCK", "LAUNDRY", "GUN", "ADVERTISING", "DOG", "CARBON MONOXIDE", "NINJA", "WIZARD", "SOCRATIC", "JUVENILE DELIQUENCY", "POLITICALLY MOTIVATED", "RADTACULAR SICKNASTY")] [pick("QUEST", "FORCE", "ADVENTURE")]"
	possible_titles += "[pick("THE DAY [uppertext(GLOB.using_map.station_short)] STOOD STILL", "HUNT FOR THE GREEN WEENIE", "NECRO VS VENDOMAT", "SPACE TRACK")]"
	titles += "<center><h1>EPISODE [rand(1,1000)]<br>[pick(possible_titles)]<h1></h1></h1></center>"
	for(var/mob/living/carbon/human/H in GLOB.living_mob_list|GLOB.dead_mob_list)
		if(findtext(H.real_name,"(mannequin)"))
			continue
		if(H.isMonkey() && findtext(H.real_name,"[lowertext(H.species.name)]")) //no monki
			continue
		if(H.timeofdeath && H.timeofdeath < 5 MINUTES) //don't mention these losers (prespawned corpses mostly)
			continue
		if(!cast.len && !chunksize)
			chunk += "CAST:"
		var/job = ""
		if(GetAssignment(H) != "Unassigned")
			job = ", [uppertext(GetAssignment(H))]"
		var/used_name = H.real_name
		var/datum/computer_file/report/crew_record/R = get_crewmember_record(H.real_name)
		if(R && R.get_rank())
			var/datum/mil_rank/rank = mil_branches.get_rank(R.get_branch(), R.get_rank())
			if(rank.name_short)
				used_name = "[rank.name_short] [used_name]"
		if(prob(90))
			var/actor_name = H.species.get_random_name(H.gender)
			if(!(H.species.spawn_flags & SPECIES_CAN_JOIN) || prob(10)) //sometimes can't get actor of thos species
				var/datum/species/S = all_species["Human"]
				actor_name = S.get_random_name(H.gender)
			chunk += "[actor_name]\t \t \t \t[uppertext(used_name)][job]"
		else
			var/datum/gender/G = gender_datums[H.gender]
			chunk += "[used_name]\t \t \t \t[uppertext(G.him)]SELF"
		chunksize++
		if(chunksize > 2)
			cast += "<center>[jointext(chunk,"<br>")]</center>"
			chunk.Cut()
			chunksize = 0
	if(chunk.len)
		cast += "<center>[jointext(chunk,"<br>")]</center>"

	titles += cast

	var/list/corpses = list()
	var/list/monkies = list()
	for(var/mob/living/carbon/human/H in GLOB.dead_mob_list)
		if(H.timeofdeath < 5 MINUTES) //no prespawned corpses
			continue
		if(H.isMonkey() && findtext(H.real_name,"[lowertext(H.species.name)]"))
			monkies[H.species.name] += 1
		else if(H.real_name)
			corpses += H.real_name
	for(var/spec in monkies)
		var/datum/species/S = all_species[spec]
		corpses += "[monkies[spec]] [lowertext(monkies[spec] > 1 ? S.name_plural : S.name)]"
	if(corpses.len)
		titles += "<center>BASED ON REAL EVENTS<br>In memory of [english_list(corpses)].</center>"

	var/list/staff = list("PRODUCTION STAFF:")
	var/list/staffjobs = list("Coffe Fetcher", "Cameraman", "Angry Yeller", "Chair Operator", "Choreographer", "Historical Consultant", "Costume Designer", "Chief Editor", "Executive Assistant")
	var/list/goodboys = list()
	for(var/client/C)
		if(!C.holder)
			continue
		if(C.holder.rights & (R_DEBUG|R_ADMIN))
			var/datum/species/S = all_species[pick(all_species)]
			var/g = prob(50) ? MALE : FEMALE
			staff += "[uppertext(pick(staffjobs))] - [S.get_random_name(g)] a.k.a. '[C.key]'"
		else if(C.holder.rights & R_MOD)
			goodboys += "[C.key]"

	titles += "<center>[jointext(staff,"<br>")]</center>"
	if(goodboys.len)
		titles += "<center>STAFF'S GOOD BOYS:<br>[english_list(goodboys)]</center>"

	var/disclaimer = "Sponsored by [GLOB.using_map.company_name].<br>All rights reserved.<br>"
	disclaimer += pick("Use for parody prohibited. Prohibited.", "All stunts were performed by underpaid interns. Do NOT try at home.", "[GLOB.using_map.company_name] does not endorse behaviour depicted. Attempt at your own risk.")
	titles += "<center>[disclaimer]</center>"

	return titles
