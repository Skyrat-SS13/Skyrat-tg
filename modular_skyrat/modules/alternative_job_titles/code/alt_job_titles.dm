/**
 * This is the file you should use to add alternate titles for each job, just
 * follow the way they're done here, it's easy enough and shouldn't take any
 * time at all to add more or add some for a job that doesn't have any.
 */

/datum/job
	/// The list of alternative job titles people can pick from, null by default.
	var/list/alt_titles = null


/datum/job/ai
	alt_titles = list("AI", "Station Intelligence", "Automated Overseer")

/datum/job/assistant
	alt_titles = list("Assistant", "Civilian", "Tourist", "Businessman", "Businesswoman", "Trader", "Entertainer", "Freelancer", "Artist", "Off-Duty Staff", "Off-Duty Crew")

/datum/job/atmospheric_technician
	alt_titles = list("Atmospheric Technician", "Life Support Technician", "Emergency Fire Technician", "Firefighter")

/datum/job/barber
	alt_titles = list("Barber", "Salon Manager", "Salon Technician", "Stylist", "Colorist")

/datum/job/bartender
	alt_titles = list("Bartender", "Mixologist", "Barkeeper")

/datum/job/blueshield
	alt_titles = list("Blueshield", "Command Bodyguard", "Executive Protection Agent")

/datum/job/botanist
	alt_titles = list("Botanist", "Hydroponicist", "Gardener", "Botanical Researcher", "Herbalist")

/datum/job/bouncer
	alt_titles = list("Bouncer", "Service Guard")

/datum/job/brigoff
	alt_titles = list("Corrections Officer", "Brig Officer", "Prison Guard")

/datum/job/captain
	alt_titles = list("Captain", "Station Commander", "Commanding Officer", "Site Manager")

/datum/job/cargo_technician
	alt_titles = list("Cargo Technician", "Deck Worker", "Mailman")

/datum/job/chaplain
	alt_titles = list("Chaplain", "Priest", "Preacher", "Reverend", "Oracle", "Pontifex", "Magister", "High Priest", "Imam", "Rabbi", "Monk") //i would add OT III but honestly, thats way too specific

/datum/job/chemist
	alt_titles = list("Chemist", "Pharmacist", "Pharmacologist")

/datum/job/chief_engineer
	alt_titles = list("Chief Engineer", "Engineering Foreman", "Head of Engineering")

/datum/job/chief_medical_officer
	alt_titles = list("Chief Medical Officer", "Medical Director", "Head of Medical")

/datum/job/clown
	alt_titles = list("Clown", "Jester")

/datum/job/cook
	alt_titles = list("Cook", "Chef", "Butcher", "Culinary Artist", "Sous-Chef")

/datum/job/curator
	alt_titles = list("Curator", "Librarian", "Journalist", "Archivist")

/datum/job/customs_agent
	alt_titles = list("Customs Agent", "Customs Guard", "Supply Guard")

/datum/job/cyborg
	alt_titles = list("Cyborg", "Robot", "Android")

/datum/job/detective
	alt_titles = list("Detective", "Forensic Technician", "Private Investigator", "Forensic Scientist")

/datum/job/doctor
	alt_titles = list("Medical Doctor", "Surgeon", "Nurse", "General Practitioner", "Medical Resident", "Physician")

/datum/job/engineering_guard //see orderly


/datum/job/expeditionary_trooper
	alt_titles = list("Expeditionary Trooper", "Vanguard Operative", "Vanguard Pointman", "Expeditionary Field Medic", "Vanguard Marksman", "Expeditionary Combat Technician")

/datum/job/geneticist
	alt_titles = list("Geneticist", "Mutation Researcher")

/datum/job/head_of_personnel
	alt_titles = list("Head of Personnel", "Executive Officer", "Employment Officer", "Crew Supervisor")

/datum/job/head_of_security
	alt_titles = list("Head of Security", "Security Commander", "Chief Constable", "Chief of Security", "Sheriff")

/datum/job/janitor
	alt_titles = list("Janitor", "Custodian", "Custodial Technician", "Sanitation Technician", "Maintenance Technician", "Concierge", "Maid")

/datum/job/lawyer
	alt_titles = list("Lawyer", "Internal Affairs Agent", "Human Resources Agent", "Defence Attorney", "Public Defender", "Barrister", "Prosecutor")

/datum/job/mime
	alt_titles = list("Mime", "Pantomimist")

/datum/job/nanotrasen_consultant
	alt_titles = list("Nanotrasen Consultant", "Nanotrasen Diplomat", "Central Command Consultant", "Nanotrasen Representative", "Central Command Representative")

/datum/job/orderly
	alt_titles = list("Orderly", "Medical Guard") // departmental guards alt-titles should be kept to [department] guard to avoid confusion

/datum/job/paramedic
	alt_titles = list("Paramedic", "Emergency Medical Technician", "Search and Rescue Technician")

/datum/job/prisoner
	alt_titles = list("Prisoner", "Minimum Security Prisoner", "Maximum Security Prisoner", "SuperMax Security Prisoner", "Protective Custody Prisoner", "Convict", "Felon", "Inmate")

/datum/job/psychologist
	alt_titles = list("Psychologist", "Psychiatrist", "Therapist", "Counsellor")

/datum/job/quartermaster
	alt_titles = list("Quartermaster", "Deck Chief", "Supply Foreman", "Head of Supply", "Chief Requisition Officer", "Logistics Officer")

/datum/job/research_director
	alt_titles = list("Research Director", "Silicon Administrator", "Lead Researcher", "Biorobotics Director", "Research Supervisor", "Chief Science Officer")

/datum/job/roboticist
	alt_titles = list("Roboticist", "Biomechanical Engineer", "Mechatronic Engineer")

/datum/job/science_guard // See ordlerly


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
	)

/datum/job/security_medic
	alt_titles = list("Security Medic", "Field Medic", "Security Corpsman", "Brig Physician")

/datum/job/security_officer
	alt_titles = list("Security Officer", "Security Operative", "Peacekeeper")

/datum/job/shaft_miner
	alt_titles = list("Shaft Miner", "Excavator", "Spelunker", "Drill Technician", "Prospector")

/datum/job/station_engineer
	alt_titles = list("Station Engineer", "Emergency Damage Control Technician", "Electrician", "Engine Technician", "EVA Technician", "Mechanic")

/datum/job/virologist
	alt_titles = list("Virologist", "Pathologist")

/datum/job/warden
	alt_titles = list("Warden", "Brig Sergeant", "Dispatch Officer", "Brig Governor", "Jailer")
