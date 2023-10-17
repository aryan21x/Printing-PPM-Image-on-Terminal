// belongs to Aryan

// function prototype void ascii_art(grayimage *img, int contrast, char* asc);

        .data
        .equ    rows,   0
        .equ    width,  8                   // size of graypixel **rows
        .equ    height, 12
        .equ    size,   16

str:    .asciz          ""
output: .asciz          "%c%c%c"                       

        .text
        .global         ascii_art

ascii_art:
        stp     x29, x30, [sp,#-16]!
        stp     x27, x28, [sp,#-16]!
        stp     x25, x26, [sp,#-16]!
        stp     x23, x24, [sp,#-16]!

        mov     x28, x0                         // mov the image to a non volatile register
        mov     x27, x2                         // mov the string asc in non volatile register
        mov     x25, x1                         // mov the contrast to a non volatile register

copy_asc:
        adr     x23, str                        // load address of str in a non volatile register
        ldrb    w3, [x27],#1
        strb    w3, [x23],#1                    // store asc in str
        cbz     w3, copy_done

copy_done:
        adr     x0, str                         // load asc from str
        bl      strlen
        mov     x26, x0                         // mov the lengh to non volatile register

        cmp     x25, #0
        bne     contrast_apply

        mov     x0, #0
        mov     x1, #255                        
        mov     x2, x26                         // mov length to x2 register

        bl      calculate_scale
        mov     x24, #0                         // value to be passed as min

        b       i_loop

contrast_apply:

        mov     x0, x28                         // mov image to parameter 1
        mov     x1, #0
        mov     x2, #0

        bl      find_min_max
        mov     x9, x1                          // move min pixel value to x9
        mov     x10, x2                         // mov the max pixel value to x10

        mov     x24, x9                         // store min in non volatile register

        mov     x0, x2                          // mov the max value to parameter 1 
        mov     x1, x1                          // mov the min value to parameter 2
        mov     x2, x26                         // mov the lengh of asc to parameter 3

        bl      calculate_scale

        ldr     w3, [x28, #height]              // num of rows (i max)
        ldr     w5, [x28, #width]               // num of columns (j max)

        mov     x6, #0                          // i = 0

i_loop:
        mov     x7, #0                          // j = 0
        ldr     x10, [x28, x6, lsl #3]          // load w10 with appropriate row

        cmp     x6, x3                          // compare rows withs i max

        // code to be added

        blt     j_loop

        ldp     x23, x24, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

j_loop:
        cmp     x7, x5
        bge     increament_i

        ldrb    w8, [x10], #1                   // load a pixel from row and increament

        // code to be added
        add     x7, x7, #1
        b       j_loop

increament_i:
        add     x6, x6 , #1
        b       i_loop


