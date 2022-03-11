//flags for outfits that have mutant variants: Most of these require additional sprites to work.
#define STYLE_DIGITIGRADE (1<<0) //jumpsuits, suits and shoes
#define STYLE_MUZZLE (1<<1) //hats or masks
#define STYLE_TAUR_SNAKE (1<<2) //taur-friendly suits
#define STYLE_TAUR_PAW (1<<3)
#define STYLE_TAUR_HOOF (1<<4)
#define STYLE_VOX (1<<5) //For glasses, masks and head pieces for the Vox race
#define STYLE_TESHARI (1<<6) //teshari clothes and shit

/// Holds all 3 taur types in bitwise OR configuration. To be used to either declare an item should be on all 3 taur types, or to check if something has any of the 3 bitflags.
#define STYLE_TAUR_ALL (STYLE_TAUR_SNAKE | STYLE_TAUR_PAW | STYLE_TAUR_HOOF)

/// Holds all 3 taur types in bitwise AND configuration. DO NOT USE WITH MUTANT_VARIANTS. Use for checking if something has all 3 of the bitflags.
#define STYLE_TAUR (STYLE_TAUR_SNAKE & STYLE_TAUR_PAW & STYLE_TAUR_HOOF)
