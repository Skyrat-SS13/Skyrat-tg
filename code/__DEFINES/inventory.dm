/*ALL DEFINES RELATED TO INVENTORY OBJECTS, MANAGEMENT, ETC, GO HERE*/

//ITEM INVENTORY WEIGHT, FOR w_class
/// Usually items smaller then a human hand, (e.g. playing cards, lighter, scalpel, coins/holochips)
#define WEIGHT_CLASS_TINY 1
/// Pockets can hold small and tiny items, (e.g. flashlight, multitool, grenades, GPS device)
#define WEIGHT_CLASS_SMALL 2
/// Standard backpacks can carry tiny, small & normal items, (e.g. fire extinguisher, stun baton, gas mask, metal sheets)
#define WEIGHT_CLASS_NORMAL 3
/// Items that can be wielded or equipped but not stored in an inventory, (e.g. defibrillator, backpack, space suits)
#define WEIGHT_CLASS_BULKY 4
/// Usually represents objects that require two hands to operate, (e.g. shotgun, two-handed melee weapons)
#define WEIGHT_CLASS_HUGE 5
/// Essentially means it cannot be picked up or placed in an inventory, (e.g. mech parts, safe)
#define WEIGHT_CLASS_GIGANTIC 6

/// Weight class that can fit in pockets
#define POCKET_WEIGHT_CLASS WEIGHT_CLASS_SMALL

//Inventory depth: limits how many nested storage items you can access directly.
//1: stuff in mob, 2: stuff in backpack, 3: stuff in box in backpack, etc
#define INVENTORY_DEPTH 3
#define STORAGE_VIEW_DEPTH 2

//ITEM INVENTORY SLOT BITMASKS
/// Suit slot (armors, costumes, space suits, etc.)
#define ITEM_SLOT_OCLOTHING (1<<0)
/// Jumpsuit slot
#define ITEM_SLOT_ICLOTHING (1<<1)
/// Glove slot
#define ITEM_SLOT_GLOVES (1<<2)
/// Glasses slot
#define ITEM_SLOT_EYES (1<<3)
/// Ear slot (radios, earmuffs)
#define ITEM_SLOT_EARS (1<<4)
/// Mask slot
#define ITEM_SLOT_MASK (1<<5)
/// Head slot (helmets, hats, etc.)
#define ITEM_SLOT_HEAD (1<<6)
/// Shoe slot
#define ITEM_SLOT_FEET (1<<7)
/// ID slot
#define ITEM_SLOT_ID (1<<8)
/// Belt slot
#define ITEM_SLOT_BELT (1<<9)
/// Back slot
#define ITEM_SLOT_BACK (1<<10)
/// Dextrous simplemob "hands" (used for Drones and Dextrous Guardians)
#define ITEM_SLOT_DEX_STORAGE (1<<11)
/// Neck slot (ties, bedsheets, scarves)
#define ITEM_SLOT_NECK (1<<12)
/// A character's hand slots
#define ITEM_SLOT_HANDS (1<<13)
/// Inside of a character's backpack
#define ITEM_SLOT_BACKPACK (1<<14)
/// Suit Storage slot
#define ITEM_SLOT_SUITSTORE (1<<15)
/// Left Pocket slot
#define ITEM_SLOT_LPOCKET (1<<16)
/// Right Pocket slot
#define ITEM_SLOT_RPOCKET (1<<17)
/// Handcuff slot
#define ITEM_SLOT_HANDCUFFED (1<<18)
/// Legcuff slot (bolas, beartraps)
#define ITEM_SLOT_LEGCUFFED (1<<19)

/// Total amount of slots
#define SLOTS_AMT 20 // Keep this up to date!

//SLOT GROUP HELPERS
#define ITEM_SLOT_POCKETS (ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET)
/// Slots that are physically on you
#define ITEM_SLOT_ON_BODY (ITEM_SLOT_ICLOTHING | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_EYES | ITEM_SLOT_EARS | \
	ITEM_SLOT_MASK | ITEM_SLOT_HEAD | ITEM_SLOT_FEET | ITEM_SLOT_ID | ITEM_SLOT_BELT | ITEM_SLOT_BACK | ITEM_SLOT_NECK )

