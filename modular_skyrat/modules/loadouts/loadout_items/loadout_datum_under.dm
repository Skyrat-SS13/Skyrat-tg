
// --- Loadout item datums for under suits ---

/// Underslot - Jumpsuit Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_jumpsuits, generate_loadout_items(/datum/loadout_item/under/jumpsuit))

/// Underslot - Formal Suit Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_undersuits, generate_loadout_items(/datum/loadout_item/under/formal))

/// Underslot - Misc. Under Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_miscunders, generate_loadout_items(/datum/loadout_item/under/miscellaneous))

/datum/loadout_item/under
	category = LOADOUT_ITEM_UNIFORM

/datum/loadout_item/under/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(isplasmaman(equipper))
		if(!visuals_only)
			to_chat(equipper, "Your loadout uniform was not equipped directly due to your envirosuit.")
			LAZYADD(outfit.backpack_contents, item_path)
	else
		outfit.uniform = item_path

// jumpsuit undersuits
/datum/loadout_item/under/jumpsuit

/datum/loadout_item/under/jumpsuit/greyscale
	name = "Greyscale Jumpsuit"
	can_be_greyscale = TRUE
	item_path = /obj/item/clothing/under/color

/datum/loadout_item/under/jumpsuit/greyscale_skirt
	name = "Greyscale Jumpskirt"
	can_be_greyscale = TRUE
	item_path = /obj/item/clothing/under/color/jumpskirt

/datum/loadout_item/under/jumpsuit/random
	name = "Random Jumpsuit"
	item_path = /obj/item/clothing/under/color/random
	additional_tooltip_contents = list(TOOLTIP_RANDOM_COLOR)

/datum/loadout_item/under/jumpsuit/random_skirt
	name = "Random Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/random
	additional_tooltip_contents = list(TOOLTIP_RANDOM_COLOR)

/datum/loadout_item/under/jumpsuit/black
	name = "Black Jumpsuit"
	item_path = /obj/item/clothing/under/color/black

/datum/loadout_item/under/jumpsuit/black_skirt
	name = "Black Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/black

/datum/loadout_item/under/jumpsuit/blue
	name = "Blue Jumpsuit"
	item_path = /obj/item/clothing/under/color/blue

/datum/loadout_item/under/jumpsuit/blue_skirt
	name = "Blue Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/blue

/datum/loadout_item/under/jumpsuit/brown
	name = "Brown Jumpsuit"
	item_path = /obj/item/clothing/under/color/brown

/datum/loadout_item/under/jumpsuit/brown_skirt
	name = "Brown Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/brown

/datum/loadout_item/under/jumpsuit/darkblue
	name = "Dark Blue Jumpsuit"
	item_path = /obj/item/clothing/under/color/darkblue

/datum/loadout_item/under/jumpsuit/darkblue_skirt
	name = "Dark Blue Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/darkblue

/datum/loadout_item/under/jumpsuit/darkgreen
	name = "Dark Green Jumpsuit"
	item_path = /obj/item/clothing/under/color/darkgreen

/datum/loadout_item/under/jumpsuit/darkgreen_skirt
	name = "Dark Green Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/darkgreen

/datum/loadout_item/under/jumpsuit/green
	name = "Green Jumpsuit"
	item_path = /obj/item/clothing/under/color/green

/datum/loadout_item/under/jumpsuit/green_skirt
	name = "Green Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/green

/datum/loadout_item/under/jumpsuit/grey
	name = "Grey Jumpsuit"
	item_path = /obj/item/clothing/under/color/grey

/datum/loadout_item/under/jumpsuit/grey_skirt
	name = "Grey Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/grey

/datum/loadout_item/under/jumpsuit/lightbrown
	name = "Light Brown Jumpsuit"
	item_path = /obj/item/clothing/under/color/lightbrown

/datum/loadout_item/under/jumpsuit/ightbrown_skirt
	name = "Light Brown Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/lightbrown

/datum/loadout_item/under/jumpsuit/lightpurple
	name = "Light Purple Jumpsuit"
	item_path = /obj/item/clothing/under/color/lightpurple

/datum/loadout_item/under/jumpsuit/lightpurple_skirt
	name = "Light Purple Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/lightpurple

/datum/loadout_item/under/jumpsuit/maroon
	name = "Maroon Jumpsuit"
	item_path = /obj/item/clothing/under/color/maroon

/datum/loadout_item/under/jumpsuit/maroon_skirt
	name = "Maroon Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/maroon

/datum/loadout_item/under/jumpsuit/irange
	name = "Orange Jumpsuit"
	item_path = /obj/item/clothing/under/color/orange

/datum/loadout_item/under/jumpsuit/orange_skirt
	name = "Orange Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/orange

/datum/loadout_item/under/jumpsuit/pin
	name = "Pink Jumpsuit"
	item_path = /obj/item/clothing/under/color/pink

/datum/loadout_item/under/jumpsuit/pink_skirt
	name = "Pink Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/pink

/datum/loadout_item/under/jumpsuit/rainbow
	name = "Rainbow Jumpsuit"
	item_path = /obj/item/clothing/under/color/rainbow

/datum/loadout_item/under/jumpsuit/rainbow_skirt
	name = "Rainbow Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/rainbow

/datum/loadout_item/under/jumpsuit/red
	name = "Red Jumpsuit"
	item_path = /obj/item/clothing/under/color/red

/datum/loadout_item/under/jumpsuit/red_skirt
	name = "Red Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/red

/datum/loadout_item/under/jumpsuit/teal
	name = "Teal Jumpsuit"
	item_path = /obj/item/clothing/under/color/teal

/datum/loadout_item/under/jumpsuit/teal_skirt
	name = "Teal Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/teal

/datum/loadout_item/under/jumpsuit/yellow
	name = "Yellow Jumpsuit"
	item_path = /obj/item/clothing/under/color/yellow

/datum/loadout_item/under/jumpsuit/yellow_skirt
	name = "Yellow Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/yellow

/datum/loadout_item/under/jumpsuit/white
	name = "White Jumpsuit"
	item_path = /obj/item/clothing/under/color/white

/datum/loadout_item/under/jumpsuit/white_skirt
	name = "White Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/white

// formal undersuits
/datum/loadout_item/under/formal

/datum/loadout_item/under/formal/amish_suit
	name = "Amish Suit"
	item_path = /obj/item/clothing/under/suit/sl

/datum/loadout_item/under/formal/assistant
	name = "Assistant Formal"
	item_path = /obj/item/clothing/under/misc/assistantformal

/datum/loadout_item/under/formal/beige_suit
	name = "Beige Suit"
	item_path = /obj/item/clothing/under/suit/beige

/datum/loadout_item/under/formal/black_suit
	name = "Black Suit"
	item_path = /obj/item/clothing/under/suit/black

/datum/loadout_item/under/formal/black_suitskirt
	name = "Black Suitskirt"
	item_path = /obj/item/clothing/under/suit/black/skirt

/datum/loadout_item/under/formal/black_tango
	name = "Black Tango Dress"
	item_path = /obj/item/clothing/under/dress/blacktango

/datum/loadout_item/under/formal/Black_twopiece
	name = "Black Two-Piece Suit"
	item_path = /obj/item/clothing/under/suit/blacktwopiece

/datum/loadout_item/under/formal/black_skirt
	name = "Black Skirt"
	item_path = /obj/item/clothing/under/dress/skirt

