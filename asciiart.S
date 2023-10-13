// belongs to Aryan

// function prototype void ascii_art(grayimage *img, int contrast, char* asc);

.global     ascii_art

ascii_art:
        stp x29, x30, [sp,#-16]!

        ldp x29, x30, [sp], #16

