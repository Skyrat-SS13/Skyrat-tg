/**
 * This is the file you should use to add alternate titles for each job, just
 * follow the way they're done here, it's easy enough and shouldn't take any
 * time at all to add more or add some for a job that doesn't have any.
 */

/datum/job
	/// The list of alternative job titles people can pick from, null by default.
	var/list/alt_titles = null


/datum/job/ai
	alt_titles = list(
		"AI",
		"Station Intelligence",
		"Automated Overseer"
	)

/datum/job/assistant
	alt_titles = list(
		"Assistant",
		"Civilian",
		"Tourist",
		"Businessman",
		"Businesswoman",
		"Trader",
		"Entertainer",
		"Freelancer",
		"Artist",
		"Off-Duty Staff",
		"Off-Duty Crew",
	)

/datum/job/atmospheric_technician
	alt_titles = list(
		"Atmospheric Technician",
		"Life Support Technician",
		"Emergency Fire Technician",
		"Firefighter",
	)

/datum/job/barber
	alt_titles = list(
		"Barber",
		"Salon Manager",
		"Salon Technician",
		"Stylist",
		"Colorist",
	)

/datum/job/bartender
	alt_titles = list(
		"Bartender",
		"Mixologist",
		"Barkeeper",
		"Barista",
	)

/datum/job/blueshield
	alt_titles = list(
		"Blueshield",
		"Command Bodyguard",
		"Executive Protection Agent",
	)

/datum/job/botanist
	alt_titles = list(
		"Botanist",
		"Hydroponicist",
		"Gardener",
		"Botanical Researcher",
		"Herbalist",
		"Florist",
	)

/datum/job/bouncer
	alt_titles = list(
		"Bouncer",
		"Service Guard",
	)

/datum/job/corrections_officer
	alt_titles = list(
		"Corrections Officer",
		"Brig Officer",
		"Prison Guard",
	)

/datum/job/captain
	alt_titles = list(
		"Captain",
		"Station Commander",
		"Commanding Officer",
		"Site Manager",
	)

/datum/job/cargo_technician
	alt_titles = list(
		"Warehouse Technician",
		"Deck Worker",
		"Mailman",
		"Union Associate",
		"Inventory Associate",
	)

/datum/job/chaplain
	alt_titles = list(
		"Chaplain",
		"Priest",
		"Preacher",
		"Reverend",
		"Oracle",
		"Pontifex",
		"Magister",
		"High Priest",
		"Imam",
		"Rabbi",
		"Monk",
	)

/datum/job/chemist
	alt_titles = list(
		"Chemist",
		"Pharmacist",
		"Pharmacologist",
		"Trainee Pharmacist",
	)

/datum/job/chief_engineer
	alt_titles = list(
		"Chief Engineer",
		"Engineering Foreman",
		"Head of Engineering",
	)

/datum/job/chief_medical_officer
	alt_titles = list(
		"Chief Medical Officer",
		"Medical Director",
		"Head of Medical",
		"Chief Physician",
		"Head Physician",
	)

/datum/job/clown
	alt_titles = list(
		"Clown",
		"Jester",
		"Joker",
		"Comedian",
	)

/datum/job/cook
	alt_titles = list(
		"Cook",
		"Chef",
		"Butcher",
		"Culinary Artist",
		"Sous-Chef",
	)

/datum/job/coroner
	alt_titles = list(
		"Coroner",
		"Mortician",
		"Funeral Director",
	)

/datum/job/curator
	alt_titles = list(
		"Curator",
		"Librarian",
		"Journalist",
		"Archivist",
	)

/datum/job/customs_agent
	alt_titles = list(
		"Customs Agent",
		"Supply Guard",
	)

/datum/job/cyborg
	alt_titles = list(
		"Cyborg",
		"Robot",
		"Android",
	)

/datum/job/detective
	alt_titles = list(
		"Detective",
		"Forensic Technician",
		"Private Investigator",
		"Forensic Scientist",
	)

/datum/job/doctor
	alt_titles = list(
		"Medical Doctor",
		"Surgeon",
		"Nurse",
		"General Practitioner",
		"Medical Resident",
		"Physician",
	)

