/*
 * main.c
 *
 * Created: 09-Jan-22 6:13:38 PM
 *  Author: Denis
 */ 

#include <xc.h>
#include <avr/io.h>
#include <util/delay.h>

#define TICK_INTERVAL_MS 4000
#define NON_LEGATO_DELAY 0.2

#define h0 0b00000000

#define n1 0b00000001
#define n2 0b00000010
#define n3 0b00000100
#define n4 0b00001000
#define n5 0b00010000
#define n6 0b00100000
#define n7 0b01000000


void delay(int duration);
void play_note(const int note_port, const float duration, int legato);
void play_melody();

int main(void)
{
	DDRB = 0xFF;
	PORTB = h0;
    while(1)
    {
        play_melody();
    }
}

void delay(int duration) {
	for (int k = 0; k < duration; ++k)
	_delay_ms(1);
}

void play_note(const int note_port, const float duration, int legato) {
	PORTB = note_port;
	
	if (legato) {
		delay(duration * TICK_INTERVAL_MS);
		return;
	}

	const int sound_duration = (1 - NON_LEGATO_DELAY) * duration * TICK_INTERVAL_MS;
	const int delay_duration = NON_LEGATO_DELAY * duration * TICK_INTERVAL_MS;
	delay(sound_duration);
	PORTB = h0;
	delay(delay_duration);
}

void play_melody() {
	play_note(n5, 1./4, 0);
	play_note(n3, 1./8, 0);
	play_note(n3, 1./8, 0);
	
	play_note(n5, 1./4, 0);
	play_note(n3, 1./8, 0);
	play_note(n3, 1./8, 0);
	
	play_note(n5, 1./8, 0);
	play_note(n4, 1./8, 0);
	play_note(n3, 1./8, 0);
	play_note(n2, 1./8, 0);
	
	play_note(n1, 1./2, 0);
	
	play_note(n6, 1./4, 0);
	play_note(n7, 1./8, 0);
	play_note(n6, 1./8, 0);
	
	play_note(n5, 1./4, 0);
	play_note(n3, 1./8, 0);
	play_note(n3, 1./8, 0);
	
	play_note(n5, 1./8, 0);
	play_note(n4, 1./8, 0);
	play_note(n3, 1./8, 0);
	play_note(n2, 1./8, 0);
	
	play_note(n1, 1./2, 0);
	
	play_note(h0,	 1,	0);
}