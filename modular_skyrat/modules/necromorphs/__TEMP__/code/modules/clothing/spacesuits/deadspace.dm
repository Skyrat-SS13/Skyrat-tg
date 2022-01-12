///////////////////
////UNI OUTFITS////
///////////////////

/obj/item/clothing/head/helmet/space/unitologist
	name = "strange helmet"
	icon_state = "unifaith"
	item_state = "unifaith"
	desc = "A square, black helmet with several crimson highlights, it seems to be a custom design made of parts from a Fuel Carrier RIG. The words, 'Schofield Tools' are stamped on the bottom-back of the helmet. Despite the helmet's non-standard nature, the work done putting it together seems professional."
	armor = list(melee = 50, bullet = 60, laser = 30,energy = 30, bomb = 60, bio = 100, rad = 30)
	siemens_coefficient = 0.3

/obj/item/clothing/suit/space/unitologist
	name = "strange suit"
	icon_state = "unifaith"
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	desc = "A black and gray RIG suit covered in strange symbols and red highlights. The words, 'Schofield Tools' are stamped to the back of the shoulder piece. It seems to be a custom design made of parts from a Fuel Carrier RIG. Despite the helmet's non-standard nature, the work done putting it together seems professional."
	w_class = ITEM_SIZE_LARGE
	armor = list(melee = 50, bullet = 60, laser = 30,energy = 30, bomb = 60, bio = 100, rad = 30)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	siemens_coefficient = 0.3

/obj/item/clothing/suit/space/unitologist/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 1

/obj/item/clothing/head/helmet/space/unitologist/berserker
	name = "heavy helmet"
	icon_state = "unizerk"
	item_state = "unizerk"
	desc = "A square, black helmet with a few crimson highlights, it seems to be a custom design made of parts from a Fuel Carrier RIG. The words, 'Schofield Tools' are stamped on the bottom-back of the helmet. Despite the helmet's non-standard nature, the work done putting it together seems professional."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 60, bullet = 70, laser = 30,energy = 30, bomb = 70, bio = 100, rad = 30)

/obj/item/clothing/suit/space/unitologist/berserker
	name = "heavy suit"
	icon_state = "unizerk"
	desc = "A heavy, gray RIG suit covered in strange symbols and red highlights. The words, 'Schofield Tools' are stamped on the back of the shoulder piece. It seems to be a custom design made of parts from a Fuel Carrier RIG, with a significant amount of extra protection added to the lower torso. Despite the helmet's non-standard nature, the work done putting it together seems professional."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 60, bullet = 70, laser = 30,energy = 30, bomb = 70, bio = 100, rad = 30)

/obj/item/clothing/head/helmet/space/unitologist/deacon
	name = "ornate helmet"
	icon_state = "unideac"
	item_state = "unideac"
	desc = "An odd, cylindrical, black helmet with a few crimson highlights, covered heavily in strange symbols. Despite the fancier adornments, the helmet doesn't look like it would provide more than the bare minimum protection."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 30, bullet = 30, laser = 30,energy = 30, bomb = 50, bio = 100, rad = 30)

/obj/item/clothing/suit/space/unitologist/deacon
	name = "ornate suit"
	icon_state = "unideac"
	desc = "A ornate, gray RIG suit covered in strange symbols and a red sash wrapped around it. Several protective pieces have been removed to make room for sash and buckle on the left shoulder."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 30, bullet = 30, laser = 30,energy = 30, bomb = 50, bio = 100, rad = 30)

/obj/item/clothing/head/helmet/space/unitologist/healer
	name = "blood helmet"
	icon_state = "unimedic"
	item_state = "unimedic"
	desc = "A gray helmet with several crimson highlights, it seems to just be a repainted Security RIG. The letters, 'T.E.A.K' are stamped on the bottom-back of the helmet. Despite the helmet's non-standard nature, the work done putting it together seems professional."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)

/obj/item/clothing/suit/space/unitologist/healer
	name = "blood suit"
	icon_state = "unimedic"
	desc = "A black and red RIG suit covered in strange symbols, with a large red plus in the center of the torso. The letters, 'T.E.A.K' are stamped on the bottom of the back of the helmet. Despite the helmet's non-standard nature, the work done putting it together seems professional."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)

/obj/item/clothing/head/helmet/space/unitologist/mechanic
	name = "refitted helmet"
	icon_state = "uniengie"
	item_state = "uniengie"
	desc = "A black, rounded helmet with a crimson highlight along the top. The words, 'Timson Tools' are stamped on the bottom-back of the helmet. It looks like the helmet has been refitted and repainted somewhat recently, though there is still some rust spotted around the helmet. Clearly it hasn't been kept in the greatest shape. "
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 40, bullet = 50, laser = 30,energy = 30, bomb = 20, bio = 100, rad = 30)

