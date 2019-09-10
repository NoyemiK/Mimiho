# Mimiho

A grand extension of the java port of *Pimiko* that features gamestates, items, creature variety, spells, and new weapons all wrapped up in a graphical interface with tile-based presentation instead of the original text-only.

![alt text](https://i.imgur.com/gHLgmRw.png "Game Start")
![alt text](https://i.imgur.com/oKEZhlY.png "Kekolu is all alone here.")

## Features

*As of the current commit, the code is still a work in progress. Many things are subject to change very quickly!*

**The current Master is NOT yet feature complete!**

### Technical

- Gamestate framework
- PC-98 style display resolution of 640x400 and palette assigned from 12-bit colourspace (4bit r, g, and b)
- 20x20 tile and spriteset size
- mp3 music

### Gameplay

- Choice of two player characters, Amihailu and Kekolu
- Persistent data and savegames (a feature from the original *Pimiko* that did not make it into the Processing port)
- Melee and Ranged weaponry
- Keyboard-based controls: *Arrow keys for movement, `A` for a melee attack, `S` for a ranged attack (if available), `Z` to confirm or perform an action, `X` to cancel or bring up the in-game menu*

`This section is a stub. As features are completed, this section will be updated.`

### TODO

- Stat and skill tables for simple player character progression
- Opposition! A full set of basic enemies with different patterns (and stronger variants for later dungeons)
- Maploader and map assembly functions (mostly handmade with procedural combinations)
- Assignable upgrades much like the original *Pimiko*, but with a better interface
