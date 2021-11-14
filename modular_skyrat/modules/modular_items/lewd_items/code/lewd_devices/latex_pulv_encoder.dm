////////////////////////////////////
/// LIVING LATEX SPRAYER ENCODER ///
////////////////////////////////////
//TODO: это заглушка для программатора. Нужно полностью реализовать предмет
/obj/item/latex_pulv_encoder
	name = "\improper living latex sprayer encoder"
	desc = "Portable Microcomputer Programming Modules for Live Latex Sprayer."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "encoder_off"
	var/obj/item/firing_pin/latexpulvmodule/pin = null
	var/programslist = null // Это будет полный список всех возможных программ
	var/pai_candidates = null // Это будет список всех доступных кандидатов в ИИ
	var/latexprogram = null // Это будет структура с итоговой программой

/obj/item/latex_pulv_encoder/Initialize(mapload)
	. = ..()
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "encoder_off"
	base_icon_state = "encoder_off"

//
/obj/item/latex_pulv_encoder/AltClick(mob/user)
	. = ..()

// Вставляем флешку. Возможно можно будет хакнуть, чем-либо
/obj/item/latex_pulv_encoder/attackby(obj/item/I, mob/living/user, params)
	. = ..()

// Обработчик чтобы открывать интерфейс программатора
/obj/item/latex_pulv_encoder/attack_hand(mob/user, list/modifiers)
	. = ..()



// Handler for clicking an empty hand on an encoder
/obj/item/latex_pulv_encoder/ui_interact(mob/user, datum/tgui/ui)
	var/obj/item/latex_pulv_encoder/E = src

	// There wil be checks for encoder in hands

	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "LatexPulvEncoder", name)
		ui.open()

/obj/item/latex_pulv_encoder/ui_data(mob/user)
	//. = ..()
	var/list/data = list()

	data["pin"] = pin ? pin : null
	data["programslist"] = programslist ? programslist : null
	data["pinprograms"] = pin.latexprogram ? pin.latexprogram : null
	data["pai_candidates"] = pai_candidates ? pai_candidates : null
	data["latexprogram"] = latexprogram ? latexprogram : null

	updateUsrDialog()
	return data

/obj/item/latex_pulv_encoder/ui_act(action, list/params)
	. = ..()






/obj/item/latex_pulv_encoder/
