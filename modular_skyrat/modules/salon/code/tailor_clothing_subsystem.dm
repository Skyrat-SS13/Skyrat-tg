/datum/config_entry/flag/enable_clothing_approval_queue // Turn this flag on to enable the clothing approval queue.

/datum/tailor_clothing
	var/name = "Clothing Name"
	var/desc = "Clothing Description"
	/// The ckey that uploaded this.
	var/ckey_author
	/// The author of the sprite.
	var/author
	/// The clothing's ID.
	var/id
	/// The clothing's slot.
	var/slot
	/// Does this clothing support digitigrade?
	var/digitigrade = FALSE
	/// Has this clothing been banned by the admins?
	var/banned = FALSE
	/// Has this clothing been approved by admins?
	var/approved = TRUE

/datum/tailor_clothing/proc/get_json()
	return json_encode(list("name" = name, "desc" = desc, "ckey_author" = ckey_author, "author" = author, "id" = id, "slot" = slot, "digitigrade" = digitigrade, "banned" = banned, "approved" = approved))

/datum/tailor_clothing/proc/get_list()
	return list("name" = name, "desc" = desc, "ckey_author" = ckey_author, "author" = author, "id" = id, "slot" = slot, "digitigrade" = digitigrade, "banned" = banned, "approved" = approved)

/datum/tailor_clothing/proc/ban_pattern()
	banned = TRUE
	if(CONFIG_GET(flag/enable_clothing_approval_queue))
		if(src in SSclothing_database.clothing_awaiting_approval)
			SSclothing_database.clothing_awaiting_approval.Remove(src)
	var/json_entry = get_json()
	fdel("data/clothing/[id].json")
	text2file(json_entry, "data/clothing/[id].json") // Delete and remake the json to record the ban.
	// We don't delete the files so that incorrect bans can be reversed.

/datum/tailor_clothing/proc/approve_pattern()
	approved = TRUE
	SSclothing_database.clothing_awaiting_approval.Remove(src)
	var/json_entry = get_json()
	fdel("data/clothing/[id].json")
	text2file(json_entry, "data/clothing/[id].json") // Delete and remake the json to record the approval.

SUBSYSTEM_DEF(clothing_database)
	name = "Clothing Database"
	flags = NONE
	wait = 1 MINUTES // Every minute, remind admins there's a clothing queue to process.
	/// All loaded clothing datums.
	var/list/clothing_loaded = list()
	var/list/clothing_awaiting_approval = list()

/datum/controller/subsystem/clothing_database/stat_entry(msg)
	if(CONFIG_GET(flag/enable_clothing_approval_queue))
		msg = "CLOTHING: [LAZYLEN(clothing_loaded)]|APP QUEUE: [LAZYLEN(clothing_awaiting_approval)]"
	else
		msg = "CLOTHING: [LAZYLEN(clothing_loaded)]"
	return ..()

/datum/controller/subsystem/clothing_database/fire(resumed)
	if(!clothing_awaiting_approval.len)
		return // no clothes need approval
	if(!CONFIG_GET(flag/enable_clothing_approval_queue))
		return // approval queue is disabled
	message_admins("CLOTHING: [LAZYLEN(clothing_awaiting_approval)] clothing awaiting approval.")
	message_admins("CLOTHING: Use the Clothing Approval Queue verb under the Game section of the Admin tab to handle the clothing approval process.")

/datum/controller/subsystem/clothing_database/Initialize(start_timeofday)
	var/list/clothes = flist("data/clothing/")
	for(var/i in 1 to clothes.len)
		var/clothing_json = json_load("data/clothing/[i].json")
		var/datum/tailor_clothing/loaded_clothing = new
		loaded_clothing.name = clothing_json["name"]
		loaded_clothing.desc = clothing_json["desc"]
		loaded_clothing.ckey_author = clothing_json["ckey_author"]
		loaded_clothing.author = clothing_json["author"]
		loaded_clothing.id = clothing_json["id"]
		loaded_clothing.slot = clothing_json["slot"]
		loaded_clothing.digitigrade = clothing_json["digitigrade"]
		loaded_clothing.banned = clothing_json["banned"]
		if(CONFIG_GET(flag/enable_clothing_approval_queue))
			if(clothing_json["approved"] == null)
				loaded_clothing.approved = TRUE // grandfather in old jsons
			else
				loaded_clothing.approved = clothing_json["approved"]
			if(!loaded_clothing.approved && !loaded_clothing.banned)
				clothing_awaiting_approval.Add(loaded_clothing)
		else
			loaded_clothing.approved = TRUE
		clothing_loaded.Add(loaded_clothing)
	message_admins("Loaded [clothing_loaded.len] clothing entries!")
	message_admins("Loaded [clothing_awaiting_approval.len] clothing entries awaiting approval!")
	..()

/datum/controller/subsystem/clothing_database/proc/register_clothing(datum/tailor_clothing/clothing_datum, icon/clothing_icon)
	clothing_datum.id = clothing_loaded.len + 1
	if(CONFIG_GET(flag/enable_clothing_approval_queue))
		clothing_datum.approved = FALSE
		clothing_awaiting_approval.Add(clothing_datum)
	clothing_loaded.Add(clothing_datum)
	var/json_entry = clothing_datum.get_json()
	fcopy(clothing_icon, "data/clothing_icons/[clothing_datum.id].dmi")
	text2file(json_entry, "data/clothing/[clothing_datum.id].json")
