//Samarth Naik
        .text
        .global calculate_scale
        
calculate_scale:
        stp x29, x30, [sp, #-16]!
        mov x29, sp

        mov x3, x0 //mov max to x3
        mov x4, x1 // mov min to x4
        mov x5, x2 // mov numAsciiChars to x5

        sub x6, x5, #1 //numAsciiChars - 1
        sub x7, x3, x4 //max - min

        lsl x6, x6, #16 //shifting number to left by 16 bits

        udiv x8, x6, x7 

        mov x0, x8

        /*
        sub x2, x2, #1  //numAsciiChars - 1
        sub x0, x0, x1  //max - min
        sdiv x0, x2, x0 //signed division*/

        ldp x29, x30, [sp], #16
        ret
