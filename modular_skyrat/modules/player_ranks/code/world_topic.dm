
/datum/world_topic/set_player_rank
	keyword = "set_player_rank"
	require_comms_key = TRUE

/datum/world_topic/set_player_rank/Run(list/input)
	. = list()

	var/sender_discord_id = input["sender_discord_id"]

	if(!sender_discord_id)
		.["success"] = FALSE
		.["message"] = "Invalid sender Discord ID, this should not be happening! Report this immediately!"
		return

	var/target_ckey = ckey(input["target_ckey"])

	if(!target_ckey)
		.["success"] = FALSE
		.["message"] = "Invalid target ckey provided."
		return

	var/sender_ckey = ckey(SSdiscord.lookup_ckey(sender_discord_id))

	if(!sender_ckey)
		.["success"] = FALSE
		.["message"] = "No ckey was found to be attached to the provided Discord account ID, **[sender_discord_id]**. Please verify your Discord account following the instructions of the in-game verb before trying this command again."
		return

	var/datum/admins/linked_admin_holder = GLOB.admin_datums[sender_ckey] || GLOB.deadmins[sender_ckey]

	if(!linked_admin_holder)
		.["success"] = FALSE
		.["message"] = "No valid admin datum was found associated with the ckey associated to your Discord account."
		return

	if(!linked_admin_holder.check_for_rights(R_PERMISSIONS))
		.["success"] = FALSE
		.["message"] = "You do not possess the permissions to execute this command."
		return

	var/target_rank = input["target_rank"]

	if(!target_rank)
		.["success"] = FALSE
		.["message"] = "Invalid target rank provided."
		return

	target_rank = capitalize(target_rank)

	var/desired_rank_status = !!text2num(input["desired_rank_status"])

	if(desired_rank_status)
		var/result = SSplayer_ranks.add_player_to_group(linked_admin_holder, target_ckey, target_rank)

		.["success"] = !!result
		.["message"] = result ? "**[linked_admin_holder.target]** successfully added **[target_rank]** status to **[target_ckey]**." : "**[linked_admin_holder.target]** was unable to add **[target_rank]** status to **[target_ckey]**. Please verify that you entered their ckey correctly and that they did not already possess that status before trying again. Use the in-game verb to get more information if you keep on receiving this error."
		message_admins(replacetext(.["message"], "*", ""))
		return

	else
		var/result = SSplayer_ranks.remove_player_from_group(linked_admin_holder, target_ckey, target_rank)

		.["success"] = !!result
		.["message"] = result ? "**[linked_admin_holder.target]** successfully removed **[target_rank]** status from **[target_ckey]**." : "**[linked_admin_holder.target]** was unable to remove **[target_rank]** status from **[target_ckey]**. Please verify that you entered their ckey correctly and that they did possess that status before trying again. Use the in-game verb to get more information if you keep on receiving this error."
		message_admins(replacetext(.["message"], "*", ""))
		return
