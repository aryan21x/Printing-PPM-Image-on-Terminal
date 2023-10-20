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
        stp     x29, x30, [sp,#-16]!            // fp and lr 
        stp     x27, x28, [sp,#-16]!            // asc and image
        stp     x25, x26, [sp,#-16]!            // contrast and len(asc)
        stp     x23, x24, [sp,#-16]!            // asc and min
        stp     x21, x22, [sp,#-16]!            // stored image, scaling
        stp     x19, x20, [sp,#-16]!            // i and j

        mov     x28, x0                         // mov the image to a non volatile register
        mov     x27, x2                         // mov the string asc in non volatile register
        mov     x25, x1                         // mov the contrast to a non volatile register

        ldr     x21, [x28]                      // store the image in non volatile register
        mov     x23, x27                        // mov the asc to x27
        mov     x26, #0                         // set count = 0

count_asc:
        ldrb    w0, [x23], #1;
        cmp     w0, #0
        beq     count_done
        add     x26, x26, #1
        b       count_asc

count_done:

        cmp     x25, #0
        bne     contrast_apply

        mov     x0, #0
        mov     x1, #255                        
        mov     x2, x26                         // mov length to x2 register

        bl      calculate_scale
        mov     x22, x0                         // store the 's' value in non volatile register
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

        mov     x0, x10                          // mov the max value to parameter 1 
        mov     x1, x9                          // mov the min value to parameter 2
        mov     x2, x26                         // mov the lengh of asc to parameter 3

        bl      calculate_scale
        mov     x22, x0                         // store the 's' value in non volatile register

        mov     x19, #0                          // i = 0

i_loop:
        ldr     w9, [x28, #height]              // num of rows (i max)
        ldr     w5, [x28, #width]               // num of columns (j max)

        mov     x20, #0                          // j = 0
        ldr     x10, [x21, x19, lsl #3]          // load x10 with appropriate row

        cmp     x19, x9                          // compare rows withs i max
        blt     j_loop

        ldp     x19, x20, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x29, x30, [sp], #16
        ret

j_loop:
        cmp     x20, x5
        bge     increament_i

        ldrb    w8, [x10], #1                   // load a pixel from row and increament

        sub     x11, x8 , x24                   // x11 contains ( g - min )
        mul     x11, x22, x11                   // x11 contains s *(g - min)

        mov     x1, #1                          
        lsl     x1, x1, #15                     // shifting one to the half bit (x1 is 32 bits)
        add     x0, x11, x1
        lsr     x0, x0, #16                     // truncating the result to remove fractional bits

        // asc is in x23

        ldr     w15, [x23, x0]                  // load w15 with asc[i] where i is x0
        mov     w1, w15
        mov     w2, w15
        mov     w3, w15                         // since ascii char is 3 times as tall than wide

        ldr     x0, =output                     
        bl      printf                          // printing on screen

        add     x20, x20, #1                      // increament j
        b       j_loop

increament_i:
        add     x19, x19 , #1
        b       i_loop


