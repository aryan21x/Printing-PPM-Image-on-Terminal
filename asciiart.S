// belongs to Aryan

// function prototype void ascii_art(grayimage *img, int contrast, char* asc);

        .data 
        str:    .asciz              

        .text
        .global     ascii_art

ascii_art:
        stp     x29, x30, [sp,#-16]!
        stp     x27, x28, [sp,#-16]!
        stp     x25, x26, [sp,#-16]!

        mov     x28, x0                         // mov the image to a non volatile register
        mov     x27, x2                         // mov the string asc in non volatile register
        mov     x25, x1                         // mov the contrast to a non volatile register

        str     x25, [x0]  
        bl      strlen
        mov     x26, x0                         // mov the lengh to non volatile register

        cmp     x25, #0
        bne     contrast_apply

        mov     x0, #0
        mov     x1, #255                        
        mov     x2, x26                         // mov length to x2 register

        bl      calculate_scale

contrast_apply:

        mov     x0, x28                        // mov image to parameter 1
        mov     x1, #0
        mov     x2, #0

        bl      find_min_max
        mov     x9, x1                         // move min pixel value to x9
        mov     x10, x2                        // mov the max pixel value to x10

        mov     x0, x2
        mov     x1, x1
        mov     x2, x26


        ldp     x25, x26, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x29, x30, [sp], #16
        ret



