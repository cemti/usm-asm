COMMENT *
	Lucrare individuala nr. 4, varianta 3
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

.MODEL small
.STACK

len 	EQU 10			; lungimea constanta a sirului
crlf	EQU 0Dh, 0Ah	; linia noua
crlft	EQU crlf, '$'	; crlf cu terminator

.DATA
txt1 DB 'Introduceti sirul s1:', crlft
txt2 DB 'Sirul s1 este:', crlft
txt3 DB 'Sirul s2 este:', crlft

s1 DB len + 2 DUP (?)
s2 DB len / 3 DUP (?)

.CODE
; initializarea segmentului de date
	mov dx, @data
	mov ds, dx
	lea si, s1	; s1 ca sursa, pozitionata la al treilea caracter
	lea di, s2	; s2 ca destinatie

; afisare mesaj #1
	mov ah, 09h
	lea dx, txt1
	int 21h

; citire s1
	mov ah, 3Fh
	xor bx, bx
	mov cx, len + 2
	mov dx, si
	int 21h

; salvam lungimea s1
	mov cl, al

; afisare mesaj #2
	mov ah, 09h
	lea dx, txt2
	int 21h

; afisare s1
	mov ah, 40h
	inc bl
	mov dx, si
	int 21h

; testare daca lungimea s1 este mai mare decat 2
	sub cl, 4		; scapam de primele 2 caractere, 0Dh si 0Ah
	jbe iesire		; salt daca flagul C sau Z este setat

; scapam de primele doua caractere din s1
	add si, 2

bucla:
	mov al, [si]
	mov [di], al	; copiem caracterul din si in di
	add si, 3		; 3 pasi inainte pentru ca copiem fiecare al treilea caracter
	inc di
	sub cl, 3		; ibidem
	ja bucla		; salt daca flagurile Z si C au 0 in comun

; afisare text #3
	mov ah, 09h
	lea dx, txt3
	int 21h

; afisare s2
	mov ah, 40h
	mov cx, di 
	sub cx, OFFSET s2 ; calculam lungimea s2
	lea dx, s2
	int 21h

; iesire cu succes, cu 0
iesire:
	mov ax, 4C00h
	int 21h
END