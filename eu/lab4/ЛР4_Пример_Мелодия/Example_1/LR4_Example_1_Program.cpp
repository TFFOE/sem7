#include <avr/io.h> 
#include <util/delay.h> 
 
#define h0 0b00000000 
 
#define n1 0b00000001 
#define n2 0b00000010 
#define n3 0b00000100 
#define n4 0b00001000 
#define n5 0b00010000 
#define n6 0b00100000 
#define n7 0b01000000 
 
 
void delay(int duration)
{  
    for (int k=0; k<duration; k++)
    {  
        _delay_ms(1);  
    } 
} 
 
void play_note(const int note_port, double duration, _Bool flag)
{  
    PORTB = note_port;  
	delay(duration);  
	if(flag)
	{   
	    PORTB = h0;  
    } 
} 
 
void repeat_sequence()
{  
    play_note(n7, 800, 1);  
	play_note(n5, 400, 1);  
	play_note(n7, 400, 1);  
	play_note(n6, 400, 1);  
	play_note(n7, 400, 1);  
	play_note(n5, 400, 1);  
	play_note(n4, 400, 1);    
	play_note(n5, 800, 0);  
	play_note(n4, 800, 1);  
	play_note(n1, 1600, 1);    
	play_note(n4, 800, 0);  
	play_note(n1, 800, 1);  
	play_note(n3, 800, 1);  
	play_note(n1, 400, 1);  
	play_note(n3, 400, 1);    
	play_note(n2, 2400, 1);  
	delay(800); 
} 
 
int main(void) 
{  
    DDRB = 0xFF;  
	PORTD = h0;  
	PORTB = h0;     
	/* Replace with your application code */     
	while (1)      
	{      
	    play_note(n1, 800, 0);   
		play_note(n2, 400, 1);   
		play_note(n3, 400, 1);   
		play_note(n1, 800, 1);   
		play_note(n4, 400, 1);   
		play_note(n3, 400, 1);      
		play_note(n1, 2400, 1);   
		delay(800);      
		play_note(n5, 1600, 0);   
		play_note(n5, 800, 1);   
		play_note(n6, 400, 1);   
		play_note(n5, 400, 1);      
		play_note(n7, 2400, 1); 
        delay(800);      
        repeat_sequence();   
		repeat_sequence();     
	} 
} 