/datum/loadout_item/under/formal/black_lawyer_suit
	name = "Black Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black

/datum/loadout_item/under/formal/black_lawyer_skirt
	name = "Black Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black/skirt

/datum/loadout_item/under/formal/blue_suit
	name = "Blue Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit

/datum/loadout_item/under/formal/blue_suitskirt
	name = "Blue Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt

/datum/loadout_item/under/formal/blue_lawyer_suit
	name = "Blue Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue

/datum/loadout_item/under/formal/blue_lawyer_skirt
	name = "Blue Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue/skirt

/datum/loadout_item/under/formal/blue_skirt
	name = "Blue Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/blue

/datum/loadout_item/under/formal/blue_skirt_plaid
	name = "Blue Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid/blue

/datum/loadout_item/under/formal/burgundy_suit
	name = "Burgundy Suit"
	item_path = /obj/item/clothing/under/suit/burgundy

/datum/loadout_item/under/formal/charcoal_suit
	name = "Charcoal Suit"
	item_path = /obj/item/clothing/under/suit/charcoal

/datum/loadout_item/under/formal/checkered_suit
	name = "Checkered Suit"
	item_path = /obj/item/clothing/under/suit/checkered

/datum/loadout_item/under/formal/executive_suit
	name = "Executive Suit"
	item_path = /obj/item/clothing/under/suit/black_really

/datum/loadout_item/under/formal/executive_skirt
	name = "Executive Suitskirt"
	item_path = /obj/item/clothing/under/suit/black_really/skirt

/datum/loadout_item/under/formal/executive_suit_alt
	name = "Executive Suit Alt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/female

/datum/loadout_item/under/formal/executive_skirt_alt
	name = "Executive Suitskirt Alt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/female/skirt

/datum/loadout_item/under/formal/green_suit
	name = "Green Suit"
	item_path = /obj/item/clothing/under/suit/green

/datum/loadout_item/under/formal/green_skirt_plaid
	name = "Green Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid/green

/datum/loadout_item/under/formal/navy_suit
	name = "Navy Suit"
	item_path = /obj/item/clothing/under/suit/navy

/datum/loadout_item/under/formal/maid_outfit
	name = "Maid Outfit"
	item_path = /obj/item/clothing/under/costume/maid

/datum/loadout_item/under/formal/maid_uniform
	name = "Maid Uniform"
	item_path = /obj/item/clothing/under/rank/civilian/janitor/maid

/datum/loadout_item/under/formal/purple_suit
	name = "Purple Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit

/datum/loadout_item/under/formal/purple_suitskirt
	name = "Purple Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt

/datum/loadout_item/under/formal/purple_skirt
	name = "Purple Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/purple

/datum/loadout_item/under/formal/purple_skirt_plaid
	name = "Purple Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid/purple

/datum/loadout_item/under/formal/red_suit
	name = "Red Suit"
	item_path = /obj/item/clothing/under/suit/red

/datum/loadout_item/under/formal/red_lawyer_skirt
	name = "Red Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red

/datum/loadout_item/under/formal/red_lawyer_skirt
	name = "Red Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red/skirt

/datum/loadout_item/under/formal/red_gown
	name = "Red Evening Gown"
	item_path = /obj/item/clothing/under/dress/redeveninggown

/datum/loadout_item/under/formal/red_skirt
	name = "Red Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/red

/datum/loadout_item/under/formal/red_skirt_plaid
	name = "Red Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid

/datum/loadout_item/under/formal/sailor
	name = "Sailor Suit"
	item_path = /obj/item/clothing/under/costume/sailor

/datum/loadout_item/under/formal/sailor_skirt
	name = "Sailor Dress"
	item_path = /obj/item/clothing/under/dress/sailor

/datum/loadout_item/under/formal/scratch_suit
	name = "Scratch Suit"
	item_path = /obj/item/clothing/under/suit/white_on_white

/datum/loadout_item/under/formal/striped_skirt
	name = "Striped Dress"
	item_path = /obj/item/clothing/under/dress/striped

/datum/loadout_item/under/formal/sensible_suit
	name = "Sensible Suit"
	item_path = /obj/item/clothing/under/rank/civilian/curator

/datum/loadout_item/under/formal/sensible_skirt
	name = "Sensible Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/curator/skirt

/datum/loadout_item/under/formal/sundress
	name = "Sundress"
	item_path = /obj/item/clothing/under/dress/sundress

/datum/loadout_item/under/formal/tan_suit
	name = "Tan Suit"
	item_path = /obj/item/clothing/under/suit/tan

/datum/loadout_item/under/formal/tuxedo
	name = "Tuxedo Suit"
	item_path = /obj/item/clothing/under/suit/tuxedo

/datum/loadout_item/under/formal/waiter
	name = "Waiter's Suit"
	item_path = /obj/item/clothing/under/suit/waiter

/datum/loadout_item/under/formal/wedding
	name = "Wedding Dress"
	item_path = /obj/item/clothing/under/dress/wedding_dress

/datum/loadout_item/under/formal/white_suit
	name = "White Suit"
	item_path = /obj/item/clothing/under/suit/white

/datum/loadout_item/under/formal/white_skirt
	name = "White Suitskirt"
	item_path = /obj/item/clothing/under/suit/white/skirt

// misc undersuits
/datum/loadout_item/under/miscellaneous

/datum/loadout_item/under/miscellaneous/camo
	name = "Camo Pants"
	item_path = /obj/item/clothing/under/pants/camo

/datum/loadout_item/under/miscellaneous/jeans_classic
	name = "Classic Jeans"
	item_path = /obj/item/clothing/under/pants/classicjeans

/datum/loadout_item/under/miscellaneous/jeans_black
	name = "Black Jeans"
	item_path = /obj/item/clothing/under/pants/blackjeans

/datum/loadout_item/under/miscellaneous/black
	name = "Black Pants"
	item_path = /obj/item/clothing/under/pants/black

/datum/loadout_item/under/miscellaneous/black_short
	name = "Black Shorts"
	item_path = /obj/item/clothing/under/shorts/black

/datum/loadout_item/under/miscellaneous/blue_short
	name = "Blue Shorts"
	item_path = /obj/item/clothing/under/shorts/blue

/datum/loadout_item/under/miscellaneous/green_short
	name = "Green Shorts"
	item_path = /obj/item/clothing/under/shorts/green

/datum/loadout_item/under/miscellaneous/grey_short
	name = "Grey Shorts"
	item_path = /obj/item/clothing/under/shorts/grey

/datum/loadout_item/under/miscellaneous/jeans
	name = "Jeans"
	item_path = /obj/item/clothing/under/pants/jeans

/datum/loadout_item/under/miscellaneous/khaki
	name = "Khaki Pants"
	item_path = /obj/item/clothing/under/pants/khaki

/datum/loadout_item/under/miscellaneous/jeans_musthang
	name = "Must Hang Jeans"
	item_path = /obj/item/clothing/under/pants/mustangjeans

/datum/loadout_item/under/miscellaneous/purple_short
	name = "Purple Shorts"
	item_path = /obj/item/clothing/under/shorts/purple

/datum/loadout_item/under/miscellaneous/red
	name = "Red Pants"
	item_path = /obj/item/clothing/under/pants/red

/datum/loadout_item/under/miscellaneous/red_short
	name = "Red Shorts"
	item_path = /obj/item/clothing/under/shorts/red

