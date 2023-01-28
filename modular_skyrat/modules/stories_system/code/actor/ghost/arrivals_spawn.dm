/datum/story_actor/ghost/spawn_in_arrivals
	name = "Spawn In Arrivals template"

/datum/story_actor/ghost/spawn_in_arrivals/send_them_in(mob/living/carbon/human/to_send_human)
	to_send_human.client?.prefs?.safe_transfer_prefs_to(to_send_human)
	. = ..()
	var/atom/spawn_location = SSjob.get_last_resort_spawn_points()
	spawn_location.JoinPlayerHere(to_send_human, TRUE) // This will drop them on the arrivals shuttle, hopefully buckled to a chair. Worst case, they go to the error room.

/datum/story_actor/ghost/spawn_in_arrivals/tourist
	name = "Obnoxious Tourist"
	actor_outfits = list(
		/datum/outfit/tourist,
	)
	actor_info = "After saving up your hard earned money, you're so excited to be here on the frontier as a tourist! You've dreamed of being out here for years, and now you can \
	finally make it happen. You're coming into the station on the arrivals shuttle now, so get ready for the vacation day of a lifetime!"
	actor_goal = "Explore the station! Partake in the sights! Be an annoying tourist who takes photos of everything! Ask the crew stupid repetitive questions they've heard \
	thousands of times!"

/datum/story_actor/ghost/spawn_in_arrivals/tourist/syndicate
	name = "\"Tourist\""
	actor_info = "To the station, you're just another jackass tourist with a photocamera and a fat stack of cash. In reality, you're an agent of the Syndicate, sent to gather \
	intelligence on the crew and what they're working on to pass to your corporate overlords after you depart."
	actor_goal = "Find and photograph sensitive Nanotrasen equipment and documents. Interrogate the crew for classified details about their research and work. \
	Be a shifty character who asks too many questions, but try not to get caught."

/datum/story_actor/ghost/spawn_in_arrivals/tourist/broke
	name = "Broke Tourist"
	actor_outfits = list(
		/datum/outfit/tourist/broke,
	)
	actor_info = "After saving up your hard earned money, you're so excited to be here on the frontier as a tourist! You've dreamed of being out here for years, and now you can \
	finally make it happen. You're coming into the station on the arrivals shuttle now, so get ready for the vacation day of a lifetime!\n\n\
	At least, that's what you would be saying, if you hadn't lost most of your money at that casino last night. Unfortunately for you, you're dirt broke. However, \
	Nanotrasen has a low tolerance for broke tourists. Do your best to conceal your lack of wealth while still flaunting how rich and touristy you are!"
	actor_goal = "Explore the station! Partake in the sights! Be an annoying tourist who takes photos of everything! Ask the crew stupid repetitive questions they've heard \
	thousands of times! Don't get caught being broke! Flaunt your wealth that you don't actually have!"

/datum/story_actor/ghost/spawn_in_arrivals/tourist/wealthy
	name = "Wealthy Tourist"
	actor_outfits = list(
		/datum/outfit/tourist/wealthy,
	)
	actor_info = "After saving up your hard earned money, you're so excited to be here on the frontier as a tourist! You've dreamed of being out here for years, and now you can \
	finally make it happen. You're coming into the station on the arrivals shuttle now, so get ready for the vacation day of a lifetime!\n\n\
	The best part? You won the lottery recently and walked away with a solid 10 grand in credits! As a newly filthy rich tourist, it's your solemn duty to \
	be obnoxiously rich. Purchase expensive liquors. Flaunt your wealth, and be an obnoxious braggart about how lucky you are to have so much cash!"
	actor_goal = "Explore the station! Partake in the sights! Be an annoying tourist who takes photos of everything! Ask the crew stupid repetitive questions they've heard \
	thousands of times! Flaunt your excessive wealth! Brag about how rich and powerful you are! Face the consequences of being an annoying rich dickwad!"

/datum/story_actor/ghost/spawn_in_arrivals/tourist/monolingual
	name = "Monolingual Tourist"
	actor_info = "After saving up your hard earned money, you're so excited to be here on the frontier as a tourist! You've dreamed of being out here for years, and now you can \
	finally make it happen. You're coming into the station on the arrivals shuttle now, so get ready for the vacation day of a lifetime!\n\n\
	However, there's one small hitch. You didn't bother to learn anything about the local language in this sector of space, like, at all. Clearly, this isn't a problem for you, \
	it's a problem for the locals to resolve for you. Perhaps if you speak slowly and louder whenever they don't understand you? It's not your fault they don't know your language!"
	actor_goal = "Explore the station! Partake in the sights! Be an annoying tourist who takes photos of everything! Ask the crew stupid repetitive questions they've heard \
	thousands of times! Cause problems with your language barrier! Be an obnoxious tourist who didn't learn anything about the language before coming here! Blame the crew \
	for not accomodating to your inability to speak their language!\n\n\
	NOTE: Common will be removed from your character when you spawn on the station. Have a backup language selected that you will be using as your primary language to communicate with."

