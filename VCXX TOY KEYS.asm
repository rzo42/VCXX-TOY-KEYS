*=$1200

;Key addresses
index_1$    = $22
index_2$    = $24
fac$        = $61
afac$       = $69
not_point   = $fc
osc_1$      = 36874
osc_2$      = 36875
osc_3$      = 36876  
osc_4$      = 36877
vol$        = 36878
bg_color$   = 36879
k_in$       = 197
vertical$   = $9001
horizontal$ = $9000     ;bit 6-0             
column$     = $9002     ;bit 6-0 default 22  
row$        = $9003     ;bit  6-1   bit 0=0   bit 7=raster
            
;Kernal calls
chrout$     = $ffd2
close$      = $ffc3
getin$      = $ffe4
load$       = $ffd5
open$       = $ffc0
plot$       = $fff0
save$       = $ffd8
scnkey$     = $ff9f
setim$     = $ffdb
rdtim$      = $ffde
            
            
;Rom calls
pr_str$     = $cb1e ;ay
pr_int$     = $ddcd ;ax
pr_fac$     = $ddd7
devide$     = $db12 ;fac=afac/fac
ldf_y$      = $d3a2 ;fac(float)=y(integer(0 to 255))
ldaf_f$     = $dc04 ;afac=fac   
lday_f$     = $d1aa            ; a/y(intger)=fac
ldf_ay$     = $d391 ;fac=a/y           
;Constants
vert$       = 16
bg$         = 14
col$        = 19
rw$         = 11*2
down$       = 17
right$      = 29
up$         = 145
left$       = 157
k_press$    = 107
kb_size$    = 649
kb_clear$   = 198
k_rpt$      = 650
mask_off=%01111111
mask_on=%11111111                                  
start       lda   #1
            sta   kb_size$
            LDA   #bg$
            sta   bg_color$   
            lda   #128
            sta   k_rpt$
            lda   row$        
            and   #129  
            ora   #rw$        
            sta   row$
            lda   vertical$   
            clc
            adc   #vert$
            sta   vertical$
            lda   #<screen    
            ldy   #>screen    
            jsr   pr_str$ 
            lda   #<screen2    
            ldy   #>screen2 
            jsr   pr_str$ 
       
;GUI
gui         LDA   #0
            sta   vol$        
            lda   #126           
            sta   osc_1$
            sta   osc_2$
            sta   osc_3$      
            sta   osc_4$
            LDY   #16
            ldx   #9        
            clc
            jsr   plot$       
            lda   #<mod_edt   
            ldy   #>mod_edt   
            jsr   pr_str$
            lda   #0          
            sta   kb_clear$
g_loop      LDX   #0
            stx   buffer_x
g_loop_1    jsr   getin$      
            sta   buffer_a    
            cmp   #13         
            bne   g_u         
;player setup
play_set    LDY   #16
            ldx   #9        
            clc
            jsr   plot$       
            lda   #<mod_lod   
            ldy   #>mod_lod   
            jsr   pr_str$                
            
            
            lda   att         
            jsr   devi            
            stx   att_g       
            lda   rel         
            jsr   devi        
            stx   rel_g
            jmp   pl_start
;gui input 
g_u         ldx   buffer_x
            lda   buffer_a    
            cmp   #0          
            beq   g_loop_1
            CMP   key_1,x     
            bne   g_d
            lda   gan,x
            cmp   max,x        
            beq   g_count
            inc   gan,x
g_jump      lda   gan,x
            sta   buffer_a
            ldy   y_,x            
            lda   x_,x        
            tax
            jmp   p_val
g_d         CMP   key_2,x
            bne   g_count
            lda   gan,x         
            beq   g_count
            dec   gan,x         
            jmp   g_jump 
g_count     ldx   buffer_x
            cpx   #4
            beq   g_loop
            inx
            stx   buffer_x
            jmp   g_loop_1

            

;value byte  er
p_val       clc
            jsr   plot$       
            lda   buffer_a
            cmp   #10
            bcs   p_val_1
            lda   #48         
            jsr   chrout$
