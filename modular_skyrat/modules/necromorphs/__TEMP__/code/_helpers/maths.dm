// Macro functions.
#define RAND_F(LOW, HIGH) (rand()*(HIGH-LOW) + LOW)
#define ceil(x) (-round(-(x)))
#define CEILING(x, y) ( -round(-(x) / (y)) * (y) )

/**
Mathematical function that allows us to scale numbers easily.
MAP(map_from, map_from_minimum, map_from_maximum, map_to_min, map_to_max)
EG:
1-> 0-25 : 0-100
*/
#define MAP(s,a1,a2,b1,b2) b1+(((s-a1)*(b2-b1))/(a2-a1))

// min is inclusive, max is exclusive
/proc/Wrap(val, min, max)
	if (max == min)
		return min
	var/d = max - min
	var/t = Floor((val - min) / d)
	return val - (t * d)

/proc/Default(a, b)
	return a ? a : b

// Trigonometric functions.
/proc/Tan(x)
	return sin(x) / cos(x)

/proc/Csc(x)
	return 1 / sin(x)

/proc/Sec(x)
	return 1 / cos(x)

/proc/Cot(x)
	return 1 / Tan(x)

/proc/Atan2(x, y)
	if(!x && !y) return 0
	var/a = arccos(x / sqrt(x*x + y*y))
	return y >= 0 ? a : -a

/proc/Floor(x)
	return round(x)


/proc/floor_to_multiple(x, multiple)
	return (x - (x % multiple))

/proc/Ceiling(x)
	return -round(-x)

/proc/ceiling_to_multiple(x, multiple)
	return ((x - (x % multiple)) + multiple)

// Greatest Common Divisor: Euclid's algorithm.
/proc/Gcd(a, b)
	while (1)
		if (!b) return a
		a %= b
		if (!a) return b
		b %= a

// Least Common Multiple. The formula is a consequence of: a*b = LCM*GCD.
/proc/Lcm(a, b)
	return abs(a) * abs(b) / Gcd(a, b)

// Useful in the cases when x is a large expression, e.g. x = 3a/2 + b^2 + Function(c)
/proc/Square(x)
	return x*x

/proc/Inverse(x)
	return 1 / x

// Condition checks.
/proc/IsAboutEqual(a, b, delta = 0.1)
	return abs(a - b) <= delta

// Returns true if val is from min to max, inclusive.
/proc/IsInRange(val, min, max)
	return (val >= min) && (val <= max)

/proc/IsInteger(x)
	return Floor(x) == x

/proc/IsMultiple(x, y)
	return x % y == 0

/proc/IsEven(x)
	return !(x & 0x1)

/proc/IsOdd(x)
	return  (x & 0x1)

// Performs a linear interpolation between a and b.
// Note: weight=0 returns a, weight=1 returns b, and weight=0.5 returns the mean of a and b.
/proc/Interpolate(a, b, weight = 0.5)
	return a + (b - a) * weight // Equivalent to: a*(1 - weight) + b*weight

/proc/rand_between(var/lower, var/upper)
	return (rand() * (upper - lower)) + lower

/proc/Mean(...)
	var/sum = 0
	for(var/val in args)
		sum += val
	return sum / args.len

// Returns the nth root of x.
/proc/Root(n, x)
	return x ** (1 / n)

// The quadratic formula. Returns a list with the solutions, or an empty list
// if they are imaginary.
/proc/SolveQuadratic(a, b, c)
	ASSERT(a)

	. = list()
	var/discriminant = b*b - 4*a*c
	var/bottom       = 2*a

	// Return if the roots are imaginary.
	if(discriminant < 0)
		return

	var/root = sqrt(discriminant)
	. += (-b + root) / bottom

	// If discriminant == 0, there would be two roots at the same position.
	if(discriminant != 0)
		. += (-b - root) / bottom

/proc/ToDegrees(radians)
	// 180 / Pi ~ 57.2957795
	return radians * 57.2957795

/proc/ToRadians(degrees)
	// Pi / 180 ~ 0.0174532925
	return degrees * 0.0174532925

// Vector algebra.
/proc/squaredNorm(x, y)
	return x*x + y*y

/proc/norm(x, y)
	return sqrt(squaredNorm(x, y))

/proc/IsPowerOfTwo(var/val)
	return (val & (val-1)) == 0

/proc/RoundUpToPowerOfTwo(var/val)
	return 2 ** -round(-log(2,val))


