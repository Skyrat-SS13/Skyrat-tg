//MODULAR ID TRIM ACCESS OVERRIDES GO HERE!!

/datum/id_trim/job/head_of_security
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'

/datum/id_trim/job/warden
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'

/datum/id_trim/job/security_officer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'

/datum/id_trim/job/head_of_security/New()
	. = ..()

	access |= list(ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP)

/datum/id_trim/job/warden/New()
	. = ..()

	access |= list(ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP)

/datum/id_trim/job/security_officer/New()
	. = ..()

	access |= list(ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP)

/datum/id_trim/job/chief_engineer
	minimal_access = list(ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CE, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_EVA,
					ACCESS_EXTERNAL_AIRLOCKS, ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
					ACCESS_MINERAL_STOREROOM, ACCESS_MINISAT, ACCESS_RC_ANNOUNCE, ACCESS_BRIG_ENTRANCE, ACCESS_TCOMSAT, ACCESS_TECH_STORAGE, ACCESS_WEAPONS)

/datum/id_trim/job/chief_medical_officer
	minimal_access = list(ACCESS_CHEMISTRY, ACCESS_EVA, ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_MAINT_TUNNELS, ACCESS_MECH_MEDICAL,
					ACCESS_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_MORGUE, ACCESS_PHARMACY, ACCESS_PSYCHOLOGY, ACCESS_RC_ANNOUNCE,
					ACCESS_BRIG_ENTRANCE, ACCESS_SURGERY, ACCESS_VIROLOGY, ACCESS_WEAPONS)

/datum/id_trim/job/research_director
	minimal_access = list(ACCESS_AI_UPLOAD, ACCESS_AUX_BASE, ACCESS_EVA, ACCESS_GATEWAY, ACCESS_GENETICS, ACCESS_HEADS, ACCESS_KEYCARD_AUTH,
					ACCESS_NETWORK, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_MECH_MINING, ACCESS_MECH_SECURITY, ACCESS_MECH_SCIENCE,
					ACCESS_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MINISAT, ACCESS_MORGUE,
					ACCESS_ORDNANCE, ACCESS_ORDNANCE_STORAGE, ACCESS_RC_ANNOUNCE, ACCESS_RESEARCH, ACCESS_RND, ACCESS_ROBOTICS,
					ACCESS_BRIG_ENTRANCE, ACCESS_TECH_STORAGE, ACCESS_TELEPORTER, ACCESS_XENOBIOLOGY, ACCESS_WEAPONS)

/datum/id_trim/job/atmospheric_technician
	extra_access = list(ACCESS_TECH_STORAGE)
	minimal_access = list(ACCESS_ATMOSPHERICS, ACCESS_AUX_BASE, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
					ACCESS_MINERAL_STOREROOM)

/datum/id_trim/job/head_of_personnel
	minimal_access = list(ACCESS_AI_UPLOAD, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_AUX_BASE, ACCESS_BAR, ACCESS_BARBER, ACCESS_SERVICE, ACCESS_CARGO, ACCESS_CHAPEL_OFFICE,
					ACCESS_CHANGE_IDS, ACCESS_CONSTRUCTION, ACCESS_COURT, ACCESS_CREMATORIUM, ACCESS_ENGINE, ACCESS_EVA, ACCESS_GATEWAY,
					ACCESS_HEADS, ACCESS_HOP, ACCESS_HYDROPONICS, ACCESS_JANITOR, ACCESS_KEYCARD_AUTH, ACCESS_KITCHEN, ACCESS_LAWYER, ACCESS_LIBRARY,
					ACCESS_MAILSORTING, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_MECH_MEDICAL, ACCESS_MECH_MINING,
					ACCESS_MECH_SECURITY, ACCESS_MECH_SCIENCE, ACCESS_MEDICAL, ACCESS_MINERAL_STOREROOM,
					ACCESS_MINING_STATION, ACCESS_MORGUE, ACCESS_PSYCHOLOGY, ACCESS_QM, ACCESS_RC_ANNOUNCE, ACCESS_RESEARCH,
					ACCESS_SECURITY, ACCESS_BRIG_ENTRANCE, ACCESS_TELEPORTER, ACCESS_THEATRE, ACCESS_VAULT, ACCESS_WEAPONS)

