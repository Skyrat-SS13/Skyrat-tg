#define CREDIT_ROLL_SPEED 185
#define CREDIT_SPAWN_SPEED 20
#define CREDIT_ANIMATE_HEIGHT (14 * world.icon_size)
#define CREDIT_EASE_DURATION 22
GLOBAL_VAR_INIT(end_credits_song, null)
GLOBAL_VAR_INIT(end_credits_title, null)
GLOBAL_LIST(end_titles)
#define JOINTEXT(X) jointext(X, null)
/datum/controller/subsystem/ticker/declare_completion()
	for(var/client/C)
		if(!C.credits)
			C.RollCredits()
	for(var/thing in GLOB.clients)
		var/client/C = thing
		if (!C)
			continue

/datum/controller/subsystem/ticker/show_roundend_report(client/C, report_type = null)
	. = ..()
	for(var/iteration in GLOB.clients)
		var/client/clients = iteration
		if(!clients.credits)
			clients.RollCredits()
/* /client
	var/list/credits */


/client/proc/RollCredits()
	set waitfor = FALSE


	if(!GLOB.end_titles)
		GLOB.end_titles = generate_titles()

	LAZYINITLIST(credits)

/* 	if(mob)
		mob.overlay_fullscreen("meeting",/atom/movable/screen/fullscreen/emergency_meeting) */
//	sound_to_playing_players('modular_skyrat/master_files/sound/music/elibao.ogg', volume = 100, vary = FALSE, frequency = 0, channel = 0, pressure_affected = FALSE)

	var/list/_credits = credits
	verbs += /client/proc/ClearCredits
	for(var/I in GLOB.end_titles)
		if(!credits)
			return
		var/atom/movable/screen/credit/T = new(null, I, src)
		_credits += T
		T.rollem()
		sleep(CREDIT_SPAWN_SPEED)
	sleep(CREDIT_ROLL_SPEED - CREDIT_SPAWN_SPEED)

	ClearCredits()
	verbs -= /client/proc/ClearCredits

/client/proc/ClearCredits()
	set name = "Stop End Titles"
	set category = "OOC"
	verbs -= /client/proc/ClearCredits
	QDEL_NULL(credits)
//	mob.clear_fullscreen("meeting")

/atom/movable/screen/credit
	icon_state = "blank"
	mouse_opacity = 0
	alpha = 0
	screen_loc = "CENTER-7,CENTER-7"
	plane = HUD_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	var/client/parent
	var/matrix/target

/atom/movable/screen/credit/Initialize(mapload, credited, client/P)
	. = ..()
	parent = P
	maptext = {"<div style="font:'Small Fonts'">[credited]</div>"}
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
	LAZYREMOVE(P?.credits, src)
	parent = null
	return . = ..()

