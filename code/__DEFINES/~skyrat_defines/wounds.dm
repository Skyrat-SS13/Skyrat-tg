/// See muscle.dm
#define WOUND_SERIES_MUSCLE_DAMAGE 10000 // We use a super high number as realistically speaking TG will never increment to this amount of wound series

/// If this wound, when bandaged, will cause a splint overlay to generate rather than a bandage overlay.
#define SPLINT_OVERLAY (1<<200) // we use a big number since tg realistically wouldnt go to it
