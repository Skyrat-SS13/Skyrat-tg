///This is the standard 'baseline' NIF model.
/obj/item/organ/internal/cyberimp/brain/nif/standard
	name = "NIF Model-SR"
	desc = "This is the standard NIF, nothing special here"
	manufacturer_notes = "something cool"

/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model
	name = "NIF Model-RP"
	desc = "A standard NIF at a Reduced Price"
	manufacturer_notes = "something cool"

	max_power = 500
	max_nifsofts = 3
	calibration_time = 1 MINUTES
	max_durability = 50
	death_durability_loss = 10
	shift_durability_loss = 5


/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model/cheap
	name = "NIF Model-ERP"
	desc = "a reduced price NIF at a extremely reduced price! wow!"
	nif_persistence = FALSE

/obj/item/autosurgeon/organ/nif/disposable //Disposable, as in the fact that this only lasts for one shift
	name = "NIF Model-ERP Autosurgeon"
	starting_organ = /obj/item/organ/internal/cyberimp/brain/nif/roleplay_model/cheap
