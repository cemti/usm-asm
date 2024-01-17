COMMENT *
	Lucrare individuala nr. 5, varianta 3
	Versiunea .COM
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

.MODEL tiny

.CODE
	ORG 100h

main:
; optimizari de spatiu
	lea si, lungime_s2_max
	lea di, lungime_s3_max
	mov BYTE PTR [di], len + 1
	xor bx, bx ; liniile 66 si 92

; afisare text pentru sir #2
	mov ah, 09h
	lea dx, txt_sir
	int 21h

; citeste s2
	inc ah ; acum e 0Ah
	mov dx, si
	int 21h

; inlocuim in s2 0Dh cu '$'
	mov bl, [si + 1]
	mov BYTE PTR [si + bx + 2], '$'

; afisare text pentru caracter
	dec ah ; acum e 09h
	lea dx, txt_sim
	int 21h

; citeste a1
	mov ah, 1
	int 21h
	mov [a1], al

; formatam text pentru sir #3, conform cerintele sarcinii
	inc cifra
	mov WORD PTR [cifra + 2], '$ '
	
; afisare text pentru sir #3
	mov ah, 09h
	lea dx, [txt_sir - 2]
	int 21h

; citeste s3
	inc ah
	mov dx, di
	int 21h

; inlocuim in s3 0Dh cu '$'
	mov bl, lungime_s3
	mov BYTE PTR [di + bx + 2], '$'

; afisare rezultat
	dec ah
	lea si, msk
	mov bx, msk_idx

bucla:
	mov dx, [bx + si]
	int 21h
	sub bx, 2
	jnc bucla
	
; iesire cu succes, cu cod 0
	mov ax, 4C00h
	int 21h

; date

len		EQU 10
crlf	EQU 0Dh, 0Ah

DB crlf
txt_sir DB 'Introduceti sirul s'
cifra DB '2', \ ; truc pentru a nu crea mesaje redundante
':', crlf, '$'

txt_sim DB 0Ah, 'Introduceti simbolul a1: $'
txt_rez DB 0Ah, 'Rezultatul obtinut: $'

b DB ' $' ; spatiu liber
a1 DB ?, '$' ; caracter
s1 DB 'definit$' ; sirul s1 este definit

msk DW \
	OFFSET s3, OFFSET s2, OFFSET b, OFFSET b, OFFSET a1, \
	OFFSET s1, OFFSET a1, OFFSET b, OFFSET b, OFFSET s1, \
	OFFSET txt_rez
	
; tabelul de cautare
; se interpreteaza de la dreapta la stanga
	
msk_idx EQU $ - msk - 2 ; pozitia ultimului pointer

lungime_s2_max DB len + 1
lungime_s2 DB ?
s2 DB len + 2 DUP (?)

lungime_s3_max DB ?
lungime_s3 DB ?
s3 DB len + 2 DUP (?)
END main