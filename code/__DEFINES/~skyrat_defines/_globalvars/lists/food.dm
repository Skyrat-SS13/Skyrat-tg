/// A mirror of the FOOD_FLAGS_IC define, except with bitflags as values and as a GLOB.
GLOBAL_LIST_INIT(food_ic_flag_to_bitflag, list(
	"Meat" = MEAT,
	"Vegetables" = VEGETABLES,
	"Raw food" = RAW,
	"Junk food" = JUNKFOOD,
	"Grain" = GRAIN,
	"Fruits" = FRUIT,
	"Dairy products" = DAIRY,
	"Fried food" = FRIED,
	"Alcohol" = ALCOHOL,
	"Sugary food" = SUGAR,
	"Gross food" = GROSS,
	"Toxic food" = TOXIC,
	"Pineapples" = PINEAPPLE, // I know why this is a food type, but this is pointless to the Nth degree...
	"Breakfast food" = BREAKFAST,
	"Clothing" = CLOTH,
	"Nuts" = NUTS,
	"Seafood" = SEAFOOD,
	"Oranges" = ORANGES, // Why is this even a foodtype?!
	"Bugs" = BUGS,
	"Gore" = GORE,
	"Bloody" = BLOODY,
))

/// Point values are based on commonality in my arbitrary view, with gameplay being a secondary thought. Balancing this around gameplay is dumb on a supposed RP server.
/// Higher values mean more rare, lower values mean more common.
/// Defaults have a value of 0, and cannot be liked. Likes should cost more than 1 point, unless it's really obscure. 0 point likes do not count towards the like limit.
/// Lower than default ADDS points, higher than default REMOVES points.
/// Assoc list of IC food flags to another assoc list of point values for each food like/dislike level, plus one extra entry for dictating the default value.
GLOBAL_LIST_INIT(food_ic_flag_to_point_values, list(
	"Meat" = list(
		"[FOOD_TOXIC]" = 2,
		"[FOOD_DISLIKED]" = 1,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -2,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Vegetables" = list(
		"[FOOD_TOXIC]" = 2,
		"[FOOD_DISLIKED]" = 1,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -2,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Raw food" = list(
		"[FOOD_TOXIC]" = 1,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = -2,
		"[FOOD_LIKED]" = -4,
		"[FOOD_DEFAULT]" = "[FOOD_DISLIKED]",
	),
	"Junk food" = list(
		"[FOOD_TOXIC]" = 1,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -3,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Grain" = list(
		"[FOOD_TOXIC]" = 2,
		"[FOOD_DISLIKED]" = 1,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -2,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Fruits" = list(
		"[FOOD_TOXIC]" = 2,
		"[FOOD_DISLIKED]" = 1,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -2,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Dairy products" = list( // These next three entries have 0 on both neutral and disliked to allow swapping between roughly as common dislikes without too much compromise.
		"[FOOD_TOXIC]" = 1,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -2,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Fried food" = list(
		"[FOOD_TOXIC]" = 1,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -3,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Alcohol" = list(
		"[FOOD_TOXIC]" = 1,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -2,
		"[FOOD_DEFAULT]" = "[FOOD_DISLIKED]",
	),
	"Sugary food" = list(
		"[FOOD_TOXIC]" = 2,
		"[FOOD_DISLIKED]" = 1,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -3,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Gross food" = list(
		"[FOOD_TOXIC]" = 0,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = -3,
		"[FOOD_LIKED]" = -5,
		"[FOOD_DEFAULT]" = "[FOOD_DISLIKED]",
	),
	"Toxic food" = list(
		"[FOOD_TOXIC]" = 0,
		"[FOOD_DISLIKED]" = 2,
		"[FOOD_NEUTRAL]" = -4,
		"[FOOD_LIKED]" = -6,
		"[FOOD_DEFAULT]" = "[FOOD_TOXIC]",
	),
	"Pineapples" = list( // I know why this is a food type, but this is pointless to the Nth degree...
		"[FOOD_TOXIC]" = 0,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = 0,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
		"[FOOD_OBSCURE]" = TRUE,
	),
	"Breakfast food" = list(
		"[FOOD_TOXIC]" = 2,
		"[FOOD_DISLIKED]" = 1,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -2,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Clothing" = list(
		"[FOOD_TOXIC]" = 1,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = -2,
		"[FOOD_LIKED]" = -4,
		"[FOOD_DEFAULT]" = "[FOOD_DISLIKED]",
	),
	"Nuts" = list( // Too obscure.
		"[FOOD_TOXIC]" = 0,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = 0,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
		"[FOOD_OBSCURE]" = TRUE,
	),
	"Seafood" = list(
		"[FOOD_TOXIC]" = 2,
		"[FOOD_DISLIKED]" = 1,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = -2,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
	),
	"Oranges" = list( // Why is this even a foodtype?!
		"[FOOD_TOXIC]" = 0,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = 0,
		"[FOOD_LIKED]" = 0,
		"[FOOD_DEFAULT]" = "[FOOD_NEUTRAL]",
		"[FOOD_OBSCURE]" = TRUE,
	),
	"Bugs" = list(
		"[FOOD_TOXIC]" = 1,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = -2,
		"[FOOD_LIKED]" = -4,
		"[FOOD_DEFAULT]" = "[FOOD_DISLIKED]",
	),
	"Gore" = list(
		"[FOOD_TOXIC]" = 0,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = -4,
		"[FOOD_LIKED]" = -6,
		"[FOOD_DEFAULT]" = "[FOOD_TOXIC]", // Toxic by default to allow default values to be usable from the start.
	),
	"Bloody" = list(
		"[FOOD_TOXIC]" = 0,
		"[FOOD_DISLIKED]" = 0,
		"[FOOD_NEUTRAL]" = -3,
		"[FOOD_LIKED]" = -5,
		"[FOOD_DEFAULT]" = "[FOOD_TOXIC]", // Toxic by default to allow default values to be usable from the start.
	),
))
