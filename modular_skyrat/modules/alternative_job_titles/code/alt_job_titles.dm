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
		"Automated Overseer",
		"Station Intelligence",
	)

/datum/job/assistant
	alt_titles = list(
		"Assistant",
		"Ambassador"
		"Artist",
		"Actor",
		"Businessman",
		"Businesswoman",
		"Butler",
		"Colonist",
		"Contractor",
		"Civilian",
		"Duke",
		"Diplomat"
		"Entertainer",
		"Freelancer",
		"Fitness Instructor",
		"Fisher",
		"Fisherman",
		"Fisherwoman",
		"Hobbyist",
		"Tourist",
		"Trader",
		"Performer",
		"Personal Physician",
		"Off-Duty Crew",
		"Off-Duty Staff",
		"Musician",
		"Waiter",
	)

/datum/job/atmospheric_technician
	alt_titles = list(
		"Atmospheric Technician",
		"Emergency Fire Technician",
		"Firefighter",
		"Life Support Technician",
		"HVAC Engineer",
	)

/datum/job/barber
	alt_titles = list(
		"Barber",
		"Aethestician",
		"Colorist",
		"Masseuse",
		"Salon Manager",
		"Salon Technician",
		"Stylist",
	)

/datum/job/bartender
	alt_titles = list(
		"Bartender",
		"Barista",
		"Barkeeper",
		"Tavernkeeper",
		"Mixologist",
	)

/datum/job/bitrunner
	alt_titles = list(
		"Bitrunner",
		"Bitdomain Technician",
		"Data Retrieval Specialist",
		"Netdiver",
		"Pod Jockey",
		"Union Bitrunner",
		"Junior Runner",
		"Professional Gamer",
	)

/datum/job/blueshield
	alt_titles = list(
		"Blueshield",
		"Command Bodyguard",
		"Executive Protection Agent",
		"Command Goon",
	)

/datum/job/botanist
	alt_titles = list(
		"Botanist",
		"Botanical Researcher",
		"Florist",
		"Gardener",
		"Herbalist",
		"Hydroponicist",
		"Mycologist",
		"Junior Botanist",
		"Apiarist",
		"Apiculturist",
		"Beekeeper",
		"Farmer",
	)

/datum/job/bouncer
	alt_titles = list(
		"Bouncer",
		"Service Guard",
		"Sevice Goon",
		"Doorman",
		"Doorwoman",
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
		"Commanding Officer",
		"Site Manager",
		"Station Commander",
		"Facility Director",
	)

/datum/job/cargo_technician
	alt_titles = list(
		"Cargo Technician",
		"Warehouse Technician",
		"Commodities Trader",
		"Deck Worker",
		"Inventory Associate",
		"Mailman",
		"Mailwoman",
		"Mail Carrier",
		"Merchantman",
		"Merchantwoman",
		"Postman",
		"Postwoman",
		"Receiving Clerk",
		"Union Associate",
	)

/datum/job/chaplain
	alt_titles = list(
		"Chaplain",
		"Clockwork Priest",
		"Cleric",
		"High Priest",
		"High Priestess",
		"Imam",
		"Magister",
		"Monk",
		"Nun",
		"Oracle",
		"Preacher",
		"Priest",
		"Priestess",
		"Pontifex",
		"Guru",
		"Rabbi",
		"Reverend",
		"Shrine Maiden",
		"Shrine Guardian",
	)

/datum/job/chemist
	alt_titles = list(
		"Chemist",
		"Alchemist",
		"Pharmacist",
		"Pharmacologist",
		"Trainee Pharmacist",
	)

/datum/job/chief_engineer
	alt_titles = list(
		"Chief Engineer",
		"Head Crystallomancer",
		"Engineering Foreman",
		"Head of Engineering",
	)

/datum/job/chief_medical_officer
	alt_titles = list(
		"Chief Medical Officer",
		"Chief Physician",
		"Head of Medical",
		"Head Physician",
		"Medical Director",
	)

/datum/job/clown
	alt_titles = list(
		"Clown",
		"Comedian",
		"Jester",
		"Joker",
	)

/datum/job/cook
	alt_titles = list(
		"Cook",
		"Baker"
		"Butcher",
		"Chef",
		"Line Cook",
		"Fry Cook",
		"Culinary Artist",
		"Sous-Chef",
		"Junior Chef",
		"Tavern Chef",,
		"Confectionist",
		"Pastry Chef",
	)

/datum/job/coroner
	alt_titles = list(
		"Coroner",
		"Forensic Pathologist",
		"Funeral Director",
		"Medical Examiner",
		"Mortician",
		"Undertaker",
	)

/datum/job/curator
	alt_titles = list(
		"Curator",
		"Adventurer",
		"Archivist",
		"Conservator",
		"Journalist",
		"Librarian",
		"Historian",
		"Archaeologist",
		"Professor",
		"Veteran Adventurer"
	)

/datum/job/customs_agent
	alt_titles = list(
		"Customs Agent",
		"Supply Guard",
	)

/datum/job/cyborg
	alt_titles = list(
		"Cyborg",
		"Android",
		"Robot",
	)

/datum/job/detective
	alt_titles = list(
		"Detective",
		"Forensic Scientist",
		"Forensic Technician",
		"Private Investigator",
	)