/datum/loadout_item/under/miscellaneous/tam
	name = "Tan Pants"
	item_path = /obj/item/clothing/under/pants/tan

/datum/loadout_item/under/miscellaneous/track
	name = "Track Pants"
	item_path = /obj/item/clothing/under/pants/track

/datum/loadout_item/under/miscellaneous/jeans_youngfolk
	name = "Young Folks Jeans"
	item_path = /obj/item/clothing/under/pants/youngfolksjeans

/datum/loadout_item/under/miscellaneous/white
	name = "White Pants"
	item_path = /obj/item/clothing/under/pants/white

/datum/loadout_item/under/miscellaneous/kilt
	name = "Kilt"
	item_path = /obj/item/clothing/under/costume/kilt

/datum/loadout_item/under/miscellaneous/treasure_hunter
	name = "Treasure Hunter"
	item_path = /obj/item/clothing/under/rank/civilian/curator/treasure_hunter

/datum/loadout_item/under/miscellaneous/overalls
	name = "Overalls"
	item_path = /obj/item/clothing/under/misc/overalls

/datum/loadout_item/under/miscellaneous/pj_blue
	name = "Mailman Jumpsuit"
	item_path = /obj/item/clothing/under/misc/mailman

/datum/loadout_item/under/miscellaneous/vice_officer
	name = "Vice Officer Jumpsuit"
	item_path = /obj/item/clothing/under/misc/vice_officer

/datum/loadout_item/under/miscellaneous/soviet
	name = "Soviet Uniform"
	item_path = /obj/item/clothing/under/costume/soviet

/datum/loadout_item/under/miscellaneous/redcoat
	name = "Redcoat"
	item_path = /obj/item/clothing/under/costume/redcoat

/datum/loadout_item/under/miscellaneous/pj_red
	name = "Red PJs"
	item_path = /obj/item/clothing/under/misc/pj/red

/datum/loadout_item/under/miscellaneous/pj_blue
	name = "Blue PJs"
	item_path = /obj/item/clothing/under/misc/pj/blue

/datum/loadout_item/under/gandalf
	name = "Nostalgic Costume"
	item_path = /obj/item/clothing/under/nostalgiacritic
	ckeywhitelist = list("gandalf2k15")

/datum/loadout_item/under/assistantformal
	name = "Assistant's formal uniform"
	item_path = /obj/item/clothing/under/misc/assistantformal

/datum/loadout_item/under/greyshirt
	name = "Grey Shirt"
	item_path = /obj/item/clothing/under/misc/greyshirt

/datum/loadout_item/under/maidcostume
	name = "Maid costume"
	item_path = /obj/item/clothing/under/costume/maid

/datum/loadout_item/under/mailmanuniform
	name = "Mailman's jumpsuit"
	item_path = /obj/item/clothing/under/misc/mailman

/datum/loadout_item/under/croptop
	name = "Croptop"
	item_path = /obj/item/clothing/under/croptop

/datum/loadout_item/under/kilt
	name = "Kilt"
	item_path = /obj/item/clothing/under/costume/kilt

/datum/loadout_item/under/royalkilt
	name = "Royal Kilt"
	item_path = /obj/item/clothing/under/misc/royalkilt

/datum/loadout_item/under/poly_kilt
	name = "Polychromic Kilt"
	item_path = /obj/item/clothing/under/misc/poly_kilt



/datum/loadout_item/under/poly_button_up
	name = "Polychromic Button Up Shirt"
	item_path = /obj/item/clothing/under/misc/poly_shirt



/datum/loadout_item/under/poly_tri_jumpsuit
	name = "Polychromic Tri-Tone Jumpsuit"
	item_path = /obj/item/clothing/under/misc/polyjumpsuit



/datum/loadout_item/under/poly_tanktop
	name = "Polychromic Tanktop"
	item_path = /obj/item/clothing/under/misc/poly_tanktop



/datum/loadout_item/under/poly_tanktop_fem
	name = "Polychromic Feminine Tanktop"
	item_path = /obj/item/clothing/under/misc/poly_tanktop/female



/datum/loadout_item/under/gear_harnesses
	name = "Gear Harness"
	item_path = /obj/item/clothing/under/misc/gear_harness

/datum/loadout_item/under/loincloth	//Sensor version for station crew
	name = "Leather Loincloth"
	item_path = /obj/item/clothing/under/costume/loincloth/sensor

/datum/loadout_item/under/loincloth/cloth	//Sensor version for station crew
	name = "Cloth Loincloth"
	item_path = /obj/item/clothing/under/costume/loincloth/cloth/sensor


/datum/loadout_item/under/pinkstripper
	name = "Pink stripper outfit"
	item_path = /obj/item/clothing/under/misc/stripper


/datum/loadout_item/under/greenstripper
	name = "Green stripper outfit"
	item_path = /obj/item/clothing/under/misc/stripper/green


/datum/loadout_item/under/bunnysuit
	name = "Bunny suit"
	item_path = /obj/item/clothing/under/misc/stripper/bunnysuit


/datum/loadout_item/under/bunnysuit/white
	name = "Bunny suit, white"
	item_path = /obj/item/clothing/under/misc/stripper/bunnysuit/white


/datum/loadout_item/under/qipao
	name = "Qipao, Black"
	item_path = /obj/item/clothing/under/costume/qipao


/datum/loadout_item/under/qipao/white
	name = "Qipao, White"
	item_path = /obj/item/clothing/under/costume/qipao/white


/datum/loadout_item/under/qipao/red
	name = "Qipao, Red"
	item_path = /obj/item/clothing/under/costume/qipao/red


/datum/loadout_item/under/cheongsam
	name = "Cheongsam, Black"
	item_path = /obj/item/clothing/under/costume/cheongsam


/datum/loadout_item/under/cheongsam/white
	name = "Cheongsam, White"
	item_path = /obj/item/clothing/under/costume/cheongsam/white


/datum/loadout_item/under/cheongsam/red
	name = "Cheongsam, Red"
	item_path = /obj/item/clothing/under/costume/cheongsam/red


/datum/loadout_item/under/kimono
	name = "Kimono, White"
	item_path = /obj/item/clothing/under/costume/kimono


/datum/loadout_item/under/kimono/dark
	name = "Kimono, Black"
	item_path = /obj/item/clothing/under/costume/kimono/dark


/datum/loadout_item/under/kimono/sakura
	name = "Kimono, Sakura"
	item_path = /obj/item/clothing/under/costume/kimono/sakura


/datum/loadout_item/under/kimono/fancy
	name = "Kimono, Fancy"
	item_path = /obj/item/clothing/under/costume/kimono/fancy


/datum/loadout_item/under/kamishimo
	name = "Kamishimo"
	item_path = /obj/item/clothing/under/costume/kamishimo


/datum/loadout_item/under/corset
	name = "Black Corset"
	item_path = /obj/item/clothing/under/dress/corset


/datum/loadout_item/under/chaps
	name = "Black Chaps"
	item_path = /obj/item/clothing/under/pants/chaps


/datum/loadout_item/under/taccas
	name = "Tacticasual Uniform"
	item_path = /obj/item/clothing/under/misc/taccas


/datum/loadout_item/under/tracky
	name = "Blue Tracksuit"
	item_path = /obj/item/clothing/under/misc/bluetracksuit



