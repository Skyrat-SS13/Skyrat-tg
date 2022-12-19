/// Stub component for flagging an item as off cargo manifest.
/datum/component/hidden_from_cargo_manifest
	dupe_mode = COMPONENT_DUPE_UNIQUE

/datum/supply_pack/hop_mail
	name = "HoP Mail from Central Command"
	hidden = TRUE
	access = ACCESS_HOP
	crate_name = "Mail for HoP"
	crate_type = /obj/structure/closet/crate/secure

	/// How much money to give.
	var/value

/datum/supply_pack/hop_mail/New(var/value)
	. = ..()
	src.value = value

	if(GLOB.hop_crate_goodies.len)
		return

	var/list/bad_heads = list(JOB_CAPTAIN, JOB_AI, JOB_HEAD_OF_SECURITY, JOB_BLUESHIELD, JOB_NT_REP, JOB_CENTCOM, "CentCom")
	for(var/datum/job/job in subtypesof(/datum/job))
		var/list/job_diff = list() + bad_heads // Quick and dirty list copying. No point in doing deep copies here.
		job_diff -= initial(job.department_head)
		if(job_diff.len == bad_heads.len)
			GLOB.hop_crate_goodies += initial(job.mail_goodies)

/datum/supply_pack/hop_mail/generate(atom/owning_turf, datum/bank_account/paying_account)
	var/obj/structure/closet/crate/crate
	crate = new /obj/structure/closet/crate/secure(owning_turf)
	crate.name = "Mail for the HoP - Sent by Central Command"

	if(access)
		crate.req_access = list(access)
	if(access_any)
		crate.req_one_access = access_any

	fill(crate)
	return crate

/datum/supply_pack/hop_mail/fill(obj/structure/closet/crate/crate)
	var/obj/item/holochip/chip = new /obj/item/holochip(crate, round(value * rand(0.8, 1.2)))
	chip.AddComponent(/datum/component/hidden_from_cargo_manifest)

	for(var/amount = pick(3, 6), amount > 0, amount--)
		var/obj/goodie = pick_weight(GLOB.hop_crate_goodies)
		new goodie(crate)
