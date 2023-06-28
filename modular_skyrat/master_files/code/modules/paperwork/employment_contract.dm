
/obj/item/paper/work_contract
	icon_state = "paper_words"
	throw_range = 3
	throw_speed = 3
	item_flags = NOBLUDGEON
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
	This Agreement is made and entered into as of the date of last signature below, by and between [employee_name] (hereafter referred to as <i>the employee</i>), \
	and Nanotrasen (hereafter referred to as the <i>employer</i>).\
	<BR>WITNESSETH:<BR>WHEREAS, <i>the employee</i> is a natural born human, acceptable humanoid, or synthetic humanoid with proven sapience, possessing skills upon which <i>the employee</i> can aid the <i>employer</i>, \
    and seeks employment with them.<BR>WHEREAS, <i>employer</i> agrees to provide payment to <i>the employee</i> to the best of its ability depending on local circumstance and in a timely fashion, \
    in exchange for the completion of work duties described by the individual job postings to which <i>the employee</i> is assigned.<BR>NOW THEREFORE in consideration of the mutual covenants herein contained, and other good and valuable consideration, the parties hereto mutually agree as follows:\
    <BR>In exchange for a fixed wage, <i>the employee</i> agrees to work for the <i>employer</i>, \
    for a standard contract of no less than four years.<BR>The employee agrees to maintain confidentiality of all <i>employer</i> trade secrets, \
	locations of stations or other strategically valuable items, value or condition of assets, existence of pending lawsuits, \
	or any other material that may impact the profit and health of the <i>employer</i> as a whole.  \
	Additionally, <i>the employee</i> understands that the <i>employer</i> is not bound by the same contract principles as them and may terminate the contract at any time, \
	for any reason, and without warning if need be. The employee agrees to approach any and all employment disputes through the assigned Head of Personnel \
	or Central Command Representative aboard the station at the time of the dispute. An <i>employer</i> contracted lawyer may be present for the dispute \
	if requested by <i>the employee</i>. Wages are non-negotiable and no individual, including the Captain, on the station has the option to raise pay, \
	so <i>the employee</i> agrees to handle payment disputes through the proper channels or risk breach of contract.\
    <BR>Signed,<BR><span style=\"color:black;font-family:'Segoe Script';\"><p><b>[employee_name]</b></p></span>")

/obj/structure/filingcabinet/employment/addFile(mob/living/carbon/human/employee)
	new /obj/item/paper/work_contract(src, employee.mind.name)
