# Title: Lobby screens!

MODULE ID: lobbyscreen

## Description:

Adds a brand new look to the lobby screen, adds a splash screen too, since that shit is awesome. Inspired by TauCeti, heavily modified by me.

## Guide:

To make sure your server doesn't/does have this feature, see config.txt
##Enable server swapping, uncomment to enable reading of swap_ips.txt (file directory: config/skyrat/swap_ips.txt)
SERVER_SWAP_ENABLED
if you use this, make sure swap_ips.txt is present in skyrat config.

We offer the option to customise the lobby HTML by giving you access to a file named lobby_html.txt in the config. The server will runtime if this file does not exist. Ensure it exists in directory config/skyrat/lobby_html.txt.

DO NOT UNDER ANY CIRCUMSTANCES RENAME THE ELEMENTS WITHIN THE HTML FILE, KEEP THEM AS THEY ARE.

Elements:
.bg - the background image
.container_terminal - This is the startup terminal html, generally, don't change this unless you want a cooler startup terminal.
.terminal_text - Terminal text
.container_progress - This is the container for the progress bar. Changing this likely involves changing the .container_terminal.
.progress_bar - The moving part of the progress bar. Must start at 0% width; the body script updates the width live.
.fade_out - Generic class that fades content out. Currently applied to .container_progress when the progress bar overruns 100%.
.container_nav - This is the main menu container box, it defines where the menu is, and what it looks like.
.menu_button - The "buttons" for the main menu(join, observe, etc).
.menu_button:hover - The animation for hovering over buttons.
.menu_newpoll - This is the new polls text, so players attention is brought to it, flashes in and out with @ pollsmove animation.
.container_notice - This is the admin notice container for when an admin sets the title notice. This button is under fun in the admin tab.
.menu_notice - Admin notice text.
.unchecked - Unchecked ☒ box.
.checked - Checked ☑ box.
REMEMBER, DO NOT EDIT THESE ELEMENT NAMES ELSE THE LOBBYSCREEN WILL BREAK.

## Credits:
Gandalf2k15 & TauCeti
