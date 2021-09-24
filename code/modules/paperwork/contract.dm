/* For employment contracts */

/obj/item/paper/contract
	throw_range = 3
	throw_speed = 3
	var/signed = FALSE
	var/datum/mind/target
	item_flags = NOBLUDGEON

<<<<<<< HEAD
/obj/item/paper/contract/ComponentInitialize()
=======
/obj/item/paper/employment_contract/Initialize(mapload)
>>>>>>> 6c01cc2c010 (every case of initialize that should have mapload, does (#61623))
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/paper/contract/proc/update_text()
	return

/obj/item/paper/contract/employment
	icon_state = "paper_words"

/obj/item/paper/contract/employment/New(atom/loc, mob/living/nOwner)
	. = ..()
	if(!nOwner || !nOwner.mind)
		qdel(src)
		return -1
	target = nOwner.mind
	update_text()


/obj/item/paper/contract/employment/update_text()
	name = "paper- [target] employment contract"
	info = "<center>Employment Agreement</center> <BR><center>[target]</center><BR><BR><BR><BR>This Agreement is made and entered into as of the date of last signature below, by and between [target] (hereafter referred to as EMPLOYEE), and Nanotrasen (hereafter referred to as the company).<BR>WITNESSETH:<BR>WHEREAS, EMPLOYEE is a registered citizen of SolGov, SolGov recognised galactic entities, or any other entity listed in the Nanotrasen recognised entities list<BR>WHEREAS, EMPLOYEE possesses skills upon which he can aid the company, and seeks employment in the company in accordance with said skills.<BR>WHEREAS, the company agrees to regularly provide salary according to position, in accordance with the Nanotrasen salary rates statement, subject to inflation, tax, and SolGov regulations, in exchange for employment.<BR>WHEREAS, EMPLOYEE agrees to abide by all Corporate Regulations, and waives all legal rights that would conflict with due punishment of breach of these regulations.<BR>WHEREAS, EMPLOYEE will perform their duties in accordance with Standard Operating Procedure and the company's best interests.<BR>WHEREAS, EMPLOYEE agrees to resolve any and all legal disputes, both of a criminal and civil nature, under the exclusive jurisdiction of the Nanotrasen court system, and waives any right to civil redress when attempting to claim action under any other court.<BR>WHEREAS, EMPLOYEE agrees to all 2761 terms of employment contained within the Nanotrasen employee manual, all 942 clauses contained within the employee privacy policy, the entirety of the workplace hazard rights waiver, and any other clauses contained within written documents associated with this agreement as approved by the company<BR>NOW THEREFORE in consideration of the mutual covenants herein contained, and other good and valuable consideration, the parties hereto mutually agree as follows:<BR>In exchange for salary payments, EMPLOYEE agrees to work for the company, for the remainder of his or her employable life(s).<BR>Further, EMPLOYEE agrees to the clauses of this document, to adherence to Corporate Regulations, and Standard Operating Procedure.<BR>Authority over the employment of [target] is transferred to the relevant departmental head for his station of employment, the captain of said station (provided he is not, himself, the captain), and any corporate agent higher in the chain of command, at the time of signing of this document.<BR>Signed,<BR><i>[target]</i>" // SKYRAT EDIT
// SKYRAT EDIT -- ORIGINAL
// info = "<center>Conditions of Employment</center><BR><BR><BR><BR>This Agreement is made and entered into as of the date of last signature below, by and between [target] (hereafter referred to as SLAVE), and Nanotrasen (hereafter referred to as the omnipresent and helpful watcher of humanity).<BR>WITNESSETH:<BR>WHEREAS, SLAVE is a natural born human or humanoid, possessing skills upon which he can aid the omnipresent and helpful watcher of humanity, who seeks employment in the omnipresent and helpful watcher of humanity.<BR>WHEREAS, the omnipresent and helpful watcher of humanity agrees to sporadically provide payment to SLAVE, in exchange for permanent servitude.<BR>NOW THEREFORE in consideration of the mutual covenants herein contained, and other good and valuable consideration, the parties hereto mutually agree as follows:<BR>In exchange for paltry payments, SLAVE agrees to work for the omnipresent and helpful watcher of humanity, for the remainder of his or her current and future lives.<BR>Further, SLAVE agrees to transfer ownership of his or her soul to the loyalty department of the omnipresent and helpful watcher of humanity.<BR>Should transfership of a soul not be possible, a lien shall be placed instead.<BR>Signed,<BR><i>[target]</i>"