//SUITS

/datum/loadout_item/under/suit/suitblack
	name = "Black suit"
	item_path = /obj/item/clothing/under/suit/black

/datum/loadout_item/under/suit/suitgreen
	name = "Green suit"
	item_path = /obj/item/clothing/under/suit/green

/datum/loadout_item/under/suit/suitred
	name = "Red suit"
	item_path = /obj/item/clothing/under/suit/red

/datum/loadout_item/under/suit/suitcharcoal
	name = "Charcoal suit"
	item_path = /obj/item/clothing/under/suit/charcoal

/datum/loadout_item/under/suit/suitnavy
	name = "Navy suit"
	item_path = /obj/item/clothing/under/suit/navy

/datum/loadout_item/under/suit/suitburgundy
	name = "Burgundy suit"
	item_path = /obj/item/clothing/under/suit/burgundy

/datum/loadout_item/under/suit/suittan
	name = "Tan suit"
	item_path = /obj/item/clothing/under/suit/tan

/datum/loadout_item/under/suit/suitwhite
	name = "White suit"
	item_path = /obj/item/clothing/under/suit/white

/datum/loadout_item/under/suit/scarface
	name = "Cuban suit"
	item_path = /obj/item/clothing/under/suit/white/scarface

/datum/loadout_item/under/suit/vice
	name = "Grey and Black suit"
	item_path = /obj/item/clothing/under/misc/vice_officer

/datum/loadout_item/under/suit/greyskirty
	name = "Grey Suit Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/grey/skirtybaby

/datum/loadout_item/under/suit/blackskirty
	name = "Black Suit Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black/skirtybaby

/datum/loadout_item/under/suit/gentleskirty
	name = "Gentle Suit Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/gentle/skirtybaby

/datum/loadout_item/under/suit/gentleskirty
	name = "Gentle Suit Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/gentle/skirtybaby

/datum/loadout_item/under/suit/burgskirty
	name = "Burgundy Suit Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red/skirtybaby

/datum/loadout_item/under/suit/tanskirty
	name = "Tan Suit Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/tan/skirtybaby

/datum/loadout_item/under/suit/blueskirty
	name = "Blue Suit Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue/skirtybaby

/datum/loadout_item/under/suit/greenskirty
	name = "Green Suit Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/green/skirtybaby

/datum/loadout_item/under/suit/femblack
	name = "Feminine Suit"
	item_path = /obj/item/clothing/under/suit/black/female

/datum/loadout_item/under/suit/femblacksk
	name = "Feminine Skirt Suit"
	item_path = /obj/item/clothing/under/suit/black/female/skirt

/datum/loadout_item/under/suit/femblackskirt
	name = "Executive Skirt"
	item_path = /obj/item/clothing/under/suit/black_really/skirt

/datum/loadout_item/under/suit/cybersleek	//Cyberpunk P.I. Outfit
	name = "Sleek Modern Coat"
	item_path = /obj/item/clothing/under/costume/cybersleek

/datum/loadout_item/under/suit/cybersleek_long	//Alt of above
	name = "Long Modern Coat"
	item_path = /obj/item/clothing/under/costume/cybersleek/long

/datum/loadout_item/under/suit/victorian
	name = "Victorian Vest, Black Shirt"
	item_path = /obj/item/clothing/under/costume/vic_vest


/datum/loadout_item/under/suit/victorian/red
	name = "Victorian Vest, Red Shirt"
	item_path = /obj/item/clothing/under/costume/vic_vest/red


/datum/loadout_item/under/suit/victorian/blue
	name = "Victorian Vest, Blue Shirt"
	item_path = /obj/item/clothing/under/costume/vic_vest/blue


/datum/loadout_item/under/suit/victorian/red_alt
	name = "Red Victorian Vest, Black Shirt"
	item_path = /obj/item/clothing/under/costume/vic_vest/red_alt


/datum/loadout_item/under/suit/peaky
	name = "Birmingham Bling"
	item_path = /obj/item/clothing/under/misc/peakyblinder


/datum/loadout_item/under/suit/dutch
	name = "Dutch Suit"
	item_path = /obj/item/clothing/under/costume/dutch


/datum/loadout_item/under/suit/arthur
	name = "Dutch Assistant Suit"
	item_path = /obj/item/clothing/under/costume/arthur


/datum/loadout_item/under/suit/rancher
	name = "Rancher Suit"
	item_path = /obj/item/clothing/under/rancher

/datum/loadout_item/under/suit/pioneer
	name = "Pioneer Suit"
	item_path = /obj/item/clothing/under/rancher/pioneer

/datum/loadout_item/under/suit/worker
	name = "Western Worker Suit"
	item_path = /obj/item/clothing/under/rancher/worker

/datum/loadout_item/under/suit/cowboywhatever
	name = "Cowboy Suit"
	item_path = /obj/item/clothing/under/rancher/cowboy

/datum/loadout_item/under/suit/checkered
	name = "Checkered Shirt"
	item_path = /obj/item/clothing/under/rancher/checkered

/datum/loadout_item/under/suit/whiterussian
	name = "Russian Baron Suit"
	item_path = /obj/item/clothing/under/whiterussian


/datum/loadout_item/under/suit/beige
	name = "Beige Suit"
	item_path = /obj/item/clothing/under/suit/beige


//SKIRTS

/datum/loadout_item/under/skirt/skirtblack
	name = "Black skirt"
	item_path = /obj/item/clothing/under/dress/skirt

/datum/loadout_item/under/skirt/suitskirtblack
	name = "Black Suitskirt"
	item_path = /obj/item/clothing/under/suit/black/skirt

/datum/loadout_item/under/skirt/skirtblue
	name = "Blue skirt"
	item_path = /obj/item/clothing/under/dress/skirt/blue

/datum/loadout_item/under/skirt/skirtred
	name = "Red skirt"
	item_path = /obj/item/clothing/under/dress/skirt/red

/datum/loadout_item/under/skirt/curatorthing
	name = "Sensible Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/curator/skirt

/datum/loadout_item/under/skirt/skirtpurple
	name = "Purple skirt"
	item_path = /obj/item/clothing/under/dress/skirt/purple

/datum/loadout_item/under/skirt/skirtplaid
	name = "Plaid skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid

/datum/loadout_item/under/skirt/sweptskirt
	name = "Swept skirt"
	item_path = /obj/item/clothing/under/dress/skirt/swept

/datum/loadout_item/under/skirt/schoolgirlblue
	name = "Blue Schoolgirl Uniform"
	item_path = /obj/item/clothing/under/costume/schoolgirl

/datum/loadout_item/under/skirt/schoolgirlred
	name = "Red Schoolgirl Uniform"
	item_path = /obj/item/clothing/under/costume/schoolgirl/red

/datum/loadout_item/under/skirt/schoolgirlgreen
	name = "Green Schoolgirl Uniform"
	item_path = /obj/item/clothing/under/costume/schoolgirl/green

/datum/loadout_item/under/skirt/schoolgirlorange
	name = "Orange Schoolgirl Uniform"
	item_path = /obj/item/clothing/under/costume/schoolgirl/orange

/datum/loadout_item/under/skirt/denimskirt
	name = "Denim Skirt"
	item_path = /obj/item/clothing/under/pants/denimskirt

/datum/loadout_item/under/skirt/poly_skirt
	name = "Polychromic Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/polychromic



