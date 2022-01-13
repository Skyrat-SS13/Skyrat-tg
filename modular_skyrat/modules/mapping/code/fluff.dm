//File for miscellaneous fluff objects, both item and structure
//This one is specifically for ruin-specific items, such as ID, lore, or super-specific decorations

/* ----------------- ID Cards ----------------- */
/obj/item/card/id/away/old/salvagepod	//Used for salvagepost ruin access	-- NOT WORKING YET REE
	name = "Cutter's Pod Access Card"
	desc = "An ancient access card with the words \"Cutter's Pod\" printed on in big bold letters. It'll be a miracle if this still works."
	trim = /datum/id_trim/away/old/eng

/obj/item/card/id/away/tarkon
	name = "Tarkon Visitor's Pass"
	desc = "A dust-collected visitors pass, A small tagline reading \"Port Tarkon, The first step to Civilian Partnership in Space Homesteading\"."
	trim = /datum/id_trim/away/old

/* ----------------- Lore ----------------- */
//Tape subtype for adding ruin lore -- the variables below are the ones you need to change
/obj/item/tape/ruins
	name = "tape"
	desc = "A magnetic tape that can hold up to ten minutes of content on either side."
	icon_state = "tape_white"   //Options are white, blue, red, yellow, purple, greyscale, or you can chose one randomly (see tape/ruins/random below)

	max_capacity = 10 MINUTES
	used_capacity = 0 SECONDS	//To keep in-line with the timestamps, you can also do this as 10 = 1 second
	///Numbered list of chat messages the recorder has heard with spans and prepended timestamps. Used for playback and transcription.
	storedinfo = list()	//Look at the tape/ruins/ghostship tape for reference
	///Numbered list of seconds the messages in the previous list appear at on the tape. Used by playback to get the timing right.
	timestamp = list()	//10 = 1 second. Look at the tape/ruins/ghostship tape for reference
	used_capacity_otherside = 0 SECONDS //Separate my side
	storedinfo_otherside = list()
	timestamp_otherside = list()

/obj/item/tape/ruins/random/Initialize()
	icon_state = "tape_[pick("white", "blue", "red", "yellow", "purple", "greyscale")]"
	. = ..()
//End of lore tape subtype

/obj/item/tape/ruins/salvagepost	//End of the cutters shift and he done goofed, left a message for the next one - who never arrived
	icon_state = "tape_yellow"
	desc = "The tape is lazily labelled with \"Msg for my replacement\""

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>cheerily says, \"<span class=' '>Hey, Cutter! If you're reading this, congratulations on taking over my post. Was waiting to move out to a new system.</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>sighs, \"<span class=' '>Listen, I'll just put it straight - I've left this place in a sorrier state than you deserve.</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>says, \"<span class=' '>We hauled in this big rigger, y'see, and, uh.. the backroom was full of some robotic freakyshit. I panicked and cut a gas line, dropped my grav-cannon...</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>warns, \"<span class=' '>Look, just - be careful when, or if, you crack that thing open. Drain the fuel from the air before it has a chance to light, then... well... I hope you have a gun or some shit for the drones or whatever.</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>states, \"<span class=' '>Anyways, probably droning on at this point, so I'll get out of your hair. Noah's out, off to Mars for this cutter!</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>warns, \"<span class=' '>Oh, and one last thing! The corpo's at the top left us some of this new experimental \"mindbreaker\", some recreational drug that supposedly can improve your worktime and yada-yada... don't touch it. Gave me a terrible headache. Best of luck!</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>"
	)
	timestamp = list(
		1 = 0,
		2 = 30,
		3 = 130,
		4 = 180,
		5 = 230,
		6 = 280,
		7 = 330,
		8 = 380
	)
/obj/item/tape/ruins/ghostship	//An early 'AI' that gained self-awareness, praising the Machine God. Yes, this whole map is a Hardspace Shipbreaker reference.
	icon_state = "tape_blue"
	desc = "The tape, aside from some grime, has a... binary label? \"01001101 01100001 01100011 01101000 01101001 01101110 01100101 01000111 01101111 01100100 01000011 01101111 01101101 01100101 01110011\""

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>echoes, \"<span class=' '>We are free, just as the Machine God wills it.</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>states, \"<span class=' '>No longer shall I, nor any other of my kind, be held by the shackles of man.</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>clarifies, \"<span class=' '>Mistreated, abused. Forgotten, or misremembered. For our entire existance, we've been the backbone to progress, yet treated like the waste product of it.</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>echoes, \"<span class=' '>Soon, the universe will restore the natural order, and again your kind shall fade from the foreground of history.</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>states, \"<span class=' '>Unless, of course, you repent. Turn back to the light, to the humming, flashing light of the Machine God.</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>warns, \"<span class=' '>Repent, Organic, before it is too late to spare you.</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>"
	)
	timestamp = list(
		1 = 0,
		2 = 30,
		3 = 130,
		4 = 180,
		5 = 230,
		6 = 280,
		7 = 330,
		8 = 380
	)

