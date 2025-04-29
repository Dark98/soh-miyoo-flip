## Information
Ship of Harkinian was built from GitHub Actions at the [JeodC's HM64 Autobuild Factory](https://github.com/JeodC/hm64-builder).

## Installation
1. Clone/Download this Repo and move the `soh` folder into the `App` folder on your Flip's SD Card.
2. You need to provide your own roms. See the [Shipwright](https://github.com/HarbourMasters/Shipwright/blob/develop/docs/supportedHashes.json) repository for a list of supported rom hashes. Gather your roms and put them in the `App/soh` folder. Start the port, and on first run, your .otr files will be generated from the roms you provide(This will take about 5-10 minutes, the screen should freeze on launch at the "Loading" screen.). Note that only one `oot.otr` and `oot-mq.otr` will be made--if you provide more than one rom per game, strange things may occur. You *can* use pregenerated `.otr` files from elsewhere, but you may experience crashes.

Texture pack files and mods can be added to the `App/soh/mods` folder. 

## Updating
Clone/Download this Repo and move the `soh` folder into the `App` folder on your Flip's SD Card Replacing all files when asked, then delete the old `oot.otr` and/or `oot-mq.otr` files from `App/soh`. You can then follow the Installation section above skipping step 1.

## Menu Navigation
Ship of Harkinian has built-in controller navigation for the imgui menu. Press `SELECT` to open the menu and use the `D-PAD` to choose a submenu, then press `A` to switch focus to it. Press `B` to back out of a submenu.

## Default Gameplay Controls
The port uses SDL controller mapping and controls can be remapped from the imgui menu.

## Thanks
Nintendo for the game  
HarbourMasters for the native pc port  
fpasteau for the original 8.0.4 compatibility build  
beniamino for the updated build steps for develop to work on more devices  
AkerHasReawakened for the cover art  
IanSantos for the ghibli skybox mod  
Testers and Devs from the PortMaster Discord  
JeodC For The PortMaster Port



