///I couldn't do this via radios. I'll do this via tapes.
///Various announcements and radio transmissions I've copypasted from the Black Mesa, to make the away mission feel more a u t h e n t i c .
///Three EASes for the Vanguard and BMST, three HECU-related ones to tell them they're fucked.

/obj/item/tape/ruins/black_mesa/first_eas	//First EAS record, the local disaster.
	icon_state = "tape_blue"
	desc = "The tape with some signs of date. Probably used by some aspiring wave listener."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>blares, \"<span class=' '>The following message is transmitted at the request of local authorities.</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>states, \"<span class=' '>At 9:47 AM, Mountain Time, a disaster of unknown type has occurred at the Black Mesa Research Facility causing significant damage and failure to various power and communication systems in the surrounding areas.</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>clarifies, \"<span class=' '>An immediate evacuation order has been issued for all residents within a 75 mile radius of the facility, and on-site military has been dispatched to provide assistance.</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>echoes, \"<span class=' '>Make sure to bring an emergency supply of food, water, clothing, first aid kit, flashlights with extra batteries, and battery powered radios.</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>states, \"<span class=' '>Follow local evacuation routes which have been marked by local authorities and only use one vehicle.</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>warns, \"<span class=' '>Do not return to the warning area until the all clear has been given.</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>announces, \"<span class='tape_recorder '>If you are not in the evacuation zone stay where you are.</span>\"</span></span>",
		9 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>announces, \"<span class='tape_recorder '>If you are within the evacuation area and have no transportation locate your nearest police department or military officer.</span>\"</span></span>",
		10 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>announces, \"<span class='tape_recorder '>Do not use telephones or cell phones except in the case of emergencies.</span>\"</span></span>",
		11 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>announces, \"<span class='tape_recorder '>Stay tuned to local news media outlets for further details and information on this situation.</span>\"</span></span>",
		12 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>",
	)
	timestamp = list(
		1 = 0,
		2 = 20,
		3 = 40,
		4 = 80,
		5 = 100,
		6 = 120,
		7 = 140,
		8 = 160,
		9 = 180,
		10 = 200,
		11 = 220,
		12 = 240,
	)

/obj/item/tape/ruins/black_mesa/second_eas	//Second EAS record, the local disaster.
	icon_state = "tape_white"
	desc = "The tape with some markings of blood. Probably used by some (now deceased) radio enthusiast."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>blares, \"<span class=' '>The following message is transmitted at the request of the New Mexico Department of Emergency Services.</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>states, \"<span class=' '>At 9:47 AM, Mountain Standard Time, a disaster of unknown type has occurred at the Black Mesa Research Facility causing significant damage and failure to various power and communication systems in the surrounding areas.</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>clarifies, \"<span class=' '>This message replaces the previous alert, which expires at 10:01 PM Mountain Standard Time, this afternoon.</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>echoes, \"<span class=' '>A full quarantine has been issued for the Black Mesa area. In the interest of public safety, all residents withing a 150-mile radius of Black Mesa, New Mexico, are advised to evacuate the area immediately.</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>states, \"<span class=' '>Take only essential supplies, and a battery-powered radio. Do not use more than one vehicle for traveling.</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>warns, \"<span class=' '>Follow local evacuation routes which have been marked by local authorities.</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>announces, \"<span class='tape_recorder '>If you are within the evacuation area and have no transportation locate your nearest police department.</span>\"</span></span>",
		9 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>states, \"<span class='tape_recorder '>If you begin experiencing a fever, coughing, nausea, dizziness, muscle ache, pneumonia, hair loss, or any such similar ailments...</span>\"</span></span>",
		10 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>blares, \"<span class='tape_recorder '>...please contact your nearest Disease Control Center immediately, as these symptoms may be related to recent events.</span>\"</span></span>",
		11 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>echoes, \"<span class='tape_recorder '>Stay tuned to local media outlets for further information on this ongoing emergency.</span>\"</span></span>",
		12 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>",
	)
	timestamp = list(
		1 = 0,
		2 = 20,
		3 = 40,
		4 = 80,
		5 = 100,
		6 = 120,
		7 = 140,
		8 = 160,
		9 = 180,
		10 = 200,
		11 = 220,
		12 = 240,
	)