//Bit flags for the flags_inv variable, which determine when a piece of clothing hides another. IE a helmet hiding glasses.
//Make sure to update check_obscured_slots() if you add more.
#define HIDEGLOVES (1<<0)
#define HIDESUITSTORAGE (1<<1)
#define HIDEJUMPSUIT (1<<2) //these first four are only used in exterior suits
#define HIDESHOES (1<<3)
#define HIDEMASK (1<<4) //these next seven are only used in masks and headgear.
#define HIDEEARS (1<<5) // (ears means headsets and such)
#define HIDEEYES (1<<6) // Whether eyes and glasses are hidden
#define HIDEFACE (1<<7) // Whether we appear as unknown.
#define HIDEHAIR (1<<8)
#define HIDEFACIALHAIR (1<<9)
#define HIDENECK (1<<10)
/// for wigs, only obscures the headgear
#define HIDEHEADGEAR (1<<11)
///for lizard snouts, because some HIDEFACE clothes don't actually conceal that portion of the head.
#define HIDESNOUT (1<<12)
///hides mutant/moth wings, does not apply to functional wings
#define HIDEMUTWINGS (1<<13)

//SKYRAT EDIT ADDITION: CUSTOM EAR TOGGLE FOR ANTHRO/ETC EAR SHOWING -
/// Manually set this on items you want anthro ears to show on!
#define SHOWSPRITEEARS (1<<14)
/// Does this sprite hide the tail?
#define HIDETAIL (1<<15)
/// Does this sprite also hide the spine on tails? Realistically only useful for the clothes that have a special tail overlay, like MODsuits
#define HIDESPINE (1<<16)
/// Does this sprite hide devious devices?
#define HIDESEXTOY (1<<17)
//SKYRAT EDIT ADDITION END

//bitflags for clothing coverage - also used for limbs
#define HEAD (1<<0)
#define CHEST (1<<1)
#define GROIN (1<<2)
#define LEG_LEFT (1<<3)
#define LEG_RIGHT (1<<4)
#define LEGS (LEG_LEFT | LEG_RIGHT)
#define FOOT_LEFT (1<<5)
#define FOOT_RIGHT (1<<6)
#define FEET (FOOT_LEFT | FOOT_RIGHT)
#define ARM_LEFT (1<<7)
#define ARM_RIGHT (1<<8)
#define ARMS (ARM_LEFT | ARM_RIGHT)
#define HAND_LEFT (1<<9)
#define HAND_RIGHT (1<<10)
#define HANDS (HAND_LEFT | HAND_RIGHT)
#define NECK (1<<11)
#define FULL_BODY ALL

//defines for the index of hands
#define LEFT_HANDS 1
#define RIGHT_HANDS 2

//flags for female outfits: How much the game can safely "take off" the uniform without it looking weird
/// For when there's simply no need for a female version of this uniform.
#define NO_FEMALE_UNIFORM 0
/// For the game to take off everything, disregards other flags.
#define FEMALE_UNIFORM_FULL (1<<0)
/// For when you really need to avoid the game cutting off that one pixel between the legs, to avoid the comeback of the infamous "dixel".
#define FEMALE_UNIFORM_TOP_ONLY (1<<1)
/// For when you don't want the "breast" effect to be applied (the one that cuts two pixels in the middle of the front of the uniform when facing east or west).
#define FEMALE_UNIFORM_NO_BREASTS (1<<2)
// SKYRAT EDIT ADDITION START
/// For when you -don't- want to apply FEMALE_UNIFORM_TOP_ONLY to the digi version (which happens by default).
#define FEMALE_UNIFORM_DIGI_FULL (1<<3)
// SKYRAT EDIT ADDITION END

//flags for alternate styles: These are hard sprited so don't set this if you didn't put the effort in
#define NORMAL_STYLE 0
#define ALT_STYLE 1
#define DIGITIGRADE_STYLE 2

//Flags (actual flags, fucker ^) for /obj/item/var/supports_variations_flags
///No alternative sprites based on bodytype
#define CLOTHING_NO_VARIATION (1<<0)
///Has a sprite for digitigrade legs specifically.
#define CLOTHING_DIGITIGRADE_VARIATION (1<<1)
///The sprite works fine for digitigrade legs as-is.
#define CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON (1<<2)
///has a sprite for monkeys
#define CLOTHING_MONKEY_VARIATION (1<<3)
// SKYRAT EDIT ADDITION START
/// The sprite works fine for snouts.
#define CLOTHING_SNOUTED_VARIATION (1<<4)
/// The sprite works fine for snouts as-is.
#define CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON (1<<5)
/// The sprite works fine for vox snouts.
#define CLOTHING_SNOUTED_VOX_VARIATION (1<<6)
/// The sprite works fine for vox snouts as is.
#define CLOTHING_SNOUTED_VOX_VARIATION_NO_NEW_ICON (1<<7)
/// The sprite works fine for vox snouts.
#define CLOTHING_SNOUTED_BETTER_VOX_VARIATION (1<<8)
/// The sprite works fine for vox snouts as is.
#define CLOTHING_SNOUTED_BETTER_VOX_VARIATION_NO_NEW_ICON (1<<9)
// SKYRAT EDIT ADDITION END

