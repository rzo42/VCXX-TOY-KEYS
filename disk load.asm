*=664
setlfs$=$ffba
setnam$     = $$ffbd
load$=$ffd5           
start       lda   #1
            ldx   #8          
            ldy   #1
            jsr   setlfs$
            lda   #2          
            ldx   #<file_     
            ldy   #>file_     
            jsr   setnam$     
            lda   #0       
            jsr   load$       
            jmp   $1200
file_   byte "tk"