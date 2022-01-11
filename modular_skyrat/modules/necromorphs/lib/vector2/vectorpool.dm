/*
	Vector pooling solution
	Keeps vectors in a global list and recycles them

	Creates new ones when needed

	Vectors must be cleaned up using release_vector(vector) when they are no longer needed, and before the end of their scope.
	The responsibility for doing this belongs to the owner

	Do not leave vectors to be GCed

	Here is how ownership is determined

		-Anything you create is yours. Unless you return it, then the caller owns it.
		-Anything passed into you as a parameter is not yours, make a copy if you wish to modify it, and be sure to release your copy
		-Anything held in a variable of an object is the property of that object. Don't locally store a vector you don't own

	Never modify a vector you don't own.
		-All of the SelfXXXX functions will modify that vector.
		-All those without self will create a new vector which is yours to use


	Creating Copies:
		If you're creating something for the first time or as a temporary var, use sourcevector.Copy()
		If you're regularly copying a vector into a locally stored version, use sourcevector.CopyTo(myvector)
			This is more efficient than releasing the old one and then using copy
*/

GLOBAL_LIST_EMPTY(vector_pool)
GLOBAL_VAR_INIT(vector_pool_filling, FALSE)


//GLOBAL_VAR_INIT(vectors_created, 0)
//GLOBAL_VAR_INIT(vectors_recycled, 0)

//Fills the pool with fresh vectors for later use. Sleeps while doing so to reduce lag.
//This can take as long as it needs to, and other procs may extend the time by taking from the pool while it fills
//If the pool runs empty during the process then vectors will be created on demand
/proc/fill_vector_pool()
	set waitfor = FALSE

	if (GLOB.vector_pool_filling)
		return

	GLOB.vector_pool_filling = TRUE
	while (length(GLOB.vector_pool) < VECTOR_POOL_FULL)
		sleep()
		GLOB.vector_pool += new /vector2(0,0)

	GLOB.vector_pool_filling = FALSE

/*
	This is the proc to make a new vector, it should always be used instead of new whenever possible
	It is not possible at compiletime, and so that is one scenario where using new is acceptable.
		But in that case, be sure to release those vectors in Destroy
*/
/proc/get_new_vector(var/new_x, var/new_y)
	if (length(GLOB.vector_pool))
		var/vector2/newvec
		macropop(GLOB.vector_pool, newvec)
		newvec.x = new_x
		newvec.y = new_y
		return newvec

	else
		//If we failed to get one from the list, make a new one for almost-immediate return
		.=new /vector2(new_x,new_y)
		//GLOB.vectors_created++
		//And start the pool filling if needed
		if (!GLOB.vector_pool_filling)
			spawn()
				fill_vector_pool()


//Releasing vectors is handled via a define in _macros.dm



/client/proc/debug_vectorpool()
	set category = "Debug"
	set name = "Vector Pool Debug"
	to_chat(src, "Vecpool: [length(GLOB.vector_pool)]")
	//to_chat(src, "Created: [GLOB.vectors_created]")
	//to_chat(src, "Recycled: [GLOB.vectors_recycled]")

