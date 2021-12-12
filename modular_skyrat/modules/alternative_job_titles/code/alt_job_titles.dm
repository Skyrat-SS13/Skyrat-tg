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
	alt_titles = list("Assistant", "Civilian", "Tourist", "Businessman", "Trader", "Entertainer", "Off-Duty Staff")

/datum/job/atmospheric_technician
	alt_titles = list("Atmospheric Technician", "Life Support Technician", "Emergency Fire Technician")

/datum/job/barber
	alt_titles = list("Salon Manager", "Salon Technician", "Stylist", "Colorist")

/datum/job/bartender
	alt_titles = list("Bartender", "Mixologist")

/datum/job/blueshield
	alt_titles = list("Blueshield", "Command Bodyguard", "Executive Protection Agent")


/datum/job/botanist
	alt_titles = list("Botanist", "Hydroponicist", "Gardener", "Botanical Researcher", "Herbalist")

/datum/job/bouncer


/datum/job/brigoff
	alt_titles = list("Corrections Officer", "Brig Officer", "Prison Guard")

/datum/job/captain
	alt_titles = list("Captain", "Station Commander", "Commanding Officer", "Site Manager")

/datum/job/cargo_technician
	alt_titles = list("Cargo Technician", "Deck Worker", "Mailman")

/datum/job/chaplain
	alt_titles = list("Chaplain", "Priest", "Preacher")

/datum/job/chemist
	alt_titles = list("Chemist", "Pharmacist", "Pharmacologist")

/datum/job/chief_engineer
	alt_titles = list("Chief Engineer", "Engineering Foreman")

/datum/job/chief_medical_officer
	alt_titles = list("Chief Medical Officer", "Medical Director")

/datum/job/clown
	alt_titles = list("Clown", "Jester")

/datum/job/cook
	alt_titles = list("Cook", "Chef", "Butcher", "Culinary Artist", "Sous-Chef")

/datum/job/curator
	alt_titles = list("Curator", "Librarian", "Journalist", "Archivist")

/datum/job/customs_agent


/datum/job/cyborg
	alt_titles = list("Cyborg", "Robot", "Android")

/datum/job/detective
	alt_titles = list("Detective", "Forensic Technician", "Private Investigator", "Forensic Scientist")

/datum/job/doctor
	alt_titles = list("Medical Doctor", "Surgeon", "Nurse")

/datum/job/engineering_guard


/datum/job/expeditionary_trooper


/datum/job/geneticist
	alt_titles = list("Geneticist", "Mutation Researcher")

/datum/job/head_of_personnel
	alt_titles = list("Head of Personnel", "Executive Officer", "Employment Officer", "Crew Supervisor")

/datum/job/head_of_security
	alt_titles = list("Head of Security", "Security Commander")

/datum/job/janitor
	alt_titles = list("Janitor", "Custodian", "Custodial Technicial", "Sanitation Technician", "Maid")

/datum/job/lawyer
	alt_titles = list("Lawyer", "Internal Affairs Agent", "Human Resources Agent")

/datum/job/mime
	alt_titles = list("Mime", "Pantomimist")

/datum/job/nanotrasen_representative
	alt_titles = list("Nanotrasen Representative", "Nanotrasen Diplomat", "Central Command Representative")

/datum/job/orderly


/datum/job/paramedic
	alt_titles = list("Paramedic", "Emergency Medical Technician", "Search and Rescue Technician")

/datum/job/prisoner
	alt_titles = list("Prisoner", "Minimum Security Prisoner", "Maximum Security Prisoner", "SuperMax Security Prisoner", "Protective Custody Prisoner")

/datum/job/psychologist
	alt_titles = list("Psychologist", "Psychiatrist", "Therapist", "Counsellor")

/datum/job/quartermaster
	alt_titles = list("Quartermaster", "Deck Chief", "Cargo Foreman")

/datum/job/research_director
	alt_titles = list("Research Director", "Silicon Administrator", "Lead Researcher", "Biorobotics Director", "Research Supervisor", "Chief Science Officer")

/datum/job/roboticist
	alt_titles = list("Roboticist", "Biomechanical Engineer", "Mechatronic Engineer")

/datum/job/science_guard


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
	)

/datum/job/security_medic
	alt_titles = list("Security Medic", "Field Medic", "Security Corpsman", "Brig Physician")

/datum/job/security_officer
	alt_titles = list("Security Officer", "Security Operative", "Peacekeeper")

/datum/job/security_sergeant
	alt_titles = list("Security Sergeant", "Security Squad Leader", "Security Task Force Leader", "Security Fireteam Leader")

/datum/job/shaft_miner
	alt_titles = list("Shaft Miner", "Excavator")

/datum/job/station_engineer
	alt_titles = list("Station Engineer", "Emergency Damage Control Technician", "Electrician", "Engine Technician", "EVA Technician")

/datum/job/virologist
	alt_titles = list("Virologist", "Pathologist")

/datum/job/warden
	alt_titles = list("Warden", "Brig Sergeant", "Dispatch Officer")