/obj/item/tape/ruins/black_mesa/third_eas	//Third EAS record, the global disaster.
	icon_state = "tape_purple"
	desc = "The tape with some... weird vines faintly growing through. Probably used by some alien."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>blares, \"<span class=' '>The following message is transmitted at the request of the United Stated Department of Defense. This is not a test.</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>states, \"<span class=' '>Today, at 4:16 PM Mountain Time, a state of emergency was declared by the President of the United States.</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>clarifies, \"<span class=' '>An unknown hostile force was declared present at the Black Mesa Research Facility, and several other locations in the surronding areas of Black Mesa, New Mexico.</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>echoes, \"<span class=' '>As of 5:42 PM Mountain Time, the President issued executive orders to withdrawl all grounds forces...</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>states, \"<span class=' '>...and begind immediate airstrikes over the Black Mesa Research Facility and surrounding areas, beginning no later than 6:42 PM this evening.</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>warns, \"<span class=' '>For your own safety, an immediate evacuation order has been issued to the entire state of New Mexico.</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>announces, \"<span class='tape_recorder '>To all residents of New Mexico and surrounding areas, leave all your personal belongings. Take a battery-powered radio, and only essential supplies with you.</span>\"</span></span>",
		9 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>states, \"<span class='tape_recorder '>Do not remain in your homes. Seek shelter at your nearest militarized zone outside the state of New Mexico, and awaiy further instructions.</span>\"</span></span>",
		10 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>blares, \"<span class='tape_recorder '>If you cannot find your nearest evacuation route, seek assistance from local authorities immediately.</span>\"</span></span>",
		11 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>echoes, \"<span class='tape_recorder '>If you have military training, firearms training, or any similar weapons training, contract your nearest military officer immediately.</span>\"</span></span>",
		12 = "<span class='game say'><span class='name'>EAS Announcer</span> <span class='message'>clarifies, \"<span class='tape_recorder '>Stay tuned to frequency 740 AM for further updates on this emergency.</span>\"</span></span>",
		13 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>",
	)
	timestamp = list(
		1 = 0,
		2 = 20,
		3 = 40,
		4 = 80,
		5 = 100,
		6 = 120,
		7 = 140,
		8 = 160,
		9 = 180,
		10 = 200,
		11 = 220,
		12 = 240,
		13 = 260,
	)

/obj/item/tape/ruins/black_mesa/first_hecu	//First HECU record, the "You are abandoned" kinda one; meant to be added to SL so they're, you know, informed. And depressed.
	icon_state = "tape_purple"
	desc = "Freshly-recorded tape, it isn't even signed."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>High Command</span> <span class='message'>blares, \"<span class=' '>Come in officer, do you copy? Officer, do you read me?</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>High Command</span> <span class='message'>states, \"<span class=' '>Forget about Freeman! We're abandoning the base!</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>High Command</span> <span class='message'>clarifies, \"<span class=' '>We are cutting our losses and pulling out! Anyone left down there now is on his own!</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>High Command</span> <span class='message'>clarifies, \"<span class=' '>Repeat, if you weren't already evacuated, then you are on your own!</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>",
	)
	timestamp = list(
		1 = 0,
		2 = 20,
		3 = 40,
		4 = 60,
		5 = 80,
		6 = 100,
	)

/obj/item/tape/ruins/black_mesa/second_hecu	//Second HECU record, for Vanguard to know that there's military nearby.
	icon_state = "tape_red"
	desc = "Relatively freshly-recorded taped, signed as \"radio transmission number XX XX.XX.200X\". Date and serial numbers have been scratched beyond recognition. How convenient."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>Echo-5 Bravo</span> <span class='message'>blares, \"<span class=' '>Any station, any station, this is Echo-5 Bravo! Are there any ground assets able to provide support in Sector 8?</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>Echo-5 Bravo</span> <span class='message'>states, \"<span class=' '>Any station, any station, this is Echo-5 Bravo! Are there any ground assets able to provide support in Sector 8? Is anyone reading this?</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>Echo-5 Yankee</span> <span class='message'>states, \"<span class=' '>This is Echo-5 Bravo! No longer in a position to assist. We are moving to LZ Finch!</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>Echo-5 Bravo</span> <span class='message'>clarifies, \"<span class=' '>The hell are you saying? We are freaking surrounded over here!</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>Echo-5 Yankee</span> <span class='message'>clarifies, \"<span class=' '>Push out the the nearest LZ and await further instructions!</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>",
	)
	timestamp = list(
		1 = 0,
		2 = 20,
		3 = 40,
		4 = 80,
		5 = 100,
		6 = 120,
	)

/obj/item/tape/ruins/black_mesa/third_hecu	//Third HECU record, because it's  s a d .
	icon_state = "tape_blue"
	desc = "Blood-covered tape. That's pretty much it."

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>Echo-3 Juliet</span> <span class='message'>blares, \"<span class=' '>Any station, any station, this is Echo-3 Juliet... My team ambushed... I am unjred... I'm losing a lot of blood here. Left leg.</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>Echo-5 Romeo</span> <span class='message'>states, \"<span class=' '>Echo-3 Juliet, this is Echo-5 Romeo. I need you to tie a tourniquet at hand's length above the wound. Get one of your IFAK now.</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>Echo-3 Juliet</span> <span class='message'>states, \"<span class=' '>IFAK's gone.</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>Echo-5 Romeo</span> <span class='message'>clarifies, \"<span class=' '>Say again?</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>Echo-3 Juliet</span> <span class='message'>clarifies, \"<span class=' '>My IFAK's gone... I'm, uhh... *clear falling sounds*</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>Echo-5 Romeo</span> <span class='message'>clarifies, \"<span class=' '>Okay, you're gonna need to find another pack and get a tourniquet out of it.</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>Echo-5 Romeo</span> <span class='message'>clarifies, \"<span class=' '>Are you still there? Echo-3 Juliet, can you hear me?</span>\"</span></span>",
		9 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>",
	)
	timestamp = list(
		1 = 0,
		2 = 10,
		3 = 30,
		4 = 40,
		5 = 50,
		6 = 70,
		7 = 90,
		8 = 110,
		9 = 120,
	)
