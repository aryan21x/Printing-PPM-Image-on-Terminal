//Samarth Naik
        .text
        .global calculate_scale

// unsigned int calculate_scale(graypixel max, graypixel min, int numAsciiChars);

calculate_scale:
        stp x29, x30, [sp, #-16]!

        mov x3, x0 //mov max to x3
        mov x4, x1 // mov min to x4
        mov x5, x2 // mov numAsciiChars to x5

        sub x6, x5, #1 //numAsciiChars - 1
        sub x7, x3, x4 //max - min

        lsl x6, x6, #16 //shifting numerator to left by 16 bits

        udiv x8, x6, x7 

        mov x0, x8

        ldp x29, x30, [sp], #16
        ret
