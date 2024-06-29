/proc/create_message(type, target_key, admin_ckey, text, timestamp, server, secret, logged = 1, browse, expiry, note_severity)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	if(!type)
		return
	var/target_ckey = ckey(target_key)
	if(!target_key && (type == "note" || type == "message" || type == "watchlist entry"))
		var/new_key = input(usr,"Who would you like to create a [type] for?","Enter a key or ckey",null) as null|text
		if(!new_key)
			return
		var/new_ckey = ckey(new_key)
		var/datum/db_query/query_find_ckey = SSdbcore.NewQuery(
			"SELECT ckey FROM [format_table_name("player")] WHERE ckey = :ckey",
			list("ckey" = new_ckey)
		)
		if(!query_find_ckey.warn_execute())
			qdel(query_find_ckey)
			return
		if(!query_find_ckey.NextRow())
			if(tgui_alert(usr, "[new_key]/([new_ckey]) has not been seen before, are you sure you want to create a [type] for them?", "Unknown ckey", list("Yes", "No", "Cancel")) != "Yes")
				qdel(query_find_ckey)
				return
		qdel(query_find_ckey)
		target_ckey = new_ckey
		target_key = new_key
	if(QDELETED(usr))
		return
	if(!target_key)
		target_key = target_ckey
	if(!admin_ckey)
		admin_ckey = usr.ckey
		if(!admin_ckey)
			return
	if(!target_ckey)
		target_ckey = admin_ckey
	if(!text)
		text = input(usr,"Write your [type]","Create [type]") as null|message
		if(!text)
			return
	if(!server)
		var/ssqlname = CONFIG_GET(string/serversqlname)
		if (ssqlname)
			server = ssqlname
	if(isnull(secret))
		switch(tgui_alert(usr,"Hide note from being viewed by players?", "Secret note?",list("Yes","No","Cancel")))
			if("Yes")
				secret = 1
			if("No")
				secret = 0
			else
				return
	if(isnull(expiry))
		if(tgui_alert(usr, "Set an expiry time? Expired messages are hidden like deleted ones.", "Expiry time?", list("Yes", "No", "Cancel")) == "Yes")
			var/expire_time = input("Set expiry time for [type] as format YYYY-MM-DD HH:MM:SS. All times in server time. HH:MM:SS is optional and 24-hour. Must be later than current time for obvious reasons.", "Set expiry time", ISOtime()) as null|text
			if(!expire_time)
				return
			var/datum/db_query/query_validate_expire_time = SSdbcore.NewQuery(
				"SELECT IF(STR_TO_DATE(:expire_time,'%Y-%c-%d %T') > NOW(), STR_TO_DATE(:expire_time,'%Y-%c-%d %T'), 0)",
				list("expire_time" = expire_time)
			)
			if(!query_validate_expire_time.warn_execute())
				qdel(query_validate_expire_time)
				return
			if(query_validate_expire_time.NextRow())
				var/checktime = text2num(query_validate_expire_time.item[1])
				if(!checktime)
					to_chat(usr, "Datetime entered is improperly formatted or not later than current server time.", confidential = TRUE)
					qdel(query_validate_expire_time)
					return
				expiry = query_validate_expire_time.item[1]
			qdel(query_validate_expire_time)
	if(type == "note" && isnull(note_severity))
		note_severity = input("Set the severity of the note.", "Severity", null, null) as null|anything in list("High", "Medium", "Minor", "None")
		if(!note_severity)
			return
	var/list/parameters = list(
		"type" = type,
		"target_ckey" = target_ckey,
		"admin_ckey" = admin_ckey,
		"text" = text,
		"server_name" = CONFIG_GET(string/serversqlname), // SKYRAT EDIT ADDITION - MULTISERVER
		"server" = server,
		"internet_address" = world.internet_address || "0",
		"port" = "[world.port]",
		"round_id" = GLOB.round_id,
		"secret" = secret,
		"expiry" = expiry || null,
		"note_severity" = note_severity,
	)
	if(timestamp)
		parameters["timestamp"] = timestamp
	var/datum/db_query/query_create_message = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("messages")] (type, targetckey, adminckey, text, timestamp, server, server_ip, server_port, round_id, secret, expire_timestamp, severity, playtime)
		VALUES (:type, :target_ckey, :admin_ckey, :text, [timestamp? ":timestamp" : "Now()"], :server, INET_ATON(:internet_address), :port, :round_id, :secret, :expiry, :note_severity, (SELECT `minutes` FROM [format_table_name("role_time")] WHERE `ckey` = :target_ckey AND `job` = 'Living'))
	"}, parameters)
	var/pm = "[key_name(usr)] has created a [type][(type == "note" || type == "message" || type == "watchlist entry") ? " for [target_key]" : ""]: [text]"
	var/header = "[key_name_admin(usr)] has created a [type][(type == "note" || type == "message" || type == "watchlist entry") ? " for [target_key]" : ""]"
	if(!query_create_message.warn_execute())
		qdel(query_create_message)
		return
	qdel(query_create_message)
	if(logged)
		log_admin_private(pm)
		message_admins("[header]:<br>[text]")
		admin_ticket_log(target_ckey, "<font color='blue'>[header]</font><br>[text]")
		if(browse)
			browse_messages("[type]")
		else
			browse_messages(target_ckey = target_ckey, agegate = TRUE)

