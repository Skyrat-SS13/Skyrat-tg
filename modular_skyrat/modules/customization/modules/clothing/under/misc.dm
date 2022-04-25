/obj/item/clothing/under/misc/stripper
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "pink stripper outfit"
	icon_state = "stripper_p"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/stripper/green
	name = "green stripper outfit"
	icon_state = "stripper_g"

/obj/item/clothing/under/misc/stripper/mankini
	name = "pink mankini"
	icon_state = "mankini"

/obj/item/clothing/under/misc/stripper/bunnysuit
	name = "bunny suit"
	desc = "Makes the wearer more attractive, even men."
	icon_state = "bunnysuit"
	can_adjust = TRUE
	alt_covers_chest = FALSE

/obj/item/clothing/under/misc/stripper/bunnysuit/white
	name = "white bunny suit"
	icon_state = "whitebunnysuit"
	can_adjust = FALSE

/obj/item/clothing/under/croptop
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "crop top"
	desc = "We've saved money by giving you half a shirt!"
	icon_state = "croptop"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/misc/gear_harness
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "gear harness"
	desc = "A simple, inconspicuous harness replacement for a jumpsuit."
	icon_state = "gear_harness"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/colourable_kilt
	name = "colourable kilt"
	desc = "It's not a skirt!"
	icon_state = "kilt"
	greyscale_config = /datum/greyscale_config/kilt
	greyscale_config_worn = /datum/greyscale_config/kilt/worn
	greyscale_colors = "#008000#777777"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/royalkilt
	name = "royal kilt"
	desc = "A far more modern kilt, the tunic's been tossed for a combat sweater, the Hunting tartan swapped for Royal Stuart, the itchy green socks are now not itchy or green!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "royalkilt"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/under/misc/tactical1
	name = "irish tactical uniform"
	desc = "The SAM missiles are in the sky! Faint whiffs of cheap booze and Libyan semtex come off this getup, someone was so kind as to leave a book in one of the pockets, too bad it's all in Gaelic!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tactical1"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/under/rank/security/blackwatch
	name = "security kilt"
	desc = "Youve heard about the B-men, the cruel RUC. Well theres another regiment the devil calls his own. Theyre known as the Black Watch commissioned by the Crown"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "blackwatch"
	inhand_icon_state = "kilt"
	armor = list(MELEE = 30, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 10, ACID = 20, WOUND = 10)
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/under/misc/kimunder
	name = "aerostatic suit"
	desc = "A crisp and well-pressed suit; professional, comfortable and curiously authoritative."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "aerostatic_suit"

/obj/item/clothing/under/misc/countess
	name = "countess dress"
	desc = "A wide flowing dress fitting for a countess, maybe not for anyone who enjoys a dress that doesn't catch on things."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "countess_s"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES

/obj/item/clothing/under/misc/formaldressred
	name = "formal red dress"
	desc = "Not too wide flowing, but big enough to make an impression."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "formalred_s"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES

/obj/item/clothing/under/misc/peakyblinder
	name = "birmingham bling"
	desc = "A grey suit with a white vest, maybe you run a whiskey plant, maybe you have a frenemy relationship with that guy out of that one film, whatever it is, it's still a nice looking suit."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "peakyblinder"

/obj/item/clothing/under/misc/taccas
	name = "tacticasual uniform"
	desc = "A white wifebeater on top of some cargo pants. For when you need to carry various beers."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tac_s"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/misc/bluetracksuit
	name = "blue tracksuit"
	desc = "Found on a dead homeless man squatting in an alleyway, the classic design has been mass produced to bring terror to the galaxy."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tracksuit_blue"