/datum/story_actor/ghost/spawn_in_arrivals/tourist/monolingual/send_them_in(mob/living/carbon/human/to_send_human)
	. = ..()
	to_send_human.remove_language(/datum/language/common) // good luck

/datum/story_actor/ghost/spawn_in_arrivals/salaryman_drinking_with_boss
	name = "Salaryman"
	actor_outfits = list(
		/datum/outfit/salaryman,
	)
	actor_info = "After a long 14 hour shift at the company, it's time to go out for after-shift drinks with your coworkers and the Boss, %BOSS_NAME%. \
	It's part of the job. To not drink with your boss would be a massive faux pas, and could result in disciplinary action at work. Your boss decided that he wants \
	drinks at this ramdom fringe station, so you and your coworkers are tagging along as is required. Maybe you can find a nice gift for your significant other here \
	to bring home and apologize for the long hours you've been working recently."
	actor_goal = "Hang out with your boss and coworkers at the bar. Drink heavily, but keep pace with the boss, %BOSS_NAME%'s drinking. If he drinks, you drink. \
	If he leaves, you leave. It's not a great life, but it's the life you have. Try to get some stress relief in. Commiserate with your coworkers on the situation without \
	offending the boss. Find a nice gift to bring back to your significant other when you leave."

/datum/story_actor/ghost/spawn_in_arrivals/salaryman_drinking_with_boss/send_them_in(mob/picked_spawner, datum/story_type/current_story)
	. = ..()
	var/datum/story_type/unimpactful/drinking_with_the_boss/drinking_with_the_boss = involved_story
	actor_info = replacetext(actor_info, "%BOSS_NAME%", drinking_with_the_boss?.boss?.real_name)
	actor_goal = replacetext(actor_goal, "%BOSS_NAME%", drinking_with_the_boss?.boss?.real_name)

/datum/story_actor/ghost/spawn_in_arrivals/salaryman_boss
	name = "Salaryman's Boss"
	actor_outfits = list(
		/datum/outfit/salaryman/boss,
	)
	actor_info = "After a short 14 hour shift at the company, it's time to go out for after-shift drinks with your subordinates, as is tradition for the company. \
	This classic team building exercise you commit every night with your employees is an important part of the corporate lifestyle, and it's important that you hold up \
	this tradition to set an example for your subordinates. Tonight you will drink, be merry, and be jovial, all while reminding your employees who they work for and who \
	signs their checks. The staff at this location are here to serve you, and if they give you shit, remind them of the respect you deserve as a high level executive of \
	a Fortune 500 company in the Spinward Stellar Coalition."
	actor_goal = "Drink with your subordinates at the bar, and consume good food. When you drink, they will drink as well. Deviation from this tradition is to be frowned upon. \
	Remind your employees how much they should be respecting you for this opportunity. Demand the staff of the station treat you with the same level of respect. Be an annoying \
	boss. Establish your authority as the most important person in the room at all times."

/datum/story_actor/ghost/spawn_in_arrivals/salaryman_boss/send_them_in(mob/living/carbon/human/to_send_human)
	. = ..()
	var/datum/story_type/unimpactful/drinking_with_the_boss/drinking_story = involved_story
	drinking_story.boss = to_send_human

/datum/story_actor/ghost/spawn_in_arrivals/shore_leave
	name = "Shore Leave Sailor"
	actor_outfits = list(
		/datum/outfit/centcom/naval/ensign,
	)
	actor_info = "You've been working on a ship for the last year with no shore leave. Finally, your ship's docked at a NT station and you and your buddies finally have some \
	well deserved shore leave. Find some good booze, find some good food, and get some R&R in with the boys. Cut loose, let off some steam, and be a proud navy man!"
	actor_goal = "Get drunk with the boys. Have some good fucking food at the kitchen. Be rowdy and merry. Get into fights, be a nuisance, be obnoxious to the station. \
	Avoid getting thrown in the brig so that your commanding officer doesn't have to bail you out."

