/datum/outfit/job/chaplain
	implants = list(/obj/item/implant/sad_trombone/mortis)

/obj/item/implant/sad_trombone/mortis
	name = "MORTIS implant"

/obj/item/implant/sad_trombone/mortis/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> God Co. MORTIS Implant<BR>
				<b>Life:</b> Activates upon death.<BR>
				"}
	return dat

/obj/item/implant/sad_trombone/mortis/trigger(emote, mob/source)
	if(emote == "deathgasp")
		playsound(source.loc, 'modular_skyrat/modules/alerts/sound/misc/mortis.ogg', 50, 0)
