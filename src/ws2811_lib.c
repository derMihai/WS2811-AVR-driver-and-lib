#include "WS2811_lib.h"

void ledcpy(volatile uint8_t dest[3], volatile uint8_t source[3])
{
    dest[0] = source[0];
    dest[1] = source[1];
    dest[2] = source[2];
}

void limit_intensity(volatile uint8_t buffer[][3], volatile uint8_t pow_2, uint8_t led_cnt)
{
	for(uint8_t i = 0; i < led_cnt; i++){
		buffer[i][0] >>= pow_2;
		buffer[i][1] >>= pow_2;
		buffer[i][2] >>= pow_2;
	}
}
