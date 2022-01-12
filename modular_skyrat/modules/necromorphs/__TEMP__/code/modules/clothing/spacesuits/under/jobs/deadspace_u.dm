//Dead Space//
/obj/item/clothing/under/deadspace
/*
 * Command
 */
/obj/item/clothing/under/deadspace/captain
	name = "captain's uniform"
	desc = "A neatly pressed, blue uniform with navy blue patches on each shoulder and pure gold cuffs. Looks fancy!"
	item_state = "ds_captain"
	worn_state = "ds_captain"
	icon_state = "ds_captain"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0)
	species_allowed = list(SPECIES_NECROMORPH_SLASHER)
	sprite_sheets = list(
		SPECIES_NECROMORPH_SLASHER = 'icons/mob/necromorph/slasher/clothing.dmi'
		)

/obj/item/clothing/under/deadspace/first_lieutenant
	name = "first lieutenant's uniform"
	desc = "A neatly pressed, blue uniform with dark, green patches on each shoulder and gold cuffs with green highlights. Looks fancy!"
	item_state = "ds_firstlieutenant"
	worn_state = "ds_firstlieutenant"
	icon_state = "ds_firstlieutenant"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0)
	sprite_sheets = list(
		SPECIES_NECROMORPH_SLASHER = 'icons/mob/necromorph/slasher/clothing.dmi'
		)

/obj/item/clothing/under/deadspace/bridge_officer
	name = "ensign's uniform"
	desc = "A neatly pressed, blue uniform with burgundy patches on each shoulder. This uniform is typically worn by ensigns manning the bridge."
	item_state = "ds_bridgeensign"
	worn_state = "ds_bridgeensign"
	icon_state = "ds_bridgeensign"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0)


/*
 * Engineering
 */

/obj/item/clothing/under/deadspace/engineer
	name = "engineer's uniform"
	desc = "A sleek, navy blue uniform issued to engineering department. Typically, a vest is worn over top of this uniform."
	item_state = "ds_engineer"
	worn_state = "ds_engineer"
	icon_state = "ds_engineer"
	permeability_coefficient = 0.50

/*
 * Medical
 */
/obj/item/clothing/under/deadspace/senior_medical_officer
	name = "senior medical officer's uniform"
	desc = "A white uniform with a bright blue collar, symbolizing this uniform belongs to the Senior Medical Officer.."
	item_state = "ds_senior_med_officer"
	worn_state = "ds_senior_med_officer"
	icon_state = "ds_senior_med_officer"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0)
	species_allowed = list(SPECIES_NECROMORPH_SLASHER)

/obj/item/clothing/under/deadspace/doctor
	name = "medical doctor's uniform"
	desc = "A white uniform with a standard, gray collar, symbolizing this uniform belongs to the medical department."
	item_state = "ds_med_doctor"
	worn_state = "ds_med_doctor"
	icon_state = "ds_med_doctor"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0)
	species_allowed = list(SPECIES_NECROMORPH_SLASHER)
	sprite_sheets = list(
		SPECIES_NECROMORPH_SLASHER = 'icons/mob/necromorph/slasher/clothing.dmi'
		)

/obj/item/clothing/under/deadspace/surgeon
	name = "surgeon's uniform"
	desc = "A white uniform with a red collar, this uniform is worn by surgeons of the Ishimura medical department."
	item_state = "ds_surgeon"
	worn_state = "ds_surgeon"
	icon_state = "ds_surgeon"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0)
	species_allowed = list(SPECIES_NECROMORPH_SLASHER)

/*
 * Research
 */
/obj/item/clothing/under/deadspace/chief_science_officer
	name = "chief science officer's uniform"
	desc = "A neatly pressed, white uniform with light green patches on each shoulder and burgundy cuffs."
	item_state = "ds_chief_sci_officer"
	worn_state = "ds_chief_sci_officer"
	icon_state = "ds_chief_sci_officer"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/deadspace/research_assistant
	name = "research assistant's uniform"
	desc = "A white uniform with a purple collar, symbolizing this uniform belongs to the research department."
	item_state = "ds_research_assistant"
	worn_state = "ds_research_assistant"
	icon_state = "ds_research_assistant"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0)