/proc/delete_message(message_id, logged = 1, browse)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/type
	var/target_key
	var/text
	var/user_key_name = key_name(usr)
	var/user_name_admin = key_name_admin(usr)
	var/deleted_by_ckey = usr.ckey
	var/datum/db_query/query_find_del_message = SSdbcore.NewQuery(
		"SELECT type, IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey), text FROM [format_table_name("messages")] WHERE id = :id AND deleted = 0",
		list("id" = message_id)
	)
	if(!query_find_del_message.warn_execute())
		qdel(query_find_del_message)
		return
	if(query_find_del_message.NextRow())
		type = query_find_del_message.item[1]
		target_key = query_find_del_message.item[2]
		text = query_find_del_message.item[3]
	qdel(query_find_del_message)
	var/datum/db_query/query_del_message = SSdbcore.NewQuery(
		"UPDATE [format_table_name("messages")] SET deleted = 1, deleted_ckey = :deleted_ckey WHERE id = :id",
		list("deleted_ckey" = deleted_by_ckey, "id" = message_id)
	)
	if(!query_del_message.warn_execute())
		qdel(query_del_message)
		return
	qdel(query_del_message)
	if(logged)
		var/m1 = "[user_key_name] has deleted a [type][(type == "note" || type == "message" || type == "watchlist entry") ? " for" : " made by"] [target_key]: [text]"
		var/m2 = "[user_name_admin] has deleted a [type][(type == "note" || type == "message" || type == "watchlist entry") ? " for" : " made by"] [target_key]:<br>[text]"
		log_admin_private(m1)
		message_admins(m2)
		if(browse)
			browse_messages("[type]")
		else
			browse_messages(target_ckey = ckey(target_key), agegate = TRUE)

