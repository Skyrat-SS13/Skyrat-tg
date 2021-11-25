/// The amount of cell charge drained during a drain failure.
#define MICROFUSION_CELL_DRAIN_FAILURE 500

#define MICROFUSION_CELL_FAILURE_LOWER 10 SECONDS
/// The upper most time for a microfusion cell meltdown.
#define MICROFUSION_CELL_FAILURE_UPPER 15 SECONDS

/// Returned when the phase emtiter process is successful.
#define SHOT_SUCCESS "success"
/// Returned when a gun is fired but there is no phase emitter.
#define SHOT_FAILURE_NO_EMITTER "No phase emitter installed!"

/// The error message returned when the phase emitter is processed but damaged.
#define PHASE_FAILURE_DAMAGED "PHASE EMITTER: Emitter damaged!"
/// The error message returned when the phase emitter has reached it's htermal throttle.
#define PHASE_FAILURE_THROTTLE "PHASE EMITTER: Thermal throttle active!"
