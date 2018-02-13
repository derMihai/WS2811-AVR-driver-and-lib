#include <stdint.h>


// led color components order, may vary
enum {RED_C, GRN_C, BLU_C};


/*
 * Flushes led_cnt * 3 array in the WS2811, where
 * 0 < led_cnt < 86
 */
void flush(volatile uint8_t buffer[][3], uint8_t led_cnt);

/*
 * Simply copies data from one LED to another
 */
void ledcpy(volatile uint8_t dest[3], volatile uint8_t source[3]);