/proc/edit_message(message_id, browse)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/editor_ckey = usr.ckey
	var/editor_key = usr.key
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_find_edit_message = SSdbcore.NewQuery({"
		SELECT
			type,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), targetckey),
			text
		FROM [format_table_name("messages")]
		WHERE id = :id AND deleted = 0
	"}, list("id" = message_id))
	if(!query_find_edit_message.warn_execute())
		qdel(query_find_edit_message)
		return
	if(query_find_edit_message.NextRow())
		var/type = query_find_edit_message.item[1]
		var/target_key = query_find_edit_message.item[2]
		var/admin_key = query_find_edit_message.item[3]
		var/old_text = query_find_edit_message.item[4]
		var/new_text = input("Input new [type]", "New [type]", "[old_text]") as null|message
		if(!new_text)
			qdel(query_find_edit_message)
			return
		var/edit_text = "Edited by [editor_key] on [ISOtime()] from<br>[old_text]<br>to<br>[new_text]<hr>"
		var/datum/db_query/query_edit_message = SSdbcore.NewQuery({"
			UPDATE [format_table_name("messages")]
			SET text = :text, lasteditor = :lasteditor, edits = CONCAT(IFNULL(edits,''),:edit_text)
			WHERE id = :id AND deleted = 0
		"}, list("text" = new_text, "lasteditor" = editor_ckey, "edit_text" = edit_text, "id" = message_id))
		if(!query_edit_message.warn_execute())
			qdel(query_edit_message)
			return
		qdel(query_edit_message)
		log_admin_private("[kn] has edited a [type] [(type == "note" || type == "message" || type == "watchlist entry") ? " for [target_key]" : ""] made by [admin_key] from [old_text] to [new_text]")
		message_admins("[kna] has edited a [type] [(type == "note" || type == "message" || type == "watchlist entry") ? " for [target_key]" : ""] made by [admin_key] from<br>[old_text]<br>to<br>[new_text]")
		if(browse)
			browse_messages("[type]")
		else
			browse_messages(target_ckey = ckey(target_key), agegate = TRUE)
	qdel(query_find_edit_message)

/proc/edit_message_expiry(message_id, browse)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/editor_ckey = usr.ckey
	var/editor_key = usr.key
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_find_edit_expiry_message = SSdbcore.NewQuery({"
		SELECT
			type,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
			expire_timestamp
		FROM [format_table_name("messages")]
		WHERE id = :id AND deleted = 0
	"}, list("id" = message_id))
	if(!query_find_edit_expiry_message.warn_execute())
		qdel(query_find_edit_expiry_message)
		return
	if(query_find_edit_expiry_message.NextRow())
		var/type = query_find_edit_expiry_message.item[1]
		var/target_key = query_find_edit_expiry_message.item[2]
		var/admin_key = query_find_edit_expiry_message.item[3]
		var/old_expiry = query_find_edit_expiry_message.item[4]
		var/new_expiry
		var/expire_time = input("Set expiry time for [type] as format YYYY-MM-DD HH:MM:SS. All times in server time. HH:MM:SS is optional and 24-hour. Must be later than current time for obvious reasons. Enter -1 to remove expiry time.", "Set expiry time", old_expiry) as null|text
		if(!expire_time)
			qdel(query_find_edit_expiry_message)
			return
		if(expire_time == "-1")
			new_expiry = "non-expiring"
		else
			var/datum/db_query/query_validate_expire_time_edit = SSdbcore.NewQuery({"
				SELECT IF(STR_TO_DATE(:expire_time,'%Y-%c-%d %T') > NOW(), STR_TO_DATE(:expire_time,'%Y-%c-%d %T'), 0)
			"}, list("expire_time" = expire_time))
			if(!query_validate_expire_time_edit.warn_execute())
				qdel(query_validate_expire_time_edit)
				qdel(query_find_edit_expiry_message)
				return
			if(query_validate_expire_time_edit.NextRow())
				var/checktime = text2num(query_validate_expire_time_edit.item[1])
				if(!checktime)
					to_chat(usr, "Datetime entered is improperly formatted or not later than current server time.", confidential = TRUE)
					qdel(query_validate_expire_time_edit)
					qdel(query_find_edit_expiry_message)
					return
				new_expiry = query_validate_expire_time_edit.item[1]
			qdel(query_validate_expire_time_edit)
		var/edit_text = "Expiration time edited by [editor_key] on [ISOtime()] from [(old_expiry ? old_expiry : "no expiration date")] to [new_expiry]<hr>"
		var/datum/db_query/query_edit_message_expiry = SSdbcore.NewQuery({"
			UPDATE [format_table_name("messages")]
			SET expire_timestamp = :expire_time, lasteditor = :lasteditor, edits = CONCAT(IFNULL(edits,''),:edit_text)
			WHERE id = :id AND deleted = 0
		"}, list("expire_time" = (expire_time == "-1" ? null : new_expiry), "lasteditor" = editor_ckey, "edit_text" = edit_text, "id" = message_id))
		if(!query_edit_message_expiry.warn_execute())
			qdel(query_edit_message_expiry)
			qdel(query_find_edit_expiry_message)
			return
		qdel(query_edit_message_expiry)
		log_admin_private("[kn] has edited the expiration time of a [type] [(type == "note" || type == "message" || type == "watchlist entry") ? " for [target_key]" : ""] made by [admin_key] from [(old_expiry ? old_expiry : "no expiration date")] to [new_expiry]")
		message_admins("[kna] has edited the expiration time of a [type] [(type == "note" || type == "message" || type == "watchlist entry") ? " for [target_key]" : ""] made by [admin_key] from [(old_expiry ? old_expiry : "no expiration date")] to [new_expiry]")
		if(browse)
			browse_messages("[type]")
		else
			browse_messages(target_ckey = ckey(target_key), agegate = TRUE)
	qdel(query_find_edit_expiry_message)

/proc/edit_message_severity(message_id)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_find_edit_note_severity = SSdbcore.NewQuery({"
		SELECT
			type,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
			severity
		FROM [format_table_name("messages")]
		WHERE id = :id AND deleted = 0
	"}, list("id" = message_id))
	if(!query_find_edit_note_severity.warn_execute())
		qdel(query_find_edit_note_severity)
		return
	if(query_find_edit_note_severity.NextRow())
		var/type = query_find_edit_note_severity.item[1]
		var/target_key = query_find_edit_note_severity.item[2]
		var/admin_key = query_find_edit_note_severity.item[3]
		var/old_severity = query_find_edit_note_severity.item[4]
		if(!old_severity)
			old_severity = "NA"
		var/editor_key = usr.key
		var/editor_ckey = usr.ckey
		var/new_severity = input("Set the severity of the note.", "Severity", null, null) as null|anything in list("high", "medium", "minor", "none") //lowercase for edit log consistency
		if(!new_severity)
			qdel(query_find_edit_note_severity)
			return
		new_severity = new_severity
		var/edit_text = "Note severity edited by [editor_key] on [ISOtime()] from [old_severity] to [new_severity]<hr>"
		var/datum/db_query/query_edit_note_severity = SSdbcore.NewQuery({"
			UPDATE [format_table_name("messages")]
			SET severity = :severity, lasteditor = :lasteditor, edits = CONCAT(IFNULL(edits,''),:edit_text)
			WHERE id = :id AND deleted = 0
		"}, list("severity" = new_severity, "lasteditor" = editor_ckey, "edit_text" = edit_text, "id" = message_id))
		if(!query_edit_note_severity.warn_execute(async = TRUE))
			qdel(query_edit_note_severity)
			qdel(qdel(query_find_edit_note_severity))
			return
		qdel(query_edit_note_severity)
		log_admin_private("[kn] has edited the severity of a [type] for [target_key] made by [admin_key] from [old_severity] to [new_severity]")
		message_admins("[kna] has edited the severity time of a [type] for [target_key] made by [admin_key] from [old_severity] to [new_severity]")
		browse_messages(target_ckey = ckey(target_key), agegate = TRUE)
	qdel(query_find_edit_note_severity)

/proc/toggle_message_secrecy(message_id)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	message_id = text2num(message_id)
	if(!message_id)
		return
	var/editor_ckey = usr.ckey
	var/editor_key = usr.key
	var/kn = key_name(usr)
	var/kna = key_name_admin(usr)
	var/datum/db_query/query_find_message_secret = SSdbcore.NewQuery({"
		SELECT
			type,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), targetckey),
			secret
		FROM [format_table_name("messages")]
		WHERE id = :id AND deleted = 0
	"}, list("id" = message_id))
	if(!query_find_message_secret.warn_execute())
		qdel(query_find_message_secret)
		return
	if(query_find_message_secret.NextRow())
		var/type = query_find_message_secret.item[1]
		var/target_key = query_find_message_secret.item[2]
		var/admin_key = query_find_message_secret.item[3]
		var/secret = text2num(query_find_message_secret.item[4])
		var/edit_text = "Made [secret ? "not secret" : "secret"] by [editor_key] on [ISOtime()]<hr>"
		var/datum/db_query/query_message_secret = SSdbcore.NewQuery({"
			UPDATE [format_table_name("messages")]
			SET secret = NOT secret, lasteditor = :lasteditor, edits = CONCAT(IFNULL(edits,''),:edit_text)
			WHERE id = :id
		"}, list("lasteditor" = editor_ckey, "edit_text" = edit_text, "id" = message_id))
		if(!query_message_secret.warn_execute())
			qdel(query_find_message_secret)
			qdel(query_message_secret)
			return
		qdel(query_message_secret)
		log_admin_private("[kn] has toggled [target_key]'s [type] made by [admin_key] to [secret ? "not secret" : "secret"]")
		message_admins("[kna] has toggled [target_key]'s [type] made by [admin_key] to [secret ? "not secret" : "secret"]")
		browse_messages(target_ckey = ckey(target_key), agegate = TRUE)
	qdel(query_find_message_secret)

/proc/browse_messages(type, target_ckey, index, linkless = FALSE, filter, agegate = FALSE)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return

	//Needs to be requested before url retrieval since you can view your notes before SSassets finishes initialization
	var/datum/asset/notes_assets = get_asset_datum(/datum/asset/simple/notes)

	var/list/output = list()
	var/ruler = "<hr style='background:#000000; border:0; height:3px'>"
	var/list/navbar = list("<a href='?_src_=holder;[HrefToken()];nonalpha=1'>All</a><a href='?_src_=holder;[HrefToken()];nonalpha=2'>#</a>")
	for(var/letter in GLOB.alphabet)
		navbar += "<a href='?_src_=holder;[HrefToken()];showmessages=[letter]'>[letter]</a>"
	navbar += "<a href='?_src_=holder;[HrefToken()];showmemo=1'>Memos</a><a href='?_src_=holder;[HrefToken()];showwatch=1'>Watchlist</a>"
	navbar += "<br><form method='GET' name='search' action='?'>\
	<input type='hidden' name='_src_' value='holder'>\
	[HrefTokenFormField()]\
	<input type='text' name='searchmessages' value='[index]'>\
	<input type='submit' value='Search'></form>"
	if(!linkless)
		output = navbar
	if(type == "memo" || type == "watchlist entry")
		if(type == "memo")
			output += "<h2><center>Admin memos</h2>"
			output += "<a href='?_src_=holder;[HrefToken()];addmemo=1'>Add memo</a></center>"
		else if(type == "watchlist entry")
			output += "<h2><center>Watchlist entries</h2>"
			output += "<a href='?_src_=holder;[HrefToken()];addwatchempty=1'>Add watchlist entry</a>"
			if(filter)
				output += "<a href='?_src_=holder;[HrefToken()];showwatch=1'>Unfilter clients</a></center>"
			else
				output += "<a href='?_src_=holder;[HrefToken()];showwatchfilter=1'>Filter offline clients</a></center>"
		output += ruler
		var/datum/db_query/query_get_type_messages = SSdbcore.NewQuery(/* SKYRAT EDIT CHANGE - MULTISERVER */{"
			SELECT
				id,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
				targetckey,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
				text,
				timestamp,
				server_name,
				server,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = lasteditor), lasteditor),
				expire_timestamp,
				playtime,
				round_id
			FROM [format_table_name("messages")]
			WHERE type = :type AND deleted = 0 AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)
		"}, list("type" = type))
		if(!query_get_type_messages.warn_execute())
			qdel(query_get_type_messages)
			return
		while(query_get_type_messages.NextRow())
			if(QDELETED(usr))
				return
			var/id = query_get_type_messages.item[1]
			var/t_key = query_get_type_messages.item[2]
			var/t_ckey = query_get_type_messages.item[3]
			if(type == "watchlist entry" && filter && !(t_ckey in GLOB.directory))
				continue
			var/admin_key = query_get_type_messages.item[4]
			var/text = query_get_type_messages.item[5]
			var/timestamp = query_get_type_messages.item[6]
			var/server = query_get_type_messages.item[7]
			var/editor_key = query_get_type_messages.item[9] // SKYRAT EDIT CHANGE BEGIN - MULTISERVER
			var/expire_timestamp = query_get_type_messages.item[10]
			var/playtime = query_get_type_messages.item[11]
			var/round_id = query_get_type_messages.item[12] // SKYRAT EDIT CHANGE END - MULTISERVER
			output += "<b>"
			if(type == "watchlist entry")
				output += "[t_key] | "
			output += "[timestamp] | [server] | Round [round_id] | [admin_key]"
			if(type == "watchlist entry")
				output += " | [get_exp_format(text2num(playtime))] Living Playtime"
			if(expire_timestamp)
				output += " | Expires [expire_timestamp]"
			output += "</b>"
			output += " <a href='?_src_=holder;[HrefToken()];editmessageexpiryempty=[id]'>Change Expiry Time</a>"
			output += " <a href='?_src_=holder;[HrefToken()];deletemessageempty=[id]'>Delete</a>"
			output += " <a href='?_src_=holder;[HrefToken()];editmessageempty=[id]'>Edit</a>"
			if(editor_key)
				output += " <font size='2'>Last edit by [editor_key] <a href='?_src_=holder;[HrefToken()];messageedits=[id]'>(Click here to see edit log)</a></font>"
			output += "<br>[text]<hr style='background:#000000; border:0; height:1px'>"
		qdel(query_get_type_messages)
	if(target_ckey)
		var/target_key
		var/datum/db_query/query_get_messages = SSdbcore.NewQuery(/* SKYRAT EDIT CHANGE - MULTISERVER */{"
			SELECT
				type,
				secret,
				id,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
				text,
				timestamp,
				server_name,
				server,
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = lasteditor), lasteditor),
				DATEDIFF(NOW(), timestamp),
				IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey), targetckey),
				expire_timestamp,
				severity,
				playtime,
				round_id
			FROM [format_table_name("messages")]
			WHERE type <> 'memo' AND targetckey = :targetckey AND deleted = 0 AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)
			ORDER BY timestamp DESC
		"}, list("targetckey" = target_ckey))
		if(!query_get_messages.warn_execute())
			qdel(query_get_messages)
			return
		var/list/messagedata = list()
		var/list/watchdata = list()
		var/list/notedata = list()
		var/skipped = 0
		while(query_get_messages.NextRow())
			if(QDELETED(usr))
				return
			type = query_get_messages.item[1]
			if(type == "memo")
				continue
			var/secret = text2num(query_get_messages.item[2])
			if(linkless && secret)
				continue
			var/id = query_get_messages.item[3]
			var/admin_key = query_get_messages.item[4]
			var/text = query_get_messages.item[5]
			var/timestamp = query_get_messages.item[6]
			var/server = query_get_messages.item[7]
			var/editor_key = query_get_messages.item[9] // SKYRAT EDIT CHANGE BEGIN - MULTISERVER
			var/age = text2num(query_get_messages.item[10])
			target_key = query_get_messages.item[11]
			var/expire_timestamp = query_get_messages.item[12]
			var/severity = query_get_messages.item[13]
			var/playtime = query_get_messages.item[14]
			var/round_id = query_get_messages.item[15] // SKYRAT EDIT CHANGE END - MULTISERVER
			var/alphatext = ""
			var/nsd = CONFIG_GET(number/note_stale_days)
			var/nfd = CONFIG_GET(number/note_fresh_days)
			if (agegate && type == "note" && isnum(nsd) && isnum(nfd) && nsd > nfd)
				var/alpha = clamp(100 - (age - nfd) * (85 / (nsd - nfd)), 15, 100)
				if (alpha < 100)
					if (alpha <= 15)
						if (skipped)
							skipped++
							continue
						alpha = 10
						skipped = TRUE
					alphatext = "filter: alpha(opacity=[alpha]); opacity: [alpha/100];"
			var/list/data = list("<div style='margin:0px;[alphatext]'><p class='severity'>")
			if(severity)
				data += "<img src='[SSassets.transport.get_asset_url("[severity]_button.png")]' height='24' width='24'></img> "
			data += "<b>[timestamp] | [server] | Round [round_id] | [admin_key][secret ? " | <i>- Secret</i>" : ""] | [get_exp_format(text2num(playtime))] Living Playtime"
			if(expire_timestamp)
				data += " | Expires [expire_timestamp]"
			data += "</b></p><center>"
			if(!linkless)
				if(type == "note")
					if(severity)
						data += "<a href='?_src_=holder;[HrefToken()];editmessageseverity=[id]'>[severity == "none" ? "No" : "[capitalize(severity)]"] Severity</a>"
					else
						data += "<a href='?_src_=holder;[HrefToken()];editmessageseverity=[id]'>N/A Severity</a>"
				data += " <a href='?_src_=holder;[HrefToken()];editmessageexpiry=[id]'>Change Expiry Time</a>"
				data += " <a href='?_src_=holder;[HrefToken()];deletemessage=[id]'>Delete</a>"
				if(type == "note")
					data += " <a href='?_src_=holder;[HrefToken()];secretmessage=[id]'>[secret ? "<b>Secret</b>" : "Not secret"]</a>"
				if(type == "message sent")
					data += " <font size='2'>Message has been sent</font>"
					if(editor_key)
						data += "|"
				else
					data += " <a href='?_src_=holder;[HrefToken()];editmessage=[id]'>Edit</a>"
				if(editor_key)
					data += " <font size='2'>Last edit by [editor_key] <a href='?_src_=holder;[HrefToken()];messageedits=[id]'>(Click here to see edit log)</a></font>"
			data += "</div></center>"
			data += "<p style='[alphatext]'>[text]</p><hr style='background:#000000; border:0; height:1px; [alphatext]'>"
			switch(type)
				if("message")
					messagedata += data
				if("message sent")
					messagedata += data
				if("watchlist entry")
					watchdata += data
				if("note")
					notedata += data
		qdel(query_get_messages)
		if(!target_key)
			var/datum/db_query/query_get_message_key = SSdbcore.NewQuery({"
				SELECT byond_key FROM [format_table_name("player")] WHERE ckey = :ckey
			"}, list("ckey" = target_ckey))
			if(!query_get_message_key.warn_execute())
				qdel(query_get_message_key)
				return
			if(query_get_message_key.NextRow())
				target_key = query_get_message_key.item[1]
			qdel(query_get_message_key)
		output += "<h2><center>[target_key]</center></h2><center>"
		if(!linkless)
			output += "<a href='?_src_=holder;[HrefToken()];addnote=[target_key]'>Add note</a>"
			output += " <a href='?_src_=holder;[HrefToken()];addmessage=[target_key]'>Add message</a>"
			output += " <a href='?_src_=holder;[HrefToken()];addwatch=[target_key]'>Add to watchlist</a>"
			output += " <a href='?_src_=holder;[HrefToken()];showmessageckey=[target_ckey]'>Refresh page</a></center>"
		else
			output += " <a href='?_src_=holder;[HrefToken()];showmessageckeylinkless=[target_ckey]'>Refresh page</a></center>"
		output += ruler
		if(messagedata)
			output += "<h2>Messages</h2>"
			output += messagedata
		if(watchdata)
			output += "<h2>Watchlist</h2>"
			output += watchdata
		if(notedata)
			output += "<h2>Notes</h2>"
			output += notedata
			if(!linkless)
				if (agegate)
					if (skipped) //the first skipped message is still shown so that we can put this link over it.
						output += "<center><a href='?_src_=holder;[HrefToken()];showmessageckey=[target_ckey];showall=1' style='position: relative; top: -3em;'>Show [skipped] hidden messages</a></center>"
					else
						output += "<center><a href='?_src_=holder;[HrefToken()];showmessageckey=[target_ckey];showall=1'>Show All</a></center>"
				else
					output += "<center><a href='?_src_=holder;[HrefToken()];showmessageckey=[target_ckey]'>Hide Old</a></center>"
	if(index)
		var/search
		output += "<center><a href='?_src_=holder;[HrefToken()];addmessageempty=1'>Add message</a><a href='?_src_=holder;[HrefToken()];addwatchempty=1'>Add watchlist entry</a><a href='?_src_=holder;[HrefToken()];addnoteempty=1'>Add note</a></center>"
		output += ruler
		switch(index)
			if(1)
				search = "^."
			if(2)
				search = "^\[^\[:alpha:\]\]"
			else
				search = "^[index]"
		var/datum/db_query/query_list_messages = SSdbcore.NewQuery({"
			SELECT DISTINCT
				targetckey,
				(SELECT byond_key FROM [format_table_name("player")] WHERE ckey = targetckey)
			FROM [format_table_name("messages")]
			WHERE type <> 'memo'
				AND targetckey REGEXP :search
				AND deleted = 0
				AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)
			ORDER BY targetckey
		"}, list("search" = search))
		if(!query_list_messages.warn_execute())
			qdel(query_list_messages)
			return
		while(query_list_messages.NextRow())
			if(QDELETED(usr))
				return
			var/index_ckey = query_list_messages.item[1]
			var/index_key = query_list_messages.item[2]
			if(!index_key)
				index_key = index_ckey
			output += "<a href='?_src_=holder;[HrefToken()];showmessageckey=[index_ckey]'>[index_key]</a><br>"
		qdel(query_list_messages)
	else if(!type && !target_ckey && !index)
		output += "<center><a href='?_src_=holder;[HrefToken()];addmessageempty=1'>Add message</a><a href='?_src_=holder;[HrefToken()];addwatchempty=1'>Add watchlist entry</a><a href='?_src_=holder;[HrefToken()];addnoteempty=1'>Add note</a></center>"
		output += ruler
	var/datum/browser/browser = new(usr, "Note panel", "Manage player notes", 1000, 500)
	notes_assets.send(usr.client)
	browser.set_content(jointext(output, ""))
	browser.open()

/// Represents a message stored in the db
/datum/admin_message
	/// The uid of this message
	var/id
	/// The admin who left this message
	var/admin_key
	/// The text of this message
	var/text
	/// The time this message was first created
	var/timestamp
	/// The admin who last edited this message
	var/editor_key

/proc/get_message_output(type, target_ckey, show_secret = TRUE, after_timestamp)
	if(!SSdbcore.Connect())
		to_chat(usr, span_danger("Failed to establish database connection."), confidential = TRUE)
		return
	if(!type)
		return
	var/list/parameters = list(
		"targetckey" = target_ckey,
		"type" = type,
	)
	if(after_timestamp)
		parameters["after_timestamp"] = after_timestamp
	var/datum/db_query/query_get_message_output = SSdbcore.NewQuery({"
		SELECT
			id,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = adminckey), adminckey),
			text,
			timestamp,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE ckey = lasteditor), lasteditor)
		FROM [format_table_name("messages")]
		WHERE type = :type
		AND deleted = 0
		AND (expire_timestamp > NOW() OR expire_timestamp IS NULL)
		AND (type = 'memo' OR targetckey = :targetckey)
		[after_timestamp? "AND timestamp > :after_timestamp": ""]
		[!show_secret? "AND secret = 0": ""]
	"}, parameters)
	if(!query_get_message_output.warn_execute())
		qdel(query_get_message_output)
		return
	var/list/datum/admin_message/messages = list()
	while(query_get_message_output.NextRow())
		var/datum/admin_message/message = new()
		message.id = query_get_message_output.item[1]
		message.admin_key = query_get_message_output.item[2]
		message.text = query_get_message_output.item[3]
		message.timestamp = query_get_message_output.item[4]
		message.editor_key = query_get_message_output.item[5]
		messages += message
	qdel(query_get_message_output)
	if(!length(messages))
		return
	return messages

/proc/display_admin_messages(client/display_to)
	var/list/text = list()
	for(var/datum/admin_message/message in get_message_output("message", display_to.ckey))
		text += "<font color='[COLOR_RED]' size='3'><b>Admin message left by [span_prefix("[message.admin_key]")] on [message.timestamp]</b></font>"
		text += "<br><font color='[COLOR_RED]'>[message.text] <A href='?messageread=[message.id]'>(Click here to verify you have read this message)</A></font><br>"
	if(length(text))
		to_chat(display_to, text.Join())

/proc/display_unread_notes(client/display_to, show_after)
	var/list/text = list()
	for(var/datum/admin_message/message in get_message_output("note", display_to.ckey, FALSE, show_after))
		text += "<font color='[COLOR_RED]' size='3'><b>Note left by [span_prefix("[message.admin_key]")] on [message.timestamp]</b></font>"
		text += "<br><font color='[COLOR_RED]'>[message.text]</font><br>"
	if(length(text))
		to_chat(display_to, text.Join())

/proc/display_admin_memos(client/display_to)
	var/list/text = list()
	for(var/datum/admin_message/message in get_message_output("memo", display_to.ckey))
		text += "[span_memo("Memo by <span class='prefix'>[message.admin_key]")] on [message.timestamp]"
		if(message.editor_key)
			text += "<br>[span_memoedit("Last edit by [message.editor_key] <A href='?_src_=holder;[HrefToken()];messageedits=[message.id]'>(Click here to see edit log)</A>")]"
		text += "<br>[message.text]</span><br>"
	if(length(text))
		to_chat(display_to, text.Join())

/proc/scream_about_watchlists(client/read_from)
	for(var/datum/admin_message/message in get_message_output("watchlist entry", read_from.ckey))
		message_admins("<font color='[COLOR_RED]'><B>Notice: </B></font><font color='[COLOR_ADMIN_PINK]'>[key_name_admin(read_from.ckey)] has been on the watchlist since [message.timestamp] and has just connected - Reason: [message.text]</font>")
		send2tgs_adminless_only("Watchlist", "[key_name(read_from.ckey)] is on the watchlist and has just connected - Reason: [message.text]")

#define NOTESFILE "data/player_notes.sav"
//if the AUTOCONVERT_NOTES is turned on, anytime a player connects this will be run to try and add all their notes to the databas
/proc/convert_notes_sql(ckey)
	if(!fexists(NOTESFILE))
		return

	var/savefile/notesfile = new(NOTESFILE)
	if(!notesfile)
		log_game("Error: Cannot access [NOTESFILE]")
		return
	notesfile.cd = "/[ckey]"
	while(!notesfile.eof)
		var/notetext
		notesfile >> notetext
		var/server
		var/ssqlname = CONFIG_GET(string/serversqlname)
		if (ssqlname)
			server = ssqlname
		var/regex/note = new("^(\\d{2}-\\w{3}-\\d{4}) \\| (.+) ~(\\w+)$", "i")
		note.Find(notetext)
		var/timestamp = note.group[1]
		notetext = note.group[2]
		var/admin_ckey = note.group[3]
		var/datum/db_query/query_convert_time = SSdbcore.NewQuery("SELECT ADDTIME(STR_TO_DATE(:timestamp,'%d-%b-%Y'), '0')", list("timestamp" = timestamp))
		if(!query_convert_time.Execute())
			qdel(query_convert_time)
			return
		if(query_convert_time.NextRow())
			timestamp = query_convert_time.item[1]
		qdel(query_convert_time)
		if(ckey && notetext && timestamp && admin_ckey && server)
			create_message("note", ckey, admin_ckey, notetext, timestamp, server, 1, 0, null, 0, 0)
	notesfile.cd = "/"
	notesfile.dir.Remove(ckey)

#undef NOTESFILE
