COMMENT *
	Lucrare individuala nr. 8, varianta 3
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

INCLUDE stdio.inc

.MODEL small
.386
.STACK

.DATA
	fmt DB 'Rezultatul este %d.$'

.CODE
; initializare
	.STARTUP

; apelare procedura din sarcina
	call sigma

; afisarea numarului
	push ax
	lea si, fmt
	call printf
	add sp, 2

; iesire cu succes
	.EXIT 0

; in ax va fi rezultatul
; alte registre nu vor fi recuperate
sigma PROC
; initializare
	xor eax, eax
	mov ecx, -5

bucla:
; / 3
	imul edx, ecx, 5556h
	
; determinam negativitatea
	mov ebx, edx
	shr edx, 16
	shr ebx, 31
	add edx, ebx

; % 3
	lea edx, [edx + 2 * edx]
	add eax, ecx
	sub eax, edx

; pas inainte
	inc ecx
	cmp ecx, 17
	jle bucla

	ret
sigma ENDP
END