/obj/item/clothing/under/enclaveo
	name = "neo american officer uniform"
	desc = "Throughout the stars, rumors of mad scientists and angry drill sergeant run rampent, of creatures in armor black as night being led by men or women wearing this uniform, they share one thing, a deep, natonalistic zeal of the dream of America."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "enclaveo"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0, WOUND = 0)
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/under/enclave
	name = "neo american sergeant uniform"
	desc = "Not as high ranking as the officers often standing in front of them, this outfit is less armored than it's sister."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "enclave"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0, WOUND = 0)
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/under/enclaveo/real
	name = "neo american officer uniform"
	desc = "Throughout the stars, rumors of mad scientists and angry drill sergeant run rampent, of creatures in armor black as night being led by men or women wearing this uniform, they share one thing, a deep, natonalistic zeal of the dream of America."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "enclaveo"
	armor = list(MELEE = 0, BULLET = 10, LASER = 20,ENERGY = 20, BOMB = 0, BIO = 0, FIRE = 0, ACID = 10, WOUND = 10)
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/under/enclave/real
	name = "neo american sergeant uniform"
	desc = "Not as high ranking as the officers often standing in front of them, this outfit is less armored than it's sister."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "enclave"
	armor = list(MELEE = 0, BULLET = 10, LASER = 10,ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 0, ACID = 10, WOUND = 10)
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/under/tachawaiian
	name = "orange tactical hawaiian outfit"
	desc = "Clearly the wearer didn't know if they wanted to invade a country or lay on a nice Hawaiian beach."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tacticool_hawaiian_orange"
	supports_variations_flags = NONE

/obj/item/clothing/under/tachawaiian/blue
	name = "blue tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_blue"

/obj/item/clothing/under/tachawaiian/purple
	name = "purple tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_purple"

/obj/item/clothing/under/tachawaiian/green
	name = "green tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_green"

/obj/item/clothing/under/texas
	name = "texan formal outfit"
	desc = "A premium quality shirt and pants combo straight from Texas."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "texas"
	supports_variations_flags = NONE

/obj/item/clothing/under/doug_dimmadome
	name = "dimmadome formal outfit"
	desc = "A tight fitting suit with a belt that is surely made out of gold."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "doug_dimmadome"
	supports_variations_flags = NONE

/obj/item/clothing/under/westender
	name = "westender outfit"
	desc = "An outfit harking back to a pre-industrial revolution era."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "westender"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/pmarsrobe
	name = "priestess robe"
	desc = "A thick woolly robe adorned with black furs of a wolf. Keepers of the Flame of utter boredom. Sadly not flameproof"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "pmars_robe"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	flags_inv = HIDESHOES

///COWBOY
/obj/item/clothing/under/rancher
	name = "rancher outfit"
	desc = "An outfit from the desert outback, phrases around family murder or revenge seem to echo from this get-up."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "rancher"

/obj/item/clothing/under/rancher/pioneer
	name = "pioneer outfit"
	desc = "An outfit from the desert outback, this one seems like one on the frontline, don't trust a german, or anyone trying to get you to go to Callifornia."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "pioneer"

/obj/item/clothing/under/rancher/worker
	name = "western worker outfit"
	desc = "An outfit from the desert outback, this one seems something a coffin maker would wear, hope you're good at eyeballing size."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "worker"

/obj/item/clothing/under/rancher/cowboy
	name = "cowboy outfit"
	desc = "An outfit from the desert outback, this one seems fitting for a hat and poncho, maybe a long flowing coat."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "cowboy"

/obj/item/clothing/under/rancher/checkered
	name = "western checkered outfit"
	desc = "An outfit from the desert outback, this one seems like something someone with no fashion sense would wear."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "checkered"

/obj/item/clothing/under/rank/captain/humble
	desc = "It's a blue jumpsuit with some small gold markings denoting the rank of \"Captain\", more humble than it's sister."
	name = "captain's humble jumpsuit"
	icon_state = "captainhumble"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	inhand_icon_state = "b_suit"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0, WOUND = 15)

/obj/item/clothing/under/uvf
	name = "british combat sweater"
	desc = "Thankfully doesn't include the sash your father wore."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "uvf"

/obj/item/clothing/under/suit/black/female/skirt
	name = "feminine skirt"
	desc = "Perfect for a secretary that does no work."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "black_suit_fem_skirt"

/obj/item/clothing/under/whiterussian
	name = "army baron uniform"
	desc = "Space Communism? That's just like...your opinion man."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "rusuni"

/obj/item/clothing/under/nostalgiacritic
	name = "nostalgic outfit"
	desc = "He remembers it so you don't have to."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "cia"



