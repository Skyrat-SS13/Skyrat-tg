#define SET_ARGS(L) var/list/newargs = L; for(var/i in 1 to length(newargs)) { args[i] = newargs[i] };
