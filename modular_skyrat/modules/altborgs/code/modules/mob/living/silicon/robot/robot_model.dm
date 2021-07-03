/obj/item/robot_model
	var/icon/cyborg_icon_override
	var/sleeper_overlay
	var/cyborg_pixel_offset
	var/model_select_alternate_icon
	/// Traits unique to this model, i.e. having a unique dead sprite, being wide or being small enough to reject shrinker modules. Leverages defines in code\__DEFINES\~skyrat_defines\robot_defines.dm
	var/list/model_features = list()

//SERVICE
/obj/item/robot_model/service/skyrat
	name = "Skyrat Service"
	special_light_key = null

//MINING
/obj/item/robot_model/miner/skyrat
	name = "Skyrat Miner"
	special_light_key = null
