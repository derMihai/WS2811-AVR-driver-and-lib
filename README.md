# Project Title

AVR driver and minimal library to control WS2811 serially adressable LEDs.

## Getting Started
Don't forget to choose your favorite GPIO port and pin in [ws2811_driver.S](src/ws2811_driver.S). Any pin should work, since the driver uses bit-banging.

```C
#define PORT PORTB		// GPIO Port
#define PPIN 0			// PORTx bit
```

## Driver

Works only on 16 MHz AVR MCUs. Tested on the Mega328p MCU and WS2811 LED-string. Should also work on WS2812 since the programmed timings correspond to the WS2812 datasheet (WS2811 datasheet contained at the time lots of errors). 

### TO-DOs:

- Optimize for code size

## Library

To be extended.

## Example 

```C
#include <avr/io.h>
#include "WS2811_lib.h"

#define LED_CNT 20 // number of adressable LEDs

volatile uint8_t buff[LED_CNT][3]; // declare Buffer

int main(void)
{	
	// initialize and clear pin 0 port B
	DDRB	|= (1 << PB0);
	PORTB	&= ~(1 << PB0) ;

	// set each color-component in every LED to maximum brigthness (white)
	for(int i = 0; i < 20; i++){
		buff[i][RED_C] = 0xFF;
		buff[i][BLU_C] = 0xFF; 
		buff[i][GRN_C] = 0xFF; 
	}
	
	flush(buff, LED_CNT); // flush the buffer into the LEDs
	
	while(1);
}
```
