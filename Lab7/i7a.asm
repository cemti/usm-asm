COMMENT *
	Lucrare individuala nr. 7a, varianta 3
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

.MODEL small
.STACK

.DATA
a DB 80
b DB 45
c DB 5
d DB 3
e DB 45
f DB 9

.CODE
; init
	mov dx, @data
	mov ds, dx
	xor ax, ax

; 45 - 5
	mov al, b
	sub al, c

; (45 - 5) * 3
	mov cl, d        
	mul cl

; 80 + (45 - 5) * 3
	add al, a
	mov dl, al

; 45 / 9
	mov al, e
	mov cl, f
	div cl

; 80 + (45 - 5) * 3 + 45 / 9
	add al, dl        
	int 03h        

; iesire
	mov ax, 4C00h
	int 21h
END
