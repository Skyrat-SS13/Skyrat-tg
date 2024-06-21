# The modularization handbook - Skyrat style, v0.2

## Failure to follow this guide will result in your PR being denied.

## Introduction

To develop and maintain a separate codebase is a big task, that many have failed and suffered the consequences of, such as outdated, and messy code.
It's not necessarily the fault of lack of skill of the people maintaining it, merely the lack of resources and how much continuous effort such an endeavor takes.

One of the solutions for such, is to base our server on a solid codebase, that is primarily maintained by somebody else, in this case tgstation, and insert our content in a modular fashion, while following the general code (but not gameplay) direction of the upstream, mirroring any changes they do for parity.

Git, as a version control system, is very useful, however it is just a very methodical thing, that follows its many algorithms, that sadly cannot always intelligently resolve certain changes in the code in an unambiguous way, giving us conflicts, that need to be resolved in a manual fashion.

Due to maintainability being one of the main reasons behind our rebase to another codebase, **this protocol will seriously be enforced.**
A well organized, documented and atomized code saves our maintainers a lot of headache, when being reviewed.
Don't dump on them the work that you could have done yourself.

This document is meant to be updated and changed, whenever any new exceptions are added onto it. It might be worth it to check, from time to time, whether we didn't define a more unique standardized way of handling some common change.

## Important note - TEST YOUR PULL REQUESTS

You are responsible for the testing of your content. You should not mark a pull request ready for review until you have actually tested it. If you require a separate client for testing, you can use a guest account by logging out of BYOND and connecting to your test server. Test merges are not for bug finding, they are for stress tests where local testing simply doesn't allow for this.

### The nature of conflicts

For example, let's have an original

```byond
var/something = 1
```

in the core code, that we decide to change from 1 to 2 on our end,

```diff
- var/something = 1
+ var/something = 2 //SKYRAT EDIT
```

but then our upstream introduces a change in their codebase, changing it from 1 to 4

```diff
- var/something = 1
+ var/something = 4
```

As easy of an example as it is, it results in a relatively simple conflict, in the form of

```byond
var/something = 2 //SKYRAT EDIT
```

where we pick the preferable option manually.

### The solution

That is something that cannot and likely shouldn't be resolved automatically, because it might introduce errors and bugs that will be very hard to track down, not to even bring up more complex examples of conflicts, such as ones that involve changes that add, remove and move lines of code all over the place.

tl;dr it tries its best but ultimately is just a dumb program, therefore, we must ourselves do work to ensure that it can do most of the work, while minimizing the effort spent on manual involvement, in the cases where the conflicts will be inevitable.

Our answer to this is modularization of the code.

**Modularization** means, that most of the changes and additions we do, will be kept in a separate **`modular_skyrat/`** folder, as independent from the core code as possible, and those which absolutely cannot be modularized, will need to be properly marked by comments, specifying where the changes start, where they end, and which feature they are a part of, but more on that in the next section.

## The modularization protocol

Always start by thinking of the theme/purpose of your work. It's oftentimes a good idea to see if there isn't an already existing one, that you should append to.

**If it's a tgcode-specific tweak or bugfix, first course of action should be an attempt to discuss and PR it upstream, instead of needlessly modularizing it here.**

Otherwise, pick a new ID for your module. E.g. `DNA-FEATURE-WINGS` or `XENOARCHEAOLOGY` or `SHUTTLE_TOGGLE` - We will use this in future documentation. It is essentially your module ID. It must be uniform throughout the entire module. All references MUST be exactly the same. This is to allow for easy searching.

And then you'll want to establish your core folder that you'll be working out of which is normally your module ID. E.g. `modular_skyrat/modules/shuttle_toggle`

### Maps

IMPORTANT: MAP CONTRIBUTION GUIDELINES HAVE BEEN UPDATED

When you are adding a new item to the map you MUST follow this procedure:
Start by deciding how big of a change it is going to be, if it is a small 1 item change, you should use the simple area automapper. If it is an entire room, you should use the template automapper.

We will no longer have _skyrat map versions.

