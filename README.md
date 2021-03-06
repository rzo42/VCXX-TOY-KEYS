# VCXX-TOY-KEYS V.1.5.0
A simple playable keyboard for the Commodore Vic-20

download:[TOY KEYS.zip](https://github.com/rzo42/VCXX-TOY-KEYS/files/7140906/TOY.KEYS.zip)

A USERS GUIDE TO…
VCXX TOY KEYS
FOR THE COMMODORE VIC-20
BY: RYAN LISTON (includes VIZNUTS PWP PULSE WAVE CODE) 
2021

TARGET:
COMMODORE VIC-20

EXPANSION:
ANY OR NONE 

DESCRIPTION:
A simple playable toy keyboard with voice selection, pulse wave selection and a simple attack/release envelope.


FEATURES:
15 Voice variations
15 selectable pulse wave forms
3 octave keyboard
Attack/release envelope


*CVXX Toy Keys is tuned for true interval note values. This is tuned approx. 3/7 flat to standard western tuning but presnts more accurate space between notes.  

PACKAGE

VCXX Toy Keys is distributed as a compressed file package (VCXX TOY KEYS.zip or VCXX TOY KEYS.7z.) The package contains files for easy direct usage with Vice, Sdiec, and Tapuino. It also contains file for the user to create their own disk, tape or cart if so desired for personal use. TOY KEYS is intended as a community release. While it is intended for tape I wanted to make it easy for the user to use as they wish in whatever media they wish.

PACKAGE CONTESNTS

TOY KEYS.d64 : Disk image
TOY KEYS.tap : Tape image
tkart.prg : Cartridge loader @ $A000
tkart.bin : Rom image place @ $A000
tkart : Cartridge loader for sdiec @ $A000
toy keys.prg : Loader for disk format
tk.prg : Toy keys program @ $1200
toy keys/ts : prg files for sdiec
tape load.prg : loader for tape format
tape make.prg : Writes TS.prg to tape format
tape load/tape make : Tape writer files for sdiec
TAPE MAKE.d64 : Tape writer disk image
TOY KEYS.wav/TOY KEYS.mp3 : audio format
DEV KIT : file containing full source code and dev files.
TOY KEYS USERS GUIDE.pdf : users guide

SETUP

*VCXX Toy Keys is designed to run with any memory expansin. Do not force load. 

Disk : 	1. insert disk
		2. load “*”,8
		3. run

Tape :	1. insert tape
		2. press shift+run/stop
		3. press play on tape
		
S2diec: :	1. copy TOY KEYS and TS to a sd card
		2. insert sd into sdiec
		3. load “TOY KEYS”,8
		4. run

Cart loader : 1. load “TKART”,8,1
		2. sys 64802

Audio format : 1. record TOY KEYS.wav or TOY 						KEYS.mp3 to a cassette
 		2. (see tape)

Using the tape maker	1. load “TAPE LOAD”,8
						2. save “TOY KEYS”
						3. press play+record on tape 
						4. load “TAPE MAKE”,8
						5. run
*you will receive a syntax error. This is due to the tape maker over writing and corrupting the original basic code. This is ok. 
VOICE CONTROLS

Press return to toggle between the editor and the player.

VOLUME (VOL) : L=volume up. Shift+l=volume down.
	Volume sets the peek gain of the envelope. 15 is 	max. 0 is off.

WAVE FORM (WAV) : :=wave up. Shift+:=wave down.
	0=the Vics normal square wave. 1-15=pusle waves 	provided by Viznuts pwp pulse wave technique.			
	The selected wave form is applied across all active 	voices except for the noise channel.

VOICE (VOC) : ;=voice up. Shift+;=voice down
	VOC selects between different combonations of the 	Vics 4 voice channels
		0=all voices off
		1=bass
		2=tenor
		3=tenor+bass
		4=alto
		5=alto+bass
		6=alto+tenor
		7=alto+tenor+bass
		8=noise
		9=noise+bass
		10=noise+tenor
		11=noise+tenor+bass
		12=noise+alto
		13=noise+alto+bass
		14=noise+alto+tenor
		15=noise+alto+tenor+bass

A/R ENVELOPE

ATTACK (ATT) : ,=attack up. Shift+,=attack down (0-99)
	Attack determines the amount of time it takes for 	the volume to reach the peak gain (VOL) when a 	key is pressed.

RELEASE (REL) : .=release up. Shift+.=release down (0-99)
  	Release determines the amount of time it takes for 	the volume to reach 0 after a key is released.

The envelope does not re-trigger when a new key is pressed. If a new key is pressed the new note triggers but the envelope continues

When volume=0 and a key is pressed the attack slope is triggered. Volume increases by 1 every int(att/vol) ticks of the jiffy clock until volume=vol.  

If a key is still held down after the attack slope has ended then the note will hold at peak gain until released.

When a key is released the release slope is triggered. Volume decreases by 1 every int(rel/vol) ticks of the jiffy clock until volume=0. If a new key is pressed befor volume=0 then the attack slope will be triggered from the current volume level. 

KEYBOARD LAYOUT

	C1=Z		C#1=S		D1=X		D#1=D
	E1=C		F1=V		F#1=G		G1=B
	G#1=H		A1=N		A#1=J		B1=M
	C2=Q		C#2=2		D2=W		D#2=3
	E2=E		F2=R		F#2=5		G2=T
	G#2=6		A2=Y		A#2=7		B2=U
	C3=I		C#3=9		D3=O		D#3=0
	E3=P		F3=@		F#3=-		G3=*
	G#3=(pound)	A3=(arrow up)   A#3=(clr/home)	B3=(insert/delete)

vol=l/shift+l	wav=:/shift+:	voc=;/shift+;
att=,/shift+,	rel=./shift+.