/*
 * Spare Uniforms
 */
/obj/item/clothing/under/deadspace/cargo
	name = "cargo uniform"
	desc = "A white-grey uniform, plain and unassuming, perfect for the cargo department."
	item_state = "cargo_jumpsuit"
	worn_state = "cargo_jumpsuit"
	icon_state = "cargo_jumpsuit"

/*
 * Mining
 */
/obj/item/clothing/under/deadspace/planet_cracker
	name = "miner's overalls"
	desc = "A loose pair of overalls and a olive wifebeater, designed for blue-collar workers to labor in."
	item_state = "ds_miner"
	worn_state = "ds_miner"
	icon_state = "ds_miner"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	species_allowed = list(SPECIES_NECROMORPH_SLASHER)
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/deadspace/dom
	name = "director of mining's work clothes"
	desc = "A dress suit and slacks worn in semi-formal environments where blue-collar and white-collar workers work together."
	icon_state = "rdalt"
	item_state = "lb_suit"
	worn_state = "rdalt"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/*
 * Security
 */
/obj/item/clothing/under/deadspace/security
	name = "security officer's jumpsuit"
	desc = "A tan uniform issued to P.C.S.I officers. Slightly baggy, but comfortable. It won't protect an officer without armor though."
	item_state = "ds_securityjumpsuit"
	worn_state = "ds_securityjumpsuit"
	icon_state = "ds_securityjumpsuit"
	permeability_coefficient = 0.25
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	species_allowed = list(SPECIES_NECROMORPH_SLASHER)
	sprite_sheets = list(
		SPECIES_NECROMORPH_SLASHER = 'icons/mob/necromorph/slasher/clothing.dmi'
		)

/obj/item/clothing/under/deadspace/security/cseco
	name = "chief security officer's jumpsuit"
	desc = "A dark brown uniform worn by the Chief Security Officer. Form fitting, but comfortable. It doesn't provide any protection though."
	item_state = "ds_cseco"
	worn_state = "ds_cseco"
	icon_state = "ds_cseco"
	permeability_coefficient = 0.25

/obj/item/clothing/under/deadspace/security/vintage
	name = "vintage security uniform"
	desc = "An old, dark brown uniform that used to be issued to P.C.S.I officers. While this type of uniform used to be fitted with light armor plates sewn into the chest and thighs, this one seems to be missing them. The initials, 'A.V' have been sown above the breast."
	item_state = "ds_securityjumpsuit_old"
	worn_state = "ds_securityjumpsuit_old"
	icon_state = "ds_securityjumpsuit_old"
	permeability_coefficient = 0.25



/*
* Hydroponics
*/

/obj/item/clothing/under/deadspace/hydroponics
	name = "botanist uniform"
	item_state = "ds_hydro_bot"
	worn_state = "ds_hydro_bot"
	icon_state = "ds_hydro_bot"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/*
 * ERT Uniforms
 */
/obj/item/clothing/under/deadspace/ert/kellion
	name = "C.E.C. security contractor jumpsuit"
	desc = "A dark green uniform issued to C.E.C. security contractors."
	item_state = "kellion_jumpsuit"
	worn_state = "kellion_jumpsuit"
	icon_state = "kellion_jumpsuit"
	permeability_coefficient = 0.25
	armor = list(melee = 35, bullet = 35, laser = 0, energy = 0, bomb = 20, bio = 0, rad = 0)

/obj/item/clothing/under/deadspace/ert/kellion/leader
	name = "C.E.C. security leader jumpsuit"
	desc = "A drab, yellow-gray uniform issued to C.E.C. security team leaders. It provides more protection due to the armored plates sown into it."
	item_state = "kellion_lead"
	worn_state = "kellion_lead"
	icon_state = "kellion_lead"
	armor = list(melee = 60, bullet = 60, laser = 0, energy = 0, bomb = 35, bio = 20, rad = 0)

/obj/item/clothing/under/deadspace/ert/kellion/tech
	name = "sweatshirt"
	desc = "A tight-fitting sweatshirt with no sleeves."
	item_state = "kellion_tech"
	worn_state = "kellion_tech"
	icon_state = "kellion_tech"
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)