/datum/loadout_item/under/skirt/poly_skirt_pleated
	name = "Polychromic Pleated Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/polychromic/pleated


/datum/loadout_item/under/skirt/littleblack
	name = "Short Black Dress"
	item_path = /obj/item/clothing/under/dress/littleblack

/datum/loadout_item/under/skirt/pinktutu
	name = "Pink Tutu"
	item_path = /obj/item/clothing/under/dress/pinktutu

//DRESSES

/datum/loadout_item/under/dress/stripeddress
	name = "Striped Dress"
	item_path = /obj/item/clothing/under/dress/striped

/datum/loadout_item/under/dress/sailordress
	name = "Sailor Dress"
	item_path = /obj/item/clothing/under/dress/sailor

/datum/loadout_item/under/dress/sundresswhite
	name = "White Sundress"
	item_path = /obj/item/clothing/under/dress/sundress/white

/datum/loadout_item/under/dress/sundress
	name = "Sundress"
	item_path = /obj/item/clothing/under/dress/sundress

/datum/loadout_item/under/dress/greendress
	name = "Green Dress"
	item_path = /obj/item/clothing/under/dress/green

/datum/loadout_item/under/dress/pinkdress
	name = "Pink Dress"
	item_path = /obj/item/clothing/under/dress/pink

/datum/loadout_item/under/dress/flowerdress
	name = "Flower Dress"
	item_path = /obj/item/clothing/under/dress/flower

/datum/loadout_item/under/dress/countess
	name = "Countess Dress"
	item_path = /obj/item/clothing/under/misc/countess


/datum/loadout_item/under/dress/formal
	name = "Formal Red Dress"
	item_path = /obj/item/clothing/under/misc/formaldressred


/datum/loadout_item/under/dress/victorian
	name = "Victorian Vest, Black"
	item_path = /obj/item/clothing/under/costume/vic_dress

/datum/loadout_item/under/dress/victorian/red
	name = "Victorian Vest, Red"
	item_path = /obj/item/clothing/under/costume/vic_dress/red

//PANTS
/datum/loadout_item/under/pants/yoga
	name = "Yoga Pants"
	item_path = /obj/item/clothing/under/pants/yoga

/datum/loadout_item/under/pants/bjeans
	name = "Black Jeans"
	item_path = /obj/item/clothing/under/pants/blackjeans

/datum/loadout_item/under/pants/bpants
	name = "Black Pants"
	item_path = /obj/item/clothing/under/pants/black

/datum/loadout_item/under/pants/cjeans
	name = "Classic Jeans"
	item_path = /obj/item/clothing/under/pants/classicjeans

/datum/loadout_item/under/pants/khaki
	name = "Khaki Pants"
	item_path = /obj/item/clothing/under/pants/khaki

/datum/loadout_item/under/pants/wpants
	name = "White Pants"
	item_path = /obj/item/clothing/under/pants/white

/datum/loadout_item/under/pants/rpants
	name = "Red Pants"
	item_path = /obj/item/clothing/under/pants/red

/datum/loadout_item/under/pants/tpants
	name = "Tan Pants"
	item_path = /obj/item/clothing/under/pants/tan

/datum/loadout_item/under/pants/trpants
	name = "Track Pants"
	item_path = /obj/item/clothing/under/pants/track

/datum/loadout_item/under/pants/rippedjeans
	name = "Ripped Jeans"
	item_path = /obj/item/clothing/under/pants/jeanripped

/datum/loadout_item/under/pants/yakuza
	name = "Japanese Jeans"
	item_path = /obj/item/clothing/under/costume/yakuza

//SHORTS

/*/datum/loadout_item/under/shorts/polyshorts
	name = "Polychromic Shorts"
	item_path = /obj/item/clothing/under/misc/polyshorts
	*/

/*/datum/loadout_item/under/shorts/polyshortpants
	name = "Polychromic Athletic Shorts"
	item_path = /obj/item/clothing/under/shorts/polychromic*/


/datum/loadout_item/under/shorts/jeanshort
	name = "Jean Shorts"
	item_path = /obj/item/clothing/under/pants/jeanshort

/datum/loadout_item/under/shorts/camoshorts
	name = "Camo Pants"
	item_path = /obj/item/clothing/under/pants/camo

/datum/loadout_item/under/shorts/athleticshorts
	name = "Athletic Shorts"
	item_path = /obj/item/clothing/under/shorts/red


//SWEATERS

/datum/loadout_item/under/sweater/turtleneck
	name = "Tactitool Turtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool/sensors

/datum/loadout_item/under/sweater/tactical1
	name = "Irish Tactical Sweater"
	item_path = /obj/item/clothing/under/misc/tactical1

/datum/loadout_item/under/sweater/tactical2
	name = "British Tactical Sweater"
	item_path = /obj/item/clothing/under/uvf

/datum/loadout_item/under/sweater/turtleneck/skirt
	name = "Tactitool Skirtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool/skirt/sensors

/datum/loadout_item/under/sweater/creamsweater
	name = "Cream Commando Sweater"
	item_path = /obj/item/clothing/under/sweater

/datum/loadout_item/under/sweater/blacksweater
	name = "Black Commando Sweater"
	item_path = /obj/item/clothing/under/sweater/black

/datum/loadout_item/under/sweater/purpsweater
	name = "Purple Commando Sweater"
	item_path = /obj/item/clothing/under/sweater/purple

/datum/loadout_item/under/sweater/greensweater
	name = "Green Commando Sweater"
	item_path = /obj/item/clothing/under/sweater/green

/datum/loadout_item/under/sweater/redsweater
	name = "Red Commando Sweater"
	item_path = /obj/item/clothing/under/sweater/red

/datum/loadout_item/under/sweater/bluesweater
	name =  "Navy Commando Sweater"
	item_path = /obj/item/clothing/under/sweater/blue

/datum/loadout_item/under/sweater/polysweater
	name = "Polychromic Commando Sweater"
	item_path = /obj/item/clothing/under/misc/polysweater



/datum/loadout_item/under/sweater/keyholesweater
	name =  "Keyhole Sweater"
	item_path = /obj/item/clothing/under/sweater/keyhole

//JOB

// SKYRAT EDIT REMOVAL BEGIN - COMMAND CLOTHING VENDOR
/*
/datum/loadout_item/under/job/humblecaptain
	name = "Humble Captain Jumpsuit"
	item_path = /obj/item/clothing/under/rank/captain/humble
	restricted_roles = list("Captain")

/datum/loadout_item/under/job/captaindress
	name = "Captain's Dress"
	item_path = /obj/item/clothing/under/rank/captain/dress
	restricted_roles = list("Captain")
*/ // REMOVAL END

/datum/loadout_item/under/job/impcap
	name = "Captain's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/captain/imperial
	restricted_roles = list("Captain", "Nanotrasen Representative")

/datum/loadout_item/under/job/imphop
	name = "Head of Personnel's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/civilian/head_of_personnel/imperial
	restricted_roles = list("Head of Personnel", "Nanotrasen Representative")

