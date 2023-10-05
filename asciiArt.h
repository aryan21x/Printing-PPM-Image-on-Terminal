#include <netpbm.h>

void ascii_art(grayimage *img, int contrast, char* asc);
unsigned int calculate_scale(graypixel max, graypixel min, int numAsciiChars);
void find_min_max(grayimage *img, graypixel *min, graypixel *max);
grayimage *color_to_gray(rgbimage *image, int invert);