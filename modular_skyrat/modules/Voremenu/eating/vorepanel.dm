//
// Vore management panel for players
//

#define BELLIES_MAX 20
#define BELLIES_NAME_MIN 2
#define BELLIES_NAME_MAX 12
#define BELLIES_DESC_MAX 1024

/mob/living/proc/insidePanel()
	set name = "Vore Panel"
	set category = "Vore"

	var/datum/vore_look/picker_holder = new()
	picker_holder.loop = picker_holder
	picker_holder.selected = vore_selected

	var/dat = picker_holder.gen_vui(src)

	picker_holder.popup = new(src, "insidePanel","Vore Panel", 450, 700, picker_holder)
	picker_holder.popup.set_content(dat)
	picker_holder.popup.open()
	vore_flags |= OPEN_PANEL

/mob/living/proc/updateVRPanel() //Panel popup update call from belly events.
	if(vore_flags & OPEN_PANEL)
		var/datum/vore_look/picker_holder = new()
		picker_holder.loop = picker_holder
		picker_holder.selected = vore_selected

		var/dat = picker_holder.gen_vui(src)

		picker_holder.popup = new(src, "insidePanel","Vore Panel", 450, 700, picker_holder)
		picker_holder.popup.set_content(dat)
		picker_holder.popup.open()

//
// Callback Handler for the Inside form
//
/datum/vore_look
	var/obj/belly/selected
	var/show_interacts = FALSE
	var/datum/browser/popup
	var/loop = null;  // Magic self-reference to stop the handler from being GC'd before user takes action.

/datum/vore_look/Destroy()
	loop = null
	selected = null
	return QDEL_HINT_HARDDEL

/datum/vore_look/Topic(href,href_list[])
	if (vp_interact(href, href_list))
		popup.set_content(gen_vui(usr))
		usr << output(popup.get_content(), "insidePanel.browser")