/datum/loadout_item/under/job/lowprison
 	name = "Low Security Prisoner Jumpsuit"
 	item_path = /obj/item/clothing/under/rank/prisoner/lowsec
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/lowprisons
 	name = "Low Security Prisoner Jumpskirt"
 	item_path = /obj/item/clothing/under/rank/prisoner/lowsec/skirt
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/procusprison
 	name = "Protective Custody Prisoner Jumpsuit"
 	item_path = /obj/item/clothing/under/rank/prisoner/protcust
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/procusprisons
 	name = "Protective Custody Prisoner Jumpskirt"
 	item_path = /obj/item/clothing/under/rank/prisoner/protcust/skirt
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/supmaxprison
 	name = "Supermax Prisoner Jumpsuit"
 	item_path = /obj/item/clothing/under/rank/prisoner/supermax
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/supmaxprisons
 	name = "Supermax Prisoner Jumpskirt"
 	item_path = /obj/item/clothing/under/rank/prisoner/supermax/skirt
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/highprison
 	name = "High Risk Prisoner Jumpsuit"
 	item_path = /obj/item/clothing/under/rank/prisoner/highsec
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/supmaxprisons
 	name = "High Risk Prisoner Jumpskirt"
 	item_path = /obj/item/clothing/under/rank/prisoner/highsec/skirt
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/blacknwhite
 	name = "Classic Prisoner Jumpsuit"
 	item_path = /obj/item/clothing/under/rank/prisoner/classic
 	restricted_roles = list("Prisoner")

/datum/loadout_item/under/job/priestrobe
	name = "Priestess Robe"
	item_path = /obj/item/clothing/under/rank/pmarsrobe

	restricted_roles = list("Chaplain")


/datum/loadout_item/under/job/imphos
 	name = "Head of Security's Naval Uniform"
 	item_path = /obj/item/clothing/under/rank/security/head_of_security/imperial
 	restricted_roles = list("Head of Security")


/datum/loadout_item/under/job/navyblueuniformofficer
 	name = "Security officer navyblue uniform"
 	item_path = /obj/item/clothing/under/rank/security/officer/formal
 	restricted_roles = list("Security Officer","Security Medic","Security Sergeant")

/datum/loadout_item/under/job/navyblueuniformwarden
	name = "Warden navyblue uniform"
	item_path = /obj/item/clothing/under/rank/security/warden/formal
	restricted_roles = list("Warden")

/datum/loadout_item/under/job/solwarden
	name = "Sol Warden Uniform"
	item_path = /obj/item/clothing/under/rank/security/warden/peacekeeper/sol
	restricted_roles = list("Warden")

/datum/loadout_item/under/job/coroffw
	name = "Corrections Officer Sweater (skirt)"
	item_path = /obj/item/clothing/under/rank/security/brigguard/sweater/women
	restricted_roles = list("Corrections Officer","Warden")

/datum/loadout_item/under/job/coroffshir
	name = "Corrections Officer Shirt"
	item_path = /obj/item/clothing/under/rank/security/brigguard
	restricted_roles = list("Corrections Officer","Warden")

/datum/loadout_item/under/job/coroffshirw
	name = "Corrections Officer Skirt"
	item_path = /obj/item/clothing/under/rank/security/brigguard/women
	restricted_roles = list("Corrections Officer","Warden")

/datum/loadout_item/under/job/peacetrouse
	name = "Peacekeeper Trousers"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/trousers
	restricted_roles = list("Security Officer", "Warden", "Head of Security","Security Medic","Security Sergeant")

/datum/loadout_item/under/job/peacetrouse
	name = "Security Trousers"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/trousers/red
	restricted_roles = list("Security Officer", "Warden", "Head of Security","Security Medic","Security Sergeant")

/datum/loadout_item/under/job/secskirt
	name = "Security skirt"
	item_path = /obj/item/clothing/under/rank/security/officer/skirt
	restricted_roles = list("Security Officer", "Warden", "Head of Security","Security Medic","Security Sergeant") //i want a femboy sergeant to shove a baton up my ass //disgusting

/datum/loadout_item/under/job/seccadett
	name = "Sol Cadet Uniform"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/junior/sol
	restricted_roles = list("Security Officer", "Warden", "Head of Security","Security Medic","Security Sergeant", "Civil Disputes Officer")

/datum/loadout_item/under/job/sectrafficop
	name = "Sol Traffic Cop Uniform"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/junior/sol/traffic
	restricted_roles = list("Security Officer", "Warden", "Head of Security","Security Medic","Security Sergeant", "Civil Disputes Officer")

/datum/loadout_item/under/job/solofficerthing
	name = "Sol Officer Uniform"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/sol
	restricted_roles = list("Security Officer", "Warden", "Head of Security","Security Medic","Security Sergeant")

// SKYRAT EDIT REMOVAL BEGIN - MOVED TO COMMAND CLOTHING VENDOR
/*
/datum/loadout_item/under/job/hosskirt
	name = "Head of security's skirt"
	item_path = /obj/item/clothing/under/rank/security/head_of_security/skirt
	restricted_roles = list("Head of Security")
*/ // END

/datum/loadout_item/under/job/disco
	name = "Superstar Cop Suit"
	item_path = /obj/item/clothing/under/misc/discounder
	restricted_roles = list("Detective")
	restricted_desc = "Superstar Detectives"

/datum/loadout_item/under/job/seckilt
	name = "Security Kilt"
	item_path = /obj/item/clothing/under/rank/security/blackwatch
	restricted_roles = list("Security Officer", "Warden", "Head of Security","Security Medic","Security Sergeant")

/datum/loadout_item/under/job/medrscrubs
	name = "Red Scrubs (security)"
	item_path = /obj/item/clothing/under/rank/medical/doctor/red
	restricted_roles = list("Security Medic")
	restricted_desc = "Security Medic"

/datum/loadout_item/under/job/redscrubs
	name = "Red Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/doctor/red/unarm
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Security Medic", "Paramedic")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/bluescrubs
	name = "Blue Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/doctor/blue
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Security Medic", "Paramedic")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/greenscrubs
	name = "Green Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/doctor/green
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Security Medic", "Paramedic")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/purplescrubs
	name = "Purple Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/doctor/purple
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Security Medic", "Paramedic")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/whitescrubs
	name = "White Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/doctor/white

	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Security Medic", "Paramedic")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/nursesuit
	name = "Nurse Suit"
	item_path = /obj/item/clothing/under/rank/medical/doctor/nurse
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Security Medic", "Paramedic")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/formalmed
	name = "Formal Medical Suit"
	item_path = /obj/item/clothing/under/rank/medical/doctor/formal
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Security Medic", "Paramedic", "Psychologist")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/formalmedskirt
	name = "Formal Medical Skirt"
	item_path = /obj/item/clothing/under/rank/medical/doctor/formal/skirt
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Security Medic", "Paramedic", "Psychologist")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/formalvir
	name = "Formal Virologist Suit"
	item_path = /obj/item/clothing/under/rank/medical/virologist/formal
	restricted_roles = list("Chief Medical Officer", "Virologist")
	restricted_desc = "Virology"

/datum/loadout_item/under/job/formalvirskirt
	name = "Formal Virologist Skirt"
	item_path = /obj/item/clothing/under/rank/medical/virologist/formal/skirt
	restricted_roles = list("Chief Medical Officer", "Virologist")
	restricted_desc = "Virology"

/datum/loadout_item/under/job/formalchem
	name = "Formal Chemist Suit"
	item_path = /obj/item/clothing/under/rank/medical/chemist/formal
	restricted_roles = list("Chief Medical Officer", "Chemist")
	restricted_desc = "Chemistry"

