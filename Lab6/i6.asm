COMMENT *
	Lucrare individuala nr. 6, varianta 3
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

.MODEL small
.STACK

crlf EQU 0Dh, 0Ah

.DATA
txt DB 'Introduceti un simbol: $'
txte DB crlf, 'eroare'
nl DB crlf, '$'

lino MACRO
	mov ah, 09h
	lea dx, nl
	int 21h
ENDM lino

.CODE
; initializare ds
	mov dx, @data
	mov ds, dx
	mov ah, 09h

bucla:
; afisare text pentru s2
	lea dx, txt
	int 21h

; citeste caracter
	mov ah, 01h
	int 21h

; al este 0 daca este spatiu
; se inverseaza al5
	xor al, ' ' ; 20h
	jz iesire
	
; al este intre 0 si 9, daca a fost o cifra ASCII
; se inverseaza al4
	xor al, 10h

; verifica daca al este intre 0 si 9
	cmp al, 9
	ja contrar
	
; afisare linia noua
	lino
	
; afisare '!'
	mov ah, 02h
	mov dl, '!'
	int 21h

; afisare linia noua
	lino
	jmp bucla

; afisare 'eroare'
contrar:
	mov ah, 09h
	lea dx, txte
	int 21h
	jmp bucla

iesire:
	mov ax, 4C00h
	int 21h
END