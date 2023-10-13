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
        ldr     x3, [x27, #rows]            // load the address of rows in x3
        ldr     x5, [x27, #width]           // width

        ldr     x28, [x27]                  // x28 now contains grayimage

        mov     x25, #0                     // temp to hold min
        mov     x26, #0                     // temp to hold max

        mov     x6, #0                      // i = 0
i_loop:
        mov     x7, #0                      // j = 0
        ldr     x10, [x28, x6, lsl#3 ]      // load x10 with the appropriate row 
        cmp     x6, x3                      // if i has reached max
        blt     j_loop

        mov     x1, x25                     
        mov     x2, x26
        ldp     x25, x26, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x29, x30, [sp], #16          // restore the fp and lr
        ret 

j_loop:
        cmp     x7, x5
        bge     i_increament                 // when all the columns are checked

        ldrb     w8, [x10], #1               // load a value from row and increament column
              
        csel    x25, x25, x8,lt              // comparing if current is less than min
        csel    x26, x26, x8,gt              // comparing if curr is greater than max
        add     x7, x7, #1                   // j++
        b       j_loop

i_increament:
        add     x6, x6,#1
        b       i_loop




