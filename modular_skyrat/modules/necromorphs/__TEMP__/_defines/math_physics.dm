// Math constants.
#define M_PI    3.14159265

#define R_IDEAL_GAS_EQUATION       8.31    // kPa*L/(K*mol).
#define ONE_ATMOSPHERE             101.325 // kPa.
#define IDEAL_GAS_ENTROPY_CONSTANT 1164    // (mol^3 * s^3) / (kg^3 * L).

// Radiation constants.
#define STEFAN_BOLTZMANN_CONSTANT    5.6704e-8 // W/(m^2*K^4).
#define COSMIC_RADIATION_TEMPERATURE 3.15      // K.
#define AVERAGE_SOLAR_RADIATION      200       // W/m^2. Kind of arbitrary. Really this should depend on the sun position much like solars.
#define RADIATOR_OPTIMUM_PRESSURE    3771      // kPa at 20 C. This should be higher as gases aren't great conductors until they are dense. Used the critical pressure for air.
#define GAS_CRITICAL_TEMPERATURE     132.65    // K. The critical point temperature for air.

#define RADIATOR_EXPOSED_SURFACE_AREA_RATIO 0.04 // (3 cm + 100 cm * sin(3deg))/(2*(3+100 cm)). Unitless ratio.
#define HUMAN_EXPOSED_SURFACE_AREA          5.2 //m^2, surface area of 1.7m (H) x 0.46m (D) cylinder

#define T0C   273.15 //    0.0 degrees celcius
#define T20C  293.15 //   20.0 degrees celcius
#define T100C 373.15 //  100.0 degrees celsius
#define TCMB  2.7    // -270.3 degrees celcius

#define ATMOS_PRECISION 0.0001
#define QUANTIZE(variable) (round(variable, ATMOS_PRECISION))

#define INFINITY	1.#INF

#define SHORT_REAL_LIMIT 16777216

#define TICKS_IN_DAY 		24*60*60*10
#define TICKS_IN_SECOND 	10

#define SIMPLE_SIGN(X) ((X) < 0 ? -1 : 1)
#define SIGN(X)        ((X) ? SIMPLE_SIGN(X) : 0)

// round() acts like floor(x, 1) by default but can't handle other values
#define FLOOR(x, y) ( round((x) / (y)) * (y) )

// Similar to clamp but the bottom rolls around to the top and vice versa. min is inclusive, max is exclusive
#define WRAP(val, min, max) clamp(( min == max ? min : (val) - (round(((val) - (min))/((max) - (min))) * ((max) - (min))) ),min,max)

// Real modulus that handles decimals
#define MODULUS(x, y) ( (x) - (y) * round((x) / (y)) )

// Determines the exchange ratio of reagents being converted to gas and vice versa.
#define REAGENT_GAS_EXCHANGE_FACTOR 10


//Clock directions, used for multistage cones
#define CLOCKWISE	1
#define ANTICLOCKWISE	-1

/// Gets shift x that would be required the bitflag (1<<x)
#define TOBITSHIFT(bit) ( log(2, bit) )
