
/datum/world_topic/set_player_rank
	keyword = "set_player_rank"
	require_comms_key = TRUE

/datum/world_topic/set_player_rank/Run(list/input)
	var/sender_discord_id = input["sender_discord_id"]

	if(!sender_discord_id)
		return

	var/target_ckey = ckey(input["target_ckey"])

	if(!target_ckey)
		return "Invalid target ckey provided."

	var/sender_ckey = ckey(SSdiscord.lookup_ckey(sender_discord_id))

	if(!sender_ckey)
		return "No ckey was found to be attached to this Discord account. Please verify your Discord account following the instructions of the in-game verb before trying this command again."

	var/datum/admins/linked_admin_holder = GLOB.admin_datums[sender_ckey] || GLOB.deadmins[sender_ckey]

	if(!linked_admin_holder)
		return "No valid admin datum was found associated with the ckey associated to your Discord account."

	if(!linked_admin_holder.check_for_rights(R_PERMISSIONS))
		return "You do not possess the permissions to execute this command."

	var/target_rank = input["target_rank"]

	if(!target_rank)
		return "Invalid target rank provided."

	target_rank = capitalize(target_rank)

	var/desired_rank_status = !!input["desired_rank_status"]

	if(desired_rank_status)
		var/result = SSplayer_ranks.add_player_to_group(linked_admin_holder, target_ckey, target_rank)

		return result ? "Successfully added **[target_rank]** status to **[target_ckey]**." : "Unable to add **[target_rank]** status to **[target_ckey]**. Please verify that you entered their ckey correctly and that they did not already possess that status before trying again. Use the in-game verb to get more information if you keep on receiving this error."

	else
		var/result = SSplayer_ranks.remove_player_from_group(linked_admin_holder, target_ckey, target_rank)

		return result ? "Successfully removed **[target_rank]** status from **[target_ckey]**." : "Unable to remove **[target_rank]** status from **[target_ckey]**. Please verify that you entered their ckey correctly and that they did possess that status before trying again. Use the in-game verb to get more information if you keep on receiving this error."

