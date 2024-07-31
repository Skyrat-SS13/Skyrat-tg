// This file contains any stuff related to admin-visible traits.
// There's likely more than a few traits missing from this file, do consult the `_traits.dm` file in this folder to see every global trait that exists.
// quirks have their own panel so we don't need them here.

GLOBAL_LIST_INIT(admin_visible_traits, list(
	/atom = list(
		"TRAIT_UNHITTABLE_BY_PROJECTILES" = TRAIT_UNHITTABLE_BY_PROJECTILES,
		"TRAIT_KEEP_TOGETHER" = TRAIT_KEEP_TOGETHER,
	),
	/atom/movable = list(
		"TRAIT_ASHSTORM_IMMUNE" = TRAIT_ASHSTORM_IMMUNE,
		"TRAIT_HAS_LABEL" = TRAIT_HAS_LABEL,
		"TRAIT_LAVA_IMMUNE" = TRAIT_LAVA_IMMUNE,
		"TRAIT_MOVE_FLOATING" = TRAIT_MOVE_FLOATING,
		"TRAIT_MOVE_FLYING" = TRAIT_MOVE_FLYING,
		"TRAIT_MOVE_GROUND" = TRAIT_MOVE_GROUND,
		"TRAIT_MOVE_PHASING" = TRAIT_MOVE_PHASING,
		"TRAIT_MOVE_VENTCRAWLING" = TRAIT_MOVE_VENTCRAWLING,
		"TRAIT_MOVE_UPSIDE_DOWN" = TRAIT_MOVE_UPSIDE_DOWN,
		"TRAIT_RUNECHAT_HIDDEN" = TRAIT_RUNECHAT_HIDDEN,
		"TRAIT_SCARY_FISHERMAN" = TRAIT_SCARY_FISHERMAN,
		"TRAIT_SNOWSTORM_IMMUNE" = TRAIT_SNOWSTORM_IMMUNE,
		"TRAIT_VOIDSTORM_IMMUNE" = TRAIT_VOIDSTORM_IMMUNE,
		"TRAIT_WEATHER_IMMUNE" = TRAIT_WEATHER_IMMUNE,
	),
	/mob = list(
		"TRAIT_ABDUCTOR_SCIENTIST_TRAINING" = TRAIT_ABDUCTOR_SCIENTIST_TRAINING,
		"TRAIT_ABDUCTOR_TRAINING" = TRAIT_ABDUCTOR_TRAINING,
		"TRAIT_ADVANCEDTOOLUSER" = TRAIT_ADVANCEDTOOLUSER,
		"TRAIT_AGENDER" = TRAIT_AGENDER,
		"TRAIT_AGEUSIA" = TRAIT_AGEUSIA,
		"TRAIT_ALCOHOL_TOLERANCE" = TRAIT_ALCOHOL_TOLERANCE,
		"TRAIT_ANOSMIA" = TRAIT_ANOSMIA,
		"TRAIT_ANTIMAGIC" = TRAIT_ANTIMAGIC,
		"TRAIT_ANXIOUS" = TRAIT_ANXIOUS,
		"TRAIT_BADDNA" = TRAIT_BADDNA,
		"TRAIT_BADTOUCH" = TRAIT_BADTOUCH,
		"TRAIT_BALD" = TRAIT_BALD,
		"TRAIT_BATON_RESISTANCE" = TRAIT_BATON_RESISTANCE,
		"TRAIT_BEAST_EMPATHY" = TRAIT_BEAST_EMPATHY,
		"TRAIT_BLOCK_SHUTTLE_MOVEMENT" = TRAIT_BLOCK_SHUTTLE_MOVEMENT,
		"TRAIT_BLOOD_CLANS" = TRAIT_BLOOD_CLANS,
		"TRAIT_BLOODSHOT_EYES" = TRAIT_BLOODSHOT_EYES,
		"TRAIT_BOMBIMMUNE" = TRAIT_BOMBIMMUNE,
		"TRAIT_BONSAI" = TRAIT_BONSAI,
		"TRAIT_BOOZE_SLIDER" = TRAIT_BOOZE_SLIDER,
		"TRAIT_BYPASS_MEASURES" = TRAIT_BYPASS_MEASURES,
		"TRAIT_CAN_HOLD_ITEMS" = TRAIT_CAN_HOLD_ITEMS,
		"TRAIT_CANNOT_BE_UNBUCKLED" = TRAIT_CANNOT_BE_UNBUCKLED,
		"TRAIT_CANNOT_OPEN_PRESENTS" = TRAIT_CANNOT_OPEN_PRESENTS,
		"TRAIT_CHASM_DESTROYED" = TRAIT_CHASM_DESTROYED,
		"TRAIT_CHUNKYFINGERS_IGNORE_BATON" = TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		"TRAIT_CHUNKYFINGERS" = TRAIT_CHUNKYFINGERS,
		"TRAIT_CLOWN_ENJOYER" = TRAIT_CLOWN_ENJOYER,
		"TRAIT_CLUMSY" = TRAIT_CLUMSY,
		"TRAIT_COMMISSIONED" = TRAIT_COMMISSIONED,
		"TRAIT_CRITICAL_CONDITION" = TRAIT_CRITICAL_CONDITION,
		"TRAIT_CULT_HALO" = TRAIT_CULT_HALO,
		"TRAIT_DEAF" = TRAIT_DEAF,
		"TRAIT_DEATHCOMA" = TRAIT_DEATHCOMA,
		"TRAIT_DEFIB_BLACKLISTED" = TRAIT_DEFIB_BLACKLISTED,
		"TRAIT_DEPRESSION" = TRAIT_DEPRESSION,
		"TRAIT_DIAGNOSTIC_HUD" = TRAIT_DIAGNOSTIC_HUD,
		"TRAIT_BOT_PATH_HUD" = TRAIT_BOT_PATH_HUD,
		"TRAIT_DISCOORDINATED_TOOL_USER" = TRAIT_DISCOORDINATED_TOOL_USER,
		"TRAIT_DISFIGURED" = TRAIT_DISFIGURED,
		"TRAIT_DISK_VERIFIER" = TRAIT_DISK_VERIFIER,
		"TRAIT_DISSECTED" = TRAIT_DISSECTED,
		"TRAIT_DRINKS_BLOOD" = TRAIT_DRINKS_BLOOD,
		"TRAIT_DUMB" = TRAIT_DUMB,
		"TRAIT_DWARF" = TRAIT_DWARF,
		"TRAIT_EASILY_WOUNDED" = TRAIT_EASILY_WOUNDED,
		"TRAIT_EASYDISMEMBER" = TRAIT_EASYDISMEMBER,
		"TRAIT_EMOTEMUTE " = TRAIT_EMOTEMUTE,
		"TRAIT_EMPATH" = TRAIT_EMPATH,
		"TRAIT_EXAMINE_FITNESS" = TRAIT_EXAMINE_FITNESS,
		"TRAIT_EXPANDED_FOV" = TRAIT_EXPANDED_FOV,
		"TRAIT_EXPERT_FISHER" = TRAIT_EXPERT_FISHER,
		"TRAIT_FAKEDEATH" = TRAIT_FAKEDEATH,
		"TRAIT_FAST_CUFFING" = TRAIT_FAST_CUFFING,
		"TRAIT_FAT" = TRAIT_FAT,
		"TRAIT_FEARLESS" = TRAIT_FEARLESS,
		"TRAIT_FENCE_CLIMBER" = TRAIT_FENCE_CLIMBER,
		"TRAIT_FIST_MINING" = TRAIT_FIST_MINING,
		"TRAIT_FIXED_HAIRCOLOR" = TRAIT_FIXED_HAIRCOLOR,
		"TRAIT_FIXED_MUTANT_COLORS" = TRAIT_FIXED_MUTANT_COLORS,
		"TRAIT_FLOORED" = TRAIT_FLOORED,
		"TRAIT_FORCED_STANDING" = TRAIT_FORCED_STANDING,
		"TRAIT_FREERUNNING" = TRAIT_FREERUNNING,
		"TRAIT_FRIENDLY" = TRAIT_FRIENDLY,
		"TRAIT_GAMER" = TRAIT_GAMER,
		"TRAIT_GAMERGOD" = TRAIT_GAMERGOD,
		"TRAIT_GENELESS" = TRAIT_GENELESS,
		"TRAIT_GIANT" = TRAIT_GIANT,
		"TRAIT_GOOD_HEARING" = TRAIT_GOOD_HEARING,
		"TRAIT_GRABWEAKNESS" = TRAIT_GRABWEAKNESS,
		"TRAIT_GREENTEXT_CURSED" = TRAIT_GREENTEXT_CURSED,
		"TRAIT_GUNFLIP" = TRAIT_GUNFLIP,
		"TRAIT_HANDS_BLOCKED" = TRAIT_HANDS_BLOCKED,
		"TRAIT_HARDLY_WOUNDED" = TRAIT_HARDLY_WOUNDED,
		"TRAIT_HEAVY_SLEEPER" = TRAIT_HEAVY_SLEEPER,
		"TRAIT_HIDE_EXTERNAL_ORGANS" = TRAIT_HIDE_EXTERNAL_ORGANS,
		"TRAIT_HOLY" = TRAIT_HOLY,
		"TRAIT_HUSK" = TRAIT_HUSK,
		"TRAIT_IGNORE_ELEVATION" = TRAIT_IGNORE_ELEVATION,
		"TRAIT_IGNORESLOWDOWN" = TRAIT_IGNORESLOWDOWN,
		"TRAIT_ILLITERATE" = TRAIT_ILLITERATE,
		"TRAIT_IMMOBILIZED" = TRAIT_IMMOBILIZED,
		"TRAIT_INCAPACITATED" = TRAIT_INCAPACITATED,
		"TRAIT_INVISIBLE_MAN" = TRAIT_INVISIBLE_MAN,
		"TRAIT_IWASBATONED" = TRAIT_IWASBATONED,
		"TRAIT_JOLLY" = TRAIT_JOLLY,
		"TRAIT_KISS_OF_DEATH" = TRAIT_KISS_OF_DEATH,
		"TRAIT_KNOCKEDOUT" = TRAIT_KNOCKEDOUT,
		"TRAIT_KNOW_ENGI_WIRES" = TRAIT_KNOW_ENGI_WIRES,
		"TRAIT_KNOW_ROBO_WIRES" = TRAIT_KNOW_ROBO_WIRES,
		"TRAIT_LIGHT_DRINKER" = TRAIT_LIGHT_DRINKER,
		"TRAIT_LIGHT_STEP" = TRAIT_LIGHT_STEP,
		"TRAIT_LIGHTBULB_REMOVER" = TRAIT_LIGHTBULB_REMOVER,
		"TRAIT_LIMBATTACHMENT" = TRAIT_LIMBATTACHMENT,
		"TRAIT_LITERATE" = TRAIT_LITERATE,
		"TRAIT_LIVERLESS_METABOLISM" = TRAIT_LIVERLESS_METABOLISM,
		"TRAIT_MAGICALLY_GIFTED" = TRAIT_MAGICALLY_GIFTED,
		"TRAIT_MEDICAL_HUD" = TRAIT_MEDICAL_HUD,
		"TRAIT_MIME_FAN" = TRAIT_MIME_FAN,
		"TRAIT_MIMING" = TRAIT_MIMING,
		"TRAIT_MINDSHIELD" = TRAIT_MINDSHIELD,
		"TRAIT_MOB_HIDE_HAPPINESS" = TRAIT_MOB_HIDE_HAPPINESS,
		"TRAIT_MORBID" = TRAIT_MORBID,
		"TRAIT_MUSICIAN" = TRAIT_MUSICIAN,
		"TRAIT_MUTANT_COLORS" = TRAIT_MUTANT_COLORS,
		"TRAIT_MUTE" = TRAIT_MUTE,
		"TRAIT_NAIVE" = TRAIT_NAIVE,
		"TRAIT_NEVER_WOUNDED" = TRAIT_NEVER_WOUNDED,
		"TRAIT_NICE_SHOT" = TRAIT_NICE_SHOT,
		"TRAIT_NIGHT_VISION" = TRAIT_NIGHT_VISION,
		"TRAIT_NO_AUGMENTS" = TRAIT_NO_AUGMENTS,
		"TRAIT_NO_BLOOD_OVERLAY" = TRAIT_NO_BLOOD_OVERLAY,
		"TRAIT_NO_DNA_COPY" = TRAIT_NO_DNA_COPY,
		"TRAIT_NO_EXTINGUISH" = TRAIT_NO_EXTINGUISH,
		"TRAIT_NO_GLIDE" = TRAIT_NO_GLIDE,
		"TRAIT_NO_PLASMA_TRANSFORM" = TRAIT_NO_PLASMA_TRANSFORM,
		"TRAIT_NO_SLIP_ALL" = TRAIT_NO_SLIP_ALL,
		"TRAIT_NO_SLIP_ICE" = TRAIT_NO_SLIP_ICE,
		"TRAIT_NO_SLIP_SLIDE" = TRAIT_NO_SLIP_SLIDE,
		"TRAIT_NO_SLIP_WATER" = TRAIT_NO_SLIP_WATER,
		"TRAIT_NO_SOUL" = TRAIT_NO_SOUL,
		"TRAIT_NO_TRANSFORM" = TRAIT_NO_TRANSFORM,
		"TRAIT_NO_UNDERWEAR" = TRAIT_NO_UNDERWEAR,
		"TRAIT_NO_ZOMBIFY" = TRAIT_NO_ZOMBIFY,
		"TRAIT_NOBLOOD" = TRAIT_NOBLOOD,
		"TRAIT_NOBREATH" = TRAIT_NOBREATH,
		"TRAIT_NOCRITDAMAGE" = TRAIT_NOCRITDAMAGE,
		"TRAIT_NOCRITOVERLAY" = TRAIT_NOCRITOVERLAY,
		"TRAIT_NODEATH" = TRAIT_NODEATH,
		"TRAIT_NODISMEMBER" = TRAIT_NODISMEMBER,
		"TRAIT_NOFIRE" = TRAIT_NOFIRE,
		"TRAIT_NOFLASH" = TRAIT_NOFLASH,
		"TRAIT_NOGUNS" = TRAIT_NOGUNS,
		"TRAIT_TOSS_GUN_HARD" = TRAIT_TOSS_GUN_HARD,
		"TRAIT_NOHARDCRIT" = TRAIT_NOHARDCRIT,
		"TRAIT_NOHUNGER" = TRAIT_NOHUNGER,
		"TRAIT_NOLIMBDISABLE" = TRAIT_NOLIMBDISABLE,
		"TRAIT_NOMOBSWAP" = TRAIT_NOMOBSWAP,
		"TRAIT_NOSOFTCRIT" = TRAIT_NOSOFTCRIT,
		"TRAIT_OIL_FRIED" = TRAIT_OIL_FRIED,
		"TRAIT_OVERWATCH_IMMUNE" = TRAIT_OVERWATCH_IMMUNE,
		"TRAIT_PACIFISM" = TRAIT_PACIFISM,
		"TRAIT_HIPPOCRATIC_OATH" = TRAIT_HIPPOCRATIC_OATH,
		"TRAIT_PAPER_MASTER" = TRAIT_PAPER_MASTER,
		"TRAIT_PARALYSIS_L_ARM" = TRAIT_PARALYSIS_L_ARM,
		"TRAIT_PARALYSIS_L_LEG" = TRAIT_PARALYSIS_L_LEG,
		"TRAIT_PARALYSIS_R_ARM" = TRAIT_PARALYSIS_R_ARM,
		"TRAIT_PARALYSIS_R_LEG" = TRAIT_PARALYSIS_R_LEG,
		"TRAIT_PASSTABLE" = TRAIT_PASSTABLE,
		"TRAIT_PASSWINDOW" = TRAIT_PASSWINDOW,
		"TRAIT_PERFECT_ATTACKER" = TRAIT_PERFECT_ATTACKER,
		"TRAIT_PHOTOGRAPHER" = TRAIT_PHOTOGRAPHER,
		"TRAIT_PIERCEIMMUNE" = TRAIT_PIERCEIMMUNE,
		"TRAIT_PLANT_SAFE" = TRAIT_PLANT_SAFE,
		"TRAIT_PLASMA_LOVER_METABOLISM" = TRAIT_PLASMA_LOVER_METABOLISM,
		"TRAIT_PRESENT_VISION" = TRAIT_PRESENT_VISION,
		"TRAIT_PREVENT_IMPLANT_AUTO_EXPLOSION" = TRAIT_PREVENT_IMPLANT_AUTO_EXPLOSION,
		"TRAIT_PRIMITIVE" = TRAIT_PRIMITIVE, //unable to use mechs. Given to Ash Walkers
		"TRAIT_PROSOPAGNOSIA" = TRAIT_PROSOPAGNOSIA,
		"TRAIT_PULL_BLOCKED" = TRAIT_PULL_BLOCKED,
		"TRAIT_PUSHIMMUNE" = TRAIT_PUSHIMMUNE,
		"TRAIT_QUICK_CARRY" = TRAIT_QUICK_CARRY,
		"TRAIT_QUICKER_CARRY" = TRAIT_QUICKER_CARRY,
		"TRAIT_RADIMMUNE" = TRAIT_RADIMMUNE,
		"TRAIT_RESISTCOLD" = TRAIT_RESISTCOLD,
		"TRAIT_RESISTHEAT" = TRAIT_RESISTHEAT,
		"TRAIT_RESISTHEATHANDS" = TRAIT_RESISTHEATHANDS,
		"TRAIT_RESISTHIGHPRESSURE" = TRAIT_RESISTHIGHPRESSURE,
		"TRAIT_RESISTLOWPRESSURE" = TRAIT_RESISTLOWPRESSURE,
		"TRAIT_RESTRAINED" = TRAIT_RESTRAINED,
		"TRAIT_ROUGHRIDER" = TRAIT_ROUGHRIDER,
		"TRAIT_SECURITY_HUD" = TRAIT_SECURITY_HUD,
		"TRAIT_SELF_AWARE" = TRAIT_SELF_AWARE,
		"TRAIT_SETTLER" = TRAIT_SETTLER,
		"TRAIT_SHIFTY_EYES" = TRAIT_SHIFTY_EYES,
		"TRAIT_SHOCKIMMUNE" = TRAIT_SHOCKIMMUNE,
		"TRAIT_SIGN_LANG" = TRAIT_SIGN_LANG,
		"TRAIT_SILENT_FOOTSTEPS" = TRAIT_SILENT_FOOTSTEPS,
		"TRAIT_SILICON_EMOTES_ALLOWED" = TRAIT_SILICON_EMOTES_ALLOWED,
		"TRAIT_SIXTHSENSE" = TRAIT_SIXTHSENSE,
		"TRAIT_SKITTISH" = TRAIT_SKITTISH,
		"TRAIT_SLEEPIMMUNE" = TRAIT_SLEEPIMMUNE,
		"TRAIT_SLOW_FLIP" = TRAIT_SLOW_FLIP,
		"TRAIT_SMOKER" = TRAIT_SMOKER,
		"TRAIT_SNOB" = TRAIT_SNOB,
		"TRAIT_SOOTHED_THROAT" = TRAIT_SOOTHED_THROAT,
		"TRAIT_SPACEWALK" = TRAIT_SPACEWALK,
		"TRAIT_SPECIAL_TRAUMA_BOOST" = TRAIT_SPECIAL_TRAUMA_BOOST,
		"TRAIT_SPIRITUAL" = TRAIT_SPIRITUAL,
		"TRAIT_STABLEHEART" = TRAIT_STABLEHEART,
		"TRAIT_STABLELIVER" = TRAIT_STABLELIVER,
		"TRAIT_STRONG_GRABBER" = TRAIT_STRONG_GRABBER,
		"TRAIT_STRONG_STOMACH" = TRAIT_STRONG_STOMACH,
		"TRAIT_STUBBY_BODY" = TRAIT_STUBBY_BODY,
		"TRAIT_STUNIMMUNE" = TRAIT_STUNIMMUNE,
		"TRAIT_STURDY_FRAME" = TRAIT_STURDY_FRAME,
		"TRAIT_SURGEON" = TRAIT_SURGEON,
		"TRAIT_SURGICALLY_ANALYZED" = TRAIT_SURGICALLY_ANALYZED,
		"TRAIT_TAGGER" = TRAIT_TAGGER,
		"TRAIT_TENTACLE_IMMUNE" = TRAIT_TENTACLE_IMMUNE,
		"TRAIT_TESLA_SHOCKIMMUNE" = TRAIT_TESLA_SHOCKIMMUNE,
		"TRAIT_THERMAL_VISION" = TRAIT_THERMAL_VISION,
		"TRAIT_TOXIMMUNE" = TRAIT_TOXIMMUNE,
		"TRAIT_TOXINLOVER" = TRAIT_TOXINLOVER,
		"TRAIT_TRAIT_MEDIBOTCOMINGTHROUGH" = TRAIT_MEDIBOTCOMINGTHROUGH,
		"TRAIT_TUMOR_SUPPRESSION" = TRAIT_TUMOR_SUPPRESSED,
		"TRAIT_UI_BLOCKED" = TRAIT_UI_BLOCKED,
		"TRAIT_UNDENSE" = TRAIT_UNDENSE,
		"TRAIT_UNDERWATER_BASKETWEAVING_KNOWLEDGE" = TRAIT_UNDERWATER_BASKETWEAVING_KNOWLEDGE,
		"TRAIT_UNHUSKABLE" = TRAIT_UNHUSKABLE,
		"TRAIT_UNINTELLIGIBLE_SPEECH" = TRAIT_UNINTELLIGIBLE_SPEECH,
		"TRAIT_UNKNOWN" = TRAIT_UNKNOWN,
		"TRAIT_UNNATURAL_RED_GLOWY_EYES" = TRAIT_UNNATURAL_RED_GLOWY_EYES,
		"TRAIT_UNOBSERVANT" = TRAIT_UNOBSERVANT,
		"TRAIT_UNSTABLE" = TRAIT_UNSTABLE,
		"TRAIT_USED_DNA_VAULT" = TRAIT_USED_DNA_VAULT,
		"TRAIT_USES_SKINTONES" = TRAIT_USES_SKINTONES,
		"TRAIT_VIRUSIMMUNE" = TRAIT_VIRUSIMMUNE,
		"TRAIT_VORACIOUS" = TRAIT_VORACIOUS,
		"TRAIT_WOUND_LICKER" = TRAIT_WOUND_LICKER,
		"TRAIT_WEAK_SOUL" = TRAIT_WEAK_SOUL,
		"TRAIT_WEB_SURFER" = TRAIT_WEB_SURFER,
		"TRAIT_WEB_WEAVER" = TRAIT_WEB_WEAVER,
		"TRAIT_WINE_TASTER" = TRAIT_WINE_TASTER,
		"TRAIT_XENO_HOST" = TRAIT_XENO_HOST,
		"TRAIT_XENO_IMMUNE" = TRAIT_XENO_IMMUNE,
		"TRAIT_XRAY_HEARING" = TRAIT_XRAY_HEARING,
		"TRAIT_XRAY_VISION" = TRAIT_XRAY_VISION,
		"TRAIT_MINING_PARRYING" = TRAIT_MINING_PARRYING,
	),
	/obj/item = list(
		"TRAIT_APC_SHOCKING" = TRAIT_APC_SHOCKING,
		"TRAIT_DANGEROUS_OBJECT" = TRAIT_DANGEROUS_OBJECT,
		"TRAIT_GERM_SENSITIVE" = TRAIT_GERM_SENSITIVE,
		"TRAIT_HAUNTED" = TRAIT_HAUNTED,
		"TRAIT_NO_STORAGE_INSERT" = TRAIT_NO_STORAGE_INSERT,
		"TRAIT_NO_TELEPORT" = TRAIT_NO_TELEPORT,
		"TRAIT_NODROP" = TRAIT_NODROP,
		"TRAIT_T_RAY_VISIBLE" = TRAIT_T_RAY_VISIBLE,
		"TRAIT_UNCATCHABLE" = TRAIT_UNCATCHABLE,
		),
	/obj/item/bodypart = list(
		"TRAIT_PARALYSIS" = TRAIT_PARALYSIS,
	),
	/obj/item/card/id = list(
		"TRAIT_MAGNETIC_ID_CARD" = TRAIT_MAGNETIC_ID_CARD,
	),
	/obj/item/fish = list(
		"TRAIT_FISH_CROSSBREEDER" = TRAIT_FISH_CROSSBREEDER,
		"TRAIT_FISH_FED_LUBE" = TRAIT_FISH_FED_LUBE,
		"TRAIT_FISH_NO_HUNGER" = TRAIT_FISH_NO_HUNGER,
		"TRAIT_FISH_NO_MATING" = TRAIT_FISH_NO_MATING,
		"TRAIT_FISH_SELF_REPRODUCE" = TRAIT_FISH_SELF_REPRODUCE,
		"TRAIT_FISH_TOXIN_IMMUNE" = TRAIT_FISH_TOXIN_IMMUNE,
		"TRAIT_RESIST_EMULSIFY" =  TRAIT_RESIST_EMULSIFY,
		"TRAIT_YUCKY_FISH" = TRAIT_YUCKY_FISH,
	),
	/obj/item/organ/internal/liver = list(
		"TRAIT_BALLMER_SCIENTIST" = TRAIT_BALLMER_SCIENTIST,
		"TRAIT_COMEDY_METABOLISM" = TRAIT_COMEDY_METABOLISM,
		"TRAIT_CORONER_METABOLISM" = TRAIT_CORONER_METABOLISM,
		"TRAIT_CULINARY_METABOLISM" = TRAIT_CULINARY_METABOLISM,
		"TRAIT_ENGINEER_METABOLISM" = TRAIT_ENGINEER_METABOLISM,
		"TRAIT_LAW_ENFORCEMENT_METABOLISM" = TRAIT_LAW_ENFORCEMENT_METABOLISM,
		"TRAIT_MAINTENANCE_METABOLISM" = TRAIT_MAINTENANCE_METABOLISM,
		"TRAIT_MEDICAL_METABOLISM" = TRAIT_MEDICAL_METABOLISM,
		"TRAIT_PRETENDER_ROYAL_METABOLISM" = TRAIT_PRETENDER_ROYAL_METABOLISM,
		"TRAIT_ROYAL_METABOLISM" = TRAIT_ROYAL_METABOLISM,
	),
	/obj/item/organ/internal/lungs = list(
		"TRAIT_SPACEBREATHING" = TRAIT_SPACEBREATHING,
	),
	// SKYRAT EDIT ADDITION START - SKYRAT TRAITS
	/obj/item/toy/plush/skyrat = list(
		"TRAIT_AFFECTION_AVERSION" = TRAIT_AFFECTION_AVERSION,
		"TRAIT_APHRO" = TRAIT_APHRO,
		"TRAIT_AVIAN" = TRAIT_AVIAN,
		"TRAIT_ASH_ASPECT" = TRAIT_ASH_ASPECT,
		"TRAIT_BIMBO" = TRAIT_BIMBO,
		"TRAIT_CANINE" = TRAIT_CANINE,
		"TRAIT_CHAMELEON_SKIN" = TRAIT_CHAMELEON_SKIN,
		"TRAIT_CONDOM_BROKEN" = TRAIT_CONDOM_BROKEN,
		"TRAIT_CURRENTLY_GLASSBLOWING" = TRAIT_CURRENTLY_GLASSBLOWING,
		"TRAIT_DETECTIVE" = TRAIT_DETECTIVE,
		"TRAIT_DNR" = TRAIT_DNR,
		"TRAIT_EXCITABLE" = TRAIT_EXCITABLE,
		"TRAIT_FELINE" = TRAIT_FELINE,
		"TRAIT_FLORAL_ASPECT" = TRAIT_FLORAL_ASPECT,
		"TRAIT_FREE_GHOST" = TRAIT_FREE_GHOST,
		"TRAIT_GHOSTROLE" = TRAIT_GHOSTROLE,
		"TRAIT_GIFTED" = TRAIT_GIFTED,
		"TRAIT_GLASSBLOWING" = TRAIT_GLASSBLOWING,
		"TRAIT_GLOVES" = TRAIT_GLOVES,
		"TRAIT_GLUED_ITEM" = TRAIT_GLUED_ITEM,
		"TRAIT_HARD_SOLES" = TRAIT_HARD_SOLES,
		"TRAIT_HYDRA_HEADS" = TRAIT_HYDRA_HEADS,
		"TRAIT_INSTANT_RELOAD" = TRAIT_INSTANT_RELOAD,
		"TRAIT_LINGUIST" = TRAIT_LINGUIST,
		"TRAIT_LEWDCHEM" = TRAIT_LEWDCHEM,
		"TRAIT_LEWDQUIRK" = TRAIT_LEWDQUIRK,
		"TRAIT_MASOCHISM" = TRAIT_MASOCHISM,
		"TRAIT_MOOD_NOEXAMINE" = TRAIT_MOOD_NOEXAMINE,
		"TRAIT_MUTANT_IMMUNE" = TRAIT_MUTANT_IMMUNE,
		"TRAIT_NARCOTICS" = TRAIT_NARCOTICS,
		"TRAIT_NEVERBONER" = TRAIT_NEVERBONER,
		"TRAIT_NIFSOFT" = TRAIT_NIFSOFT,
		"TRAIT_NIFSOFT_HUD_GRANTER" = TRAIT_NIFSOFT_HUD_GRANTER,
		"TRAIT_NO_HUSK" = TRAIT_NO_HUSK,
		"TRAIT_NORUNNING" = TRAIT_NORUNNING,
		"TRAIT_OVERSIZED" = TRAIT_OVERSIZED,
		"TRAIT_OXYIMMUNE" = TRAIT_OXYIMMUNE,
		"TRAIT_PERMIT_HUD" = TRAIT_PERMIT_HUD,
		"TRAIT_PERSONALSPACE" = TRAIT_PERSONALSPACE,
		"TRAIT_QUICKREFLEXES" = TRAIT_QUICKREFLEXES,
		"TRAIT_PET_OWNER" = TRAIT_PET_OWNER,
		"TRAIT_R_UNIQUEWRECK" = TRAIT_R_UNIQUEWRECK,
		"TRAIT_R_UNIQUETIP" = TRAIT_R_UNIQUETIP,
		"TRAIT_R_WIDE" = TRAIT_R_WIDE,
		"TRAIT_R_TALL" = TRAIT_R_TALL,
		"TRAIT_R_SMALL" = TRAIT_R_SMALL,
		"TRAIT_R_UNIQUEPANEL" = TRAIT_R_UNIQUEPANEL,
		"TRAIT_REAGENT" = TRAIT_REAGENT,
		"TRAIT_REVIVES_BY_HEALING" = TRAIT_REVIVES_BY_HEALING,
		"TRAIT_RIGGER" = TRAIT_RIGGER,
		"TRAIT_ROBOTIC_DNA_ORGANS" = TRAIT_ROBOTIC_DNA_ORGANS,
		"TRAIT_ROPEBUNNY" = TRAIT_ROPEBUNNY,
		"TRAIT_RSD_COMPATIBLE" = TRAIT_RSD_COMPATIBLE,
		"TRAIT_SACRIFICED" = TRAIT_SACRIFICED ,
		"TRAIT_SADISM" = TRAIT_SADISM,
		"TRAIT_SENSITIVESNOUT" = TRAIT_SENSITIVESNOUT,
		"TRAIT_SLICK_SKIN" = TRAIT_SLICK_SKIN,
		"TRAIT_SLIPPERY" = TRAIT_SLIPPERY,
		"TRAIT_SPARKLE_ASPECT" = TRAIT_SPARKLE_ASPECT,
		"TRAIT_STICKY_FINGERS" = TRAIT_STICKY_FINGERS,
		"TRAIT_STRAPON" = TRAIT_STRAPON,
		"TRAIT_STYLISH" = TRAIT_STYLISH,
		"TRAIT_SYNTHETIC" = TRAIT_SYNTHETIC,
		"TRAIT_SYSTEM_SHOCK" = TRAIT_SYSTEM_SHOCK,
		"TRAIT_TRASHMAN" = TRAIT_TRASHMAN,
		"TRAIT_WATER_ASPECT" = TRAIT_WATER_ASPECT,
		"TRAIT_WATER_BREATHING" = TRAIT_WATER_BREATHING,
		"TRAIT_WEBBING_ASPECT" = TRAIT_WEBBING_ASPECT,
		"TRAIT_XENO_ABILITY_GIVEN" = TRAIT_XENO_ABILITY_GIVEN,
		"TRAIT_XENOARCH_QUALIFIED" = TRAIT_XENOARCH_QUALIFIED,
		"TRAIT_XENO_HEAL_AURA" = TRAIT_XENO_HEAL_AURA,
		"TRAIT_XENO_INNATE" = TRAIT_XENO_INNATE,
		"TRAIT_CLOTHES_DAMAGED_BY_PIERCING" = TRAIT_CLOTHES_DAMAGED_BY_PIERCING,
	),
	// SKYRAT EDIT ADDITION END
))

/// value -> trait name, generated as needed for adminning.
GLOBAL_LIST(admin_trait_name_map)

/proc/generate_admin_trait_name_map()
	. = list()
	for(var/key in GLOB.admin_visible_traits)
		for(var/tname in GLOB.admin_visible_traits[key])
			var/val = GLOB.admin_visible_traits[key][tname]
			.[val] = tname

	return .