/datum/job/doctor
	alt_titles = list(
		"Medical Doctor",
		"General Practitioner",
		"Medical Resident",
		"Nurse",
		"Physician",
		"Surgeon",
		"Medical Student",
		"Virologist",
		"Epidemiologist",
		"Pathologist",
		"Junior Pathologist",
	)

/datum/job/engineering_guard //see orderly
	alt_titles = list(
		"Engineering Guard",
		"Engineering Goon",
	)

/datum/job/geneticist
	alt_titles = list(
		"Geneticist",
		"Genemancer",
		"Gene Tailor",
		"Mutation Researcher",
	)

/datum/job/head_of_personnel
	alt_titles = list(
		"Head of Personnel",
		"Crew Supervisor",
		"Employment Officer",
		"Executive Officer",
	)

/datum/job/head_of_security
	alt_titles = list(
		"Head of Security",
		"Commander of the Guard",
		"Commissioner of Security",
		"Chief Constable",
		"Chief of Security",
		"Security Commander",
		"Sheriff",
	)

/datum/job/janitor
	alt_titles = list(
		"Janitor",
		"Concierge",
		"Custodial Technician",
		"Custodian",
		"Groundskeeper",
		"Maid",
		"Maintenance Technician",
		"Sanitation Technician",
	)

/datum/job/lawyer
	alt_titles = list(
		"Lawyer",
		"Barrister",
		"Defense Attorney",
		"Human Resources Agent",
		"Internal Affairs Agent",
		"Magistrate",
		"Legal Clerk",
		"Prosecutor",
		"Public Defender",
	)

/datum/job/mime
	alt_titles = list(
		"Mime",
		"Mummer",
		"Pantomimist",
	)

/datum/job/nanotrasen_consultant
	alt_titles = list(
		"Nanotrasen Consultant",
		"Nanotrasen Advisor",
		"Nanotrasen Diplomat",
		"Nanotrasen Representative",
		"Nanotrasen Liason",
		"Central Command Consultant",
		"Central Command Advisor",
		"Central Command Diplomat",
		"Central Command Representative",
		"Central Command Liason",
		"Corporate Liason",
	)

/datum/job/orderly
	alt_titles = list(
		"Orderly",
		"Medical Guard",
		"Medical Goon",
	) //other dept guards' alt-titles should be kept to [department] guard to avoid confusion, unless the department gets a re-do.

/datum/job/paramedic
	alt_titles = list(
		"Paramedic",
		"Emergency Medical Technician",
		"Search and Rescue Technician",
		"Trauma Team Responder",
	)

/datum/job/prisoner
	alt_titles = list(
		"Prisoner",
		"Minimum Security Prisoner",
		"Maximum Security Prisoner",
		"SuperMax Security Prisoner",
		"Protective Custody Prisoner",
	)

/datum/job/psychologist
	alt_titles = list(
		"Psychologist",
		"Counsellor",
		"Psychiatrist",
		"Therapist",
	)

/datum/job/quartermaster
	alt_titles = list(
		"Quartermaster",
		"Deck Chief",
		"Head of Supply",
		"Logistics Coordinator",
		"Supply Foreman",
		"Union Requisitions Officer",
		"Warehouse Supervisor",
	)

/datum/job/research_director
	alt_titles = list(
		"Research Director",
		"Biorobotics Director",
		"Chief Science Officer",
		"Lead Researcher",
		"Research Supervisor",
		"Silicon Administrator",
	)

/datum/job/roboticist
	alt_titles = list(
		"Roboticist",
		"Biomechanical Engineer",
		"Cyberneticist",
		"Machinist",
		"Mechatronic Engineer",
		"Apprentice Roboticist",
	)

/datum/job/science_guard //See orderly
	alt_titles = list(
		"Science Guard",
		"Research Guard",
		"Science Goon",
	)

/datum/job/scientist
	alt_titles = list(
		"Scientist",
		"Anomalist",
		"Circuitry Designer",
		"Cytologist",
		"Graduate Student",
		"Lab Technician",
		"Ordnance Technician",
		"Plasma Researcher",
		"Resonance Researcher",
		"Theoretical Physicist",
		"Xenoarchaeologist",
		"Xenobiologist",
		"Research Assistant",
	)

/datum/job/security_officer
	alt_titles = list(
		"Security Officer",
		"Guard",
		"Security Guard",
		"Security Constable",
		"Peacekeeper",
		"Security Operative",
		"Security Cadet",
		"Junior Officer",
		"Security Assistant",
	)

/datum/job/shaft_miner
	alt_titles = list(
		"Shaft Miner",
		"Union Miner",
		"Excavator",
		"Drill Technician",
		"Prospector",
		"Spelunker",
		"Apprentice Miner",
	)

/datum/job/station_engineer
	alt_titles = list(
		"Station Engineer",
		"Electrician",
		"Emergency Damage Control Technician",
		"Engine Technician",
		"EVA Technician",
		"Mechanic",
		"Apprentice Engineer",
	)

/datum/job/telecomms_specialist
	alt_titles = list(
		"Telecomms Specialist",
		"Wireless Operator",
		"Network Engineer",
		"Sysadmin",
		"Tram Technician",
	)


/datum/job/warden
	alt_titles = list(
		"Warden",
		"Armory Superintendent"
		"Brig Sergeant",
		"Brig Sentry",
		"Brig Governor",
		"Deputy Commissioner of Security",
		"Dispatch Officer",
		"Deputy Commissioner
		"Jailer",
		"Master-at-Arms",
	)