/obj/item/clothing/suit/space/unitologist/mechanic
	name = "refitted suit"
	icon_state = "uniengie"
	desc = "A black and gray RIG suit with some rust along the armor. The words, 'Timson Tools' are stamped to the back of the shoulder piece. It looks like the suit has been refitted and repainted somewhat recently, though the rust shows it clearly hasn't been kept in the greatest shape."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 40, bullet = 50, laser = 30,energy = 30, bomb = 20, bio = 100, rad = 30)

///////////////////
////EDF OUTFITS////
///////////////////
/*
	//These are obsolete but they have nice writing, we should port that over at some point
/obj/item/clothing/head/helmet/space/edf
	name = "MDH-G7 Marine Helmet"
	icon_state = "edfgrunt"
	item_state = "edfgrunt"
	desc = "A blocky, white helmet with a red stripe above the eye. The letters, 'T.E.A.K' are stamped on the bottom-back of the helmet."
	armor = list(melee = 50, bullet = 60, laser = 30,energy = 30, bomb = 60, bio = 100, rad = 30)
	siemens_coefficient = 0.3

/obj/item/clothing/suit/space/edf
	name = "MDS-G7 Marine RIG suit"
	icon_state = "edfgrunt"
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	desc = "A military RIG suit given to EDF marines. The letters, 'T.E.A.K' are stamped on the back of the shoulder piece. Professionally manufactured and well maintained, this suit of armor gleams as it catches the light."
	w_class = ITEM_SIZE_LARGE
	armor = list(melee = 50, bullet = 60, laser = 30,energy = 30, bomb = 60, bio = 100, rad = 30)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	siemens_coefficient = 0.3

/obj/item/clothing/suit/space/edf/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 1

/obj/item/clothing/head/helmet/space/edf/commander
	name = "MDH-C7 Command Helmet"
	icon_state = "edfcomm"
	item_state = "edfcomm"
	desc = "A blocky, white helmet with a red stripe above the eye. This helmet is given to officers, providing more protection due to the extra plating near the jaw and forhead. The letters, 'T.E.A.K' are stamped on the bottom-back of the helmet."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)

/obj/item/clothing/suit/space/edf/commander
	name = "MDS-C7 Command RIG suit"
	icon_state = "edfcomm"
	desc = "A military RIG suit given to EDF squad leaders. This suit comes with an defensive pauldrons on both shoulders, providing more protection than the basic marine variant. The letters, 'T.E.A.K' are stamped on the back of the shoulder piece. Professionally manufactured and well maintained, this suit of armor gleams as it catches the light."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 55, bullet = 65, laser = 30,energy = 30, bomb = 65, bio = 100, rad = 30)

/obj/item/clothing/head/helmet/space/edf/engineer
	name = "MDH-E7 Engineer Helmet"
	icon_state = "edfengie"
	item_state = "edfengie"
	desc = "A blocky, white helmet with a yellow stripe above the eye. The letters, 'T.E.A.K' are stamped on the bottom-back of the helmet."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)

/obj/item/clothing/suit/space/edf/engineer
	name = "MDS-E7 Engineer RIG suit"
	icon_state = "edfengie"
	desc = "A military RIG suit given to EDF engineers, distinguished by the yellow highlights on the armor. This suit comes with an defensive pauldrons on both shoulders, providing more protection than the basic marine variant. The letters, 'T.E.A.K' are stamped on the back of the shoulder piece. Professionally manufactured and well maintained, this suit of armor gleams as it catches the light."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 55, bullet = 65, laser = 30,energy = 30, bomb = 65, bio = 100, rad = 30)

/obj/item/clothing/head/helmet/space/edf/medic
	name = "MDH-M7 Medic Helmet"
	icon_state = "edfmedic"
	item_state = "edfmedic"
	desc = "A blocky, white helmet with a red cross in the center of the forehead. The letters, 'T.E.A.K' are stamped on the bottom-back of the helmet."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)

/obj/item/clothing/suit/space/edf/medic
	name = "MDS-M7 Medic RIG suit"
	icon_state = "edfmedic"
	desc = "A military RIG suit given to EDF medics, distinguished by the red cross over the heart on the chestplate. This suit comes with an defensive pauldrons on both shoulders, providing more protection than the basic marine variant. The letters, 'T.E.A.K' are stamped on the back of the shoulder piece. Professionally manufactured and well maintained, this suit of armor gleams as it catches the light."
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)
	armor = list(melee = 55, bullet = 65, laser = 30,energy = 30, bomb = 65, bio = 100, rad = 30)

*/