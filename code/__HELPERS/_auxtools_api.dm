#define AUXTOOLS_FULL_INIT 2
#define AUXTOOLS_PARTIAL_INIT 1

GLOBAL_LIST_EMPTY(auxtools_initialized)
GLOBAL_PROTECT(auxtools_initialized)

#define AUXTOOLS_CHECK(LIB)\
	if (!CONFIG_GET(flag/auxtools_enabled)) {\
		CRASH("Auxtools is not enabled in config!");\
	}\
	if (GLOB.auxtools_initialized[LIB] != AUXTOOLS_FULL_INIT) {\
		if (fexists(LIB)) {\
			var/string = call_ext(LIB,"auxtools_init")();\
			if(findtext(string, "SUCCESS")) {\
				GLOB.auxtools_initialized[LIB] = AUXTOOLS_FULL_INIT;\
			} else {\
				CRASH(string);\
			}\
		} else {\
			CRASH("No file named [LIB] found!")\
		}\
	}\

#define AUXTOOLS_SHUTDOWN(LIB)\
	if (GLOB.auxtools_initialized[LIB] == AUXTOOLS_FULL_INIT && fexists(LIB)){\
		call_ext(LIB,"auxtools_shutdown")();\
		GLOB.auxtools_initialized[LIB] = AUXTOOLS_PARTIAL_INIT;\
	}\

#define AUXTOOLS_FULL_SHUTDOWN(LIB)\
	if (GLOB.auxtools_initialized[LIB] && fexists(LIB)){\
		call_ext(LIB,"auxtools_full_shutdown")();\
		GLOB.auxtools_initialized[LIB] = FALSE;\
	}

/proc/auxtools_stack_trace(msg)
	CRASH(msg)

/proc/auxtools_expr_stub()
	CRASH("auxtools not loaded")

/proc/enable_debugging(mode, port)
	CRASH("auxtools not loaded")
