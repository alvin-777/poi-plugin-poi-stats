# poi-stats
A plugin for the scalable KanColle browser [Poi](https://github.com/poooi/poi).
Shows drop statistics gathered by Poi in a new window.
![image](https://cloud.githubusercontent.com/assets/13615512/12034488/3f26ade8-ae7d-11e5-80ac-e60dbe7805f9.png)
![image](https://cloud.githubusercontent.com/assets/13615512/12034499/5c5313e8-ae7d-11e5-8b12-3e53106fda9b.png)
![image](https://cloud.githubusercontent.com/assets/13615512/12034523/afd65732-ae7d-11e5-9230-f120bb7c541a.png)

### Usage
Use plugin config in Poi to install this plugin.

![image](https://cloud.githubusercontent.com/assets/13615512/12079140/f67bf264-b279-11e5-927f-58e63b075e1c.png)
- In Poi Settings => Plugin Config => Advanced
- Enter `poi-plugin-poi-stats`, then click `INSTALL`
- (You may need to select a reachable npm server)

### Change Log

#### v2.0.1
* Added instructions to install the plugin through poi plugin config

#### v2.0.0
* Compatible with Poi v5.0.0 or newer
* Electron v0.36.1
* Node v5.1.1
* React v0.14
* Using absolute paths
* Using i18n-2
* Removed "Copy To Clipboard" button
* Added an "Open in Browser" button
* Refactored a lot of code
* Removed bunches of warnings
* Bug fixes
* Will publish to npm since this version

#### v1.2.0
* Fixed i18n
* Rewrote how it saves the window position & size
* Added package.json

#### v1.1.2
* Minor bug fix

#### v1.1.1
* Minor bug fix

#### v1.1.0
* New button features
  * Right-click on Zoom button will reset the window size and position.
  * New Hide button.

#### v1.0.1
* Removed a label (which didn't work, and wouldn't look good if it worked...). Use plain text instead.

#### v1.0.0
* First major version.
* Lots of improvements. Almost rewrote everything.
* 3 new buttons: Zoom, Full Screen and Copy to clipboard.

#### v0.2.0
* Minor improvements.
* Remembers window position and size.
* Only one window can be opened.
* Removed unused code.

#### v0.1.0
* First working version.
