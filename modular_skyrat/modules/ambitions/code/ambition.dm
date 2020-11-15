#define AMBITION_INTENSITY_MILD 2
#define AMBITION_INTENSITY_MEDIUM 4
#define AMBITION_INTENSITY_SEVERE 10
#define AMBITION_INTENSITY_EXTREME 15

/datum/ambitions
	///Reasons of why would you act in antagonic ways
	var/narrative = ""
	///List of your objectives, in string form
	var/list/objectives = list()
	///Chosen intensity of your antagonism
	var/intensity = AMBITION_INTENSITY_MILD
	///Note in which you can optionally write out your vision/reasonings, useful if you want it to get reviewed
	var/note_to_admins = ""
	///Whether it was submitted or not
	var/submitted = FALSE
	///Whether we requested an admin review
	var/admin_review_requested = FALSE
	///Whether an admin approved our ambitions.
	var/admin_approval = FALSE
	///If we changed our ambitions after approval
	var/changed_after_approval = FALSE
	///Log of changes made to the ambitions
	var/list/log = list()
	///The mind the ambitions belong to
	var/datum/mind/my_mind

/datum/ambitions/New(datum/mind/M)
	my_mind = M

/datum/ambitions/proc/ShowPanel(mob/user, admin_view = FALSE)
	if(!user || !user.client)
		return
	var/list/dat = list("<center>")
	dat += "<b>Antagonists are supposed to provide excitement and intrigue, drive a story with the crew, and provide fun and interesting experience for people involved. <BR> Remember, it's not about winning or losing, but about the story and interactions, this is a roleplay server.</b><BR><BR>"
	dat += "<i>Here you write your ambitions for your antagonist round! Ambitions are your motive and what you plan to accomplish throught the round.</i>"
	dat += "<BR><i>After filling all things out and submitting your ambition, your uplink/powers will unlock.</i>"
	dat += "<BR><i>If you can't come up with anything, use a <b>template</b>, and if you don't know if your ambition are proper, or too extreme, <b>request admin review</b>.</i>"
	dat += "<BR><i>You can still edit them post submission.</i>"
	dat += "<BR><b><font color='#FF0000'>If your ambitions are nonsensical, you may be subjected to an antagonist ban.</font></b>"
	dat += "<center><a href='?src=[REF(src)];pref=submit'>Choose template</a> <a href='?src=[REF(src)];pref=submit'>Request admin review</a></center>"
	dat += "<HR>"
	dat += "<h3>Narrative:</h3>"
	dat += "<i>Here you set your narrative. It's the reason on why you're doing antagonistic things. Perhaps you need money for personal reasons, or you were contracted to do someone's dirty work, or want to take down the BigPharma.</i>"
	dat += "<BR><table align='center'; width='100%'; style='background-color:#13171C'><tr><td><center>"
	if(narrative == "")
		dat += "<font color='#CCCCFF'><b>Please set your narrative!</b><font>"
	else
		dat += narrative
	dat += "</center><center><a href='?src=[REF(src)];pref=submit'>Set your narrative</a></center>"
	dat += "</td></tr></table>"
	dat += "<BR>"
	dat += "<h3>Objectives:</h3>"
	dat += "<i>Here you add your objectives. Think about them as milestones to your narratives.</i>"
	dat += "<BR><table align='center'; width='100%'; style='background-color:#13171C'>"
	if(length(objectives))
		var/even = TRUE
		for(var/objectiv in objectives)
			even = !even
			var/bg_color = "#23273C"
			if(even)
				bg_color = "#19222C"
			dat += "<tr style='background-color:[bg_color]'><td><center> * [objectiv] <a href='?src=[REF(src)];pref=submit'>Edit</a> <a href='?src=[REF(src)];pref=submit'>Remove</a></center></td></tr>"
	else
		dat += "<tr><td><center><font color='#CCCCFF'><b>Please add atleast one objective!</b><font></center></td></tr>"
	dat += "<tr><td><center><a href='?src=[REF(src)];pref=submit'>Add new objective</a></center></td></tr>"
	dat += "</table>"
	dat += "<BR>"
	dat += "<h3>Intensity:</h3>"
	dat += "<i>Set the estimated intensity of your ambitions, this helps the admins gauge on how chaotic a round may be. Please set it accordingly.</i>"
	dat += "<table>"
	dat += "<tr><td width=15%></td><td width=85%></td></tr>"
	for(var/i in 1 to 4)
		var/current_spice
		switch(i)
			if(1)
				current_spice = AMBITION_INTENSITY_MILD
			if(2)
				current_spice = AMBITION_INTENSITY_MEDIUM
			if(3)
				current_spice = AMBITION_INTENSITY_SEVERE
			if(4)
				current_spice = AMBITION_INTENSITY_EXTREME
		var/active = (current_spice == intensity)
		var/spice_link = active ? "class='linkOn'" : "href='?src=[REF(src)];pref=spice;amount=[current_spice]'"
		var/spice_name
		var/spice_desc
		var/spice_color
		switch(current_spice)
			if(AMBITION_INTENSITY_MILD)
				spice_name = "Mild"
				spice_desc = "Thievery and vandalism"
				spice_color = "#fcdf03"
			if(AMBITION_INTENSITY_MEDIUM)
				spice_name = "Medium"
				spice_desc = "Mugging, beating people, general thuggery."
				spice_color = "#fcb103"
			if(AMBITION_INTENSITY_SEVERE)
				spice_name = "Severe"
				spice_desc = "Station sabotage and occasional manslaughter"
				spice_color = "#fc8c03"
			if(AMBITION_INTENSITY_EXTREME)
				spice_name = "Extreme"
				spice_desc = "Grand sabotage and indiscriminate murder"
				spice_color = "#fc5603"
		dat += "<tr style='background-color:[spice_color]'><td><a [spice_link]>[spice_name]</a></td><td><center><i><font color='#000000'><b>[spice_desc]</b></font></i></center></td></tr>"
	dat += "</table>"
	dat += "<HR>"
	dat += "<h3>Note to Admin (optional):</h3>"
	dat += "<i>If you want to request a review, you can set this to explain your reasoning or what experience you hope to bring to the station.</i>"
	dat += "<BR><table align='center'; width='100%'; style='background-color:#13171C'><tr><td><center>"
	dat += note_to_admins
	dat += "</center><BR><center><a href='?src=[REF(src)];pref=submit'>Edit your note to admin</a></center>"
	dat += "</td></tr></table>"
	dat += "<HR>"
	if(!submitted)
		dat += "<center><a href='?src=[REF(src)];pref=submit'>Submit</a></center>"
	else
		dat += "<center><b>You've already submitted your ambitions, but feel free to edit them</b></center>"

	winshow(user, "ambition_window", TRUE)
	var/datum/browser/popup = new(user, "ambition_window", "<div align='center'>Ambitions</div>", 950, 750)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(user, "ambition_window", src)

/mob/proc/view_ambitions()
	set name = "View Ambitions"
	set category = "IC"
	set desc = "View and edit your character's ambitions."
	if(!mind)
		return
	if(!mind.my_ambitions)
		return
	mind.my_ambitions.ShowPanel(src)

#undef AMBITION_INTENSITY_MILD
#undef AMBITION_INTENSITY_MEDIUM
#undef AMBITION_INTENSITY_SEVERE
#undef AMBITION_INTENSITY_EXTREME
