// Just keeping this easy to maintain in the future.
#define JOB_NOT_VETERAN (JOB_UNAVAILABLE_AGE + 1)
#define JOB_UNAVAILABLE_QUIRK (JOB_NOT_VETERAN + 1)
#define JOB_UNAVAILABLE_SPECIES (JOB_UNAVAILABLE_QUIRK + 1)
#define JOB_UNAVAILABLE_LANGUAGE (JOB_UNAVAILABLE_SPECIES + 1)
#define JOB_UNAVAILABLE_FLAVOUR (JOB_UNAVAILABLE_LANGUAGE + 1)
#define JOB_UNAVAILABLE_AUGMENT (JOB_UNAVAILABLE_FLAVOUR + 1)

#define SEC_RESTRICTED_QUIRKS "Blind" = TRUE, "Brain Tumor" = TRUE, "Deaf" = TRUE, "Paraplegic" = TRUE, "Hemiplegic" = TRUE, "Mute" = TRUE, "Foreigner" = TRUE, "Pacifist" = TRUE, "No Guns" = TRUE, "Illiterate" = TRUE, "Nerve Stapled" = TRUE
#define HEAD_RESTRICTED_QUIRKS "Blind" = TRUE, "Deaf" = TRUE, "Mute" = TRUE, "Foreigner" = TRUE, "Brain Tumor" = TRUE, "Illiterate" = TRUE
#define GUARD_RESTRICTED_QUIRKS "Blind" = TRUE, "Deaf" = TRUE, "Foreigner" = TRUE, "Pacifist" = TRUE, "Nerve Stapled" = TRUE

#define RESTRICTED_QUIRKS_EXCEPTIONS list("Mute" = "Signer")

#define HEAD_RESTRICTED_AUGMENTS /obj/item/bodypart/arm/left/self_destruct, /obj/item/bodypart/arm/right/self_destruct, /obj/item/bodypart/leg/left/self_destruct, /obj/item/bodypart/leg/right/self_destruct
#define SEC_RESTRICTED_AUGMENTS /obj/item/bodypart/arm/left/self_destruct, /obj/item/bodypart/arm/right/self_destruct, /obj/item/bodypart/leg/left/self_destruct, /obj/item/bodypart/leg/right/self_destruct
