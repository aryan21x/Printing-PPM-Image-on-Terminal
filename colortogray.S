//Samarth Naik.
        .data
        .equ row, 0
		.equ width, 8
		.equ height, 12

        .text
        .global   color_to_gray
        
color_to_gray:  
        stp x29, x30, [sp, #-16]!
		stp x25, x26, [sp, #-16]!
		stp x21, x22, [sp, #-16]!
		mov x25, x0							// mov image to non volatile register
        mov x26, x1 						// inversion check

		ldr w1, [x25, height]				// load max rows
		ldr w0, [x25, width]				// load max columns

		bl allocate_grayimage
		mov x26, x0							// mov allocated image to non volatile register
        mov w3, #0
		ldr w14, [x25, height]
		ldr w15, [x25, width]

		ldr x21, [x25]						// load image in non volatile register
		ldr x22, [x26]						// load allocate_grayimage to non volatile register

loop1:
		mov w4, #0							// i = 0
		ldr x7, [x21, x3 , lsl #3] 			// load adress of row from image
	    ldr x10, [x22, x3, lsl #3]			// load adress of row from allocate_grayimage 

	    cmp x3, x14							// check if i max is reached
	    blt loop2

		mov x0, x26							// return grayimage
		ldp x21, x22, [sp], #16
		ldp x25, x26, [sp], #16
		ldp x29, x30, [sp], #16
		ret


loop2: 
		cmp x4, x15
		bge i_increament					// if j max is reached increament i

		ldrb w0, [x7], #1					// load rgb pixels
		ldrb w1, [x7], #1
		ldrb w2, [x7], #1 

		mov x12, #54						// appropriate calculation to convert to graypixel
		mul x0, x0, x12
        mov x12, #184
		mul x1, x1, x12
		mov x12, #18
		mul x2, x2, x12

		add x9, x0, x1
		add x9, x9, x2
 
		lsr x9, x9, #8
        cmp x26, #0							// check if inversion is supplied
        beq no_inv		

        b inversion							

no_inv:
		strb w9, [x10, x4]					// store without inversion
        add x4, x4, #1
		b loop2

inversion:
		mov x15, #255
		sub  x9 , x15, x9					// invert all pixels and then store
        strb w9, [x10, x4]
        add x4, x4, #1
		b loop2

i_increament: 
		add x3, x3, #1						// increament i
		b loop1