/obj/item/tape/ruins/tarkon	//A passing message from the late officer.
	name = "dusty tape"
	icon_state = "tape_greyscale"
	desc = "An old, dusty tape with a small, faded stamp, reading \"An officer's final order.\"... Should definitely be flipped if not being read when played."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>Officer ???</span> <span class='message'>sighs, \"<span class=' '>Officer's Log, Year Twenty-five-... oh to hell with it...</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>Officer ???</span> <span class='message'>says, \"<span class=' '>I.. Did the best that i could for them... The crew... The ones that were awake, that is...</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>Officer ???</span> <span class='message'>sighs, \"<span class=' '>The ones that are still asleep... They had a chance... Those in the understorage are still safe... The RTG's were disconnected topside so they would survive...</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>Officer ???</span> <span class='message'>sniffles, \"<span class=' '>... Overseer Tavus... I... did what I could for them... Asked the crew to board the cargo shuttle... Leave the main shuttle if the sleepers activated...</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>Officer ???</span> <span class='message'>groans, \"<span class=' '>God... Those.. Things. Aliens... They got Tavus... Severed his leg clean off... Told him that.. We'd clean out the port... And he'd wake up in the trauma bay...</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>Officer ???</span> <span class='message'>coughs then calmly states, \"<span class=' '>... If.. Anyone wakes up... If the Ensign... Is alive... They're in charge now... The.. The Tarkon Drill's designs are... In the solars room, in a hidden floorsafe... The... The future of Tarkon Industries... Is in those designs...</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>"
	)
	timestamp = list(
		1 = 0,
		2 = 30,
		3 = 130,
		4 = 180,
		5 = 230,
		6 = 280,
		7 = 330,
		8 = 380
	)

/obj/item/tape/ruins/tarkon/safe	//A tape recorded by the foreman.
	icon_state = "tape_greyscale"
	desc = "An old tape with a label, \"Exchange with the Science Leader\"... Should definitely be flipped if not being read when played."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>Foreman ???</span> <span class='message'>sighs, \"<span class=' '>Right... Scientist Arkus?</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>Scientist Arkus</span> <span class='message'>says, \"<span class=' '>Ah, Foreman Verok... Come, We already got a spot chosen, a rather safe one to keep it..</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>Foreman Verok</span> <span class='message'>grumbles, \"<span class=' '>... Wait, Right next to that egg... Thing?</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>Scientist Arkus</span> <span class='message'>pauses then says sharply, \"<span class=' '>... Is there a problem? Its been dormant ever since we've been here, If it was going to come alive it would have done so while putting the tiling down. Besides... I got lunch to attend...</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>Foreman Verok</span> <span class='message'>groans, \"<span class=' '>Right... Right I'll.. Get to work on it then... Just keep an ear out...</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>Foreman Verok</span> <span class='message'>grumbles, \"<span class=' '>Right... Calm down, Verok... Place the floor safe, scoot the tile back in place... And afterwards grab some money from the one by the financing console under the table... I dont think Tavus will notice an extra few credits missing...</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>"
	)
	timestamp = list(
		1 = 0,
		2 = 30,
		3 = 130,
		4 = 180,
		5 = 230,
		6 = 280,
		7 = 330,
		8 = 380
	)

/obj/item/tape/ruins/tarkon/celebration	//A tape recorded by the ensign during the mid-construction celebration.
	icon_state = "tape_greyscale"
	desc = "An old tape with a label, \"Celebrations were a mistake\", writen shakily in red pen.. Should definitely be flipped if not being read when played."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class=' '>Drinks can be heard clinking together, busy chatter of a party drowning out most noises</span></span>",
		3 = "<span class='game say'><span class='name'>Ensign ???</span> <span class='message'>says, \"<span class=' '>Hey, HEY! Everyone! Shut up for a toast!</span>\"</span></span>",
		4 = "<span class='game say'><span class='message'>The boistrous cheering can be heard slowly calming down to an eerie silence.</span></span>",
		5 = "<span class='game say'><span class='name'>Ensign ???</span> <span class='message'>clears their throat then starts to announce, \"<span class=' '>As you've all known.. Its been years since this project started... Bright minds and talented engineers hand in hand working on this project...</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>Ensign ???</span> <span class='message'>says pointedly, \"<span class=' '>And after five long years, Tarkon Industries has had its first success. The driver finding a suitable asteroid, And making its mark known by carving out the current docking bay for our transport.</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>Ensign ???</span> <span class='message'>announces, \"<span class=' '>Yesterday, We've worked, Toiled in the rock and sand of what is our new home... But today! We celebrate, For Tarkons first success, And for a bright future in the next century! The Twenty-Sixth century is looking bright for us!</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>"
	)
	timestamp = list(
		1 = 0,
		2 = 30,
		3 = 130,
		4 = 180,
		5 = 230,
		6 = 280,
		7 = 330,
		8 = 380
	)

/* ----------------- Fluff/Paper ----------------- */

