start:

.include "m16def.inc" 

.list 

.def t=r20

.def temp=r16 

.def kold=r17

.def k=r18

.def s=r19
 
.def k__z=r20
 
.def k___=r21

.def s___=r22

;--------------------------------------------

.cseg 

.org 0 

;--------------------------------------------

ldi temp,0x80 

out acsr,temp

;--------------------------------------------

ldi temp,0x00 ; 0 --> temp

out ddrd,temp 

ldi temp,0xFF ; 0xff --> temp

out ddrb,temp 

out portd,temp 

;---------------------------------------------

ldi kold, 0x00 ; 0--->kold

ldi s, 0x00 ; 0--->s___

out portb, s ; s___(=0)

;---------------------------------------------
ldi temp, 0b101 ; Предделение 1024
out tccr0, temp 
ldi temp, 135 ; Коррекция тактовой частоты
out osccal, temp 
 
ldi temp,low(RAMEND) ; инициализация стека
out spl,temp 
ldi temp,high(RAMEND)
out sph,temp 
;---------------------------------------------

read:   ; метка read
in  k, pind ; Считали содержимое порта pd (--->k
cp  k, kold ; Сравнили k и kold
breq read  ; Если k=kold, read
tst  kold  ; Проверили kold
brne remem ; Если kold!=0, remen 
tst  k  ; Проверили k
breq remem  ; Если k=0, remem
jmp  lbl1  ; переход к lbl1

;---------------------------------------------

remem:   ; метка remem
mov kold, k ; помещаем k в kold
jmp  read  ; переход к read

;---------------------------------------------

lbl1: ; метка lbl1
cpi k, 0x01 ; проверка условия k = 1
breq met ; если условме выполняется, то met
jmp remem ; переход к remem

met: ; метка met

ldi k__z, 1 ; 1--->k__z
rcall subr_delay1 ; вызов  subr_delay1
ldi k__z, 1  ; 1--->k__z
rcall subr_delay0 ; вызов  subr_delay0
ldi k__z, 3  ; и тд
rcall subr_delay1
ldi k__z, 2
rcall subr_delay0
ldi k__z, 2
rcall subr_delay1
ldi k__z, 3 
rcall subr_delay0
ldi k__z, 4
rcall subr_delay1
ldi k__z, 1  
rcall subr_delay0
ldi k__z, 5
rcall subr_delay1
ldi k__z, 3  
rcall subr_delay0
ldi k__z, 7
rcall subr_delay1
ldi k__z, 60  
rcall subr_delay0

 
jmp remem  ; переход к remem
  
 
subr_delay1:  ; "1" длится k__z тактов с предделением
ldi s___, 1  ; 1 --> s___
out portb, s___  ; s___ --> pb 
ldi temp, 0
out tcnt0, temp ; 0 --> tcnt0 Обнуление таймера
ccc1:   ; повтор цикла
in k___, tcnt0 ; считали таймер
cp k___, k__z ; сравнили k__ и k__z
brlo ccc1  ; если k___<k__z, ушли в начало
 ret  ; конец подпрограммы subr_delay1
 

subr_delay0:  ; "0" длится k__z тактов с предделением
ldi s___, 0  ; 0 --> s___ 
out portb, s___  ; s___ --> pb
ldi temp, 0  
out tcnt0, temp ; 0 --> tcnt0 
ccc0:  ; повтор цикла
in k___, tcnt0 ; считали таймер
cp k___, k__z ; сравнили k__ и k__z
brlo ccc0  ; если k___<k__z, ушли в начало
ret   ; конец подпрограммы subr_delay
