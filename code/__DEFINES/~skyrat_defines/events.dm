/**
 * The events system now operates off of a defined preset of votable pools.
 * High, med, low
 * Players can vote for whatever one they want and then the subsystem will select a random event from the pool of pre-generated events.
 * The random define is for events such as anomalies so they are still run during higher level events.
 */

#define EVENT_CHAOS_LOW 1
#define EVENT_CHAOS_MED 2
#define EVENT_CHAOS_HIGH 3
#define EVENT_CHAOS_RANDOM 4
#define EVENT_CHAOS_DISABLED 5
