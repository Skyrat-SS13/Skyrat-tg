/datum/preference/toggle/admin/is_accessible(datum/preferences/preferences)
    if (!..(preferences))
        return FALSE

    return is_admin(preferences.parent)
