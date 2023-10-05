#include <stdlib.h>
#include <stdio.h>
#include <asciiArt.h>
#include <string.h>

static void usage(char *name)
{
    fprintf(stderr,"Usage: %s infile [optional mode]\n",name);
    fprintf(stderr,"Usage: %s infile -c\n",name);
    fprintf(stderr,"Usage: %s infile -i\n",name);
    fprintf(stderr,"Usage: %s infile -ci\n",name);
    exit(3);
}

int main(int argc, char **argv)
{
    rgbimage *color;
    grayimage *gray;
    int contrast = 0;
    char* asc = " `^\",:;Il!i~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$";
  
    if(argc != 3 && argc != 2)
        usage(argv[0]);

    color=read_color_image(argv[1]);

    if(argc == 3)
    {
        if(0 == strcmp(argv[2],"-i") || 0 == strcmp(argv[2],"-ci"))
        {
            gray=color_to_gray(color, 1);

            if(0 == strcmp(argv[2],"-ci"))
                contrast = 1;
        }
        else if(0 == strcmp(argv[2], "-c"))
        {
            gray=color_to_gray(color, 0);
            contrast = 1;
        }
        else
        {
            usage(argv[0]);
        }
    }
    else
    {
        gray=color_to_gray(color, 0);
    }
    
    ascii_art(gray, contrast, asc);

    return 0;
}