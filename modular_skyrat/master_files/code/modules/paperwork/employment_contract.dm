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
	add_raw_text("\
	<center><font size=3>Conditions of Employment</center><font size=2>\
	<br><hr><br>\
	This Agreement is made and entered into as of the date of last signature below, by and between [employee_name] (hereafter referred to as the <i><u>employee</u></i>),\
	and Nanotrasen (hereafter referred to as the <i><u>employer</u></i>).\
	<br>\
	<br><font size=3>WITNESSETH:<font size=2>\
	<br>\
	<br>WHEREAS, the <i><u>employee</u></i> is a natural born human, acceptable humanoid, or synthetic humanoid with proven sapience, possessing skills upon which the <i><u>employee</u></i> \
	can aid the <i><u>employer</u></i>, and seeks employment with them.\
	<br>WHEREAS, <i><u>employer</u></i> agrees to provide payment to the <i><u>employee</u></i> to the best of its ability depending on local circumstance and in a timely fashion, \
	in exchange for the completion of work duties described by the individual job postings to which the <i><u>employee</u></i> is assigned.\
	<br><br>NOW THEREFORE in consideration of the mutual covenants herein contained, and other good and valuable consideration, the parties hereto mutually agree as follows:\
	<br><br>In exchange for a fixed wage, the <i><u>employee</u></i> agrees to work for the <i><u>employer</u></i>, for a standard contract of no less than four years.\
	<br><br>The employee agrees to maintain confidentiality of all <i><u>employer</u></i> trade secrets, locations of stations or other strategically valuable items, \
	value or condition of assets, existence of pending lawsuits, or any other material that may impact the profit and health of the <i><u>employer</u></i> as a whole.\
	<br><br>Additionally, the <i><u>employee</u></i> allows the <i><u>employer</u></i> to access their medical, security and employment records for use in public relations, marketing, \
	product placement, experiments, or other company purposes not detailed by the contract. This includes and is not limited to the <i><u>employee</u></i>'s voice,\
	physical appearance, DNA sequences and Resonance; their provided criminal records and affiliations with any groups of interest; provided general background information \
	and additional information provided by verified third-party investigators; provided medical records and so forth.\
	<br><br>In case of lack of necessary skills to perform required tasks before the employment, the <i><u>employee</u></i> agrees to perform a skillchip installment and/or \
	memory upload with qualifications/skills programs necessary to perform their duties, and a skillchip removal and/or memory wipe after their contract's over. The following procedures' \
	medical fees, as well as the skillchip and/or memory altering procedures cost will be deducted from the <i><u>employee</u></i>'s payment at the end of the contract.\
	<br><br>To note for the aforementioned, any ongoing or pending criminal investigations, if originated from the Sol Federation, are to be halted for the duration of work contract, \
	with any possible crimes occuring within the <i><u>employer</u></i>'s facilities punished by the contracted or corporate paramilitary and security forces.\
	<br>Finally, the <i><u>employee</u></i> understands that the <i><u>employer</u></i> is not bound by the same contract principles as them and may terminate the contract at any time, \
	for any reason, and without warning if need be. The <i><u>employee</u></i> agrees to approach any and all employment disputes through the assigned Head of Personnel \
	or Central Command Representative aboard the station at the time of the dispute. An <i><u>employer</u></i> contracted lawyer may be present for the dispute \
	if requested by the <i><u>employee</u></i>. Wages are non-negotiable and no individual, including the Captain, on the station has the option to raise pay, \
	so the <i><u>employee</u></i> agrees to handle payment disputes through the proper channels or risk breach of contract.\
	<br><br>Signed, \
	<br><span style=\"color:black;font-family:'Segoe Script';\"><p><b>[employee_name]</b></p></span>\
	<br><br>\
	<hr><center>-----------------------------------<br>\
	<font size=3>❘❙❚❘❙❚|<span style=\"color:black;font-family:'Sitka Small Semibold';\">GLORY TO NANOTRASEN</span>™|❚❙❘❚❙❘</center></hr>\
	<br><br>\
	<font size=1>Under Corporate Law section 201 subsection B.3. Defacement, publication, or theft of this document is punishable by demerit or immediate contractual termination. \
	Central Command Representives are not responsible for possible loss of life, extermination, or bluespace occurances related to any sort of actions ordered to commit to."
	)
/obj/structure/filingcabinet/employment/addFile(mob/living/carbon/human/employee)
	new /obj/item/paper/work_contract(src, employee.mind.name)
