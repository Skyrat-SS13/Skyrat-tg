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

GLOBAL_LIST_INIT(food_defaults, list(
	"Meat" =  FOOD_PREFERENCE_NEUTRAL,
	"Vegetables" = FOOD_PREFERENCE_NEUTRAL,
	"Raw food" = FOOD_PREFERENCE_DISLIKED,
	"Junk food" = FOOD_PREFERENCE_NEUTRAL,
	"Grain" = FOOD_PREFERENCE_NEUTRAL,
	"Fruits" = FOOD_PREFERENCE_NEUTRAL,
	"Dairy products" = FOOD_PREFERENCE_NEUTRAL,
	"Fried food" = FOOD_PREFERENCE_NEUTRAL,
	"Alcohol" = FOOD_PREFERENCE_DISLIKED,
	"Sugary food" = FOOD_PREFERENCE_NEUTRAL,
	"Gross food" = FOOD_PREFERENCE_DISLIKED,
	"Toxic food" = FOOD_PREFERENCE_TOXIC,
	"Pineapples" = FOOD_PREFERENCE_NEUTRAL,
	"Breakfast food" = FOOD_PREFERENCE_NEUTRAL,
	"Clothing" = FOOD_PREFERENCE_DISLIKED,
	"Nuts" = FOOD_PREFERENCE_NEUTRAL,
	"Seafood" = FOOD_PREFERENCE_NEUTRAL,
	"Oranges" = FOOD_PREFERENCE_NEUTRAL,
	"Bugs" = FOOD_PREFERENCE_DISLIKED,
	"Gore" = FOOD_PREFERENCE_TOXIC, // Toxic by default to allow default values to be usable from the start.
	"Bloody" = FOOD_PREFERENCE_TOXIC, // Toxic by default to allow default values to be usable from the start.
))

GLOBAL_LIST_INIT(obscure_food_types, list(
	"Pineapples",
	"Oranges",
	"Nuts"
))
