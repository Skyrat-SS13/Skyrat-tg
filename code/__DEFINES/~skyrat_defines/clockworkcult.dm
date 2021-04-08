GLOBAL_LIST_EMPTY(city_of_cogs_spawns) //Anyone entering the City of Cogs spawns here
GLOBAL_LIST_EMPTY(servant_spawns) //Servants of Ratvar spawn here

#define CHANNEL_JUSTICAR_ARK 1020
#define is_reebe(z) SSmapping.level_trait(z, ZTRAIT_REEBE)
#define NOJAUNT_1					(1<<0)
#define ZTRAIT_REEBE "Reebe"
#define ZTRAITS_REEBE list(ZTRAIT_REEBE = TRUE, ZTRAIT_BOMBCAP_MULTIPLIER = 0.5)
#define ROLE_SERVANT_OF_RATVAR	"Servant of Ratvar"
#define ANTAG_HUD_CLOCKWORK		22
#define TRAIT_STARGAZED			"stargazed"	//Affected by a stargazer
#define STARGAZER_TRAIT "stargazer"
#define CLOCKCULT_SERVANTS 4
#define COMSIG_ATOM_RATVAR_ACT "atom_ratvar_act"
#define LIGHT_COLOR_CLOCKWORK 	"#BE8700"
#define TELEPORT_MODE_CLOCKWORK 2
#define COMSIG_ATOM_EMINENCE_ACT "atom_eminence_act"
#define COMSIG_CLOCKWORK_SIGNAL_RECEIVED "clock_received"			//! When anything the trap is attatched to is triggered
#define VANGUARD_TRAIT "vanguard"
#define ismovableatom(A) ismovable(A)

//component id defines; sometimes these may not make sense in regards to their use in scripture but important ones are bright
#define BELLIGERENT_EYE "belligerent_eye" //! Use this for offensive and damaging scripture!
#define VANGUARD_COGWHEEL "vanguard_cogwheel" //! Use this for defensive and healing scripture!
#define GEIS_CAPACITOR "geis_capacitor" //! Use this for niche scripture!
#define REPLICANT_ALLOY "replicant_alloy"
#define HIEROPHANT_ANSIBLE "hierophant_ansible" //! Use this for construction-related scripture!

//Invokation speech types
#define INVOKATION_WHISPER 1
#define INVOKATION_SPOKEN 2
#define INVOKATION_SHOUT 3

#define DEFAULT_CLOCKSCRIPTS "6:-29,4:-2"

//scripture types
#define SPELLTYPE_ABSTRACT "Abstract"
#define SPELLTYPE_SERVITUDE "Servitude"
#define SPELLTYPE_PRESERVATION "Preservation"
#define SPELLTYPE_STRUCTURES "Structures"

//Trap type
#define TRAPMOUNT_WALL 1
#define TRAPMOUNT_FLOOR 2

//Conversion warnings
#define CONVERSION_WARNING_NONE 0
#define CONVERSION_WARNING_HALFWAY 1
#define CONVERSION_WARNING_THREEQUARTERS 2
#define CONVERSION_WARNING_CRITIAL 3

//Name types
#define CLOCKCULT_PREFIX_EMINENCE 2
#define CLOCKCULT_PREFIX_MASTER 1
#define CLOCKCULT_PREFIX_RECRUIT 0


// cwall construction states
#define COG_COVER 1
#define COG_EXPOSED 3
#define ACCESS_CLOCKCULT 251

/obj/effect/landmark/servant_of_ratvar
	name = "servant of ratvar spawn"
	icon_state = "clockwork_orange"
	layer = MOB_LAYER

/obj/effect/landmark/servant_of_ratvar/Initialize(mapload)
	..()
	GLOB.servant_spawns += loc
	return INITIALIZE_HINT_QDEL

//City of Cogs entrances
/obj/effect/landmark/city_of_cogs
	name = "city of cogs entrance"
	icon_state = "city_of_cogs"

/obj/effect/landmark/city_of_cogs/Initialize(mapload)
	..()
	GLOB.city_of_cogs_spawns += loc
	return INITIALIZE_HINT_QDEL