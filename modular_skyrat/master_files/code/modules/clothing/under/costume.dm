/obj/item/clothing/under/costume
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'

/obj/item/clothing/under/costume/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/costume.dmi'
	can_adjust = FALSE

//My least favorite file. Just... try to keep it sorted. And nothing over the top (The victorian dresses were way too much)

/*
*	UNSORTED
*/

/obj/item/clothing/under/costume/deckers/alt //not even going to bother re-pathing this one because its such a unique case of 'TGs item has something but this alt doesnt'
	name = "deckers maskless outfit"
	desc = "A decker jumpsuit with neon blue coloring."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "decking_jumpsuit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/bathrobe
	name = "bathrobe"
	desc = "A warm fluffy bathrobe, perfect for relaxing after finally getting clean."
	icon_state = "bathrobe"
	body_parts_covered = CHEST|GROIN|ARMS

/*
*	LUNAR AND JAPANESE CLOTHES
*/

/obj/item/clothing/under/costume/qipao
	name = "black qipao"
	desc = "A qipao, traditionally worn in ancient Earth China by women during social events and lunar new years. This one is black."
	icon_state = "qipao"
	body_parts_covered = CHEST|GROIN|LEGS //Its long enough for the legs, sure
	can_adjust = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = NONE
//GAGS
/obj/item/clothing/under/costume/qipao/white
	icon_state = "qipao_white"
/obj/item/clothing/under/costume/qipao/red
	icon_state = "qipao_red"

/obj/item/clothing/under/costume/cheongsam
	name = "black cheongsam"
	desc = "A cheongsam, traditionally worn in ancient Earth China by men during social events and lunar new years. This one is black."
	icon_state = "cheong"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE
	supports_variations_flags = NONE
//GAGS
/obj/item/clothing/under/costume/cheongsam/white
	icon_state = "cheongw"
/obj/item/clothing/under/costume/cheongsam/red
	icon_state = "cheongr"

/obj/item/clothing/under/costume/kimono
	name = "kimono"
	desc = "A traditional ancient Earth Japanese Kimono"
	icon_state = "kimono"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS //Lots of long fabric
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY //Stop cutting a hole in the Kimono, please :)
//GAGS
/obj/item/clothing/under/costume/kimono/dark
	icon_state = "kimono_a"

/obj/item/clothing/under/costume/kimono/sakura
	name = "sakura kimono"
	icon_state = "sakura_kimono"

/obj/item/clothing/under/costume/kimono/fancy
	name = "fancy kimono"
	icon_state = "fancy_kimono"

/obj/item/clothing/under/costume/kamishimo //wtf do i do with this??
	name = "kamishimo"
	desc = "A traditional ancient Earth Japanese Kamishimo."
	icon_state = "kamishimo"
	body_parts_covered = CHEST|GROIN|ARMS

/*
*	CHRISTMAS CLOTHES
*/

/obj/item/clothing/under/costume/christmas
	name = "christmas costume"
	desc = "Can you believe it guys? Christmas. Just a lightyear away!" //Lightyear is a measure of distance I hate it being used for this joke :(
	icon_state = "christmasmaler"

/obj/item/clothing/under/costume/christmas/green
	name = "green christmas costume"
	desc = "4:00, wallow in self-pity. 4:30, stare into the abyss. 5:00, solve world hunger, tell no one. 5:30, jazzercize; 6:30, dinner with me. I can't cancel that again. 7:00, wrestle with my self-loathing. I'm booked. Of course, if I bump the loathing to 9, I could still be done in time to lay in bed, stare at the ceiling and slip slowly into madness."
	icon_state = "christmasmaleg"

/obj/item/clothing/under/croptop/christmas
	name = "sexy christmas costume"
	desc = "About 550 years since the release of Mariah Carey's \"All I Want For Christmas is You\", society has yet to properly recover from its repercussions. Some still keep a gun as their christmas mantlepiece, just in case she's heard singing on their rooftop late in the night..."
	icon_state = "christmasfemaler"

/obj/item/clothing/under/croptop/christmas/green
	name = "sexy green christmas costume"
	desc = "Stupid. Ugly. Out of date. If I can't find something nice to wear I'm not going."
	icon_state = "christmasfemaleg"