p_val_1     ldx   buffer_a
            lda   #0          
            jsr   pr_int$
p_val_2     jmp   g_loop_1

            

devi        LDX   #0          ;a=att/rel
            cpx   gan         
            beq   exit_dev   
loop_dev    cmp   gan      
            bcs   loop_dev2   
exit_dev    rts
loop_dev2   sec
            sbc   gan      
            inx
            jmp   loop_dev       


rtrn_edit   jmp   gui
pl_start    LDA   #0
            jsr   setim$
plloop      jsr   rdtim$
            cmp   #99         
            bne   plloop
            
                 
            ldx   #0
            lda   oct         
            
v1          lsr   
            bcc   v2         
            ldy   #mask_on    
            jmp   v3
v2          ldy   #mask_off
v3          pha
            tya
            sta   mask1,x            
            pla
            inx
            cpx   #4          
            bne   v1
            
            
            ldy   #$0c         
            ldx   wav         
            lda   w_table,x
            sta   buffer_a
v4          sty   buffer_x 
            lda   mask1-$0a,y
            and   #128        
            tax
            lda   buffer_a
            
            jsr   vizwav
            ldy   buffer_x      
            dey
            cpy   #9          
            bne   v4

            LDY   #16
            ldx   #9        
            clc
            jsr   plot$       
            lda   #<mod_ply   
            ldy   #>mod_ply   
            jsr   pr_str$                
            

            

attack_0    LDY   k_in$             ;get key input @ 203
            lda   tru_int,y     ;get key note note ue
            sta   buffer_a          ;store note value in buffer_a 
            cmp   #0                ;if note value = 0...
            beq   attack_0          ;...then loop 
attack_1    cmp   #1                ;if note value != 1...
            bne   attack_2          ;...then loop
            jmp   gui               ;else exit to editor
attack_2    lda   #0                ;set jiffy low counter to 0      
            jsr   setim$            ;set jiffy
attack_3    lda   buffer_a          ;a=note value
            ldx   mask1
            axs   osc_1$
            ldx   mask2
            axs   osc_2$
            ldx   mask3
            axs   osc_3$
            ldx   mask4
            axs   osc_4$
            
            
            jsr   rdtim$            ;read the jiffy clock
            cmp   att_g             ;if jiffy >= attack/gain...
            bcc   attack_5          ;then attack_5
            lda   gan              ;else load current volume
            cmp   vol$               ;if vol >= gain...       
            beq   release_0         ;then jump to releas
            inc   vol$
            lda   #0
            jsr   setim$
             
     
attack_5    LDY   k_in$
            lda   tru_int,y
            cmp   #0          
            bne   attack_6
            jmp   release_3   
attack_6    cmp   #1          
            bne   attack_7    
            jmp   gui         
attack_7    jmp   attack_3

release_0   LDY   k_in$
            lda   tru_int,y
            cmp   #0          
            beq   release_3
release_1   cmp   #1          
            bne   release_2    
            jmp   gui         
release_2   ldx   mask1
            axs   osc_1$
            ldx   mask2
            axs   osc_2$
            ldx   mask3
            axs   osc_3$
            ldx   mask4
            axs   osc_4$
            jmp   release_0
release_3   lda   #0    
            jsr   setim$
release_4   jsr   rdtim$      
            cmp   rel_g       
            bcc   release_5
            lda   vol$
            cmp   #0
            bne   release_4_b
            jmp   attack_0
release_4_b dec   vol$        
            lda   #0          
            JSR   setim$
release_5   LDY   k_in$
            lda   tru_int,y
            cmp   #0          
            beq   release_4
            jmp   attack_0



     

        
;      " VIZNUTS WAVEFORMS "
;       By               :      Ryan Liston
;       Original code by :      "Viznut"
;       Description      :      pulse wave form generator
;       Target           :      Commodore Vic-20
;----------------------------------------------------
;
;-initalize a,x,y befor calling
;-a=wave form
;-x=initial frequency
;-y=channel

;controls
start_address = $a400          ;start address
temp_1        = $fe           ;(temp storage for the a registor(shift registor))
temp_2        = $ff           ;(temp storage for the y registor (channel))


