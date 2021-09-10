*=664

setlfs$=$ffba
setnam$=$$ffbd
load$=$ffd5           
save$=$ffd8


start       lda   #$00        
            sta   $fb         
            lda   #$10
            sta   $fc         
            lda   #$fb        
            ldx   #$ff
            ldy   #$10        
            jsr   save$

            lda   #1
            ldx   #8          
            tay   
            jsr   setlfs$
            lda   #2          
            ldx   #<file_     
            ldy   #>file_     
            jsr   setnam$     
            lda   #0       
            jsr   load$       
            
            lda   #1
            tax
            tay
            jsr   setlfs$
            lda   #2
            ldx   #<file_     
            ldy   #>file_     
            jsr   setnam$   
            lda   #$00        
            sta   $fb         
            lda   #$12
            sta   $fc         
            lda   #$fb        
            ldx   #$ff
            ldy   #$15        
            jsr   save$       
            rts
;jmp   $1200
file_       byte  "tk"
            