/datum/job/engineering_guard //see orderly

/datum/job/geneticist
	alt_titles = list(
		"Geneticist",
		"Mutation Researcher",
	)

/datum/job/head_of_personnel
	alt_titles = list(
		"Head of Personnel",
		"Executive Officer",
		"Employment Officer",
		"Crew Supervisor",
	)

/datum/job/head_of_security
	alt_titles = list(
		"Head of Security",
		"Security Commander",
		"Chief Constable",
		"Chief of Security",
		"Sheriff",
	)

/datum/job/janitor
	alt_titles = list(
		"Janitor",
		"Custodian",
		"Custodial Technician",
		"Sanitation Technician",
		"Maintenance Technician",
		"Concierge",
		"Maid",
	)

/datum/job/lawyer
	alt_titles = list(
		"Lawyer",
		"Internal Affairs Agent",
		"Human Resources Agent",
		"Defence Attorney",
		"Public Defender",
		"Barrister",
		"Prosecutor",
		"Legal Clerk",
	)

/datum/job/mime
	alt_titles = list(
		"Mime",
		"Pantomimist",
	)

/datum/job/nanotrasen_consultant
	alt_titles = list(
		"Nanotrasen Consultant",
		"Nanotrasen Diplomat",
	)

/datum/job/orderly
	alt_titles = list(
		"Orderly",
		"Medical Guard",
	) //other dept guards' alt-titles should be kept to [department] guard to avoid confusion, unless the department gets a re-do.

/datum/job/paramedic
	alt_titles = list(
		"Paramedic",
		"Emergency Medical Technician",
		"Search and Rescue Technician",
	)

/datum/job/prisoner
	alt_titles = list(
		"Prisoner",
		"Minimum Security Prisoner",
		"Maximum Security Prisoner",
		"SuperMax Security Prisoner",
		"Protective Custody Prisoner",
		"Convict",
		"Felon",
		"Inmate",
	)

/datum/job/psychologist
	alt_titles = list(
		"Psychologist",
		"Psychiatrist",
		"Therapist",
		"Counsellor",
	)

/datum/job/quartermaster
	alt_titles = list(
		"Quartermaster",
		"Union Requisitions Officer",
		"Deck Chief",
		"Warehouse Supervisor",
		"Supply Foreman",
		"Head of Supply",
		"Logistics Coordinator",
	)

/datum/job/research_director
	alt_titles = list(
		"Research Director",
		"Silicon Administrator",
		"Lead Researcher",
		"Biorobotics Director",
		"Research Supervisor",
		"Chief Science Officer",
	)

/datum/job/roboticist
	alt_titles = list(
		"Roboticist",
		"Biomechanical Engineer",
		"Mechatronic Engineer",
		"Apprentice Roboticist",
	)

/datum/job/science_guard //See orderly

/datum/job/scientist
	alt_titles = list(
		"Scientist",
		"Circuitry Designer",
		"Xenobiologist",
		"Cytologist",
		"Plasma Researcher",
		"Anomalist",
		"Lab Technician",
		"Theoretical Physicist",
		"Ordnance Technician",
		"Xenoarchaeologist",
		"Research Assistant",
		"Graduate Student",
	)

/datum/job/security_officer
	alt_titles = list(
		"Security Officer",
		"Security Operative",
		"Peacekeeper",
		"Security Cadet",
	)

/datum/job/shaft_miner
	alt_titles = list(
		"Union Miner",
		"Excavator",
		"Spelunker",
		"Drill Technician",
		"Prospector",
	)

/datum/job/station_engineer
	alt_titles = list(
		"Station Engineer",
		"Emergency Damage Control Technician",
		"Electrician",
		"Engine Technician",
		"EVA Technician",
		"Mechanic",
		"Apprentice Engineer",
		"Engineering Trainee",
	)

/datum/job/virologist
	alt_titles = list(
		"Virologist",
		"Pathologist",
		"Junior Pathologist",
	)

/datum/job/warden
	alt_titles = list(
		"Warden",
		"Brig Sergeant",
		"Dispatch Officer",
		"Brig Governor",
		"Jailer",
	)
