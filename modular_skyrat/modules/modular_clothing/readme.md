https://github.com/Skyrat-SS13/Skyrat-tg/pull/1932

## Title: Techarmor Port

MODULE ID: MODULAR_CLOTHING

### Description:

Ports the Techarmor over from the old base. Gives said Techarmor a much needed balance pass - Specifically, downscaling its flash immunity from full flash (welder immunity) to bright lights (flashes), as well as removing hugger immunity which was never really supposed to be there in the first place but shhhhhhhhhhhhhhhhhhhhhh...

Now nobody has ANY RIGHT to complain about helmet visor flash protection!

### TG Proc Changes:

- security_officer.dm: Armor changed from normal armor (/obj/item/clothing/suit/armor/vest/alt) to techarmor (/obj/item/clothing/suit/space/hardsuit/security_armor)
- locker/security.dm: Lockers now contain their respective Techarmor variants, old armor has been commented away.
- vending/security.dm: Added normal Security Vests and Helmets to the SecVend.
- facehugger.dm: Specific check for the Techarmor to remove its hugger immunity. YOU WILL NOW FACE THE WRATH OF SLIMEY ALIEN FACE RAPE.

### Defines:

- N/A

### Master file additions

- N/A

### Included files that are not contained in this module:

- Modular item icons including suits.dmi, suit.dmi, head.dmi, hats.dmi in modular modular_skyrat\master_files\icons.


### Credits:
Shade Aware - Code
JungleRat - Spritework
necromanceranne - Helping with rebalancing values to be equal to TG armor sets
