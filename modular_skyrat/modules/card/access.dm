//moved from code/modules/jobs/access.dm
/proc/get_all_jobs() //All on-station jobs go here.
	return list("Assistant", "Captain", "Head of Personnel", "Bartender", "Cook", "Botanist", "Quartermaster", "Cargo Technician",
				"Shaft Miner", "Clown", "Mime", "Janitor", "Curator", "Lawyer", "Chaplain", "Chief Engineer", "Station Engineer",
				"Atmospheric Technician", "Chief Medical Officer", "Medical Doctor", "Paramedic", "Chemist", "Geneticist", "Virologist", "Psychologist",
				"Research Director", "Scientist", "Roboticist", "Head of Security", "Warden", "Detective", "Security Officer", "Security Medic", "Security Sergeant", 
				"Prisoner", "Blueshield", "Shuttle Pilot")

/proc/get_all_job_icons() //For all existing HUD icons, Things a HoP or someone with an agent card might realistically apply,  but not a real job. Also ghost role / event stuffs.
	return get_all_jobs() + list("Emergency Response Team Commander", "Security Response Officer", "Engineering Response Officer", "Medical Response Officer", "Entertainment Response Officer", "Religious Response Officer", "Janitorial Response Officer", "Death Commando",
	"Operative", "Tradepost Officer", "CentCom Psychologist", "Bluespace Tech", "Syndicate Overlord", "Syndicate Operative", "Syndicate Ship Captain",
	"Charlie Station Security Officer", "Charlie Station Scientist", "Charlie Station Engineer", "Charlie Station Assistant", "Charlie Station Botanist", "Charlie Station Curator", "Charlie Station Lawyer", "Charlie Station Chaplain", "Charlie Station Bartender", "Charlie Station Cook",
	"Charlie Station Janitor", "Charlie Station Clown", "Charlie Station Mime", "Charlie Station Quartermaster", "Charlie Station Cargo Technician", "Charlie Station Shaft Miner", "Charlie Station Atmospheric Technician", "Charlie Station Virologist", "Charlie Station Chemist",
	"Charlie Station Paramedic", "Charlie Station Psychologist", "Charlie Station Medical Doctor", "Charlie Station Geneticist", "Charlie Station Roboticist", "Charlie Station Warden", "Charlie Station Detective", "Charlie Station Prisoner", "Charlie Station Head Of Security",
	"Charlie Station Head Of Personnel", "Charlie Station Chief Engineer", "Charlie Station Research Director", "Charlie Station Chief Medical Officer", "Charlie Station Captain","CentCom Assistant","CentCom Botanist","CentCom Curator","CentCom Lawyer","CentCom Chaplain",
	"CentCom Bartender","CentCom Cook","CentCom Janitor","CentCom Clown","CentCom Mime","CentCom Quartermaster","CentCom Cargo Technician","CentCom Shaft Miner","CentCom Atmospheric Technician","CentCom Station Engineer","CentCom Virologist","CentCom Chemist","CentCom Paramedic",
	"CentCom Medical Doctor","CentCom Medical Doctor","CentCom Geneticist","CentCom Scientist","CentCom Roboticist","CentCom Warden","CentCom Detective","CentCom Security Officer","CentCom Prisoner","Admiral", "Protective Custody", "VIP Guest", "Custodian","Medical Officer",
	"Research Officer","Special Ops Officer","Private Security Force","CentCom Commander","Service Guest","Guest Comedian","Private Trader","Independent Technician","Long Term Patient","Research Subject","Independent Researcher","Security Contractor", "DonkCo Diplomat",
	"Cybersun Diplomat","Interdyne Chemist","Syndicate","Syndicate Prisoner","Nuclear Operative","Assault Operative","Lizard","Moth","Kobold","Cutie","Station Admiral","Corporate Liaison","Chief Engineering Officer","Chief Research Officer","Chief Master At Arms",
	"Investigative Officer","Brig Officer","Master At Arms","Corporate Lawyer","Station Medical Officer","Bioweapons Technician","Engine Technicinan","Genetics Researcher","Researcher","Robotics Technician","Chef","Counsel","Sanitation Technician","Deck Officer",
	"Deck Crewman","Syndicate Staff","Comms Officer")

/proc/get_all_centcom_jobs() //Admin-only jobs or jobs that nobody would care if it was a generic nanotrasen logo.
	return list("Central Command","Thunderdome Overseer","CentCom Official")
