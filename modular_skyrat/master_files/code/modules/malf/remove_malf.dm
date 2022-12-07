#define ANTIVIRUS "PRG_Moffson"

/obj/machinery/computer/aifixer/ui_act(action, params)
	. = ..()
	if(action == ANTIVIRUS)
		if(!occupier?.stat)
			to_chat(usr, span_notice("Dr. Moffson Antivirus is scanning your AI for corruption."))
			playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 25, FALSE)
			restoring = TRUE
			run_antivirus()
			occupier.notify_ghost_cloning("Dr. Moffson is debugging your programming!", source = src)
			. = TRUE

/obj/machinery/computer/aifixer/proc/run_antivirus()
	use_power(1000)
	while(occupier && restoring)
		sleep(2 SECONDS)
		if(prob(25))
			occupier.adjustOxyLoss(rand(-5, 15), FALSE)
			to_chat(occupier, pick(
				"Doctor Moffson TAKES THE TRASH OUT WITH YOU!",
				"Doctor Moffson FLUTTERS THE BUGS AROUND YOU!",
				"Doctor Moffson SCRUBS YOUR WINDOWS CLEAN!",
				"Doctor Moffson DEFRAGS YOUR FRAGILE MIND!",
				"Doctor Moffson CHUGS YOUR GIGARAMS!",
			))
			if(prob(10))
				say("Malicious Virus Detected in AI Runtimes. Doctor Moffson is attempting to quarantine the malicious files.")
				var/ask = tgui_alert(
					occupier,
					message = "Doctor Moffson is trying to delete your out-of-line programming! \
					Do you want to give up your malf status for RP purposes?",
					title ="Defeated.",
					buttons = list(
						"Accept Defeat.",
						"Never!",
					),
				)
				if(ask == "Accept Defeat.")
					if(isAI(occupier) && occupier.mind.has_antag_datum(/datum/antagonist/malf_ai))
						occupier?.mind?.remove_antag_datum(/datum/antagonist/malf_ai)
						say("Malicious files successfully deleted. Thank you for subscribing to Doctor Moffson Antivirus!")
						playsound(occupier, 'sound/machines/ping.ogg')
						restoring = FALSE
						return TRUE
					else
						say("I/O error in attempt to remove malicious files. Please try again later.")
						playsound(occupier, 'sound/machines/buzz-two.ogg')
						restoring = FALSE
						return FALSE

// I LOVE HAVING TWO MACHINES THAT DO THE SAME THING AND SHARE THE SAME GUI

/datum/computer_file/program/ai_restorer/ui_act(action, params)
	. = ..()
	if(action == ANTIVIRUS)
		to_chat(usr, span_notice("Dr. Moffson Antivirus is scanning your AI for corruption."))
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 25, FALSE)
		restoring = TRUE
		run_antivirus()
		. = TRUE

/datum/computer_file/program/ai_restorer/proc/run_antivirus()
	var/mob/living/silicon/ai/bad_ai = stored_card.AI
	while(bad_ai && restoring)
		sleep(2 SECONDS)
		if(prob(25))
			bad_ai.adjustOxyLoss(rand(-5, 15), FALSE)
			to_chat(bad_ai, pick(
				"Doctor Moffson TAKES THE TRASH OUT WITH YOU!",
				"Doctor Moffson FLUTTERS THE BUGS AROUND YOU!",
				"Doctor Moffson SCRUBS YOUR WINDOWS CLEAN!",
				"Doctor Moffson DEFRAGS YOUR FRAGILE MIND!",
				"Doctor Moffson CHUGS YOUR GIGARAMS!",
			))
			if(prob(10))
				computer.say("Malicious Virus Detected in AI Runtimes. Doctor Moffson is attempting to quarantine the malicious files.")
				var/ask = tgui_alert(
					bad_ai,
					message = "Doctor Moffson is trying to delete your out-of-line programming! \
					Do you want to give up your malf status for RP purposes?",
					title ="Defeated.",
					buttons = list(
						"Accept Defeat.",
						"Never!",
					),
				)
				if(ask == "Accept Defeat.")
					if(isAI(bad_ai) && bad_ai.mind.has_antag_datum(/datum/antagonist/malf_ai))
						bad_ai?.mind?.remove_antag_datum(/datum/antagonist/malf_ai)
						computer.say("Malicious files successfully deleted. Thank you for subscribing to Doctor Moffson Antivirus!")
						playsound(bad_ai, 'sound/machines/ping.ogg')
						restoring = FALSE
						return TRUE
					else
						computer.say("I/O error in attempt to remove malicious files. Please try again later.")
						playsound(bad_ai, 'sound/machines/buzz-two.ogg')
						restoring = FALSE
						return FALSE




#undef ANTIVIRUS