/proc/generate_titles()
	var/list/titles = list()
	var/list/cast = list()
	var/list/chunk = list()
	var/list/possible_titles = list()
	var/chunksize = 0
	if(!GLOB.end_credits_title)
		/* Establish a big-ass list of potential titles for the "episode". */
		possible_titles += "THE [pick("DOWNFALL OF", "RISE OF", "TROUBLE WITH", "FINAL STAND OF", "DARK SIDE OF", "DESOLATION OF", "DESTRUCTION OF", "CRISIS OF")]\
							 [pick("SPACEMEN", "HUMANITY", "DIGNITY", "SANITY", "THE CHIMPANZEES", "THE VENDOMAT PRICES", "GIANT ARMORED", "THE GAS JANITOR",\
							"THE SUPERMATTER CRYSTAL", "MEDICAL", "ENGINEERING", "SECURITY", "RESEARCH", "THE SERVICE DEPARTMENT", "COMMAND", "THE EXPLORERS", "THE PATHFINDER",\
							"SKYRAT STATION")]"
		possible_titles += "THE CREW GETS [pick("TINGLED", "PICKLED", "AN INCURABLE DISEASE", "PIZZA", "A VALUABLE HISTORY LESSON", "A BREAK", "HIGH", "TO LIVE", "TO RELIVE THEIR CHILDHOOD", "EMBROILED IN CIVIL WAR", "A BAD HANGOVER", "SERIOUS ABOUT [pick("DRUG ABUSE", "CRIME", "PRODUCTIVITY", "ANCIENT AMERICAN CARTOONS", "SPACEBALL", "DECOMPRESSION PROCEDURES")]")]"
		possible_titles += "THE CREW LEARNS ABOUT [pick("LOVE", "DRUGS", "THE DANGERS OF MONEY LAUNDERING", "XENIC SENSITIVITY", "INVESTMENT FRAUD", "KELOTANE ABUSE", "RADIATION PROTECTION", "SACRED GEOMETRY", "STRING THEORY", "ABSTRACT MATHEMATICS", "[pick("UNATHI", "SKRELLIAN", "DIONAN", "KHAARMANI", "VOX", "SERPENTID")] MATING RITUALS", "ANCIENT CHINESE MEDICINE")]"
		possible_titles += "A VERY [pick("CORPORATE", "NANOTRASEN", "FLEET", "HAPHAESTUS", "DAIS", "XENOLIFE", "EXPEDITIONARY", "DIONA", "PHORON", "MARTIAN", "SERPENTID")] [pick("CHRISTMAS", "EASTER", "HOLIDAY", "WEEKEND", "THURSDAY", "VACATION")]"
		possible_titles += "[pick("GUNS, GUNS EVERYWHERE", "THE LITTLEST ARMALIS", "WHAT HAPPENS WHEN YOU MIX MAINTENANCE DRONES AND COMMERCIAL-GRADE PACKING FOAM", "ATTACK! ATTACK! ATTACK!", "SEX BOMB", "THE LEGEND OF THE ALIEN ARTIFACT: PART [pick("I","II","III","IV","V","VI","VII","VIII","IX", "X", "C","M","L")]")]"
		possible_titles += "[pick("SPACE", "SEXY", "DRAGON", "WARLOCK", "LAUNDRY", "GUN", "ADVERTISING", "DOG", "CARBON MONOXIDE", "NINJA", "WIZARD", "SOCRATIC", "JUVENILE DELIQUENCY", "POLITICALLY MOTIVATED", "RADTACULAR SICKNASTY")] [pick("QUEST", "FORCE", "ADVENTURE")]"
		possible_titles += "[pick("THE DAY [pick("NANOTRASEN", "THE SYNDICATE", "ARMADYNE CORPORATION")] STOOD STILL", "HUNT FOR THE GREEN WEENIE", "ALIEN VS VENDOMAT", "SPACE TRACK")]"
		titles += "<center><h1>EPISODE [rand(1,1000)]<br>[pick(possible_titles)]<h1></h1></h1></center>"
	else
		titles += "<center><h1>EPISODE [rand(1,1000)]<br>[GLOB.end_credits_title]<h1></h1></h1></center>"

	for(var/datum/mind/mind in get_crewmember_minds())
		if(!cast.len && !chunksize)
			chunk += "CAST:"
		var/datum/job/job = mind?.assigned_role
		var/used_name = mind?.current.name
		var/antag_string
		for(var/datum/antagonist/antagonist as anything in mind?.antag_datums)
			antag_string ? (antag_string += ", ") : (antag_string += "...")
			antag_string += "[antagonist.name]"
		chunk += "[used_name]\t \t THE \t \t[mind?.antag_datums ? "[antag_string] AND [job.title]" : job.title]"
		for(var/datum/objective/objective as anything in mind.get_all_objectives())
			chunk += "<B>[objective.objective_name] </B>: [objective.explanation_text]"



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
		if(ismonkey(H))
			monkies[H.name] += 1
		else if(H.real_name)
			corpses += H.real_name
	if(corpses.len)
		titles += "<center>BASED ON REAL EVENTS<br>In memory of [english_list(corpses)].</center>"

	var/list/staff = list("PRODUCTION STAFF:")
	var/list/static/staffjobs = list("Coffe Fetcher", "Cameraman", "Angry Yeller", "Chair Operator", "Choreographer", "Historical Consultant", "Costume Designer", "Chief Editor", "Executive Assistant")
	var/list/goodboys = list()
	for(var/client/C)
		if(!C.holder)
			continue
		if(C.holder)
			staff += "[uppertext(pick(staffjobs))] a.k.a. '[C.key]'"

	titles += "<center>[jointext(staff,"<br>")]</center>"
	if(goodboys.len)
		titles += "<center>STAFF'S GOOD BOYS:<br>[english_list(goodboys)]</center><br>"

	var/disclaimer = "<br>Sponsored by [pick("Nanotrasen", "The Syndicate", "Armadyne Corporation")].<br>All rights reserved.<br>\
					 This motion picture is protected under the copyright laws of the Sol Central Government<br> and other nations throughout the galaxy.<br>\
					 Colony of First Publication: [pick("Mars", "Luna", "Earth", "Venus", "Phobos", "Ceres", "Tiamat", "Ceti Epsilon", "Eos", "Pluto", "Ouere",\
					 "Lordania", "Kingston", "Cinu", "Yuklid V", "Lorriman", "Tersten", "Gaia")].<br>"
	disclaimer += pick("Use for parody prohibited. PROHIBITED.",
					   "All stunts were performed by underpaid interns. Do NOT try at home.",
					   "[pick("Nanotrasen", "The Syndicate", "Armadyne Corporation")] does not endorse behaviour depicted. Attempt at your own risk.",
					   "Any unauthorized exhibition, distribution, or copying of this film or any part thereof (including soundtrack)<br>\
						may result in an ERT being called to storm your home and take it back by force.",
						"The story, all names, characters, and incidents portrayed in this production are fictitious. No identification with actual<br>\
						persons (living or deceased), places, buildings, and products is intended or should be inferred.<br>\
						This film is based on a true story and all individuals depicted are based on real people, despite what we just said.",
						"No person or entity associated	with this film received payment or anything of value, or entered into any agreement, in connection<br>\
						with the depiction of tobacco products, despite the copious amounts	of smoking depicted within.<br>\
						(This disclaimer sponsored by Carcinoma - Carcinogens are our Business!(TM)).",
						"No animals were harmed in the making of this motion picture except for those listed previously as dead. Do not try this at home.")
	titles += "<hr>"
	titles += "<center><span style='font-size:6pt;'>[JOINTEXT(disclaimer)]</span></center>"

	return titles
