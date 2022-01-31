// General reactor defines
/// How many fuel rods we can have in the reactor at any one time.
#define REACTOR_MAX_FUEL_RODS 5
/// How many control rods we can have in the reactor at any one time.
#define REACTOR_MAX_CONTROL_RODS 4


// Reactor temperatures (Reactor pressure vessel)

/// This is the operating temperature of the reactor, if we cannot boil the water to create steam, how can we run?
#define REACTOR_TEMPERATURE_MINIMUM 373.2 // Kelvin
/// The highest possible temperature the reactor can reach without taking damage from overheating.
#define REACTOR_TEMPERATURE_MAXIMUM 900
/// The fastest rate the reactor can change temperature.
#define REACTOR_MAX_TEMPERATURE_CHANGE 20
/// The fastest the ambient temperature can convect our internal temperature.
#define REACTOR_MAX_TEMPERATURE_CONDUCTION 5

// Reactor pressures (Reactor pressure vessel)
/// This is the pressure at which the reactor is best operating.
#define REACTOR_PRESSURE_OPERATING 7000 // Kilopascal
/// This is the maximum pressure the reactor can operate at without taking damage.
#define REACTOR_PRESSURE_MAXIMUM 9000
/// How quickly our internal steam condenses.
#define REACTOR_PRESSURE_CONDENSATION_RATE 0.1
/// How quickly our internal water evaporates
#define REACTOR_PRESSURE_EVAPORATION_RATE 0.1

// Damage defines
/// How much damage can the reactor take in any given second, limited to 5 so people have around 20 seconds to GTFO if the reactor is really dying.
#define REACTOR_MAX_DAMAGE_PER_SECOND 5
