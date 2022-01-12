#define VECTOR_POOL_MAX	20000
#define VECTOR_POOL_FULL	4000
#define WORLD_ICON_SIZE 32

#define release_vector(A)	if (!istype(A, /vector2)){\
		if ( !isnull(A)){\
			CRASH("Invalid vector released to pool: [A]")}}\
	else if (length(GLOB.vector_pool) < VECTOR_POOL_MAX){\
GLOB.vector_pool += A;}\
A = null;

#define Clamp(value, low, high) 	(value <= low ? low : (value >= high ? high : value))

#define release_vector_list(A)	for (var/vector2/v in A) {release_vector(v)}\
A = null;

#define release_vector_assoc_list(A)	for (var/b in A) {release_vector(A[b])}\
A = null;

#define NONSENSICAL_VALUE -99999
