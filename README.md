# music-collection

## Music Manager class

`MusicManager` is set up for very read heavy actions which is why I index everything, sticking to O(1) access across the board. Played and Unplayed are sets since we aren't keeping track of anything about the number of plays, just the state. This layer is meant to be pretty simple returning bools for "What you wanted to happen happened or did not happen.". 


## Music Input class

`MusicInput` could probably be named MusicInputOutput as it translates the bools from MusicManager to a human readable message as well as validating any input. The "view" layer if you will handling the displaying of records, help message, etc...


## Music Collection Runner

`MusicCollectionRunner` handles the specific intro and outro messages as well as the input loop.


## Music Viewer

`MusicViewer` handles the formatting of the output of music records.