/obj/item/clothing/under/suit/white/scarface
	name = "cuban suit"
	desc = "A yayo coloured silk suit with a crimson shirt. You just know how to hide, how to lie. Me, I don't have that problem. Me, I always tell the truth. Even when I lie."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "scarface"

/obj/item/clothing/under/misc/gear_harness/eve
	name = "collection of leaves"
	desc = "Three leaves, designed to cover the nipples and genetalia of the wearer. A foe so proud will first the weaker seek."
	icon_state = "eve"

/obj/item/clothing/under/misc/gear_harness/adam
	name = "leaf"
	desc = "A single leaf, designed to cover the genitalia of the wearer. Seek not temptation."
	icon_state = "adam"
	body_parts_covered = GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/misc/evilcargo
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "black cargo uniform"
	desc = "Yep, here’s your problem. Someone set this thing to evil."
	icon_state = "qmsynd"
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/doctor/white
	name = "white scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in a cream white colour."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "scrubswhite"

/obj/item/clothing/under/rank/engineering/engineer/trouser
	desc = "A yellow set of trousers that somehow protect against radiation."
	name = "engineer's trousers"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "workpants_orange"
	body_parts_covered = GROIN
	can_adjust = FALSE
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/civilian/hydroponics/trouser
	desc = "A green set of trousers, perfect for making pigs smoke."
	name = "farmer's trousers"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "workpants_green"
	body_parts_covered = GROIN
	can_adjust = FALSE
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/trousers
	name = "peacekeeper's trousers"
	desc = "Some light blue combat trousers, however you get protected by these, I have no idea."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "workpants_blue"
	body_parts_covered = GROIN
	can_adjust = FALSE
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/trousers/red
	name = "security officer's trousers"
	desc = "Some red combat trousers, however you get protected by these, I have no idea."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "workpants_red"

/obj/item/clothing/under/rank/captain/imperial
	desc = "A white jumpsuit adorned with golden epaulets and a rank badge denoting a Captain. There are two ways to destroy a person, kill him, or ruin his reputation."
	name = "captain's naval jumpsuit"
	icon_state = "impcap"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/head_of_personnel/imperial
	desc = "A olive green navel suit and a rank badge denoting the Personnel Officer. Target, maximum firepower."
	name = "head of personnel's naval jumpsuit"
	icon_state = "imphop"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/security/head_of_security/imperial
	desc = "A tar black navel jumpsuit and a rank badge denoting the Officer of The Internal Security Division. Be careful your underlings don't bump their head on a door."
	name = "head of security's naval jumpsuit"
	icon_state = "imphos"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/rnd/research_director/imperial
	desc = "A grey, sterile jumpsuit with a rank badge denoting the Officer of the Internal Science Division. It's a peaceful life."
	name = "research director's naval jumpsuit"
	icon_state = "imprd"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/engineering/chief_engineer/imperial
	desc = "A black, lead lined jumpsuit with a rank badge denoting the Officer of the Internal Engineering Division. Doesn't come with a death machine building guide."
	name = "chief engineer's naval jumpsuit"
	icon_state = "impce"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/medical/chief_medical_officer/imperial
	desc = "A teal, sterile jumpsuit with a rank badge denoting the Officer of the Medical Corps. Doesn't protect against blaster fire."
	name = "chief medical officer's naval jumpsuit"
	icon_state = "impcmo"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/imperial
	desc = "A light grey jumpsuit with a rank badge denoting an Officer. Doesn't protect against blaster fire."
	name = "light grey officer's naval jumpsuit"
	icon_state = "impcom"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/imperial/grey
	desc = "A grey jumpsuit with a rank badge denoting an Officer. Doesn't protect against blaster fire."
	name = "grey officer's naval jumpsuit"
	icon_state = "impcommand"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/imperial/grey/trouser
	desc = "A grey jumpsuit with a rank badge denoting an Officer. This one has grey trousers."
	name = "grey officer's naval jumpsuit"
	icon_state = "admiral_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/imperial/red
	desc = "A red jumpsuit with a rank badge denoting an Officer. Doesn't protect against blaster fire."
	name = "red officer's naval jumpsuit"
	icon_state = "impred_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/grey/skirtybaby
	desc = "A white shirt with a grey pancilskirt."
	name = "grey suit skirt"
	icon_state = "detective_skirty"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'


