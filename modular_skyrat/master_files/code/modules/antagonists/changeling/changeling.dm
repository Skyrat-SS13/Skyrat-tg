/datum/antagonist/changeling/forge_objectives()
	return


/datum/changeling_profile
	/// The bra worn by the profile source - Skyrats addition
	var/bra
	var/underwear_color
	var/undershirt_color
	var/socks_color
	var/bra_color
	var/eye_color_left
	var/eye_color_right
	var/emissive_eyes
	var/list/grad_style = list("None", "None")
	var/list/grad_color = list(null, null)

	var/physique
	var/list/worn_icon_digi_list = list()
	var/list/worn_icon_monkey_list = list()
	var/list/worn_icon_teshari_list = list()
	var/list/worn_icon_vox_list = list()
	var/list/supports_variations_flags_list = list()
	var/scream_type
	var/laugh_type
	var/age
	var/list/quirks = list()