;-------------------------------------------------------------------------------

;*           = start_address

;-------------------------------------------------------------------------------
vizwav      sei
            STX   init_freq   ;3/4    alters the value on the
                              ;init_freq=$87          ;       initial frequency in
                              ;       line  xxxx
            sty   ch_0        ;3/4    alters memory at ch_0
                              ;ch0=$0c
            sty   ch_1        ;3/4    an ch_1 to set voice channel
                              ;ch1=$0c
            ldx   fq_mask-$a,y;3/4    loads frequency mask for voice
                              ;x=$fb(%11111011)
            sta   temp_1      ;2/3    stores the shift register in
                              ;temp_1=$fb(%11111011)  ;       temp_1
            ora   #$7f        ;2/2    ors a with #$7f(%01111111)
                              ;%11111011 or %01111111 = %11111111($ff)
                              ;a=%11111111($ff)
            axs   $900c       ;3/4     ands a with bit mask stores at $900c
ch_0        = *-2             ;%11111111 and %11111011 = %11111011
                              ;$900c=%11111011($fb)
            sty   temp_2      ;2/3    stores y(channel) at temp_2
                              ;temp_2=$0c
            ldy   #$07        ;2/2    loads y with 7
                              ;y = 7
io          LDA   #$7f        ;2/2    loads a with $7f
                              ;a=$7f
            aso   temp_1      ;2/5    a=(temp_1<<1)or $7f
                              ;pass 1: (y=7)  (%11111011<<1) = %11110110
                              ;%11110110 or %01111111 = %11111111($ff)
                              ;a = %11111111($ff)
                              ;pass 2; (y=6)  (%11110110<<1) = %11101100
                              ;%11101100 or %01111111 = %11111111($ff)
                              ;a = %11111111($ff)
                              ;pass 3; (y=5)  (%11101100<<1) = %11011000
                              ;%11011000 or %01111111 = %11111111($ff)
                              ;a = %11111111($ff)
                              ;pass 4; (y=4)  (%11011000<<1) = %10110000
                              ;%10110000 or %01111111 = %11111111($ff)
                              ;a = %11111111($ff)
                              ;pass 5; (y=3)  (%10110000<<1) = %01100000
                              ;%01100000 or %01111111 = %01111111($ff)
                              ;a = %01111111($7f)
                              ;pass 6; (y=2)  (%01100000<<1) = %11000000
                              ;%11000000 or %01111111 = %11111111($ff)
                              ;a = %01111111($ff)
                              ;pass 7; (y=1)  (%11000000<<1) = %10000000
                              ;%10000000 or %01111111 = %11111111($ff)
                              ;a = %11111111($ff)
            axs   $900c       ;3/4    ands a with bit mask stores at $900c
ch_1        = *-2
                              ;pass 1: (y=7)  %11111111 and %11111011 = %11111011
                              ;$900c=%11111011($fb)
                              ;pass 2: (y=6)  %11111111 and %11111011 = %11111011
                              ;$900c=%11111011($fb)
                              ;pass 3: (y=5)  %11111111 and %11111011 = %11111011
                              ;$900c=%11111011($fb)
                              ;pass 4: (y=4)  %11111111 and %11111011 = %11111011
                              ;$900c=%11111011($fb)
                              ;pass 5: (y=3)  %01111111 and %11111h11 = %01111011
                              ;$900c=%01111011($fb)
                              ;pass 6: (y=2)  %11111111 and %11111011 = %11111011
                              ;$900c=%11111011($fb)
                              ;pass 7: (y=1)  %11111111 and %11111011 = %11111011
                              ;$900c=%11111011($fb)
            dey               ;1/2    y=y-1
                              ;pass 1:(y=7)   y=6
                              ;pass 2:(y=6)   y=5
                              ;pass 3:(y=5)   y=4
                              ;pass 4:(y=4)   y=3
                              ;pass 5:(y=3)   y=2
                              ;pass 6:(y=2)   y=1
                              ;pass 7:(y=1)   y=0
            bne   io          ;2/3    if not y=0 then branch to i0
                              ;       else continue
                              ;pass 1;(y=6)   branch to io
                              ;pass 2;(y=5)   branch to io
                              ;pass 3;(y=4)   branch to io
                              ;pass 4;(y=3)   branch to io
                              ;pass 5;(y=2)   branch to io
                              ;pass 6;(y=1)   branch to io
                              ;pass 7;(y=0)   continue
            lda   #128        ;2/2    loads a with the initial frequency
                              ;a=$87
