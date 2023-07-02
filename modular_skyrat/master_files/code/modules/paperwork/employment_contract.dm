
/obj/item/paper/work_contract
	icon_state = "paper_words"
	throw_range = 3
	throw_speed = 3
	item_flags = NOBLUDGEON
	///Needed to get the spawned mob's name to display in the paper.
	var/employee_name = ""

/obj/item/paper/work_contract/Initialize(mapload, new_employee_name)
	if(!new_employee_name)
		return INITIALIZE_HINT_QDEL

	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	employee_name = new_employee_name
	name = "paper- [employee_name] employment contract"
	add_raw_text("<center>Conditions of Employment</center>\
	<BR><BR><BR><BR>\
	This Agreement is made and entered into as of the date of last signature below, by and between [employee_name] (hereafter referred to as the <i>employee</i>), \
	and Nanotrasen (hereafter referred to as the <i>employer</i>).\
	<BR>WITNESSETH:<BR>WHEREAS, the <i>employee</i> is a natural born human, acceptable humanoid, or synthetic humanoid with proven sapience, possessing skills upon which the <i>employee</i> can aid the <i>employer</i>, \
    and seeks employment with them.<BR>WHEREAS, <i>employer</i> agrees to provide payment to the <i>employee</i> to the best of its ability depending on \
	local circumstance and in a timely fashion, \
    in exchange for the completion of work duties described by the individual job postings to which the <i>employee</i> is assigned.<BR>NOW THEREFORE in consideration of the \
	mutual covenants herein contained, and other good and valuable consideration, the parties hereto mutually agree as follows:\
    <BR>In exchange for a fixed wage, the <i>employee</i> agrees to work for the <i>employer</i>, \
    for a standard contract of no less than four years.<BR>The employee agrees to maintain confidentiality of all <i>employer</i> trade secrets, \
	locations of stations or other strategically valuable items, value or condition of assets, existence of pending lawsuits, \
	or any other material that may impact the profit and health of the <i>employer</i> as a whole. <BR>\
	Additionally, the <i>employee</i> allows the <i>employer</i> to access their medical, security and employment records for use in public relations, marketing, \
	product placement, experiments, or other company purposes not detailed by the contract. This includes and is not limited to the <i>employee</i>'s voice, \
	physical appearance, DNA sequences and Resonance; their provided criminal records and affiliations with any groups of interest; provided general background information \
	and additional information provided by verified third-party investigators. <BR>\
	In case of lack of necessary skills to perform required tasks before the employment, the <i>employee</i> agrees to perform a skillchip installment and/or \
	memory upload with qualification skills programs necessary to perform their duties, and a skillchip removal and/or memory wipe after their contract's over. The following procedures' \
	medical fees, as well as the skillchip and/or memory altering procedures cost will be deducted from the <i>employee</i>'s payment at the end of the contract. <BR>\
	To note for the aforementioned, any ongoing or pending criminal investigations, if originated from the Sol Federation, are to be halted for the duration of work contract, \
	with any possible crimes occuring within the <i>employer</i>'s facilities punished by the contracted or corporate paramilitary and security forces. <BR>\
	Finally, the <i>employee</i> understands that the <i>employer</i> is not bound by the same contract principles as them and may terminate the contract at any time, \
	for any reason, and without warning if need be. The <i>employee</i> agrees to approach any and all employment disputes through the assigned Head of Personnel \
	or Central Command Representative aboard the station at the time of the dispute. An <i>employer</i> contracted lawyer may be present for the dispute \
	if requested by the <i>employee</i>. Wages are non-negotiable and no individual, including the Captain, on the station has the option to raise pay, \
	so the <i>employee</i> agrees to handle payment disputes through the proper channels or risk breach of contract.\
	<BR>Signed,<BR><span style=\"color:black;font-family:'Segoe Script';\"><p><b>[employee_name]</b></p></span>")

/obj/structure/filingcabinet/employment/addFile(mob/living/carbon/human/employee)
	new /obj/item/paper/work_contract(src, employee.mind.name)
