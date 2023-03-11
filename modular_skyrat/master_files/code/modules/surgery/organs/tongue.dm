// Remove the could_speak_language check from the tongue code. This is a much better solution than trying to grant omnitongue on prefs load, and prevents any funny breakages.
/obj/item/organ/internal/tongue/could_speak_language(datum/language/language_path)
	return TRUE