init_freq   = *-1
            nop               ;1/2    burns 2 cycles
                              ; no opperation
            ldy   temp_2      ;2/3    loads y with channel index stored
                              ;y=$0c                          at temp_2
no_set      STA   $9000,y     ;3/5    stores initial freaquency to $9000+y
            cli                  ;$900c=$87
            rts               ; exit routine
fq_mask     = *
v_0a        byte  $fd     ;low voice bit mask %11111101
v_0b        byte  $fe     ;mid voice bit mask %11111110
v_0c        byte  $fb     ;hi voice bit mask %11111011
            
screen      byte "{clear}{cyan}{176}{96}{96}{96}{96}{96}{96}{178}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{174}"
            byte "{125}{white}l{yellow}vol{red}07{cyan}{125}vcxx toy keys{125}"
            byte "{125}{white}:{yellow}wav{red}11{cyan}{171}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{179}"
            byte "{125}{white}{59}{yellow}voc{red}06{cyan}{125}{white},{yellow}atk{red}14 {white}.{yellow}rel{red}56{cyan}{125}"
            byte  "{171}{96}{96}{96}{96}{96}{96}{177}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{179}"
            byte  0
screen2     byte "{125}{reverse on}{white}{163}{reverse off}2{reverse on}{163}{reverse off}3{reverse on}{163}O{reverse off}5{reverse on}{163}{reverse off}6{reverse on}{163}{reverse off}7{reverse on}{163}O{reverse off}9{reverse on}{163}{reverse off}0{reverse on}{163}O{reverse off}-{reverse on}{163}{reverse off}{cyan}{125}"
            byte "{125}{reverse on}{white}q{125}w{125}er{125}t{125}y{125}ui{125}o{125}p@{125}*{reverse off}{cyan}{125}"
            byte "{171}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{178}{178}{96}{96}{96}{96}{96}{96}{179}" 
            byte "{125}{reverse on}{white}{163}{reverse off}s{reverse on}{163}{reverse off}d{reverse on}{163}O{reverse off}g{reverse on}{163}{reverse off}h{reverse on}{163}{reverse off}j{reverse on}{163}{reverse off}{cyan}{125}{125}{white}return{cyan}{125}"
            byte "{125}{reverse on}{white}z{125}x{125}cv{125}b{125}n{125}m{reverse off}{cyan}{125}{125} {red}edit {cyan}{125}"
            byte "{173}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{96}{177}{177}{96}{96}{96}{96}{96}{96}{189}{red}"
            byte  0


            


gan         byte  7
wav         byte  11
oct         byte  6
att         byte  14
rel         byte  56      
            
mask1       byte  0
mask2       byte  0
mask3       byte  0
mask4       byte  0
            

y_          byte  5,5,5,12,19                  
x_          byte  1,2,3,3,3
key_1       byte  "l:{59},."
key_2       byte  "L[]<>"      
max         byte  15,15,15,99,99
            
w_table     byte  0,2,4,6,8,10,12,14,18,20,22,24,26,36,42,44
            

tru_int     byte  000,201,210,219,225,000,235,239,000,198,207,217,223,230,234,001
            byte  000,000,147,164,183,000,000,000,000,000,141,159,179,000,000,000
            byte  000,255,153,170,187,000,000,000,000,134,000,174,000,000,000,000
            byte  191,204,212,221,226,231,236,000,195,000,215,000,228,232,238,000
            byte  000

mod_ply     byte  "play",0
mod_edt     byte  "edit",0
mod_lod     byte  "load",0            

att_g       byte  0
rel_g       byte  0     
buffer_a    byte  0
buffer_x    byte  0
