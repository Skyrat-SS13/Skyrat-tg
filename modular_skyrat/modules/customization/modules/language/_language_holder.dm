/datum/language_holder/vox
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/vox = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/vox = list(LANGUAGE_ATOM),
	)

/datum/language_holder/skrell
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/skrell = list(LANGUAGE_ATOM),
		/datum/language/slime = list(LANGUAGE_ATOM)
	)

	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/skrell = list(LANGUAGE_ATOM),
		/datum/language/slime = list(LANGUAGE_ATOM),
	)

/datum/language_holder/shadowpeople
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/voltaic = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/voltaic = list(LANGUAGE_ATOM),
	)

/datum/language_holder/skeleton
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/terrum = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/terrum = list(LANGUAGE_ATOM),
	)

/datum/language_holder/golem/bone
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/terrum = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/terrum = list(LANGUAGE_ATOM),
	)

/datum/language_holder/felinid
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/yangyu = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/yangyu = list(LANGUAGE_ATOM),
	)

/datum/language_holder/mushroom
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/sylvan = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/sylvan = list(LANGUAGE_ATOM),
	)

/datum/language_holder/machine // SYNTHETIC LIZARD & CO LANGUAGE
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/machine = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/machine = list(LANGUAGE_ATOM),
	)

/// The cyborg and AI language list is so long that we may as well define it for easier synchronization.
#define LANGUAGES_CYBORG list( \
	/datum/language/common = list(LANGUAGE_ATOM),\
	/datum/language/uncommon = list(LANGUAGE_ATOM),\
	/datum/language/machine = list(LANGUAGE_ATOM),\
	/datum/language/draconic = list(LANGUAGE_ATOM),\
	/datum/language/moffic = list(LANGUAGE_ATOM),\
	/datum/language/calcic = list(LANGUAGE_ATOM),\
	/datum/language/voltaic = list(LANGUAGE_ATOM),\
	/datum/language/nekomimetic = list(LANGUAGE_ATOM),\
	/datum/language/gutter = list(LANGUAGE_ATOM),\
	/datum/language/panslavic = list(LANGUAGE_ATOM),\
	/datum/language/skrell = list(LANGUAGE_ATOM),\
	/datum/language/spacer = list(LANGUAGE_ATOM),\
	/datum/language/xerxian = list(LANGUAGE_ATOM),\
	/datum/language/vox = list(LANGUAGE_ATOM),\
	/datum/language/yangyu = list(LANGUAGE_ATOM),\
	/datum/language/schechi = list(LANGUAGE_ATOM),\
	/datum/language/monkey = list(LANGUAGE_ATOM),\
	/datum/language/slime = list(LANGUAGE_ATOM),\
	/datum/language/beachbum = list(LANGUAGE_ATOM),\
	/datum/language/mushroom = list(LANGUAGE_ATOM),\
	/datum/language/shadowtongue = list(LANGUAGE_ATOM),\
	/datum/language/buzzwords = list(LANGUAGE_ATOM),\
	/datum/language/terrum = list(LANGUAGE_ATOM),\
	/datum/language/sylvan = list(LANGUAGE_ATOM),\
)

// Modularized the Cyborg and AI language_holder, add here the languages that you want them to be able to speak and understand.
/datum/language_holder/synthetic
	understood_languages = LANGUAGES_CYBORG
	spoken_languages = LANGUAGES_CYBORG

#undef LANGUAGES_CYBORG
