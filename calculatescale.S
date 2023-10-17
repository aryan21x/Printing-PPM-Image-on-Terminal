//Samarth Naik
        .text
        .global calculate_scale
        
calculate_scale:
        stp x29, x30, [sp, #-16]!
        mov x29, sp

        ldr x0, [x0] //max 
        ldr x1, [x1] //min 
        ldr x2, [x2] //numAsciiChars

        sub x2, x2, #1  //numAsciiChars - 1
        sub x0, x0, x1  //max - min
        sdiv x0, x2, x0 //signed division

        ldp x29, x30, [sp], #16
        ret
