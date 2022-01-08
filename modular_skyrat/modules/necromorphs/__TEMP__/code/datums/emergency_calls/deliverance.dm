/*
	Emergency Call
*/
/datum/emergency_call/deliverance
	name = "Unitologist"
	pref_name = "Unitologist Missionary"
	weight = 1
	landmark_tag = "unitologiststeam"
	antag_id = ERT_UNITOLOGY

/*
	Antagonist
*/

/datum/antagonist/ert/unitologists
	id = ERT_UNITOLOGY
	role_text = "Unitologist Pilgrim"
	role_text_plural = "Unitologist Pilgrims"
	antag_text = "You are part of a new religion which worships strange alien artifacts, believing that only through them can humanity truly transcend. You have been blessed with a psychic connection created by the <b>marker</b>, one of these artifacts. Serve the marker's will at all costs by bringing it human sacrifices and remember that its objectives come before your own..."
	leader_welcome_text = "You are the leader of the Holy Ship Deliverance. You answer only to the call of the marker. You are here to ensure that everyone aboard Ishimura becomes a glorious sacrifice"
	welcome_text = "You are a disciple aboard the Holy Ship Deliverance. You answer only to the call of the marker, and your comrades. You are here to ensure that everyone aboard Ishimura becomes a glorious sacrifice"

	landmark_id = "unitologiststeam"
	antaghud_indicator = "hudunitologist" // Used by the ghost antagHUD.
	antag_indicator = "hudunitologist"// icon_state for icons/mob/mob.dm visual indicator.
	outfits = list(
		/decl/hierarchy/outfit/faithful,
		/decl/hierarchy/outfit/healer,
		/decl/hierarchy/outfit/mechanic,
		/decl/hierarchy/outfit/berserker,
		/decl/hierarchy/outfit/deacon)


	//Unitology gets completely random outfits once the team is filled
	fallback_outfits = list(
		/decl/hierarchy/outfit/faithful,
		/decl/hierarchy/outfit/healer,
		/decl/hierarchy/outfit/mechanic,
		/decl/hierarchy/outfit/berserker,
		/decl/hierarchy/outfit/deacon)
