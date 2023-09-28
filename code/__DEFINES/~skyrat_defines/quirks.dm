#define DEATH_CONSEQUENCES_QUIRK_NAME "Resonance Degradation Disorder"
#define DEATH_CONSEQUENCES_QUIRK_DESC "Patient's resonance is unusually susceptable to mortality."
#define DEATH_CONSEQUENCES_BASE_DEGRADATION_ON_DEATH 50

/// The victim's crit threshold cannot go below this.
#define DEATH_CONSEQUENCES_MINIMUM_VICTIM_CRIT_THRESHOLD 30

#define DEATH_CONSEQUENCES_REAGENT_FLAT_AMOUNT "dc_flat_reagent_amount"
#define DEATH_CONSEQUENCES_REAGENT_MULT_AMOUNT "dc_mult_reagent_amount"
#define DEATH_CONSEQUENCES_REAGENT_METABOLIZE "dc_reagent_should_be_metabolizing"
/// If true, we will check to see if this can process. Ex. things like synths wont process formaldehyde
#define DEATH_CONSEQUENCES_REAGENT_CHECK_PROCESSING_FLAGS "dc_check_reagent_processing_flags"
