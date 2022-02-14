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

/datum/tailor_clothing/proc/get_json()
	return json_encode(list("name" = name, "desc" = desc, "ckey_author" = ckey_author, "author" = author, "id" = id, "slot" = slot, "digitigrade" = digitigrade, "banned" = banned))

/datum/tailor_clothing/proc/get_list()
	return list("name" = name, "desc" = desc, "ckey_author" = ckey_author, "author" = author, "id" = id, "slot" = slot, "digitigrade" = digitigrade, "banned" = banned)

/datum/tailor_clothing/proc/ban_pattern()
	banned = TRUE
	var/json_entry = get_json()
	fdel("data/clothing/[id].json")
	text2file(json_entry, "data/clothing/[id].json") // Delete and remake the json to record the ban.
	// We don't delete the files so that incorrect bans can be reversed.

SUBSYSTEM_DEF(clothing_database)
	name = "Clothing Database"
	flags = SS_NO_FIRE

	/// All loaded clothing datums.
	var/list/clothing_loaded = list()

/datum/controller/subsystem/clothing_database/stat_entry(msg)
	msg = "CLOTHING: [LAZYLEN(clothing_loaded)]"
	return ..()

/datum/controller/subsystem/clothing_database/Initialize(start_timeofday)
	var/list/clothes = flist("data/clothing/")
	for(var/clothing in clothes)
		if(clothing == null || clothing == "/")
			continue
		var/clothing_json = json_load("data/clothing/[clothing]")
		var/datum/tailor_clothing/loaded_clothing = new
		loaded_clothing.name = clothing_json["name"]
		loaded_clothing.desc = clothing_json["desc"]
		loaded_clothing.ckey_author = clothing_json["ckey_author"]
		loaded_clothing.author = clothing_json["author"]
		loaded_clothing.id = clothing_json["id"]
		loaded_clothing.slot = clothing_json["slot"]
		loaded_clothing.digitigrade = clothing_json["digitigrade"]
		loaded_clothing.banned = clothing_json["banned"]
		clothing_loaded.Add(loaded_clothing)
	message_admins("Loaded [clothing_loaded.len] clothing entries!")

/datum/controller/subsystem/clothing_database/proc/register_clothing(datum/tailor_clothing/clothing_datum, icon/clothing_icon)
	clothing_datum.id = clothing_loaded.len + 1
	clothing_loaded.Add(clothing_datum)
	var/json_entry = clothing_datum.get_json()
	fcopy(clothing_icon, "data/clothing_icons/[clothing_datum.id].dmi")
	text2file(json_entry, "data/clothing/[clothing_datum.id].json")
