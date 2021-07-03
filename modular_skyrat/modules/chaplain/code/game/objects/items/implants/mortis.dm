/obj/item/implant/mortis
	name = "MORTIS implant"
	activated = 0

/obj/item/implant/mortis/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> God Co. MORTIS Implant<BR>
				<b>Life:</b> Activates upon death.<BR>
				"}
	return dat

/obj/item/implant/mortis/trigger(emote, mob/source)
	if(emote == "deathgasp")
		playsound(source.loc, 'modular_skyrat/modules/chaplain/sound/misc/mortis.ogg', 50, 0)

/obj/item/implanter/mortis
	name = "implanter (MORTIS)"
	imp_type = /obj/item/implant/mortis