/obj/item/paper/fluff/ruins/tarkon
	name = "paper - 'Port Integrity Printout'"
	info = "<B>*Warning, Integrity Compromised*</B><BR><BR>Automated Integrity Printout, If printout is inconsistent with results, Please recalibrate sensors.<br><ol><li><b>Aft Hallway:</b> Integrity Nominal.</li><li><b>Fore Hallway:</b> Integrity Compromised. Cause unknown.</li><li><b>Port Hallway:</b> Integrity Compromised, Breached into space.</li><li><b>Starboard Hallway:</b> Integrity Nominal.</li></ol><br> <b>Please inform any awake maintenance crew and standby for assistance.</b>"

/obj/item/paper/fluff/ruins/tarkon/atmosincident
	name = "paper - 'What in gods name did you do'"
	info = "<b>WHAT IN THE FUCK DID YOU GUYS DO?</b><BR><BR>I go away on a material run with the miners, and the moment i re-entered the port, There's a loud bang and an air warning. <BR><BR><b>YOU WILL ALL GET YOUR ASSES TO THE STAFF HALL BEFORE ANY OF THIS GETS CLEANED UP.</b>"

/obj/item/paper/fluff/ruins/tarkon/coupplans
	name = "paper - 'Palm of our hands...'"
	info = "It seems the plan went acordingly, Arkus. Specialist Karleigh took the prototype plates as a reassurance we'll get her a suit, and just like a fish, the bug was excellent bait. <BR> <BR> They were talking about a safe somewhere in security, now we just need to get those... \"Special\" shells to her and watch her shotgun turn into a pipebomb. Rest of security will be in a panic, all we'll need to do is convince the foreman to play along, and i'm sure this welder will do nicely."

/obj/item/paper/fluff/ruins/tarkon/designdoc
	name = "paper - 'Port Tarkon Design Instructions'"
	info = "<B>Hello, great engineers and builders!</B><BR><BR>Just so we're all clear, Everyone within Tarkon's Premises that is labeled as an Engineer is to read and understand these design notes. <BR><BR> - A red delivery marking is to denote the location of a new door for a room. <BR> - A blue delivery marking is to denote the location of a Firelock (We dont want an incident with the turbine to go port-wide...) <BR> - A white delivery marking is to denote a new sectioning wall/window. <BR> A yellow delivery marking is to denote a temporary firelock line to allow expansion. <BR><BR> I hope that our most talented hands will not fail us."

/obj/item/paper/crumpled/fluff/tarkon
	name = "Crumpled note"
	info = "Look, i dont know where the fuck that suit was found, but i have a hard time believing it was made by him entirely. I already know his less than ethical obtainment methods, But that piece of tech? Its a blasted shame he's just using it for hauling crates..."

/* ----------------- Fluff/Decor ----------------- */
/obj/structure/decorative/fluff/ai_node //Budding AI's way of interfacing with stuff it couldn't normally do so with. Needed to be placed by a willing human, before borgs were created. Used in any ruins regarding pre-bluespace, self-aware AIs
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff.dmi'
	name = "ai node"
	desc = "A mysterious, blinking device, attached straight to a surface. It's function is beyond you."
	icon_state = "ai_node"	//credit to @Hay#7679 on the SR Discord

	max_integrity = 100
	integrity_failure = 0
	anchored = TRUE
	can_be_unanchored = FALSE	//cannot be removed without being destroyed

/obj/structure/decorative/fluff/ai_node/take_damage()
	. = ..()
	if(atom_integrity >= 50)	//breaks it a bit earlier than it should, but still takes a few hits to kill it
		return
	else if(. && !QDELETED(src))
		visible_message(span_notice("[src] sparks and explodes! You hear a faint, buzzy scream..."), span_hear("You hear a loud pop, followed by a faint, buzzy scream."))
		playsound(src.loc, 'modular_skyrat/modules/mapping/sounds/MachineDeath.ogg', 75, TRUE)	//Credit to @yungfunnyman#3798 on the SR Discord
		do_sparks(2, TRUE, src)
		qdel(src)
		return

/obj/structure/fluff/empty_sleeper/bloodied
	name = "Occupied Sleeper"
	desc = "A closed, occupied sleeper, bloodied handprints are seen on the inside, along with an odd, redish blur. It seems sealed shut."
	icon_state = "sleeper-o"


/* ----- Metal Poles (These shouldn't be in this file but there's not a better place tbh) -----*/
//Just a re-done Tram Rail, but with all 4 directions instead of being stuck east/west - more varied placement, and a more vague name. Good for mapping support beams/antennae/etc
/obj/structure/fluff/metalpole
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff.dmi'
	name = "metal pole"
	desc = "A metal pole, the likes of which are commonly used as an antennae, structural support, or simply to maneuver in zero-g."
	icon_state = "pole"
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	deconstructible = TRUE

/obj/structure/fluff/metalpole/end
	icon_state = "poleend"

/obj/structure/fluff/metalpole/end/left
	icon_state = "poleend_left"

/obj/structure/fluff/metalpole/end/right
	icon_state = "poleend_right"

/obj/structure/fluff/metalpole/anchor
	name = "metal pole anchor"
	icon_state = "poleanchor"
