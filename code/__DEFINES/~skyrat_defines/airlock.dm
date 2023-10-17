#define AIRLOCK_FRAME_CLOSED "closed"
#define AIRLOCK_FRAME_CLOSING "closing"
#define AIRLOCK_FRAME_OPEN "open"
#define AIRLOCK_FRAME_OPENING "opening"

#define AIRLOCK_SECURITY_NONE 0 //Normal airlock //Wires are not secured
#define AIRLOCK_SECURITY_IRON 1 //Medium security airlock //There is a simple iron plate over wires (use welder)
#define AIRLOCK_SECURITY_PLASTEEL_I_S 2 //Sliced inner plating (use crowbar), jumps to 0
#define AIRLOCK_SECURITY_PLASTEEL_I 3 //Removed outer plating, second layer here (use welder)
#define AIRLOCK_SECURITY_PLASTEEL_O_S 4 //Sliced outer plating (use crowbar)
#define AIRLOCK_SECURITY_PLASTEEL_O 5 //There is first layer of plasteel (use welder)
#define AIRLOCK_SECURITY_PLASTEEL 6 //Max security airlock //Fully secured wires (use wirecutters to remove grille, that is electrified)

#define AIRLOCK_INTEGRITY_N  300 // Normal airlock integrity
#define AIRLOCK_INTEGRITY_MULTIPLIER 1.5 // How much reinforced doors health increases
/// How much extra health airlocks get when braced with a seal
#define AIRLOCK_SEAL_MULTIPLIER  2
#define AIRLOCK_DAMAGE_DEFLECTION_N  21  // Normal airlock damage deflection
#define AIRLOCK_DAMAGE_DEFLECTION_R  30  // Reinforced airlock damage deflection

#define AIRLOCK_DENY_ANIMATION_TIME (0.6 SECONDS) /// The amount of time for the airlock deny animation to show

#define DOOR_CLOSE_WAIT 60 /// Time before a door closes, if not overridden

#define DOOR_VISION_DISTANCE 11 ///The maximum distance a door will see out to

#define AIRLOCK_LIGHT_POWER 0.5
#define AIRLOCK_LIGHT_RANGE 2
#define AIRLOCK_LIGHT_ENGINEERING "engineering"
#define AIRLOCK_POWERON_LIGHT_COLOR "#3aa7c2"
#define AIRLOCK_BOLTS_LIGHT_COLOR "#c22323"
#define AIRLOCK_ACCESS_LIGHT_COLOR "#57e69c"
#define AIRLOCK_EMERGENCY_LIGHT_COLOR "#d1d11d"
#define AIRLOCK_ENGINEERING_LIGHT_COLOR "#fd8719"
#define AIRLOCK_DENY_LIGHT_COLOR "#c22323"