/*
	This proc makes the input taper off above cap. But there's no absolute cutoff.
	Chunks of the input value above cap, are reduced more and more with each successive one and added to the output

	A higher input value always makes a higher output value. but the rate of growth slows

*/
/proc/soft_cap(var/input, var/cap = 0, var/groupsize = 1, var/groupmult = 0.9)

	//The cap is a ringfenced amount. If we're below that, just return the input
	if (input <= cap)
		return input

	var/output = 0
	var/buffer = 0
	var/power = 1//We increment this after each group, then apply it to the groupmult as a power

	//Ok its above, so the cap is a safe amount, we move that to the output
	input -= cap
	output += cap

	//Now we start moving groups from input to buffer


	while (input > 0)
		buffer = min(input, groupsize)	//We take the groupsize, or all the input has left if its less
		input -= buffer

		buffer *= groupmult**power //This reduces the group by the groupmult to the power of which index we're on.
		//This ensures that each successive group is reduced more than the previous one

		output += buffer
		power++ //Transfer to output, increment power, repeat until the input pile is all used

	return output









/proc/shortest_angle(var/delta)
	return (delta - round(delta, 360))
#define CLAMP(CLVALUE,CLMIN,CLMAX) ( max( (CLMIN), min((CLVALUE), (CLMAX)) ) )





//Takes a view range. Produces a multiplier of how much bigger or smaller a screen edge would be with that range, compared to a baseline
/proc/view_scalar(var/range, var/base = world.view)
	return ((range*2)+1) / ((base*2)+1)


/*
	Intended to work in global pixels.
	This takes a global pixel coordinate as an origin point
	A vector measured in pixels to express the length and direction of the ray
	And a turf we'll test as the target

	This will return the points along the edge where this ray intersects the target turf.
	This will always be either two points or zero points, no other value is possible
*/
/proc/ray_turf_intersect(var/vector2/origin, var/vector2/ray, var/turf/target)
	//debug_mark_turf(target)
	//First of all, passing in a turf is just a convenience, what we actually need are the pixel coordinates of its lowerleft and upper right corners

	//This gets us the centre of the turf
	var/vector2/LL = target.get_global_pixel_loc()
	var/vector2/UR = get_new_vector(LL.x, LL.y)	//Copy it


	//We subtract 16 from X and Y to get to the lowerleft corner
	LL.x -= WORLD_ICON_SIZE / 2
	LL.y -= WORLD_ICON_SIZE / 2

	//And add 16 to get to upper left
	UR.x += WORLD_ICON_SIZE / 2
	UR.y += WORLD_ICON_SIZE / 2

	//pixelmark(target, "ll",LL)
	//pixelmark(target, "ur",UR)

	//---------------------------------

	var/vector2/endpoint = origin + ray

	var/vector2/linemin = get_new_vector(min(origin.x, endpoint.x), min(origin.y, endpoint.y))
	var/vector2/linemax = get_new_vector(max(origin.x, endpoint.x), max(origin.y, endpoint.y))
	ray = linemax - linemin



	//Next up, this piece of black magic code determines the four points at which our ray passes through the planes of this box's edges
	//These are float values, they represent percentage distances along the ray at which we intersect

	var/ax = ray.x ? ((LL.x - linemin.x) / ray.x)	:	null
	var/ay = ray.y ? ((LL.y - linemin.y) / ray.y)	:	null
	var/bx = ray.x ? ((UR.x - linemin.x) / ray.x)	:	null
	var/by = ray.y ? ((UR.y - linemin.y) / ray.y)	:	null



	//We dont need to do any miss checks, we know we hit before this function was called

	var/min_intersect
	var/max_intersect
	//Finding the bounds and null handling.
	if (!isnull(ax) && !isnull(ay))
		min_intersect = max(ax, ay)
		max_intersect = min(bx, by)
	else if (isnull(ax))
		min_intersect = ay
		max_intersect = by

	else
		min_intersect = ax
		max_intersect = bx

	var/vector2/entry = linemin + (ray * min_intersect)
	var/vector2/exit = linemin + (ray * max_intersect)

	var/list/intersections = list(entry, exit)

	//Oof, this is way too many vectors to be working with
	release_vector(LL)
	release_vector(UR)
	release_vector(endpoint)
	release_vector(linemin)
	release_vector(linemax)

	return intersections

