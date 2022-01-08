#define PUBLIC_GAME_MODE (SSticker ? (SSticker.hide_mode == 0 ? GLOB.master_mode : "Secret") : "Unknown")

#define Clamp(value, low, high) 	(value <= low ? low : (value >= high ? high : value))
#define CLAMP01(x) 		(Clamp(x, 0, 1))

#define get_turf(A) get_step(A,0)

#define show_browser(target, browser_content, browser_name) target << browse(browser_content, browser_name)
#define close_browser(target, browser_name)                 target << browse(null, browser_name)
#define send_rsc(target, rsc_content, rsc_name)             target << browse_rsc(rsc_content, rsc_name)

#define MAP_IMAGE_PATH "nano/images/[GLOB.using_map.path]/"

#define map_image_file_name(z_level) "[GLOB.using_map.path]-[z_level].png"

#define RANDOM_BLOOD_TYPE pick(4;"O-", 36;"O+", 3;"A-", 28;"A+", 1;"B-", 20;"B+", 1;"AB-", 5;"AB+")

#define any2ref(x) "\ref[x]"

#define CanInteract(user, state) (CanUseTopic(user, state) == STATUS_INTERACTIVE)

#define CanInteractWith(user, target, state) (target.CanUseTopic(user, state) == STATUS_INTERACTIVE)

#define CanPhysicallyInteract(user) CanInteract(user, GLOB.physical_state)

#define CanPhysicallyInteractWith(user, target) CanInteractWith(user, target, GLOB.physical_state)



#define ARGS_DEBUG log_debug("[__FILE__] - [__LINE__]") ; for(var/arg in args) { log_debug("\t[log_info_line(arg)]") }

// Helper macros to aid in optimizing lazy instantiation of lists.
// All of these are null-safe, you can use them without knowing if the list var is initialized yet

//Picks from the list, with some safeties, and returns the "default" arg if it fails
#define DEFAULTPICK(L, default) ((istype(L, /list) && L:len) ? pick(L) : default)
// Ensures L is initailized after this point
#define LAZYINITLIST(L) if (!L) L = list()
// Sets a L back to null iff it is empty
#define UNSETEMPTY(L) if (L && !L.len) L = null
// Removes I from list L, and sets I to null if it is now empty
#define LAZYREMOVE(L, I) if(L) { L -= I; if(!L.len) { L = null; } }
// Adds I to L, initalizing L if necessary
#define LAZYADD(L, I) if(!L) { L = list(); } L += I;
// Insert I into L at position X, initalizing L if necessary
#define LAZYINSERT(L, I, X) if(!L) { L = list(); } L.Insert(X, I);
// Adds I to L, initalizing L if necessary, if I is not already in L
#define LAZYDISTINCTADD(L, I) if(!L) { L = list(); } L |= I;
// Sets L[A] to I, initalizing L if necessary
#define LAZYSET(L, A, I) if(!L) { L = list(); } L[A] = I;
// Reads I from L safely - Works with both associative and traditional lists.
#define LAZYACCESS(L, I) (L ? (isnum(I) ? (I > 0 && I <= L.len ? L[I] : null) : L[I]) : null)
// Reads the length of L, returning 0 if null
#define LAZYLEN(L) length(L)
// Safely checks if I is in L
#define LAZYISIN(L, I) (L ? (I in L) : FALSE)
// Null-safe L.Cut()
#define LAZYCLEARLIST(L) if(L) L.Cut()

#define LAZYLIMB(L) (L ? L.is_usable() : FALSE)

#define	IS_EMPTY(L)	!(L?.len)

//Sets the value of a key in an assoc list
#define LAZYASET(L,K,V) if(!L) { L = list(); } L[K] = V;

//Adds value to the existing value of a key
#define LAZYAPLUS(L,K,V) if(!L) { L = list(); } if (!L[K]) { L[K] = 0; } L[K] += V;

//Subtracts value from the existing value of a key
#define LAZYAMINUS(L,K,V) if(!L) { L = list(); } if (!L[K]) { L[K] = 0; } L[K] -= V;

// Reads L or an empty list if L is not a list.  Note: Does NOT assign, L may be an expression.
#define SANITIZE_LIST(L) ( islist(L) ? L : list() )

// Insert an object A into a sorted list using cmp_proc (/code/_helpers/cmp.dm) for comparison.
#define ADD_SORTED(list, A, cmp_proc) if(!list.len) {list.Add(A)} else {list.Insert(FindElementIndex(A, list, cmp_proc), A)}

//Currently used in SDQL2 stuff
#define send_output(target, msg, control) target << output(msg, control)
#define send_link(target, url) target << link(url)

// Spawns multiple objects of the same type
#define cast_new(type, num, args...) if((num) == 1) { new type(args) } else { for(var/i=0;i<(num),i++) { new type(args) } }

#define FLAGS_EQUALS(flag, flags) ((flag & (flags)) == (flags))

#define JOINTEXT(X) jointext(X, null)

//Makes span tags easier
#define span(class, text) ("<span class='[class]'>[text]</span>")

//Used to set all the arguments of the currently executing proc, to a list
#define SET_ARGS(L) var/list/newargs = L; for(var/i in 1 to length(newargs)) { args[i] = newargs[i] };

#define subtypesof(prototype) (typesof(prototype) - prototype)


//Takes a list of images, and a flag.
/*
	Checks if target's hudlist has an image for the supplied hud image type
		If so, adds that image to the supplied list
		If not, sets an update
*/
#define	add_hudlist(outputlist, mobref, hudtype)	if (mobref.hud_list[hudtype])\
{outputlist += mobref.hud_list[hudtype]}\
else\
{\
BITSET(mobref.hud_updateflag, hudtype)}


#define VECTOR_POOL_MAX	20000
#define VECTOR_POOL_FULL	4000

#define release_vector(A)	if (!istype(A, /vector2)){\
		if ( !isnull(A)){\
			crash_with("Invalid vector released to pool: [to_string(A)]")}}\
	else if (length(GLOB.vector_pool) < VECTOR_POOL_MAX){\
GLOB.vector_pool += A;}\
A = null;


#define release_vector_list(A)	for (var/vector2/v in A) {release_vector(v)}\
A = null;

#define release_vector_assoc_list(A)	for (var/b in A) {release_vector(A[b])}\
A = null;

#define NONSENSICAL_VALUE -99999

// Returns true if val is from min to max, inclusive.
#define ISINRANGE(val, min, max) (min <= val && val <= max)