/datum/vore_look/proc/gen_vui(var/mob/living/user)
	var/dat
	dat += "Remember to toggle the vore mode, it's to the left of your combat toggle. Open mouth means you're voracious!<br>"
	dat += "Remember that the prey is blind, use audible mode subtle messages to communicate to them with posts!<br>"
	dat += "<HR>"
	var/atom/userloc = user.loc
	if (isbelly(userloc))
		var/obj/belly/inside_belly = userloc
		var/mob/living/eater = inside_belly.owner

		//Don't display this part if we couldn't find the belly since could be held in hand.
		if(inside_belly)
			dat += "<font color = 'green'>You are currently [(user.vore_flags & ABSORBED) ? "absorbed into " : "inside "]</font> <font color = 'yellow'>[eater]'s</font> <font color = 'red'>[inside_belly]</font>!<br><br>"

			if(inside_belly.desc)
				dat += "[inside_belly.desc]<br><br>"

			if (inside_belly.contents.len > 1)
				dat += "You can see the following around you:<br>"
				for (var/atom/movable/O in inside_belly)
					if(istype(O,/mob/living))
						var/mob/living/M = O
						//That's just you
						if(M == user)
							continue

						//That's an absorbed person you're checking
						if(M.vore_flags & ABSORBED)
							if(user.vore_flags & ABSORBED)
								dat += "<a href='?src=\ref[src];outsidepick=\ref[O];outsidebelly=\ref[inside_belly]'><span style='color:purple;'>[O]</span></a>"
								continue
							else
								continue

					//Anything else
					dat += "<a href='?src=\ref[src];outsidepick=\ref[O];outsidebelly=\ref[inside_belly]'>[O]&#8203;</a>"

					//Zero-width space, for wrapping
					dat += "&#8203;"
	else
		dat += "You aren't inside anyone."

	dat += "<HR>"

	dat += "<ol style='list-style: none; padding: 0; overflow: auto;'>"
	for(var/belly in user.vore_organs)
		var/obj/belly/B = belly
		if(B == selected)
			dat += "<li style='float: left'><a href='?src=\ref[src];bellypick=\ref[B]'><b>[B.name]</b>"
		else
			dat += "<li style='float: left'><a href='?src=\ref[src];bellypick=\ref[B]'>[B.name]"
		var/spanstyle
		switch(B.digest_mode)
			if(DM_HOLD)
				spanstyle = ""
			if(DM_DIGEST)
				spanstyle = "color:red;"
			if(DM_HEAL)
				spanstyle = "color:darkgreen;"
			if(DM_NOISY)
				spanstyle = "color:purple;"
			if(DM_ABSORB)
				spanstyle = "color:purple;"
			if(DM_DRAGON)
				spanstyle = "color:blue;"

		dat += "<span style='[spanstyle]'> ([B.contents.len])</span></a></li>"

	if(user.vore_organs.len < BELLIES_MAX)
		dat += "<li style='float: left'><a href='?src=\ref[src];newbelly=1'>New+</a></li>"
	dat += "</ol>"
	dat += "<HR>"

	// Selected Belly (contents, configuration)
	if(!selected)
		dat += "No belly selected. Click one to select it."
	else
		if(selected.contents.len)
			dat += "<b>Contents:</b> "
			for(var/O in selected)

				//Mobs can be absorbed, so treat them separately from everything else
				if(istype(O,/mob/living))
					var/mob/living/M = O

					//Absorbed gets special color OOoOOOOoooo
					if(M.vore_flags & ABSORBED)
						dat += "<a href='?src=\ref[src];insidepick=\ref[O]'><span style='color:purple;'>[O]</span></a>"
						continue

				//Anything else
				dat += "<a href='?src=\ref[src];insidepick=\ref[O]'>[O]</a>"

				//Zero-width space, for wrapping
				dat += "&#8203;"

			//If there's more than one thing, add an [All] button
			if(selected.contents.len > 1)
				dat += "<a href='?src=\ref[src];insidepick=1;pickall=1'>\[All\]</a>"

			dat += "<HR>"

		//Belly Name Button
		dat += "<a href='?src=\ref[src];b_name=\ref[selected]'>Name:</a>"
		dat += " '[selected.name]'"

		//Belly Type button
		dat += "<br><a href='?src=\ref[src];b_wetness=\ref[selected]'>Is Fleshy:</a>"
		dat += "[selected.is_wet ? "Yes" : "No"]"
		if(selected.is_wet)
			dat += "<br><a href='?src=\ref[src];b_wetloop=\ref[selected]'>Internal loop for prey?:</a>"
			dat += "[selected.wet_loop ? "Yes" : "No"]"

		//Digest Mode Button
		dat += "<br><a href='?src=\ref[src];b_mode=\ref[selected]'>Belly Mode:</a>"
		dat += " [selected.digest_mode]"

		//Belly verb
		dat += "<br><a href='?src=\ref[src];b_verb=\ref[selected]'>Vore Verb:</a>"
		dat += " '[selected.vore_verb]'"

		//Inside flavortext
		dat += "<br><a href='?src=\ref[src];b_desc=\ref[selected]'>Flavor Text:</a>"
		dat += " '[selected.desc]'"

		//Belly sound
		dat += "<br><a href='?src=\ref[src];b_sound=\ref[selected]'>Vore Sound: [selected.vore_sound]</a>"
		dat += "<a href='?src=\ref[src];b_soundtest=\ref[selected]'>Test</a>"

		//Release sound
		dat += "<br><a href='?src=\ref[src];b_release=\ref[selected]'>Release Sound: [selected.release_sound]</a>"
		dat += "<a href='?src=\ref[src];b_releasesoundtest=\ref[selected]'>Test</a>"

		//Belly messages
		dat += "<br><a href='?src=\ref[src];b_msgs=\ref[selected]'>Belly Messages</a>"

		//Can belly taste?
		dat += "<br><a href='?src=\ref[src];b_tastes=\ref[selected]'>Can Taste:</a>"
		dat += " [selected.can_taste ? "Yes" : "No"]"

		//Minimum size prey must be to show up.
		dat += "<br><a href='?src=\ref[src];b_bulge_size=\ref[selected]'>Required examine size:</a>"
		dat += " [selected.bulge_size*100]%"

		//Belly escapability
		dat += "<br><a href='?src=\ref[src];b_escapable=\ref[selected]'>Belly Interactions ([selected.escapable ? "On" : "Off"])</a>"
		if(selected.escapable)
			dat += "<a href='?src=\ref[src];show_int=\ref[selected]'>[show_interacts ? "Hide" : "Show"]</a>"

		if(show_interacts && selected.escapable)
			dat += "<HR>"
			dat += "Interaction Settings <a href='?src=\ref[src];int_help=\ref[selected]'>?</a>"
			dat += "<br><a href='?src=\ref[src];b_escapechance=\ref[selected]'>Set Belly Escape Chance</a>"
			dat += " [selected.escapechance]%"

			dat += "<br><a href='?src=\ref[src];b_escapetime=\ref[selected]'>Set Belly Escape Time</a>"
			dat += " [selected.escapetime/10]s"

			//Special <br> here to add a gap
			dat += "<br style='line-height:5px;'>"
			dat += "<br><a href='?src=\ref[src];b_transferchance=\ref[selected]'>Set Belly Transfer Chance</a>"
			dat += " [selected.transferchance]%"

			dat += "<br><a href='?src=\ref[src];b_transferlocation=\ref[selected]'>Set Belly Transfer Location</a>"
			dat += " [selected.transferlocation ? selected.transferlocation : "Disabled"]"

			//Special <br> here to add a gap
			dat += "<br style='line-height:5px;'>"
			dat += "<br><a href='?src=\ref[src];b_absorbchance=\ref[selected]'>Set Belly Absorb Chance</a>"
			dat += " [selected.absorbchance]%"

			dat += "<br><a href='?src=\ref[src];b_digestchance=\ref[selected]'>Set Belly Digest Chance</a>"
			dat += " [selected.digestchance]%"
			dat += "<HR>"

		//Delete button
		dat += "<br><a style='background:#990000;' href='?src=\ref[src];b_del=\ref[selected]'>Delete Belly</a>"

	dat += "<a href='?src=\ref[src];setflavor=1'>Set Flavor</a>"

	dat += "<HR>"

	//Under the last HR, save and stuff.
	dat += "<a href='?src=\ref[src];saveprefs=1'>Save Prefs</a>"
	dat += "<a href='?src=\ref[src];refresh=1'>Refresh</a>"
	dat += "<a href='?src=\ref[src];applyprefs=1'>Reload Slot Prefs</a>"

	dat += "<HR>"
	var/pref_on = "#173d15"
	var/pref_off = "#990000"
	dat += "<br><a style='background:[(user.vore_flags & DIGESTABLE) ? pref_on : pref_off];' href='?src=\ref[src];toggledg=1'>Toggle Digestable (Currently: [(user.vore_flags & DIGESTABLE) ? "ON" : "OFF"])</a>"
	dat += "<br><a style='background:[(user.vore_flags & DEVOURABLE) ? pref_on : pref_off];' href='?src=\ref[src];toggledvor=1'>Toggle Devourable (Currently: [(user.vore_flags & DEVOURABLE) ? "ON" : "OFF"])</a>"
	dat += "<br><a style='background:[(user.vore_flags & FEEDING) ? pref_on : pref_off];' href='?src=\ref[src];toggledfeed=1'>Toggle Feeding (Currently: [(user.vore_flags & FEEDING) ? "ON" : "OFF"])</a>"
	if(user.client.prefs)
		dat += "<br><a style='background:[(user.client.prefs.vore_flags & LICKABLE) ? pref_on : pref_off];' href='?src=\ref[src];toggledlickable=1'>Toggle Licking (Currently: [(user.client.prefs.vore_flags & LICKABLE) ? "ON" : "OFF"])</a>"
	//Returns the dat html to the vore_look
	return dat

