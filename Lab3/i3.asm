COMMENT *
	Lucrare individuala nr. 3, varianta 3
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

.MODEL small
.STACK

len EQU 20					; lungimea constanta a sirului
clrf EQU 0Dh, 0Ah, '$'		; linia noua + terminator

.DATA
txt1 DB 'Introduceti sirul s1:', clrf
txt2 DB 0Ah, 'Sirul s1 este:', clrf	; 0Ah prefixat pentru ca 0Ah/21h lasa la urma 0Dh pe ecran
txt3 DB 0Ah, 'Sirul s2 este:', clrf
prefix_s1 DB len + 1 				; nr. max. de caractere - inca unu pentru caracterul 0Dh
lungime_s1 DB ?
s1 DB len + 2 DUP (?) 				; + 1 pentru terminatorul '$'
s2 DB len / 2 + 1 DUP ('$') 		; sa nu adaugam explicit terminatorul, + 1 pentru terminator

.CODE
; initializarea registrelor
	mov dx, @data
	mov ds, dx 
	lea si, s1	; s1 ca sursa
	lea di, s2	; s2 ca destinatie

; afisare mesaj #1
	mov ah, 09h
	lea dx, txt1
	int 21h

; citire s1
	inc ah				; acum e 0Ah
	lea dx, prefix_s1
	int 21h				; lasa la urma in s1 caracterul 0Dh

; calculam pozitia sfarsitului s1
	xor bh, bh 						; setam bh la 0
	mov bl, lungime_s1 				; incarcam lungimea lui s1
	mov BYTE PTR [bx + si + 1], '$'	; adaugam terminator la s1, dupa caracterul 0Dh
; BYTE PTR asigura ca destinatia este un octet, nu cuvant

; afisare mesaj #2
	dec ah	; acum e 09h
	lea dx, txt2
	int 21h

; afisare s1
; ah este 09h
	mov dx, si	; se poate - lea dx, s1
	int 21h

; afisare text 3
; ah este 09h
	lea dx, txt3
	int 21h

; testam daca cl este 0, seteaza flagul Z daca este adevarat
	test bl, bl
	jz iesire

bucla:
	mov al, [si]
	mov [di], al	; copiem caracterul din si in di
	add si, 2		; 2 pasi inainte pentru ca copiem de pe pozitiile impare
	inc di
	sub bl, 2		; ibidem
	ja bucla		; salt daca flagurile Z si C au 0 in comun

afisare:
; ah este 09h
	lea dx, s2
	int 21h

iesire:
; iesire cu succes, cu codul de retur 0
	mov ax, 4C00h
	int 21h
END