/datum/loadout_item/under/job/formalchemskirt
	name = "Formal Chemist Skirt"
	item_path = /obj/item/clothing/under/rank/medical/chemist/formal/skirt
	restricted_roles = list("Chief Medical Officer", "Chemist")
	restricted_desc = "Chemistry"

/datum/loadout_item/under/job/impcmo
	name = "Chief Medical Officer's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/medical/chief_medical_officer/imperial
	restricted_roles = list("Chief Medical Officer")

/datum/loadout_item/under/job/gorka_cargo
	name = "Supply Gorka"
	item_path = /obj/item/clothing/under/utility/cargo/gorka
	restricted_roles = list("Cargo Technician", "Miner", "Quartermaster")
	restricted_desc = "All Cargo Personnel"

/datum/loadout_item/under/job/turtleneck_cargo
	name = "Supply Turtleneck"
	item_path = /obj/item/clothing/under/utility/cargo/turtleneck
	restricted_roles = list("Cargo Technician", "Miner", "Quartermaster")
	restricted_desc = "All Cargo Personnel"

/datum/loadout_item/under/job/casualcargothing
	name = "Casual Cargo Gear"
	item_path = /obj/item/clothing/under/rank/cargo/casualman
	restricted_roles = list("Cargo Technician", "Miner", "Quartermaster")
	restricted_desc = "All Cargo Personnel"

// SKYRAT EDIT REMOVAL BEGIN - MOVED TO COMMAND CLOTHING VENDOR
/*
/datum/loadout_item/under/job/gorka_qm
	name = "Quartermaster's Gorka"
	item_path = /obj/item/clothing/under/utility/cargo/gorka/head
	restricted_roles = list("Quartermaster")

/datum/loadout_item/under/job/turtleneck_qm
	name = "Quartermaster's Turtleneck"
	item_path = /obj/item/clothing/under/utility/cargo/turtleneck/head
	restricted_roles = list("Quartermaster")

/datum/loadout_item/under/job/qmformal
	name = "Quartermaster's Formal Suit"
	item_path = /obj/item/clothing/under/rank/cargo/qm/formal
	restricted_roles = list("Quartermaster")

/datum/loadout_item/under/job/qmformalskirt
	name = "Quartermaster's Formal Skirt"
	item_path = /obj/item/clothing/under/rank/cargo/qm/formal/skirt
	restricted_roles = list("Quartermaster")

/datum/loadout_item/under/job/qmcasual
	name = "Quartermaster's Casual Suit"
	item_path = /obj/item/clothing/under/rank/cargo/qm/casual
	restricted_roles = list("Quartermaster")
*/ // END

/datum/loadout_item/under/job/engtrous
	name = "Engineering Trousers"
	item_path = /obj/item/clothing/under/rank/engineering/engineer/trouser
	restricted_roles = list("Station Engineer","Atmospheric Technician", "Chief Engineer")
	restricted_desc = "Engineering"

/datum/loadout_item/under/job/engformal
	name = "Engineering Formal Suit"
	item_path = /obj/item/clothing/under/rank/engineering/engineer/formal
	restricted_roles = list("Station Engineer","Atmospheric Technician", "Chief Engineer")
	restricted_desc = "Engineering"

/datum/loadout_item/under/job/engformalskirt
	name = "Engineering Formal Skirt"
	item_path = /obj/item/clothing/under/rank/engineering/engineer/formal/skirt
	restricted_roles = list("Station Engineer","Atmospheric Technician", "Chief Engineer")
	restricted_desc = "Engineering"

/datum/loadout_item/under/job/impce
	name = "Chief Engineer's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/engineering/chief_engineer/imperial
	restricted_roles = list("Chief Engineer")

/datum/loadout_item/under/job/imprd
	name = "Research Director's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/imperial
	restricted_roles = list("Research Director")



//JOB - UTILITY
/datum/loadout_item/under/job/utility
	name = "Utility Uniform"
	item_path = /obj/item/clothing/under/utility
	restricted_desc = "Unrestricted"

/datum/loadout_item/under/job/utility_eng
	name = "Engineering Utility Uniform"
	item_path = /obj/item/clothing/under/utility/eng
	restricted_roles = list("Station Engineer","Atmospheric Technician", "Chief Engineer")
	restricted_desc = "Engineering"

/datum/loadout_item/under/job/utility_med
	name = "Medical Utility Uniform"
	item_path = /obj/item/clothing/under/utility/med
	restricted_roles = list("Medical Doctor", "Paramedic", "Chemist", "Virologist", "Geneticist", "Security Medic", "Chief Medical Officer", "Psychologist")
	restricted_desc = "Medical"

/datum/loadout_item/under/job/utility_sci
	name = "Science Utility Uniform"
	item_path = /obj/item/clothing/under/utility/sci
	restricted_roles = list("Scientist", "Roboticist", "Geneticist", "Research Director", "Vanguard Operative")
	restricted_desc = "Science"

/datum/loadout_item/under/job/hlscientist
	name = "Ridiculous Scientist Outfit"
	item_path = /obj/item/clothing/under/misc/hlscience
	restricted_roles = list("Scientist", "Roboticist", "Geneticist", "Research Director", "Vanguard Operative")
	restricted_desc = "Science"

/datum/loadout_item/under/job/utility_cargo
	name = "Supply Utility Uniform"
	item_path = /obj/item/clothing/under/utility/cargo
	restricted_roles = list("Cargo Technician", "Miner", "Quartermaster")
	restricted_desc = "Cargo"

/datum/loadout_item/under/job/utility_sec
	name = "Security Utility Uniform"
	item_path = /obj/item/clothing/under/utility/sec
	restricted_roles = list("Security Officer", "Detective", "Warden", "Blueshield", "Security Medic","Security Sergeant", "Head of Security", "Civil Disputes Officer", "Corrections Officer") //i dunno about the blueshield, they're a weird combo of sec and command, thats why they arent in the loadout pr im making
	restricted_desc = "Security"

/datum/loadout_item/under/job/utility_com
	name = "Command Utility Uniform"
	item_path = /obj/item/clothing/under/utility/com
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer")
	restricted_desc = "Command Staff"

/datum/loadout_item/under/job/impcommand
	name = "Light Grey Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/imperial
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer", "Nanotrasen Representative")
	restricted_desc = "Command Staff"

/datum/loadout_item/under/job/impcom
	name = "Grey Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/imperial/grey
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer", "Nanotrasen Representative")
	restricted_desc = "Command Staff"

/datum/loadout_item/under/job/impred
	name = "Red Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/imperial/red
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer")	//NT Reps would never wear red, it's unbefitting
	restricted_desc = "Command Staff"

/datum/loadout_item/under/job/impcomtrous
	name = "Grey Officer's Naval Jumpsuit (Trousers)"
	item_path = /obj/item/clothing/under/imperial/grey/trouser
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer", "Nanotrasen Representative")
	restricted_desc = "Command Staff"

/datum/loadout_item/under/job/robosleek
	name = "Sleek Roboticist Jumpsuit"
	item_path = /obj/item/clothing/under/utility/robo_sleek
	restricted_roles = list("Roboticist", "Research Director")
	restricted_desc = "Robotics"

