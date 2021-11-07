https://github.com/Skyrat-SS13/Skyrat-tg/pull/7859

## Title: Enables sec/med huds to view records on examine, as well as antagonists being able to view exploitables.

MODULE ID: records_on_examine

### Description:

This PR allows med/sec huds to view medical/security records on examine, respectively, as well as allowing you to view general records. It
also allows certain antags to view exploitables on examine as well.

Originally I planned to add a PDA program to allow all crew to view general 
records, and a OOC verb to allow antags to view exploitables of the entire crew, as well as a way for background info to be seen, however
I am not that good at coding and chickened out.

### TG Proc/File Changes:

EDIT: examine.dm, human.dm, datacore.dm. Modified the behavior of examining things while wearing HUDs, and the behavior of examining as
certain antagonists in examine.dm. Added a few variables that store records to human.dm, added the functionality to the new links 
acquired by examining. Added a field for exploitables in the locked record section of datacore.dm.

### Defines:

- N/A

### Master file additions

- code/modules/antagonists/_common/antag_datum.dm

### Included files that are not contained in this module:

- N/A

### Credits:

Niko#7526, and #development_discuss for giving me the help I needed
