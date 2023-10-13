// belongs to Aryan

// function prototype void ascii_art(grayimage *img, int contrast, char* asc);

.global     ascii_art

ascii_art:
        stp     x29, x30, [sp,#-16]!
        stp     x27, x28, [sp,#-16]!
        stp     x25, x26, [sp,#-16]!

        mov     x28, x0                         // mov the image to a non volatile register
        mov     x27, x2                         // mov the string asc in non volatile register
        mov     x25, x1                         // mov the contrast to a non volatile register

        adr     x0, x2
        bl      strlen
        mov     x25, x0                         // mov the lengh to non volatile register

        cmp     x25, #0
        bne     contrast_apply

        

        ldp     x25, x26, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

contrast_apply:

