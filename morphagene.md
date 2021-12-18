# make noise morphagene

* leveling: hold `rec`; press `shift` to toggle between gain settings
    * blue: -3 dB
    * green: eurorack level
    * orange: +6 dB
    * purple: +12 dB
* reel mode: hold `splice`; press `rec` to enter and exit
    * `organize` navigates between reels; new reel is full clockwise
* splices:
    * `rec` records into splice as per config
    * `rec` + `splice` provides alernate functionality as per above
    * `splice` creates a new splice marker at current location
    * `shift` will increment forward one slice
    * `shift` + `splice` will delete current splice marker
        * hold for 3 seconds to delete all splices
        * will not work if clock is patched into `play`
    * `shift` + `rec` will delete audio inside current splice
        * hold for 3 seconds to clear entire reel of audio and splices
        * will not work if clock is patched into `play`

*current options.txt configuration with added formatting:*
```
//
// firmware version 203
//
// 0 option is default
vsop 1 ///Varispeed option:
    0 bidirectional classic,
    1 bidirectional 1 v/oct,
    2 positive only - 1 v/oct.
inop 0 //Input option:
    0 record SOS mix,
    1 record input only
pmin 1 //Phase/position modulation:
    0 no phase modulation,
    1 phase playback modulation on right signal input when no signal on left input
omod 0 //Organize option:
    0 organize at end of gene,
    1 organize immediately
gnsm 1 //Gene smooth:
    0 classic,
    1 smooth gene window
rsop 0 //Record option:
    0 record + splice = record new splice, record = record current splice;
    1 record + splice = record current splice, record = record new splice
pmod 0 //Play option:
    0 classic,
    1 momentary,
    2 trigger loop
ckop 0 //Clock control option:
    0 hybrid gene shift time stretch,
    1 gene shift only,
    2 time stretch only
cvop 0 //CV out:
    0 envelope follow,
    1 ramp gene
mcr1 1.25992 //Morph Chord Ratio: 0.06250 to 16.00000, negative is reverse
mcr2 1.49830 //Morph Chord Ratio: 0.06250 to 16.00000, negative is reverse
mcr3 2.00000 //Morph Chord Ratio: 0.06250 to 16.00000, negative is reverse
//
//Default Chord: 2.0, 1.5, 1.33333
//
//Ratio Table - Equal Temperament
//1.00000: Unison
//1.05946: minor 2nd
//1.12246: Major 2nd
//1.18920: minor 3rd
//1.25992: Major 3rd
//1.33484: Perfect 4th
//1.41421: Tritone
//1.49830: Perfect 5th
//1.58740: minor 6th
//1.68179: Major 6th
//1.78179: minor 7th
//1.88774: Major 7th
//2.00000: Octave
//Multiply these numbers by 2, 4 or 8 for higher octaves, divide for lower octaves.
```
