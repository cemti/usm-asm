COMMENT *
	Lucrare individuala nr. 9, varianta complexa nr. 3
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

INCLUDE stdlibc.inc

.MODEL small
.STACK

crlf EQU 0Dh, 0Ah
len EQU 20

.DATA
txt DB 'Introduceti sirul:', 0
fmt_ CATSTR <'%>, %len, <c%n', 0> ; '%20c%n'
fmt1 DB fmt_
fmt2 DB 'Sirul modificat:', crlf, '%.*s', 0
sir DB len DUP (?)
n DW ?

.CODE
; initializare
	.STARTUP
	mov es, dx

; afisare text
	lea si, txt
	call puts

; citire argument
	lea di, sir

	push OFFSET n OFFSET sir
	lea si, fmt1
	call scanf
	add sp, 2
	
; incarcam lungimea sirului
	mov cx, n

; cautam primul caracter in afara de spatiu
	cld
	mov al, ' '
	
	repe scasb
	jcxz iesire_err
	
	mov dl, [di - 1]

; gasim pozitia ultimei virgula
	std
	mov al, ','
	mov cx, n
	
	mov di, OFFSET sir - 1
	add di, cx
	
	repne scasb
	jcxz iesire_err
	
	mov [di + 1], dl

; afisare sirul modificat
	push OFFSET sir n
	lea si, fmt2
	call printf
	add sp, 2

; iesire cu succes
	.EXIT 0
	
iesire_err:
	.EXIT 1
END