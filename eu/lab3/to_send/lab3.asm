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
; ��������� �������� ������
read_buttons:
in k, pind
cp k, k_old
breq read_buttons ; ���� ��������� �� ����������, ��������� �����

cp k_old, 0x00
brne update_buttons ; ���� ������ ���� ��������, �������������� ���������

cp k, 0x00
breq update_buttons ; ��������� ������������� ������� ���� ������

jmp determine_buttons ; ��������� � ����������� ������� ������
;=====================================================


;=====================================================
; ��������� ��������� ������
update_buttons:
mov k_old, k
jmp read_buttons
;=====================================================


;=====================================================
; ����������� ������� ������
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
; ����� ���������� � Port B (�� 7-�� ���������� ���������)
print_result:
out portb, s
jmp read_buttons
;=====================================================


;=====================================================
; �������� 1-�� ������
button1_action:
mov temp, s
andi temp, 0b00000011 ; ������� �� ������� �� 4

cpi temp, 3
brne read_buttons

inc s

jmp print_result
;=====================================================


;=====================================================
; �������� 2-�� ������
button2_action:
cpi s, 12
brge read_buttons

subi s, -4

jmp print_result
;=====================================================

;=====================================================
; �������� 3-�� ������
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