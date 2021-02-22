#define VOLUME_MAX		100
#define VOLUME_HIGH		45
#define VOLUME_MID_HIGH	30
#define VOLUME_MID		18
#define VOLUME_LOW		8
#define VOLUME_QUIET	5
#define VOLUME_NEAR_SILENT	2.5

//Alternate defines
#define VOLUME_LOUD	VOLUME_HIGH
#define VOLUME_MEDIUM	VOLUME_MID
#define VOLUME_NORMAL	VOLUME_MID


//Species soundtype defines
#define SOUND_FOOTSTEP		"footstep"
#define SOUND_SHOUT			"shout"
#define SOUND_SHOUT_LONG	"long shout"
#define SOUND_ATTACK		"attack"
#define SOUND_PAIN			"pain"
#define SOUND_DEATH			"death"
#define SOUND_SPEECH		"speech"
#define SOUND_REGEN			"regenerate"
#define SOUND_CLIMB			"climb"



//How much time of complete silence is left between ending one song and starting the next. Time is in deciseconds, can't use the SECONDS define here
#define MUSIC_INTERVAL_DURATION	100
