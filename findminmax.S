// belongs to Aryan

// function prototype void find_min_max(grayimage *img, graypixel *min, graypixel *max);

        .data
        .equ    rows,   0
        .equ    width,  8                   // size of graypixel **rows
        .equ    height, 12
        .equ    size,   16

        .text
        .global     find_min_max
find_min_max:
        stp     x29, x30, [sp,#-16]!         // store the fp and lr on stack
        stp     x27, x28, [sp,#-16]!
        stp     x25, x26, [sp,#-16]!

        mov     x27, x0                     // copy the image in non volatile register x27
        ldr     w3, [x27, #height]          // i max in w3
        ldr     w5, [x27, #width]           // width j max

        ldr     x28, [x27]                  // x28 now contains grayimage

        mov     x25, #255                   // temp to hold min
        mov     x26, #0                   // temp to hold max

        mov     x6, #0                      // i = 0
i_loop:
        mov     x7, #0                      // j = 0
        ldr     x10, [x28, x6, lsl#3 ]      // load x10 with the appropriate row 
        cmp     x6, x3                      // if i has reached max
        blt     j_loop

        str     x25, [x1]                 
        str     x26, [x2]
     
        ldp     x25, x26, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x29, x30, [sp], #16          // restore the fp and lr
        ret 

j_loop:
        cmp     x7, x5
        bge     i_increament                 // when all the columns are checked

        ldrb     w8, [x10], #1               // load a  pixel from row and increament 

        cmp     x8, x25
        csel    x25, x8, x25,lt              // comparing if current is less than min

        cmp     x8, x26
        csel    x26, x8, x26,gt              // comparing if curr is greater than max

        add     x7, x7, #1                   // j++
        b       j_loop

i_increament:
        add     x6, x6,#1
        b       i_loop





