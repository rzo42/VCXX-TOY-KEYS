# VCXX-TOY-KEYS
A simple playable keyboard for the Commodore Vic-20

AUTHOR:RYAN LISTON (includes VIZNUTS PWP PULSE WAVE CODE)
DATE:Sept/4/2021
TARGET:COMODORE VIC-20
EXPANSION: ANY including unexpanded 

FEATURES:
4 playable voices
15 selectable pulse wave forms
3 octave keyboard
attack/release envelope

DIRECTIONS:

TO START load "toy keys",8 or load "*",8. do not load with ,8,1. 

RETURN toggles between edit and play mode	

EDIT CONTROLS:

VOLUME (VOL) L/shift+L to set. volume sets the peak gain level (0 to 15)
	
WAVE (WAV) :/shift+: to set. wave sets the wave form of the selected 	voice (0 to 15). wav does not effect the noise channel.
	
VOICE (VOC) ;/shift+: to set. sets the voice channel (0 to 3) 
	toy keys only plays 1 voice at a time
	0=bass	1=tenor	2=alto	3=noise
	
ATTACK (ATK) ,/shift+, to set (0 to 99). attack sets the attack length.

RELEASE (REL) ./shift+. to set (0 to 99). release sets the release 	length.
 	
PLAY CONTROLS:

KEYBOARD LAYOUT

	C1=Z		C#1=S		D1=X		D#1=D
	E1=C		F1=V		F#1=G		G1=B
	G#1=H		A1=N		A#1=J		B1=M
	C2=Q		C#2=2		D2=W		D#2=3
	E2=E		F2=R		F#2=5		G2=T
	G#2=6		A2=Y		A#2=7		B2=U
	C3=I		C#3=9		D3=O		D#3=0
	E3=P		F3=@		F#3=-		G3=*
	G#3=(pound)	A3=(arrow up)	A#3=(clr/home)	B3=(insert/delete)
	
ATTACK/RELEASE ENVELEOPE
	
the attack phase is triggered when a new key is pressed while the note is off or during the release phase. 
  the attack phase begins at the current volume level (0 if the note is off) and increases the volume by 
  one every (atk/vol) ticks  of the jiffy clock until the volume=gain(vol) 
  
once volume=gain the note will hold until released. 
  a new key will trigger a new note but will not retrigger the attack phase.
	
the release phase is triggered when a key is released and no other keys are pressed. the release phase begins at the current volume 
  and decreases the volume by 1 every (rel/vol) ticks of the jiffy clock until the volume=0