/datum/story_actor/ghost/spawn_in_arrivals/small_business_owner
	name = "Small Business Owner"
	actor_outfits = list(
		/datum/outfit/small_business_owner,
	)
	actor_info = "After a small loan of a million credits from your dear old dad, you're finally ready to start your dream small business. You got a sweet deal on this \
	prime piece of real estate in the middle of the hallways on this Nanotrasen station, and after all's said and done you've got 100,000 credits remaining to pay the \
	construction team you've hired, pay any staff you need to hire, and handle any business with the station locals. However, remember to keep a healthy paycheck for yourself, \
	after all, where would this business be without your economic genius?"
	actor_goal = "Come up with a genius business plan. Have your construction workers pick a high traffic part of the hallways to construct your business in, \
	in a manner that requires the crew to traverse through your business and the construction site to get around the station. \
	Pay the construction workers as little as possible to keep them working on the construction of the business. \
	Be an aggressively proud capitalist. Employ people on the station to work in your business for as little as possible. \
	Negotiate with the annoying union rep the construction workers brought with them. Ensure your business gets as much traffic as possible."

/datum/story_actor/ghost/spawn_in_arrivals/construction_foreman
	name = "Construction Foreman"
	actor_outfits = list(
		/datum/outfit/construction_worker/foreman,
	)
	actor_info = "You've spent the last 15 years running the finest construction contractors in the frontier. Today, some rich kid walked up to you and said they wanted to \
	pay your team to build a \"groundbreaking new business on the most valuable real estate in the area\" and after some contract negotiations with the assistance of your \
	union representative, you've secured a contract for you and three of your best workers to accompany him to the property and start construction right away. He didn't \
	mention the job was on a Nanotrasen station until you arrived. Best of luck to you and your workers."
	actor_goal = "Direct your construction team. Work with the Union Rep to ensure safe practices are being followed. Work with the Small Business Owner to get your men paid for \
	their work. Construct whatever hare brained scheme the Small Business Owner comes up with."

/datum/story_actor/ghost/spawn_in_arrivals/construction_worker
	name = "Construction Worker"
	actor_outfits = list(
		/datum/outfit/construction_worker,
	)
	actor_info = "You're a contract construction worker under a foreman you trust and respect. They've never led you astray in the past, but this new job seems a bit \
	suspect. The customer's a bit of an idiot capitalist, and your union rep has concerns. However, he's adamant he's good for the money, so trust in the boss and \
	we'll all get paid."
	actor_goal = "Work with your Foreman. Build shit. Get paid. Go on your union mandated lunches and breaks and union meetings when needed. Be a hard working union man."

/datum/story_actor/ghost/spawn_in_arrivals/union_rep
	name = "Construction Union Representative"
	actor_outfits = list(
		/datum/outfit/construction_worker/union_rep,
	)
	actor_info = "You're a union represenative for Construction Workers and Service Employees Union Local 132, and you're goddamn proud of the union. However, you're worried \
	this new small business owner might cause problems for your fellow union workers. Make sure that capitalist bastard follows the rules, and that the employees get their \
	mandated hours, their mandated breaks, their mandated lunches, and most of all, their mandated pay. Although, the local Nanotrasen employees seem to be without a union. \
	Perhaps it'd be worth your time to get them involved in the galactic struggle for workers' rights?"
	actor_goal = "Stand up for the rights of your fellow union spacers. Keep tabs on the construction and treatment of the workers and make sure everything's to union code. \
	Recruit Nanotrasen employees to join the union, along with anyone that scumbag Small Business Owner hires. Do everything in your power to ensure the union protects \
	its' workers."

/datum/story_actor/ghost/spawn_in_arrivals/middle_management
	name = "Middle Management"
	actor_outfits = list(
		/datum/outfit/middle_management,
	)
	actor_info = "After years in business schooling, years of middle management in Nanotrasen, and delivering on KPI growth quarter by quarter every time, Nanotrasen has seen fit \
	to send you to fix this underperforming department in their station program. Today, you'll be managing %DEPARTMENT%. Once you arrive, it's time to work your magic and turn this \
	underperforming, unprofitable, and budget draining mess into a high quality profit earning team of high energy full time employees. Do whatever it takes to turn a profit and make \
	this department a successful business venture."
	actor_goal = "Go to and be annoying middle management in %DEPARTMENT%. Hold meetings. Drink coffee. Assign people to tasks. \
	Deploy management philsophies to develop client-centric solutions. Run the department like a business, to turn a profit. \
	Talk like an annoying management person all the time. Circle back with employees. Touch bases with problem team members. \
	Identify actionable success metrics, and action on them.\n\n\
	NOTE: Think about some of the worst managers you've ever had in your jobs over the years. Be like them."
	var/department = "Debug Department, File A Bug Report If You See This"

