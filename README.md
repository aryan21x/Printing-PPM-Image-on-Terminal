PRINT PPM IMAGE ON TERMINAL
<br>
Languages -- Arm Assembly 64-bit and C
<br>
Build -- make
<br>
Run -- ./asciiart image.ppm [optional]

Program takes a ppm image as input and prints it on the terminalu using a string of character
(" ‘^\",:;Il!i~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$). Several modes can be 
applied to the image, namely contrast, inversion or both. The program is written in two languages
,Unix Assembly 64-bit and C. Use Ctrl-Z to resize the terminal so that image can resized accordingly.
Command mogrify -format ppm -resize 256x256 sample.png can be used to convert png images to ppm
so that they can displayed on the terminal.
