// For modularity, we hook into the update_explanation_text to be sure we have a target to register.
/datum/objective/assassinate/update_explanation_text()
	RegisterSignal(target, COMSIG_LIVING_DEATH, .proc/register_target_death)
	return ..()

/datum/objective/assassinate/proc/register_target_death(mob/living/dead_guy, gibbed)
	SIGNAL_HANDLER
	completed = TRUE
	UnregisterSignal(dead_guy, COMSIG_LIVING_DEATH)

/datum/objective/download
	name = "download"

/datum/objective/download/proc/gen_amount_goal()
	target_amount = rand(20,40)
	update_explanation_text()
	return target_amount

/datum/objective/download/update_explanation_text()
	..()
	explanation_text = "Download [target_amount] research node\s."

/datum/objective/download/check_completion()
	var/datum/techweb/checking = new
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/owner in owners)
		if(ismob(owner.current))
			var/mob/mob_owner = owner.current //Yeah if you get morphed and you eat a quantum tech disk with the RD's latest backup good on you soldier.
			if(ishuman(mob_owner))
				var/mob/living/carbon/human/human_downloader = mob_owner
				if(human_downloader && (human_downloader.stat != DEAD) && istype(human_downloader.wear_suit, /obj/item/clothing/suit/space/space_ninja))
					var/obj/item/clothing/suit/space/space_ninja/ninja_suit = human_downloader.wear_suit
					ninja_suit.stored_research.copy_research_to(checking)
			var/list/otherwise = mob_owner.get_contents()
			for(var/obj/item/disk/tech_disk/dat_fukken_disk in otherwise)
				dat_fukken_disk.stored_research.copy_research_to(checking)
	return checking.researched_nodes.len >= target_amount

/datum/objective/download/admin_edit(mob/admin)
	var/count = input(admin,"How many nodes ?","Nodes",target_amount) as num|null
	if(count)
		target_amount = count
	update_explanation_text()