/datum/story_actor/ghost/spawn_in_arrivals/middle_management/handle_spawning(mob/picked_spawner, datum/story_type/current_story)
	actor_info = replacetext(actor_info, "%DEPARTMENT%", department)
	actor_goal = replacetext(actor_goal, "%DEPARTMENT%", department)
	return ..()


/datum/story_actor/ghost/spawn_in_arrivals/middle_management/security
	actor_outfits = list(/datum/outfit/middle_management/security)
	department = "Security"

/datum/story_actor/ghost/spawn_in_arrivals/middle_management/science
	actor_outfits = list(/datum/outfit/middle_management/science)
	department = "Science"

/datum/story_actor/ghost/spawn_in_arrivals/middle_management/service
	actor_outfits = list(/datum/outfit/middle_management/service)
	department = "Service"

/datum/story_actor/ghost/spawn_in_arrivals/middle_management/engineering
	actor_outfits = list(/datum/outfit/middle_management/engineering)
	department = "Engineering"

/datum/story_actor/ghost/spawn_in_arrivals/middle_management/medbay
	actor_outfits = list(/datum/outfit/middle_management/medbay)
	department = "Medbay"

/datum/story_actor/ghost/spawn_in_arrivals/middle_management/cargo
	actor_outfits = list(/datum/outfit/middle_management/cargo)
	department = "Cargo"

/datum/story_actor/ghost/spawn_in_arrivals/med_student
	name = "Medical Student"
	actor_outfits = list(
		/datum/outfit/medical_student,
	)
	actor_info = "You're a first-year medical student from some cushy Spinward university, out on a Nanotrasen station as part of a joint partnership for some hands-on education."
	actor_goal = "Learn from the station's medical department, ask an obnoxious amoount of questions, and act as incompetent at medical work as any first-year student would be."

/datum/story_actor/ghost/spawn_in_arrivals/nri_shore_leave
	name = "Shore Leave NRI Marine"
	actor_outfits = list(
		/datum/outfit/nri_shore_leave,
	)
	actor_info = "You and your comrades thought you were ready for some time off, so you all shared a bottle of vodka and took a small shuttle from your patrol vessel for some \
	well deserved R&R. You found this station out in the middle of nowhere and called it good. After all, everywhere speaks Pan-Slavic, right?"
	actor_goal = "Get even more drunk. Confuse everyone else by only comprehending Space Russian. Potentially cause the start of a war between the NRI and Nanotrasen."

/datum/story_actor/ghost/spawn_in_arrivals/agent
	name = "Agent"
	actor_outfits = list(
		/datum/outfit/story_agent,
	)
	actor_info = "Honestly you've probably screwed the captain's cat on this one.\n\n\
	In an effort to boost your client's sales, you figured a book tour was in order. A visit to inhabitable worlds (and even some inhospitable ones too) didn't do much for royalties,\
	and getting robbed by the space mafia didn't help either. So you signed both your souls away to NanoTrasen in hopes of tapping into the corporate market…\n\n\
	Shame that also means you're working for them now."
	actor_goal = "Survive the shift. Help your client sell their book. Collect your 10% at all costs."

/datum/story_actor/ghost/spawn_in_arrivals/author
	name = "Author"
	actor_outfits = list(
		/datum/outfit/story_author,
	)
	actor_info = "You're not quite sure what drove you to write. An attempt to fulfill a childhood dream? A yearning passion to speak of the burning injustices dominating the galaxy? \
	Or the thought of rolling around in a pile of money? Either way, you've utterly failed in this career thus far. So much so that your agent has signed you up to work on \
	a space station, among the plebs of society. Fantastic. Still, there's an opportunity to sell some books here… and to figure out what to do with your agent."
	actor_goal = "Survive the shift. Sell your books. Figure out what to do with your agent."

/datum/story_actor/ghost/spawn_in_arrivals/author/send_them_in(mob/living/carbon/human/to_send_human)
	. = ..()
	var/datum/story_type/unimpactful/auteurs_in_space/story = involved_story
	var/list/slots = list (
		"backpack" = ITEM_SLOT_BACKPACK,
		"left pocket" = ITEM_SLOT_LPOCKET,
		"right pocket" = ITEM_SLOT_RPOCKET
	)
	for(var/i in 1 to 5)
		var/obj/item/book/authors_book/book = new
		book.book_data = new(story.chosen_book_name, to_send_human.name, "The text is so dense, so unending, that you can't make sense of a single word.")
		to_send_human.equip_in_one_of_slots(book, slots)
