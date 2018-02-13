#include "WS2811_lib.h"

void ledcpy(volatile uint8_t dest[3], volatile uint8_t source[3])
{
    dest[0] = source[0];
    dest[1] = source[1];
    dest[2] = source[2];
}
