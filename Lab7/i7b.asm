COMMENT *
	Lucrare individuala nr. 7b, varianta 3
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

INCLUDE stdlibc.inc

.MODEL small
.386
.STACK 1000

.DATA
txt DB 'Introduceti a, b, c si d:', 0
fmt1 DB '%hd%hd%d%d', 0
fmt2 DB 'Rezultatul este: %d.', 0
a DB ?
b DB ?
c DW ?
d DW ?

.CODE
; init
	.STARTUP

; afisare text
	lea si, txt
	call puts

; argumente pentru scanf
	push OFFSET d OFFSET c OFFSET b OFFSET a
	lea si, fmt1
	call scanf
	add sp, 8

; se incarca variabilele
	movsx eax, a
	movsx ebx, b
	movsx ecx, c
	movsx edx, d

; 10 * a - 2 * b
	add eax, eax
	add ebx, ebx
	lea eax, [eax + 4 * eax]
	sub eax, ebx

; (10 * a - 2 * b) * c
	imul eax, ecx

; (10 * a - 2 * b) * c - d
	sub eax, edx

; verificam daca rezultatul incape intr-un cuvant
	movsx edx, ax
	cmp edx, eax
	je afisare
	int 04h

afisare:
; afisare text
	push ax
	lea si, fmt2
	call printf
	add sp, 2

; iesire
	.EXIT 0
END