/datum/vore_look/proc/vp_interact(href, href_list)
	var/mob/living/user = usr
	for(var/H in href_list)

	if(href_list["close"])
		qdel(src)  // Cleanup
		user.vore_flags &= ~OPEN_PANEL
		return

	if(href_list["show_int"])
		show_interacts = !show_interacts
		return TRUE //Force update

	if(href_list["int_help"])
		alert("These control how your belly responds to someone using 'resist' while inside you. The percent chance to trigger each is listed below, \
				and you can change them to whatever you see fit. Setting them to 0% will disable the possibility of that interaction. \
				These only function as long as interactions are turned on in general. Keep in mind, the 'belly mode' interactions (digest/absorb) \
				will affect all prey in that belly, if one resists and triggers digestion/absorption. If multiple trigger at the same time, \
				only the first in the order of 'Escape > Transfer > Absorb > Digest' will occur.","Interactions Help")
		return FALSE //Force update

	if(href_list["outsidepick"])
		var/atom/movable/tgt = locate(href_list["outsidepick"])
		var/obj/belly/OB = locate(href_list["outsidebelly"])
		if(!(tgt in OB)) //Aren't here anymore, need to update menu.
			return TRUE
		var/intent = "Examine"

		if(istype(tgt,/mob/living))
			var/mob/living/M = tgt
			intent = alert("What do you want to do to them?","Query","Examine","Help Out","Devour")
			switch(intent)
				if("Examine") //Examine a mob inside another mob
					M.examine(user)

				if("Help Out") //Help the inside-mob out
					if(user.stat || user.vore_flags & ABSORBED || M.vore_flags & ABSORBED)
						to_chat(user,"<span class='warning'>You can't do that in your state!</span>")
						return TRUE

					to_chat(user,"<font color='green'>You begin to push [M] to freedom!</font>")
					to_chat(M,"[usr] begins to push you to freedom!")
					to_chat(M.loc,"<span class='warning'>Someone is trying to escape from inside you!</span>")
					sleep(50)
					if(prob(33))
						OB.release_specific_contents(M)
						to_chat(usr,"<font color='green'>You manage to help [M] to safety!</font>")
						to_chat(M,"<font color='green'>[user] pushes you free!</font>")
						to_chat(OB.owner,"<span class='alert'>[M] forces free of the confines of your body!</span>")
					else
						to_chat(user,"<span class='alert'>[M] slips back down inside despite your efforts.</span>")
						to_chat(M,"<span class='alert'> Even with [user]'s help, you slip back inside again.</span>")
						to_chat(OB.owner,"<font color='green'>Your body efficiently shoves [M] back where they belong.</font>")

				if("Devour") //Eat the inside mob
					if(user.vore_flags & ABSORBED || user.stat)
						to_chat(user,"<span class='warning'>You can't do that in your state!</span>")
						return TRUE

					if(!user.vore_selected)
						to_chat(user,"<span class='warning'>Pick a belly on yourself first!</span>")
						return TRUE

					var/obj/belly/TB = user.vore_selected
					to_chat(user,"<span class='warning'>You begin to [lowertext(TB.vore_verb)] [M] into your [lowertext(TB.name)]!</span>")
					to_chat(M,"<span class='warning'>[user] begins to [lowertext(TB.vore_verb)] you into their [lowertext(TB.name)]!</span>")
					to_chat(OB.owner,"<span class='warning'>Someone inside you is eating someone else!</span>")

					sleep(TB.nonhuman_prey_swallow_time) //Can't do after, in a stomach, weird things abound.
					if((user in OB) && (M in OB)) //Make sure they're still here.
						to_chat(user,"<span class='warning'>You manage to [lowertext(TB.vore_verb)] [M] into your [lowertext(TB.name)]!</span>")
						to_chat(M,"<span class='warning'>[user] manages to [lowertext(TB.vore_verb)] you into their [lowertext(TB.name)]!</span>")
						to_chat(OB.owner,"<span class='warning'>Someone inside you has eaten someone else!</span>")
						TB.nom_mob(M)

		else if(istype(tgt,/obj/item))
			var/obj/item/T = tgt
			if(!(tgt in OB))
				//Doesn't exist anymore, update.
				return TRUE
			intent = alert("What do you want to do to that?","Query","Examine","Use Hand")
			switch(intent)
				if("Examine")
					T.examine(user)

				if("Use Hand")
					if(user.stat)
						to_chat(user,"<span class='warning'>You can't do that in your state!</span>")
						return TRUE

					user.ClickOn(T)
					sleep(5) //Seems to exit too fast for the panel to update

	if(href_list["insidepick"])
		var/intent

		//Handle the [All] choice. Ugh inelegant. Someone make this pretty.
		if(href_list["pickall"])
			intent = alert("Eject all, Move all?","Query","Eject all","Cancel","Move all")
			switch(intent)
				if("Cancel")
					return FALSE

				if("Eject all")
					if(user.stat)
						to_chat(user,"<span class='warning'>You can't do that in your state!</span>")
						return FALSE

					selected.release_all_contents()

				if("Move all")
					if(user.stat)
						to_chat(user,"<span class='warning'>You can't do that in your state!</span>")
						return FALSE

					var/obj/belly/choice = input("Move all where?","Select Belly") as null|anything in user.vore_organs
					if(!choice)
						return FALSE

					for(var/atom/movable/tgt in selected)
						to_chat(tgt,"<span class='warning'>You're squished from [user]'s [lowertext(selected)] to their [lowertext(choice.name)]!</span>")
						selected.transfer_contents(tgt, choice, 1)

		var/atom/movable/tgt = locate(href_list["insidepick"])
		if(!(tgt in selected)) //Old menu, needs updating because they aren't really there.
			return TRUE //Forces update
		intent = "Examine"
		intent = alert("Examine, Eject, Move? Examine if you want to leave this box.","Query","Examine","Eject","Move")
		switch(intent)
			if("Examine")
				tgt.examine(user)

			if("Eject")
				if(user.stat)
					to_chat(user,"<span class='warning'>You can't do that in your state!</span>")
					return FALSE

				selected.release_specific_contents(tgt)

			if("Move")
				if(user.stat)
					to_chat(user,"<span class='warning'>You can't do that in your state!</span>")
					return FALSE

				var/obj/belly/choice = input("Move [tgt] where?","Select Belly") as null|anything in user.vore_organs
				if(!choice || !(tgt in selected))
					return FALSE

				to_chat(tgt,"<span class='warning'>You're squished from [user]'s [lowertext(selected.name)] to their [lowertext(choice.name)]!</span>")
				selected.transfer_contents(tgt, choice)

	if(href_list["newbelly"])
		if(user.vore_organs.len >= BELLIES_MAX)
			return FALSE

		var/new_name = html_encode(input(usr,"New belly's name:","New Belly") as text|null)

		var/failure_msg
		if(length(new_name) > BELLIES_NAME_MAX || length(new_name) < BELLIES_NAME_MIN)
			failure_msg = "Entered belly name length invalid (must be longer than [BELLIES_NAME_MIN], no more than than [BELLIES_NAME_MAX])."
		// else if(whatever) //Next test here.
		else
			for(var/belly in user.vore_organs)
				var/obj/belly/B = belly
				if(lowertext(new_name) == lowertext(B.name))
					failure_msg = "No duplicate belly names, please."
					break

		if(failure_msg) //Something went wrong.
			alert(user,failure_msg,"Error!")
			return FALSE

		var/obj/belly/NB = new(user)
		NB.name = new_name
		selected = NB

	if(href_list["bellypick"])
		selected = locate(href_list["bellypick"])
		user.vore_selected = selected

	////
	//Please keep these the same order they are on the panel UI for ease of coding
	////
	if(href_list["b_name"])
		var/new_name = html_encode(input(usr,"Belly's new name:","New Name") as text|null)

		var/failure_msg
		if(length(new_name) > BELLIES_NAME_MAX || length(new_name) < BELLIES_NAME_MIN)
			failure_msg = "Entered belly name length invalid (must be longer than [BELLIES_NAME_MIN], no more than than [BELLIES_NAME_MAX])."
		// else if(whatever) //Next test here.
		else
			for(var/belly in user.vore_organs)
				var/obj/belly/B = belly
				if(lowertext(new_name) == lowertext(B.name))
					failure_msg = "No duplicate belly names, please."
					break

		if(failure_msg) //Something went wrong.
			alert(user,failure_msg,"Error!")
			return FALSE

		selected.name = new_name

	if(href_list["b_wetness"])
		selected.is_wet = !selected.is_wet

	if(href_list["b_wetloop"])
		selected.wet_loop = !selected.wet_loop

	if(href_list["b_mode"])
		var/list/menu_list = selected.digest_modes

		var/new_mode = input("Choose Mode (currently [selected.digest_mode])") as null|anything in menu_list
		if(!new_mode)
			return FALSE
		selected.digest_mode = new_mode

	if(href_list["b_desc"])
		var/new_desc = html_encode(input(usr,"Belly Description ([BELLIES_DESC_MAX] char limit):","New Description",selected.desc) as message|null)

		if(new_desc)
			new_desc = readd_quotes(new_desc)
			if(length(new_desc) > BELLIES_DESC_MAX)
				alert("Entered belly desc too long. [BELLIES_DESC_MAX] character limit.","Error")
				return FALSE
			selected.desc = new_desc
		else //Returned null
			return FALSE

	if(href_list["b_msgs"])
		var/list/messages = list(
			"Digest Message (to prey)",
			"Digest Message (to you)",
			"Struggle Message (outside)",
			"Struggle Message (inside)",
			"Examine Message (when full)",
			"Reset All To Default"
		)

		alert(user,"Setting abusive or deceptive messages will result in a ban. Consider this your warning. Max 150 characters per message, max 10 messages per topic.","Really, don't.")
		var/choice = input(user,"Select a type to modify. Messages from each topic are pulled at random when needed.","Pick Type") as null|anything in messages
		var/help = " Press enter twice to separate messages. '%pred' will be replaced with your name. '%prey' will be replaced with the prey's name. '%belly' will be replaced with your belly's name."

		switch(choice)
			if("Digest Message (to prey)")
				var/new_message = input(user,"These are sent to prey when they expire. Write them in 2nd person ('you feel X'). Avoid using %prey in this type."+help,"Digest Message (to prey)",selected.get_messages("dmp")) as message
				if(new_message)
					selected.set_messages(new_message,"dmp")

			if("Digest Message (to you)")
				var/new_message = input(user,"These are sent to you when prey expires in you. Write them in 2nd person ('you feel X'). Avoid using %pred in this type."+help,"Digest Message (to you)",selected.get_messages("dmo")) as message
				if(new_message)
					selected.set_messages(new_message,"dmo")

			if("Struggle Message (outside)")
				var/new_message = input(user,"These are sent to those nearby when prey struggles. Write them in 3rd person ('X's Y bulges')."+help,"Struggle Message (outside)",selected.get_messages("smo")) as message
				if(new_message)
					selected.set_messages(new_message,"smo")

			if("Struggle Message (inside)")
				var/new_message = input(user,"These are sent to prey when they struggle. Write them in 2nd person ('you feel X'). Avoid using %prey in this type."+help,"Struggle Message (inside)",selected.get_messages("smi")) as message
				if(new_message)
					selected.set_messages(new_message,"smi")

			if("Examine Message (when full)")
				var/new_message = input(user,"These are sent to people who examine you when this belly has contents. Write them in 3rd person ('Their %belly is bulging')."+help,"Examine Message (when full)",selected.get_messages("em")) as message
				if(new_message)
					selected.set_messages(new_message,"em")

			if("Reset All To Default")
				var/confirm = alert(user,"This will delete any custom messages. Are you sure?","Confirmation","DELETE","Cancel")
				if(confirm == "DELETE")
					selected.digest_messages_prey = initial(selected.digest_messages_prey)
					selected.digest_messages_owner = initial(selected.digest_messages_owner)
					selected.struggle_messages_outside = initial(selected.struggle_messages_outside)
					selected.struggle_messages_inside = initial(selected.struggle_messages_inside)

	if(href_list["b_verb"])
		var/new_verb = html_encode(input(usr,"New verb when eating (infinitive tense, e.g. nom or swallow):","New Verb") as text|null)

		if(length(new_verb) > BELLIES_NAME_MAX || length(new_verb) < BELLIES_NAME_MIN)
			alert("Entered verb length invalid (must be longer than [BELLIES_NAME_MIN], no longer than [BELLIES_NAME_MAX]).","Error")
			return FALSE

		selected.vore_verb = new_verb

	if(href_list["b_release"])
		var/choice = input(user,"Currently set to [selected.release_sound]","Select Sound") as null|anything in GLOB.pred_release_sounds

		if(!choice)
			return

		selected.release_sound = choice

	if(href_list["b_releasesoundtest"])
		var/sound/releasetest = GLOB.prey_release_sounds[selected.release_sound]
		if(releasetest)
			SEND_SOUND(user, releasetest)

	if(href_list["b_sound"])
		var/choice = input(user,"Currently set to [selected.vore_sound]","Select Sound") as null|anything in GLOB.pred_vore_sounds

		if(!choice)
			return

		selected.vore_sound = choice

	if(href_list["b_soundtest"])
		var/sound/voretest = GLOB.prey_vore_sounds[selected.vore_sound]
		if(voretest)
			SEND_SOUND(user, voretest)

	if(href_list["b_tastes"])
		selected.can_taste = !selected.can_taste

	if(href_list["b_bulge_size"])
		var/new_bulge = input(user, "Choose the required size prey must be to show up on examine, ranging from 25% to 200% Set this to 0 for no text on examine.", "Set Belly Examine Size.") as num|null
		if(new_bulge == null)
			return
		if(new_bulge == 0) //Disable.
			selected.bulge_size = 0
			to_chat(user,"<span class='notice'>Your stomach will not be seen on examine.</span>")
		else if (!ISINRANGE(new_bulge,25,200))
			selected.bulge_size = 0.25 //Set it to the default.
			to_chat(user,"<span class='notice'>Invalid size.</span>")
		else if(new_bulge)
			selected.bulge_size = (new_bulge/100)

	if(href_list["b_escapable"])
		if(selected.escapable == FALSE) //Possibly escapable and special interactions.
			selected.escapable = TRUE
			to_chat(usr,"<span class='warning'>Prey now have special interactions with your [lowertext(selected.name)] depending on your settings.</span>")
		else if(selected.escapable == TRUE) //Never escapable.
			selected.escapable = FALSE
			to_chat(usr,"<span class='warning'>Prey will not be able to have special interactions with your [lowertext(selected.name)].</span>")
			show_interacts = FALSE //Force the hiding of the panel
		else
			alert("Something went wrong. Your stomach will now not have special interactions. Press the button enable them again and tell a dev.","Error") //If they somehow have a varable that's not 0 or 1
			selected.escapable = FALSE
			show_interacts = FALSE //Force the hiding of the panel

	if(href_list["b_escapechance"])
		var/escape_chance_input = input(user, "Set prey escape chance on resist (as %)", "Prey Escape Chance") as num|null
		if(!isnull(escape_chance_input)) //These have to be 'null' because both cancel and 0 are valid, separate options
			selected.escapechance = sanitize_integer(escape_chance_input, 0, 100, initial(selected.escapechance))

	if(href_list["b_escapetime"])
		var/escape_time_input = input(user, "Set number of seconds for prey to escape on resist (1-60)", "Prey Escape Time") as num|null
		if(!isnull(escape_time_input))
			selected.escapetime = sanitize_integer(escape_time_input*10, 10, 600, initial(selected.escapetime))

	if(href_list["b_transferchance"])
		var/transfer_chance_input = input(user, "Set belly transfer chance on resist (as %). You must also set the location for this to have any effect.", "Prey Escape Time") as num|null
		if(!isnull(transfer_chance_input))
			selected.transferchance = sanitize_integer(transfer_chance_input, 0, 100, initial(selected.transferchance))

	if(href_list["b_transferlocation"])
		var/obj/belly/choice = input("Where do you want your [lowertext(selected.name)] to lead if prey resists?","Select Belly") as null|anything in (user.vore_organs + "None - Remove" - selected)

		if(!choice) //They cancelled, no changes
			return FALSE
		else if(choice == "None - Remove")
			selected.transferlocation = null
		else
			selected.transferlocation = choice.name

	if(href_list["b_absorbchance"])
		var/absorb_chance_input = input(user, "Set belly absorb mode chance on resist (as %)", "Prey Absorb Chance") as num|null
		if(!isnull(absorb_chance_input))
			selected.absorbchance = sanitize_integer(absorb_chance_input, 0, 100, initial(selected.absorbchance))

	if(href_list["b_digestchance"])
		var/digest_chance_input = input(user, "Set belly digest mode chance on resist (as %)", "Prey Digest Chance") as num|null
		if(!isnull(digest_chance_input))
			selected.digestchance = sanitize_integer(digest_chance_input, 0, 100, initial(selected.digestchance))

	if(href_list["b_del"])
		var/alert = alert("Are you sure you want to delete your [lowertext(selected.name)]?","Confirmation","Delete","Cancel")
		if(!alert == "Delete")
			return FALSE

		var/failure_msg = ""

		var/dest_for //Check to see if it's the destination of another vore organ.
		for(var/belly in user.vore_organs)
			var/obj/belly/B = belly
			if(B.transferlocation == selected)
				dest_for = B.name
				failure_msg += "This is the destiantion for at least '[dest_for]' belly transfers. Remove it as the destination from any bellies before deleting it. "
				break

		if(selected.contents.len)
			failure_msg += "You cannot delete bellies with contents! " //These end with spaces, to be nice looking. Make sure you do the same.
		if(selected.immutable)
			failure_msg += "This belly is marked as undeletable. "
		if(user.vore_organs.len == 1)
			failure_msg += "You must have at least one belly. "

		if(failure_msg)
			alert(user,failure_msg,"Error!")
			return FALSE

		qdel(selected)
		selected = user.vore_organs[1]
		user.vore_selected = user.vore_organs[1]

	if(href_list["saveprefs"])
		if(!(user.client?.prefs))
			return FALSE
		if(!user.copy_to_prefs_vr() || !user.client.prefs.save_character())
			to_chat(user, "<span class='warning'>Belly Preferences not saved!</span>")
			log_admin("Could not save vore prefs on USER: [user].")
		else
			to_chat(user, "<span class='notice'>Belly Preferences were saved!</span>")

	if(href_list["applyprefs"])
		var/alert = alert("Are you sure you want to reload the current slot preferences? This will remove your current vore organs and eject their contents.","Confirmation","Reload","Cancel")
		if(!alert == "Reload")
			return FALSE
		if(!user.copy_from_prefs_vr())
			alert("ERROR: Vore preferences failed to apply!","Error")
		else
			to_chat(user,"<span class='notice'>Vore preferences applied from active slot!</span>")

	if(href_list["setflavor"])
		var/new_flavor = html_encode(input(usr,"What your character tastes like (40ch limit). This text will be printed to the pred after 'X tastes of...' so just put something like 'strawberries and cream':","Character Flavor",user.vore_taste) as text|null)
		if(!new_flavor)
			return FALSE

		new_flavor = readd_quotes(new_flavor)
		if(length(new_flavor) > MAX_TASTE_LEN)
			alert("Entered flavor/taste text too long. [MAX_TASTE_LEN] character limit.","Error!")
			return FALSE
		user.vore_taste = new_flavor

	if(href_list["toggledg"])
		var/choice = alert(user, "This button is for those who don't like being digested. It can make you undigestable to all mobs. Digesting you is currently: [(user.vore_flags & DIGESTABLE) ? "Allowed" : "Prevented"]", "", "Allow Digestion", "Cancel", "Prevent Digestion")
		if(!user || !user.client)
			return
		switch(choice)
			if("Cancel")
				return FALSE
			if("Allow Digestion")
				user.vore_flags |= DIGESTABLE
				user.client.prefs.vore_flags |= DIGESTABLE
			if("Prevent Digestion")
				user.vore_flags &= ~DIGESTABLE
				user.client.prefs.vore_flags &= ~DIGESTABLE

	if(href_list["toggledvor"])
		var/choice = alert(user, "This button is for those who don't like vore at all. Devouring you is currently: [(user.vore_flags & DEVOURABLE) ? "Allowed" : "Prevented"]", "", "Allow Devourment", "Cancel", "Prevent Devourment")
		if(!user || !user.client)
			return
		switch(choice)
			if("Cancel")
				return FALSE
			if("Allow Devourment")
				user.vore_flags |= DEVOURABLE
				user.client.prefs.vore_flags |= DEVOURABLE
			if("Prevent Devourment")
				user.vore_flags &= ~DEVOURABLE
				user.client.prefs.vore_flags &= ~DEVOURABLE

	if(href_list["toggledfeed"])
		var/choice = alert(user, "This button is to toggle your ability to be fed to others. Feeding predators is currently: [(user.vore_flags & FEEDING) ? "Allowed" : "Prevented"]", "", "Allow Feeding", "Cancel", "Prevent Feeding")
		if(!user || !user.client)
			return
		switch(choice)
			if("Cancel")
				return FALSE
			if("Allow Feeding")
				user.vore_flags |= FEEDING
				user.client.prefs.vore_flags |= FEEDING
			if("Prevent Feeding")
				user.vore_flags &= ~FEEDING
				user.client.prefs.vore_flags &= ~FEEDING

	if(href_list["toggledlickable"])
		var/choice = alert(user, "This button is to toggle your ability to be licked. Being licked is currently: [(user.client.prefs.vore_flags & LICKABLE) ? "Allowed" : "Prevented"]", "", "Allow Licking", "Cancel", "Prevent Licking")
		if(!user || !user.client)
			return
		switch(choice)
			if("Cancel")
				return FALSE
			if("Allow Licking")
				user.client.prefs.vore_flags |= LICKABLE
			if("Prevent Licking")
				user.client.prefs.vore_flags &= ~LICKABLE

	//Refresh when interacted with, returning 1 makes vore_look.Topic update
	return TRUE
