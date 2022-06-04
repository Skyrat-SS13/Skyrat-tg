/datum/job/prisoner/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	var/linktopolicy = "https://docs.google.com/document/d/e/2PACX-1vQVFGahOD5A1R5qFhtVAmhxN7xz51JCGw-uMaw_WvhkGcB_M_fdQvr7-VxIYEhh5pZnC77eHvuMSrfB/pub"
	to_chat(M, (span_doyourjobidiot("As a roundstart/latejoin prisoner, you are not an antagonist. You are allowed to cause moderate amounts of drama and shenanigans, but you should not be security's main focus. Do not be unmanageable.  \nRefer to the Prisoner Section of 'General Player Policy and Standards'!\n\nIf you intend to break out of prison, submit an opposing force application or press F1 to admin help it! \n<a href=\"[linktopolicy]\"> Click here to read the policy! </a>")))
