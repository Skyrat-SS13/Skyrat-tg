/datum/antagonist/changeling/forge_objectives()
	return


/datum/changeling_profile
	/// The bra worn by the profile source
	var/bra
	/// The color of the undershirt used by the profile source
	var/undershirt_color
	/// The color of the socks used by the profile source
	var/socks_color
	/// The color of the bra used by the profile source
	var/bra_color
	/// The profile source's left eye color
	var/eye_color_left
	/// The profile source's right eye color
	var/eye_color_right
	/// Does the profile source's eyes glow
	var/emissive_eyes

	/// Profile source digi leg icons
	var/list/worn_icon_digi_list = list()
	/// profile source monkey icons
	var/list/worn_icon_monkey_list = list()
	/// Profile source vox icons
	var/list/worn_icon_teshari_list = list()
	/// The bra worn by the profile source
	var/list/worn_icon_vox_list = list()
	/// Support variation flags used by the profile source
	var/list/supports_variations_flags_list = list()
	/// The profile source scream type
	var/scream_type
	/// The profile source laugh type
	var/laugh_type
	/// Profile source mob height
	var/target_body_scaling
	/// Profile source Mob Size
	var/target_size
