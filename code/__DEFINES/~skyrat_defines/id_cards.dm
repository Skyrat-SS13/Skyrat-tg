/// Buffed wildcard slot define for Chameleon/Agent ID grey cards. Can hold 4 common, 2 command and 1 captain access.
#define WILDCARD_LIMIT_CHAMELEON_PLUS list( \
	WILDCARD_NAME_COMMON = list(limit = 4, usage = list()), \
	WILDCARD_NAME_COMMAND = list(limit = 2, usage = list()), \
	WILDCARD_NAME_CAPTAIN = list(limit = 1, usage = list()) \
)
