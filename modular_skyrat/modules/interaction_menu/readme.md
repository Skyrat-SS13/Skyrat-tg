https://github.com/Skyrat-SS13/Skyrat-tg/pull/<!--PR Number-->

## Title: Interaction Menu

MODULE ID: INTERACTION_MENU

### Description:

Adds an interaction menu to players, the ability to right click and choose from a list to interact with. This module does not yet have the lewd interactions system.

### TG Proc Changes:

- N/A

### Defines:

#define INTERACT_ATOM_REQUIRES_ANCHORED 			(1<<0)
#define INTERACT_ATOM_ATTACK_HAND 					(1<<1)
#define INTERACT_ATOM_UI_INTERACT 					(1<<2)
#define INTERACT_ATOM_REQUIRES_DEXTERITY 			(1<<3)
#define INTERACT_ATOM_IGNORE_INCAPACITATED		 	(1<<4)
#define INTERACT_ATOM_IGNORE_RESTRAINED 			(1<<5)
#define INTERACT_ATOM_CHECK_GRAB 					(1<<6)
#define INTERACT_ATOM_NO_FINGERPRINT_ATTACK_HAND	(1<<7)
#define INTERACT_ATOM_NO_FINGERPRINT_INTERACT 		(1<<8)

#define INTERACT_ITEM_ATTACK_HAND_PICKUP (1<<0)

#define INTERACT_MACHINE_OPEN 				(1<<0)
#define INTERACT_MACHINE_OFFLINE 			(1<<1)
#define INTERACT_MACHINE_WIRES_IF_OPEN 		(1<<2)
#define INTERACT_MACHINE_ALLOW_SILICON 		(1<<3)
#define INTERACT_MACHINE_OPEN_SILICON 		(1<<4)
#define INTERACT_MACHINE_REQUIRES_SILICON	(1<<5)
#define INTERACT_MACHINE_SET_MACHINE 		(1<<6)

### Included files that are not contained in this module:

- N/A

### Credits:

Gandalf2k15 - Porting
