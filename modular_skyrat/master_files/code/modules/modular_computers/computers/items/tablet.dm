#define DEFAULT_RINGTONE "beep"

/**
 * A simple helper proc that applies the client's ringtone prefs to the PDA's messenger app.
 *
 * Arguments:
 * * ringtone_client - The client whose prefs we'll use to set the ringtone of this PDA.
 */
/obj/item/modular_computer/tablet/pda/proc/update_ringtone(client/ringtone_client)
	if(!ringtone_client)
		return

	var/new_ringtone = ringtone_client?.prefs?.read_preference(/datum/preference/text/pda_ringtone)

	if(!new_ringtone || new_ringtone == DEFAULT_RINGTONE)
		return

	var/obj/item/computer_hardware/hard_drive/drive = all_components[MC_HDD]

	if(!drive)
		return

	for(var/datum/computer_file/program/messenger/messenger_app in drive.stored_files)
		messenger_app.ringtone = new_ringtone