/obj/item/clothing/under/rank/civilian/lawyer/black/skirtybaby
	desc = "A white shirt with a dark pancilskirt."
	name = "black suit skirt"
	icon_state = "internalaffairs_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/gentle/skirtybaby
	desc = "A black shirt with a grey pancilskirt."
	name = "gentle suit skirt"
	icon_state = "gentlesuit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/red/skirtybaby
	desc = "A satin white shirt with a dark red pancilskirt."
	name = "burgundy suit skirt"
	icon_state = "burgundy_suit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/tan/skirtybaby
	desc = "A satin white shirt with a tan pancilskirt."
	name = "tan suit skirt"
	icon_state = "tan_suit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/blue/skirtybaby
	desc = "A satin white shirt with a light blue pancilskirt."
	name = "blue suit skirt"
	icon_state = "bluesuit_suit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/green/skirtybaby
	desc = "A satin white shirt with a light green pancilskirt."
	name = "green suit skirt"
	icon_state = "greensuit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/head_of_personnel/parade
	name = "head of personnel's male formal uniform"
	desc = "A luxurious uniform for the head of personnel, woven in a deep blue. On the lapel is a small pin in the shape of a corgi's head."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "hop_parade_male"
	inhand_icon_state = "hop_parade_male"
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/head_of_personnel/parade/female
	name = "head of personnel's female formal uniform"
	icon_state = "hop_parade_female"

/obj/item/clothing/under/rank/captain/kilt
	desc = "Not a skirt, it is, however, armoured and decorated with a tartan sash."
	name = "captain's kilt"
	icon_state = "capkilt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	inhand_icon_state = "kilt"

/obj/item/clothing/under/suit/helltaker
	name = "red shirt with white pants"
	desc = "No time. Busy gathering girls."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "helltaker"

/obj/item/clothing/under/suit/helltaker/skirt
	name = "red shirt with white skirt"
	desc = "No time. Busy gathering boys."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "helltakerskirt"

/obj/item/clothing/under/costume/christmas
	name = "christmas costume"
	desc = "Can you believe it guys? Christmas. Just a lightyear away!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "christmasmaler"

/obj/item/clothing/under/costume/christmas/green
	name = "green christmas costume"
	desc = "Alright buddy, you have two options here. You can be a saint, or you can be a Grinch. Those are your two choices. Choose wisely."
	icon_state = "christmasmaleg"

/obj/item/clothing/under/croptop/christmas
	name = "sexy christmas costume"
	desc = "Can you believe it guys? Christmas. Just a lightyear away!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "christmasfemaler"

/obj/item/clothing/under/croptop/christmas/green
	name = "sexy green christmas costume"
	desc = "Alright buddy, you have two options here. You can be a saint, or you can be a Grinch. Those are your two choices. Choose wisely."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "christmasfemaleg"

/obj/item/clothing/under/rank/civilian/lawyer/inferno
	name = "inferno suit"
	desc = "Stylish enough to impress the devil."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "lucifer"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Pride" = "lucifer",
		"Wrath" = "justice",
		"Gluttony" = "malina",
		"Envy" = "zdara",
		"Vanity" = "cereberus",
	)

/obj/item/clothing/under/rank/civilian/lawyer/inferno/skirt
	name = "inferno suitskirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "modeus"
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Lust" = "modeus",
		"Sloth" = "pande",
	)

/obj/item/clothing/under/rank/civilian/lawyer/inferno/beeze
	name = "designer inferno suit"
	desc = "A fancy tail-coated suit with a fluffy bow emblazoned on the chest, complete with an NT pin."
	icon_state = "beeze"
	obj_flags = null
	unique_reskin = null

/obj/item/clothing/under/suit/black/female/trousers //i swear this already existed, but whatever
	name = "feminine suit"
	desc = "Perfect for a secretary that does no work. This time with pants!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "black_suit_fem"

/obj/item/clothing/under/rank/captain/black
	name = "captains black suit"
	desc = "A very sleek naval captains uniform for those who think they're commanding a battleship."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "captainblacksuit"