/datum/id_trim/job/quartermaster
	minimal_access = list(ACCESS_AUX_BASE, ACCESS_CARGO, ACCESS_HEADS, ACCESS_KEYCARD_AUTH, ACCESS_MAILSORTING, ACCESS_MAINT_TUNNELS, ACCESS_MECH_MINING, ACCESS_MINING_STATION,
					ACCESS_MINERAL_STOREROOM, ACCESS_MINING, ACCESS_QM, ACCESS_RC_ANNOUNCE, ACCESS_BRIG_ENTRANCE, ACCESS_VAULT, ACCESS_WEAPONS)

/datum/id_trim/job/blueshield
	assignment = "Blueshield"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_blueshield"
	sechud_icon_state = SECHUD_BLUESHIELD
	extra_access = list(ACCESS_SECURITY, ACCESS_BRIG, ACCESS_COURT, ACCESS_CARGO, ACCESS_GATEWAY) // Someone needs to come back and order these alphabetically, this is a nightmare
	minimal_access = list(
		ACCESS_FORENSICS, ACCESS_BRIG_ENTRANCE, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_MAINT_TUNNELS, ACCESS_RESEARCH,
		ACCESS_RC_ANNOUNCE, ACCESS_HEADS, ACCESS_WEAPONS, ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP
		)
	minimal_wildcard_access = list(ACCESS_CAPTAIN)
	config_job = "blueshield"
	template_access = list(ACCESS_CAPTAIN, ACCESS_CHANGE_IDS)

/datum/id_trim/job/nanotrasen_consultant
	assignment = "Nanotrasen Consultant"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_nanotrasenconsultant"
	sechud_icon_state = SECHUD_NT_CONSULTANT
	extra_access = list()
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG_ENTRANCE, ACCESS_COURT, ACCESS_WEAPONS,
				ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_ENGINE, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_HEADS,
				ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE,
				ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_HYDROPONICS, ACCESS_LAWYER,
				ACCESS_MECH_ENGINE, ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY, ACCESS_MECH_MEDICAL,
				ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, ACCESS_VAULT, ACCESS_MINING_STATION,
				ACCESS_HOP, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE, ACCESS_TELEPORTER, ACCESS_CENT_GENERAL)
	minimal_wildcard_access = list(ACCESS_CAPTAIN, ACCESS_CENT_GENERAL)
	config_job = "nanotrasen_consultant"
	template_access = list(ACCESS_CAPTAIN, ACCESS_CHANGE_IDS)

/datum/id_trim/job/security_medic
	assignment = "Security Medic"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_securitymedic"
	sechud_icon_state = SECHUD_SECURITY_MEDIC
	extra_access = list(ACCESS_FORENSICS)
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG_ENTRANCE, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM,
	ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP, ACCESS_MAINT_TUNNELS)
	config_job = "security_medic"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)

/datum/id_trim/job/security_medic/New()
	. = ..()

	// Config check for if sec has maint access.
	if(CONFIG_GET(flag/security_has_maint_access))
		access |= list(ACCESS_MAINT_TUNNELS)

/datum/id_trim/job/expeditionary_trooper
	assignment = "Vanguard Operative"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_expeditionarytrooper"
	sechud_icon_state = SECHUD_VANGUARD_OPERATIVE
	extra_access = list()
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_EVA, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_TELEPORTER, ACCESS_GATEWAY, ACCESS_TECH_STORAGE,
		ACCESS_CENT_GENERAL, ACCESS_RESEARCH, ACCESS_RND)
	config_job = "expeditionary_trooper"

/datum/id_trim/job/brigoff
	assignment = "Corrections Officer"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_brigoff"
	sechud_icon_state = SECHUD_CORRECTIONS_OFFICER
	extra_access = list()
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG_ENTRANCE, ACCESS_BRIG, ACCESS_COURT,
				ACCESS_MAINT_TUNNELS, ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP)
	config_job = "brigoff"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)
	job = /datum/job/brigoff

/datum/id_trim/job/barber
	assignment = "Barber"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_barber"
	sechud_icon_state = SECHUD_BARBER
	extra_access = list()
	minimal_access = list(ACCESS_THEATRE, ACCESS_MAINT_TUNNELS, ACCESS_BARBER, ACCESS_SERVICE)
	config_job = "barber"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/barber
