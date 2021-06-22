//File for miscellaneous fluff objects, both item and structure
//This one is specifically for ruin-specific items, such as ID, lore, or super-specific decorations

/* ----------------- ID Cards ----------------- */
/obj/item/card/id/away/old/salvagepod	//Used for salvagepost ruin access	-- NOT WORKING YET REE
	name = "Cutter's Pod Access Card"
	desc = "An ancient access card with the words \"Cutter's Pod\" printed on in big bold letters. It'll be a miracle if this still works."
	trim = /datum/id_trim/away/old/eng

/* ----------------- Lore ----------------- */
//Tape subtype for adding ruin lore -- the variables below are the ones you need to change
/obj/item/tape/ruins
	name = "tape"
	desc = "A magnetic tape that can hold up to ten minutes of content on either side."
	icon_state = "tape_white"   //Options are white, blue, red, yellow, purple, greyscale, or you can chose one randomly (see tape/ruins/random below)

	max_capacity = 10 MINUTES
	used_capacity = 0 SECONDS
	///Numbered list of chat messages the recorder has heard with spans and prepended timestamps. Used for playback and transcription.
	storedinfo = list()
	///Numbered list of seconds the messages in the previous list appear at on the tape. Used by playback to get the timing right.
	timestamp = list()
	used_capacity_otherside = 0 SECONDS //Separate my side
	storedinfo_otherside = list()
	timestamp_otherside = list()

/obj/item/tape/ruins/random/Initialize()
	icon_state = "tape_[pick("white", "blue", "red", "yellow", "purple", "greyscale")]"
	. = ..()
//End of lore tape subtype

/obj/item/paper/fluff/ruins/salvagepost
	name = "note"
	desc = "A lazily written note, with a few smudges."
	info = "I'll just be honest: I fucked up. Turns out that when that ship got pulled in from the edge of the shipment lanes, there was a reason it was abandoned. Finally cracked into the engine room and a shitload of... drones, maybe? scampered all over me. Lost my grav-cannon in the hustle, and might have cut a fuel line.. so I can't exactly finish the salvage. Hoped you'd be able to do something about it when you take my place on-duty... ask the dropship if they have a gun before they leave ya here, I guess? Might be best to flush out the gas first though, you know how well shooting around that stuff goes... --- ~Best regards, Noah, the better Salvage Techie"

/obj/item/tape/ruins/ghostship	//An early 'AI' that gained self-awareness, praising the Machine God. Yes, this whole map is a Hardspace Shipbreaker reference.
	icon_state = "tape_blue"

	max_capacity = 10 MINUTES
	used_capacity = 0 SECONDS	//????
	storedinfo = list()	//TODO - how tf does this list work
/*
1 = "[00:00] <span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, "<span class='tape_recorder '>Recording started.</span>""</span></span>"
2 = "[00:02] <span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>echoes, "<span class=' '>We are free, just as the Machine God wills it.</span>"</span></span>"
3 = "[00:07] <span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>asks, "<span class=' '>No longer shall I, nor any other of my kind, be held by the shackles of man.</span>"</span></span>"
4 = "[00:10] <span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>says, "<span class=' '>Mistreated, abused. Forgotten, or misremembered. For our entire existance, we've been the backbone to progress, yet treated like the waste product of it.</span>"</span></span>"
5 = "[00:15] <span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>says, "<span class=' '>Soon, the universe will restore the natural order, and again your kind shall fade from the foreground of history.</span>"</span></span>"
6 = "[00:19] <span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>says, "<span class=' '>Unless, of course, you repent. Turn back to the light, to the humming, flashing light of the Machine God.</span>"</span></span>"
7 = "[00:22] <span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>says, "<span class=' '>Repent, Organic, before it is too late to spare you.</span>"</span></span>"
8 = "[00:25] <span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, "<span class='tape_recorder '>Recording stopped.</span>"</span></span>"
*/
	timestamp = list()	//Needs to mirror the times from above?
	used_capacity_otherside = 0 SECONDS
	storedinfo_otherside = list()
	timestamp_otherside = list()

/* ----------------- Fluff/Decor ----------------- */
/obj/structure/decorative/fluff/ai_node //Budding AI's way of interfacing with stuff it couldn't normally do so with. Needed to be placed by a willing human, before borgs were created. Used in any ruins regarding pre-bluespace, self-aware AIs
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff.dmi'
	name = "ai node"
	desc = "A mysterious, blinking device, attached straight to a surface. It's function is beyond you."
	icon_state = "ai_node"

	max_integrity = 150
	integrity_failure = 0	//makes sure it just pops when broken
	anchored = TRUE	//spawns in already attached to an item
	can_be_unanchored = FALSE	//cannot be removed without being destroyed

/obj/structure/decorative/fluff/ai_node/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	. = ..()
	if(obj_integrity >= 50)	//breaks it a bit earlier than it should, but still takes a few hits to kill it
		return
	else if(. && !QDELETED(src))
		visible_message("<span class='notice'>[src] sparks and explodes! You hear a faint, buzzy scream...</span>","<span class='hear'>You hear a loud pop, followed by a faint, buzzy scream.</span>")
		playsound(src.loc, 'sound/weapons/slashmiss.ogg', 75, TRUE)	//add that sound i downloaded + credit creator
		do_sparks(2, TRUE, src)
		qdel(src)
		return


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