DO NOT CHANGE TG MAPS, THEY ARE HELD TO THE SAME STANDARD AS ICONS. USE THE ABOVE TO MAKE MAP EDITS.

The automapper uses prebaked templates to override sections of a map using coordinates to plot the starting location. See entries in automapper_config.toml for examples.

The simple area automapper uses datum entries to place down a single item in an area of a map that makes vauge sense.

### Assets: images, sounds, icons and binaries

Git doesn't handle conflicts of binary files well at all, therefore changes to core binary files are absolutely forbidden, unless you have a really *really* ***really*** good reason to do otherwise.

All assets added by us should be placed into the same modular folder as your code. This means everything is kept inside your module folder, sounds, icons and code files.

- ***Example:*** You're adding a new lavaland mob.

  First of all you create your modular folder. E.g. `modular_skyrat/modules/lavalandmob`

  And then you'd want to create sub-folders for each component. E.g. `/code` for code and `/sounds` for sound files and `/icons` for any icon files.

  After doing this, you'll want to set your references within the code.

  ```byond
    /mob/lavaland/newmob
      icon = 'modular_skyrat/modules/lavalandmob/icons/mob.dmi'
      icon_state = "dead_1"
      sound = 'modular_skyrat/modules/lavalandmob/sounds/boom.ogg'
  ```

  This ensures your code is fully modular and will make it easier for future edits.

- Other assets, binaries and tools, should usually be handled likewise, depending on the case-by-case context. When in doubt, ask a maintainer or other contributors for tips and suggestions.

- Any additional clothing icon files you add MUST go into the existing files in master_files clothing section.

### The `master_files` Folder

You should always put any modular overrides of icons, sound, code, etc. inside this folder, and it **must** follow the core code folder layout.

Example: `code/modules/mob/living/living.dm` -> `modular_skyrat/master_files/code/modules/mob/living/living.dm`

This is to make it easier to figure out what changed about a base file without having to search through proc definitions. 

It also helps prevent modules needlessly overriding the same proc multiple times. More information on these types of edits come later.

### Fully modular portions of your code

This section will be fairly straightforward, however, I will try to go over the basics and give simple examples, as the guide is aimed at new contributors likewise.

The rule of thumb is that if you don't absolutely have to, you shouldn't make any changes to core codebase files. With some exceptions that will be mentioned shortly.

In short, most of the modular code will be placed in the subfolders of your main module folder **`modular_skyrat/modules/yourmodule/code/`**, with similar rules as with the assets. Do not mirror core code folder structures inside your modular folder.

For example, `modular_skyrat/modules/xenoarcheaology/code` containing all the code, tools, items and machinery related to it.

Such modules, unless _very_ simple, **need** to have a `readme.md` in their folder, containing the following:

- links to the PRs that implemented this module or made any significant changes to it
- short description of the module
- list of files changed in the core code, with a short description of the change, and a list of changes in other modular files that are not part of the same module, that were necessary for this module to function properly
- (optionally) a bit more elaborative documentation for future-proofing the code,  that will be useful further development and maintenance
- credits

***Template:*** [Here](module_template.md)

## Modular Overrides (Important!!)

Note, that it is possible to append code in front, or behind a core proc, in a modular fashion, without editing the original proc, through referring the parent proc, using `. = ..()` or `..()`. And likewise, it is possible to add a new var to an existing datum or obj, without editing the core files.

**Note about proc overrides: Just because you can, doesn't mean you should!!**

In general they are a good idea and encouraged whenever it is possible to do so. However this is not a hard rule, and sometimes Skyrat edits are preferable. Just try to use your common sense about it.

For example: please do not copy paste an entire TG proc into a modular override, make one small change, and then bill it as 'fully modular'. These procs are an absolute nightmare to maintain because once something changes upstream you have to update the overridden proc.

Sometimes you aren't even aware the override exists if it compiles fine and doesn't cause any bugs. This often causes features that were added upstream to be missing here. So yeah. Avoid that. It's okay if something isn't fully modular. Sometimes it's the better choice.