//flags for covering body parts
#define GLASSESCOVERSEYES (1<<0)
#define MASKCOVERSEYES (1<<1) // get rid of some of the other stupidness in these flags
#define HEADCOVERSEYES (1<<2) // feel free to realloc these numbers for other purposes
#define MASKCOVERSMOUTH (1<<3) // on other items, these are just for mask/head
#define HEADCOVERSMOUTH (1<<4)
#define PEPPERPROOF (1<<5) //protects against pepperspray
#define EARS_COVERED (1<<6)

#define TINT_DARKENED 2 //Threshold of tint level to apply weld mask overlay
#define TINT_BLIND 3 //Threshold of tint level to obscure vision fully

// defines for AFK theft
/// How many messages you can remember while logged out before you stop remembering new ones
#define AFK_THEFT_MAX_MESSAGES 10
/// If someone logs back in and there are entries older than this, just tell them they can't remember who it was or when
#define AFK_THEFT_FORGET_DETAILS_TIME (5 MINUTES)
/// The index of the entry in 'afk_thefts' with the person's visible name at the time
#define AFK_THEFT_NAME 1
/// The index of the entry in 'afk_thefts' with the text
#define AFK_THEFT_MESSAGE 2
/// The index of the entry in 'afk_thefts' with the time it happened
#define AFK_THEFT_TIME 3

//Allowed equipment lists for security vests.

GLOBAL_LIST_INIT(detective_vest_allowed, list(
	/obj/item/detective_scanner,
	/obj/item/flashlight,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/lighter,
	/obj/item/melee/baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/taperecorder,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman,
	/obj/item/storage/belt/holster/detective,
	/obj/item/storage/belt/holster/nukie,
	/obj/item/storage/belt/holster/energy,
	/obj/item/gun/ballistic/shotgun/automatic/combat/compact,
	/obj/item/gun/microfusion, //SKYRAT EDIT ADDITION
))

GLOBAL_LIST_INIT(security_vest_allowed, list(
	/obj/item/flashlight,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/knife/combat,
	/obj/item/melee/baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman,
	/obj/item/storage/belt/holster/detective,
	/obj/item/storage/belt/holster/nukie,
	/obj/item/storage/belt/holster/energy,
	/obj/item/gun/ballistic/shotgun/automatic/combat/compact,
	/obj/item/pen/red/security,
	/obj/item/gun/microfusion, //SKYRAT EDIT ADDITION
))

GLOBAL_LIST_INIT(security_wintercoat_allowed, list(
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/melee/baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/storage/belt/holster/detective,
	/obj/item/storage/belt/holster/nukie,
	/obj/item/storage/belt/holster/energy,
	/obj/item/gun/ballistic/shotgun/automatic/combat/compact,
	/obj/item/gun/microfusion, //SKYRAT EDIT ADDITION
))

//Allowed list for all chaplain suits (except the honkmother robe)

GLOBAL_LIST_INIT(chaplain_suit_allowed, list(
	/obj/item/book/bible,
	/obj/item/nullrod,
	/obj/item/reagent_containers/cup/glass/bottle/holywater,
	/obj/item/storage/fancy/candle_box,
	/obj/item/flashlight/flare/candle,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman,
	/obj/item/gun/ballistic/bow/divine,
	/obj/item/gun/ballistic/revolver/chaplain,
))

//Allowed list for all mining suits

GLOBAL_LIST_INIT(mining_suit_allowed, list(
	/obj/item/t_scanner/adv_mining_scanner,
	/obj/item/melee/cleaving_saw,
	/obj/item/climbing_hook,
	/obj/item/flashlight,
	/obj/item/grapple_gun,
	/obj/item/tank/internals,
	/obj/item/gun/energy/recharge/kinetic_accelerator,
	/obj/item/kinetic_crusher,
	/obj/item/knife,
	/obj/item/mining_scanner,
	/obj/item/organ/internal/monster_core,
	/obj/item/storage/bag/ore,
	/obj/item/pickaxe,
	/obj/item/resonator,
	/obj/item/spear,
))

/// String for items placed into the left pocket.
#define LOCATION_LPOCKET "in your left pocket"
/// String for items placed into the right pocket
#define LOCATION_RPOCKET "in your right pocket"
/// String for items placed into the backpack.
#define LOCATION_BACKPACK "in your backpack"
/// String for items placed into the hands.
#define LOCATION_HANDS "in your hands"
/// String for items placed in the glove slot.
#define LOCATION_GLOVES "on your hands"
/// String for items placed in the eye/glasses slot.
#define LOCATION_EYES "covering your eyes"
/// String for items placed on the head/hat slot.
#define LOCATION_HEAD "on your head"
/// String for items placed in the neck slot.
#define LOCATION_NECK "around your neck"
