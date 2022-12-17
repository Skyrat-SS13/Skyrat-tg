/obj/item/implant/mortis
	name = "MORTIS implant"

/obj/item/implant/mortis/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> God Co. MORTIS Implant<BR>
				<b>Life:</b> Activates upon death.<BR>
				"}
	return dat

/obj/item/implant/mortis/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(.)
		RegisterSignal(target, COMSIG_MOB_EMOTED("deathgasp"), PROC_REF(on_deathgasp))

/obj/item/implant/mortis/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(.)
		UnregisterSignal(target, COMSIG_MOB_EMOTED("deathgasp"))

/obj/item/implant/mortis/proc/on_deathgasp(mob/source)
	SIGNAL_HANDLER
	playsound(source.loc, 'modular_skyrat/modules/chaplain/sound/mortis.ogg', 50, 0)

/obj/item/implanter/mortis
	name = "implanter (MORTIS)"
	imp_type = /obj/item/implant/mortis