/datum/loadout_item/under/job/para_red
	name = "Red Paramedic Jumpsuit"
	item_path = /obj/item/clothing/under/utility/para_red
	restricted_roles = list("Chief Medical Officer", "Paramedic", "Security Medic") //BRO RED USED TO BE THE SEC COLOUR
	restricted_desc = "Medical First Responders"

// Trekie things
//TOS
/datum/loadout_item/under/job/trek/trekcmdtos
	name = "TOS - cmd"
	item_path = /obj/item/clothing/under/trek/command
	restricted_desc = "Heads of Staff"
	restricted_roles = list("Head of Security","Captain","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer","Quartermaster")

/datum/loadout_item/under/job/trek/trekmedscitos
	name = "TOS - med/sci"
	item_path = /obj/item/clothing/under/trek/medsci
	restricted_desc = "Medical and Science"
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Virologist","Security Medic","Paramedic","Psychologist","Geneticist","Research Director","Scientist","Roboticist","Vanguard Operative")

/datum/loadout_item/under/job/trek/trekengtos
	name = "TOS - ops/sec"
	item_path = /obj/item/clothing/under/trek/engsec
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

//handled by modular skyrat code as reskins
//TNG
/datum/loadout_item/under/job/trek/trekcmdtng
	name = "TNG - cmd"
	item_path = /obj/item/clothing/under/trek/command/next
	restricted_desc = "Heads of Staff"
	restricted_roles = list("Head of Security","Captain","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer","Quartermaster")

/datum/loadout_item/under/job/trekmedscitng
	name = "TNG - med/sci"
	item_path = /obj/item/clothing/under/trek/medsci/next
	restricted_desc = "Medical and Science"
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Paramedic","Chemist","Virologist","Security Medic","Psychologist","Geneticist","Research Director","Scientist","Roboticist","Vanguard Operative")

/datum/loadout_item/under/job/trekengtng
	name = "TNG - ops/sec"
	item_path = /obj/item/clothing/under/trek/engsec/next
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

//VOY
/datum/loadout_item/under/job/trekcmdvoy
	name = "VOY - cmd"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/command/voy
	restricted_desc = "Heads of Staff"
	restricted_roles = list("Head of Security","Captain","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer","Quartermaster")

/datum/loadout_item/under/job/trekmedscivoy
	name = "VOY - med/sci"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/medsci/voy
	restricted_desc = "Medical and Science"
	restricted_roles = list("Chief Medical Officer","Security Medic","Medical Doctor","Paramedic","Chemist","Virologist","Psychologist","Geneticist","Research Director","Scientist","Roboticist","Vanguard Operative")

/datum/loadout_item/under/job/trekengvoy
	name = "VOY - ops/sec"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/engsec/voy
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Warden","Security Medic","Security Sergeant","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

//DS9
/datum/loadout_item/under/job/trekcmdds9
	name = "DS9 - cmd"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/command/ds9
	restricted_desc = "Heads of Staff"
	restricted_roles = list("Head of Security","Captain","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer","Quartermaster")

/datum/loadout_item/under/job/trekmedscids9
	name = "DS9 - med/sci"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/medsci/ds9
	restricted_desc = "Medical and Science"
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Paramedic","Security Medic","Chemist","Virologist","Psychologist","Geneticist","Research Director","Scientist", "Roboticist")

/datum/loadout_item/under/job/trekengds9
	name = "DS9 - ops/sec"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/engsec/ds9
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

//ENT
/datum/loadout_item/under/job/trekcmdent
	name = "ENT - cmd"
	item_path = /obj/item/clothing/under/trek/command/ent
	restricted_desc = "Heads of Staff"
	restricted_roles = list("Head of Security","Captain","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer","Quartermaster")

/datum/loadout_item/under/job/trekmedscient
	name = "ENT - med/sci"
	item_path = /obj/item/clothing/under/trek/medsci/ent
	restricted_desc = "Medical and Science"
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Security Medic","Paramedic","Chemist","Virologist","Psychologist","Geneticist","Research Director","Scientist", "Roboticist","Vanguard Operative")

/datum/loadout_item/under/job/trekengent
	name = "ENT - ops/sec"
	item_path = /obj/item/clothing/under/trek/engsec/ent
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

//Orville+
/datum/loadout_item/under/job/trekcptorv
	name = "ORV - captain"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/command/orv/captain
	restricted_roles = list("Captain")

/datum/loadout_item/under/job/trekcmdorv_medsci
	name = "ORV - cmd - med/sci"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/command/orv/medsci
	restricted_roles = list("Research Director","Chief Medical Officer")

/datum/loadout_item/under/job/trekcmdorv_engsec
	name = "ORV - cmd - ops/sec"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/command/orv/engsec
	restricted_roles = list("Head of Security","Chief Engineer","Quartermaster")

/datum/loadout_item/under/job/trekcmdorv
	name = "ORV - cmd"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/command/orv
	restricted_desc = "Heads of Staff"
	restricted_roles = list("Head of Security","Captain","Head of Personnel","Chief Engineer","Research Director","Chief Medical Officer","Quartermaster")

/datum/loadout_item/under/job/trekmedsciorv
	name = "ORV - med/sci"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/medsci/orv
	restricted_desc = "Medical and Science"
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Paramedic","Chemist","Virologist","Psychologist","Security Medic","Geneticist","Research Director","Scientist", "Roboticist","Vanguard Operative")

/datum/loadout_item/under/job/trekengorv
	name = "ORV - ops/sec"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/engsec/orv
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

/datum/loadout_item/under/job/trekservorv
	name = "ORV - service"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/orv/service
	restricted_desc = "Service"
	restricted_roles = list("Assistant", "Bartender", "Botanist", "Cook", "Curator", "Janitor", "Clown", "Mime", "Lawyer", "Psychologist")

/datum/loadout_item/under/job/trekadjtorv
	name = "ORV - assistant"
	item_path = /obj/item/clothing/under/trek/modular_skyrat/orv
	restricted_roles = list("Assistant")

/datum/loadout_item/under/tactical_hawaiian_orange
	name = "Tactical Hawaiian Outfit - Orange"
	item_path = /obj/item/clothing/under/tachawaiian

/datum/loadout_item/under/tactical_hawaiian_blue
	name = "Tactical Hawaiian Outfit - Blue"
	item_path = /obj/item/clothing/under/tachawaiian/blue

/datum/loadout_item/under/tactical_hawaiian_purple
	name = "Tactical Hawaiian Outfit - Purple"
	item_path = /obj/item/clothing/under/tachawaiian/purple

/datum/loadout_item/under/tactical_hawaiian_green
	name = "Tactical Hawaiian Outfit - Green"
	item_path = /obj/item/clothing/under/tachawaiian/green

/datum/loadout_item/under/texas
	name = "Texan Suit"
	item_path = /obj/item/clothing/under/texas

/datum/loadout_item/under/dimmadome
	name = "Doug Dimmadome Suit"
	item_path = /obj/item/clothing/under/doug_dimmadome

/datum/loadout_item/under/westender
	name = "Westender Suit"
	item_path = /obj/item/clothing/under/westender

/datum/loadout_item/uniform/latexmaid
	name = "Latex maid uniform"
	item_path = /obj/item/clothing/under/costume/lewdmaid

/datum/loadout_item/uniform/stripper
	name = "Stripper outfit"
	item_path = /obj/item/clothing/under/stripper_outfit

