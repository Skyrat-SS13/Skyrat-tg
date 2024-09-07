//Martial arts defines

#define MARTIALART_BOXING "boxing"
#define MARTIALART_CQC "CQC"
#define MARTIALART_EVIL_BOXING "evil boxing"
#define MARTIALART_HUNTER_BOXING "hunter boxing"
#define MARTIALART_KRAVMAGA "krav maga"
#define MARTIALART_MUSHPUNCH "mushroom punch"
#define MARTIALART_PLASMAFIST "plasma fist"
#define MARTIALART_PSYCHOBRAWL "psychotic brawling"
#define MARTIALART_SLEEPINGCARP "sleeping carp"
#define MARTIALART_WRESTLING "wrestling"

/// The number of hits required to crit a target
<<<<<<< HEAD
#define HITS_TO_CRIT(damage) round(HUMAN_MAXHEALTH / damage, 0.1) // SKYRAT EDIT - changes the magic health number of 100 to HUMAN_MAXHEALTH.
=======
#define HITS_TO_CRIT(damage) round(100 / damage, 0.1)
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
