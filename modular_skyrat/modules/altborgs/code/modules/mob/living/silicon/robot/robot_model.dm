/obj/item/robot_model
	var/icon/cyborg_icon_override
	var/sleeper_overlay
	var/has_snowflake_deadsprite
	var/cyborg_pixel_offset
	var/model_select_alternate_icon
	var/dogborg = FALSE //Is this model a wider borg?

//SERVICE
/obj/item/robot_model/service/skyrat
	name = "Skyrat Service"
	special_light_key = null

//MINING
/obj/item/robot_model/miner/skyrat
	name = "Skyrat Miner"
	special_light_key = null
