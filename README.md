## Skyrat 13 (/tg/station Downstream)

[![CI Suite](https://github.com/Skyrat-SS13/Skyrat-tg/actions/workflows/ci_suite.yml/badge.svg)](https://github.com/Skyrat-SS13/Skyrat-tg/actions/workflows/ci_suite.yml)
[![Percentage of issues still open](http://isitmaintained.com/badge/open/Skyrat-SS13/Skyrat-tg.svg)](https://isitmaintained.com/project/Skyrat-SS13/Skyrat-tg "Percentage of issues still open")
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/Skyrat-SS13/Skyrat-tg.svg)](https://isitmaintained.com/project/Skyrat-SS13/Skyrat-tg "Average time to resolve an issue")
![Coverage](https://img.shields.io/codecov/c/github/Skyrat-SS13/Skyrat-tg)

[![resentment](https://forthebadge.com/images/badges/built-with-resentment.svg)](https://www.monkeyuser.com/assets/images/2019/131-bug-free.png) [![resentment](https://forthebadge.com/images/badges/contains-technical-debt.svg)](https://user-images.githubusercontent.com/8171642/50290880-ffef5500-043a-11e9-8270-a2e5b697c86c.png) [![forinfinityandbyond](https://user-images.githubusercontent.com/5211576/29499758-4efff304-85e6-11e7-8267-62919c3688a9.gif)](https://www.reddit.com/r/SS13/comments/5oplxp/what_is_the_main_problem_with_byond_as_an_engine/dclbu1a)

* **Git / GitHub cheatsheet:** https://www.notion.so/Git-GitHub-61bc81766b2e4c7d9a346db3078ce833
* **Guide to Modularisation:** [./modular_skyrat/readme.md](./modular_skyrat/readme.md)
* **Website:** https://www.tgstation13.org
* **Code:** https://github.com/tgstation/tgstation
* **Wiki:** https://tgstation13.org/wiki/Main_Page
* **Codedocs:** https://skyrat-ss13.github.io/Skyrat-tg/
* **Skyrat 13 Discord:** https://discord.com/invite/hGpZ4Z3
* **Coderbus Discord:** https://discord.gg/Vh8TJp9

This is Skyrat's downstream fork of /tg/station created in byond.

**Please note that this repository contains sexually explicit content and is not suitable for those under the age of 18.**

Space Station 13 is a paranoia-laden round-based roleplaying game set against the backdrop of a nonsensical, metal death trap masquerading as a space station, with charming spritework designed to represent the sci-fi setting and its dangerous undertones. Have fun, and survive!

## Important note - TEST YOUR PULL REQUESTS

You are responsible for the testing of your content. You should not mark a pull request ready for review until you have actually tested it. If you require a separate client for testing, you can use a guest account by logging out of BYOND and connecting to your test server. Test merges are not for bug finding, they are for stress tests where local testing simply doesn't allow for this.

## DEVELOPMENT FLOWCHART
![image](https://i.imgur.com/aJnE4WT.png)

[Modularisation Guide](./modular_skyrat/readme.md)

## DOWNLOADING
[Downloading](.github/guides/DOWNLOADING.md)

[Running on the server](.github/guides/RUNNING_A_SERVER.md)

[Maps and Away Missions](.github/guides/MAPS_AND_AWAY_MISSIONS.md)

## :exclamation: How to compile :exclamation:

On **2021-01-04** we have changed the way to compile the codebase.

Find `BUILD.bat` here in the root folder of tgstation, and double click it to initiate the build. It consists of multiple steps and might take around 1-5 minutes to compile.

**The long way**. Find `bin/build.cmd` in this folder, and double click it to initiate the build. It consists of multiple steps and might take around 1-5 minutes to compile. If it closes, it means it has finished its job. You can then [setup the server](.github/guides/RUNNING_A_SERVER.md) normally by opening `tgstation.dmb` in DreamDaemon.

**Building tgstation in DreamMaker directly is now deprecated and might produce errors**, such as `'tgui.bundle.js': cannot find file`.

**[How to compile in VSCode and other build options](tools/build/README.md).**

## Contributors
[Guides for Contributors](.github/CONTRIBUTING.md)

[/tg/station HACKMD account](https://hackmd.io/@tgstation) - Design documentation here

[Interested in some starting lore?](https://github.com/tgstation/common_core)

## Current Skyrat Modules
* **IC Spawning**: https://github.com/Skyrat-SS13/Skyrat-tg/pull/104
* **Horrorform**: https://github.com/Skyrat-SS13/Skyrat-tg/pull/241
* **Blueshield**: https://github.com/Skyrat-SS13/Skyrat-tg/pull/127

## LICENSE

All code after [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.html).

All code before [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
(Including tools unless their readme specifies otherwise.)

See LICENSE and GPLv3.txt for more details.

The TGS DMAPI API is licensed as a subproject under the MIT license.

See the footer of [code/__DEFINES/tgs.dm](./code/__DEFINES/tgs.dm) and [code/modules/tgs/LICENSE](./code/modules/tgs/LICENSE) for the MIT license.

All assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](https://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.
