.include "m16def.inc"
.list
.def temp	= r16
.def k_old	= r17
.def k		= r18
.def s		= r19

.cseg
.org 0

ldi temp, 0x80
out acsr, temp

out ddrd,	0x00
out ddrd,	0xFF

out portd,	0xFF

ldi k_old,	0x00
ldi s,		0x00
out portb,	s

;=====================================================
; Считываем значения кнопок
read_buttons:
in k, pind
cp k, k_old
breq read_buttons ; Если состояние не изменилось, считываем снова

cp k_old, 0x00
brne update_buttons ; Если кнопка была отпущена, перезаписываем состояние

cp k, 0x00
breq update_buttons ; Исключаем одновременное нажатие двух кнопок

jmp determine_buttons ; Переходим к определению нажатой кнопки
;=====================================================


;=====================================================
; Обновляем состояние кнопок
update_buttons:
mov k_old, k
jmp read_buttons
;=====================================================


;=====================================================
; Определение нажатой кнопки
determine_buttons:
cpi k, 0b00000001
breq button1_action

cpi k, 0b00000010
breq button2_action

cpi k, 0b00000100
breq button3_action

jmp print_result
;=====================================================


;=====================================================
; Вывод результата в Port B (на 7-ми сегментный индикатор)
print_result:
out portb, s
jmp read_buttons
;=====================================================


;=====================================================
; Действие 1-ой кнопки
button1_action:
mov temp, s
andi temp, 0b00000011 ; Остаток от деления на 4

cpi temp, 3
brne read_buttons

inc s

jmp print_result
;=====================================================


;=====================================================
; Действие 2-ой кнопки
button2_action:
cpi s, 12
brge read_buttons

subi s, -4

jmp print_result
;=====================================================

;=====================================================
; Действие 3-ей кнопки
button3_action:
cpi s, 0
breq read_buttons

cpi s, 5
breq button3_action_1
cpi s, 10
breq button3_action_1
cpi s, 15
breq button3_action_1
jmp read_buttons

button3_action_1:
subi s, 5

jmp print_result
;=====================================================