The best candidates for modular proc overrides are ones where you can just tack something on after calling the parent, or weave a parent call cleverly in the middle somewhere to achieve your desired effect.

Performance should also be considered when you are overriding a hot proc (like Life() for example), as each additional call adds overhead. Skyrat edits are much more performant in those cases. For most procs this won't be something you have to think about, though.

### These modular overrides should be kept in `master_files`, and you should avoid putting them inside modules as much as possible.

To keep it simple, let's assume you wanted to make guns spark when shot, for simulating muzzle flash or whatever other reasons, and you want potentially to use it with all kinds of guns.

You could start, in a modular file, by adding a var.

```byond
/obj/item/gun
    var/muzzle_flash = TRUE
```

And it will work just fine. Afterwards, let's say you want to check that var and spawn your sparks after firing a shot.
Knowing the original proc being called by shooting is

```byond
/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
```

you can define a child proc for it, that will get inserted into the inheritance chain of the related procs (big words, but in simple cases like this, you don't need to worry)

```byond
/obj/item/gun/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
    . = ..() //. is the default return value, we assign what the parent proc returns to it, as we call it before ours
    if(muzzle_flash)
        spawn_sparks(src) //For simplicity, I assume you've already made a proc for this
```

And that wraps the basics of it up.

### Non-modular changes to the core code - IMPORTANT

Every once in a while, there comes a time, where editing the core files becomes inevitable.

Please be sure to log these in the module readme.md. Any file changes.

In those cases, we've decided to apply the following convention, with examples:

- **Addition:**

  ```byond
  //SKYRAT EDIT ADDITION BEGIN - SHUTTLE_TOGGLE - (Optional Reason/comment)
  var/adminEmergencyNoRecall = FALSE
  var/lastMode = SHUTTLE_IDLE
  var/lastCallTime = 6000
  //SKYRAT EDIT ADDITION END
  ```

- **Removal:**

  ```byond
  //SKYRAT EDIT REMOVAL BEGIN - SHUTTLE_TOGGLE - (Optional Reason/comment)
  /*
  for(var/obj/docking_port/stationary/S in stationary)
    if(S.id = id)
      return S
  */
  //SKYRAT EDIT REMOVAL END
  WARNING("couldn't find dock with id: [id]")
  ```

  And for any removals that are moved to different files:

  ```byond
  //SKYRAT EDIT REMOVAL BEGIN - SHUTTLE_TOGGLE - (Moved to modular_skyrat/shuttle_toggle/randomverbs.dm)
  /*
  /client/proc/admin_call_shuttle()
  set category = "Admin - Events"
  set name = "Call Shuttle"

  if(EMERGENCY_AT_LEAST_DOCKED)
    return

  if(!check_rights(R_ADMIN))
    return

  var/confirm = alert(src, "You sure?", "Confirm", "Yes", "No")
  if(confirm != "Yes")
    return

  SSshuttle.emergency.request()
  SSblackbox.record_feedback("tally", "admin_verb", 1, "Call Shuttle") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
  log_admin("[key_name(usr)] admin-called the emergency shuttle.")
  message_admins(span_adminnotice("[key_name_admin(usr)] admin-called the emergency shuttle."))
  return
  */
  //SKYRAT EDIT REMOVAL END
  ```

- **Change:**

  ```byond
  //SKYRAT EDIT CHANGE BEGIN - SHUTTLE_TOGGLE - (Optional Reason/comment)
  //if(SHUTTLE_STRANDED, SHUTTLE_ESCAPE) - SKYRAT EDIT - ORIGINAL
  if(SHUTTLE_STRANDED, SHUTTLE_ESCAPE, SHUTTLE_DISABLED)
  //SKYRAT EDIT CHANGE END
      return 1
  ```

## Exceptional cases of modular code

From every rule, there's exceptions, due to many circumstances. Don't think about it too much.

### Defines

Due to the way byond loads files, it has become necessary to make a different folder for handling our modular defines.
That folder is **`code/__DEFINES/~skyrat_defines`**, in which you can add them to the existing files, or create those files as necessary.

If you have a define that's used in more than one file, it **must** be declared here.

If you have a define that's used in one file, and won't be used anywhere else, declare it at the top, and `#undef MY_DEFINE` at the bottom of the file. This is to keep context menus clean, and to prevent confusion by those using IDEs with autocomplete.

### Module folder layout

To keep form and ensure most modules are easy to navigate and to keep control of the amount of files and folders being made in the repository, you are required to follow this layout.

Ensure the folder names are exactly as stated.

Top most folder: module_id

**DO NOT COPY THE CORE CODE FILE STRUCTURE IN YOUR MODULE!!**

**Code**: Any .DM files must go in here.

- Good: /modular_skyrat/modules/example_module/code/disease_mob.dm
- Bad: /modular_skyrat/modules/example_module/code/modules/antagonists/disease/disease_mob.dm

**Icons**: Any .DMI files must go in here.

- Good: /modular_skyrat/modules/example_module/icons/mining_righthand.dmi
- Bad: /modular_skyrat/modules/example_module/icons/mob/inhands/equipment/mining_righthand.dmi

**Sound**: Any SOUND files must go in here.

- Good: See above.
- Bad: See above.

The readme should go into the parent folder, module_id.

**DO NOT MIX AND MATCH FILE TYPES IN FOLDERS!**

### Commenting out code - DON'T DO IT

If you are commenting out redundant code in modules, do not comment it out, instead, delete it.

Even if you think someone is going to redo whatever it is you're commenting out, don't, gitblame exists for a reason.

This also applies to files, do not comment out entire files, just delete them instead. This helps us keep down on filebloat and pointless comments.

**This does not apply to non-modular changes.**

## Modular TGUI

TGUI is another exceptional case, since it uses javascript and isn't able to be modular in the same way that DM code is.
ALL of the tgui files are located in `/tgui/packages/tgui/interfaces` and its subdirectories; there is no specific folder for Skyrat UIs.

### Modifying upstream files

When modifying upstream TGUI files the same rules apply as modifying upstream DM code, however the grammar for comments may be slightly different.

You can do both `// SKYRAT EDIT` and `/* SKYRAT EDIT */`, though in some cases you may have to use one over the other.

In general try to keep your edit comments on the same line as the change. Preferably inside the JSX tag. e.g:

```js
<Button
	onClick={() => act('spin', { high_quality: true })}
	icon="rat" // SKYRAT EDIT ADDITION
</Button>
```

```js
<Button
	onClick={() => act('spin', { high_quality: true })}
	// SKYRAT EDIT ADDITION START - another example, multiline changes
	icon="rat"
	tooltip="spin the rat."
	// SKYRAT EDIT ADDITION END
</Button>
```

```js
<SomeThing someProp="whatever" /* it also works in self-closing tags */ />
```

If that is not possible, you can wrap your edit in curly brackets e.g. 

```js
{/* SKYRAT EDIT ADDITION START */} 
<SomeThing>
	someProp="whatever"
</SomeThing>
{/* SKYRAT EDIT ADDITION END */}
```

### Creating new TGUI files 

**IMPORTANT! When creating a new TGUI file from scratch, please add the following at the very top of the file (line 1):**
```js
// THIS IS A SKYRAT UI FILE
```

This way they are easily identifiable as modular TGUI .tsx/.jsx files. You do not have to do anything further, and there will never be any need for a Skyrat edit comment in a modular TGUI file.

## Exemplary PR's

Here are a couple PR's that are great examples of the guide being followed, reference them if you are stuck:

- <https://github.com/Skyrat-SS13/Skyrat-tg/pull/241>
- <https://github.com/Skyrat-SS13/Skyrat-tg/pull/111>

## Afterword

It might seem like a lot to take in, but if we remain consistent, it will save us a lot of headache in the long run, once we start having to resolve conflicts manually.
Thanks to a bit more scrupulous documentation, it will be immediately obvious what changes were done and where and by which features, things will be a lot less ambiguous and messy.

Best of luck in your coding. Remember that the community is there for you, if you ever need help.
