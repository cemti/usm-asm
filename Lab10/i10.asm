COMMENT *
	Lucrare individuala nr. 10, varianta complexa nr. 3
	Copyright Cemirtan Cristian 2021
	Grupa I 2101
*

INCLUDE stdlibc.inc

.MODEL small
.STACK

crlf EQU 0Dh, 0Ah

.DATA
txt1 DB 'Introduceti m si n:', 0
txt2 DB crlf, 'Rezultat:', 0
fmt1 DB '%d%d', 0
fmt2 DB crlf, 'Introduceti %d elemente:', crlf, 0

m DW 0
n DW 0

.CODE
; initializare
	.STARTUP

; afiseaza text #1
	lea si, txt1
	call puts
	
; citeste m si n
	push OFFSET n OFFSET m
	lea si, fmt1
	call scanf
	add sp, 4
	
; testare daca e pozitiv si mai mare decat 0
	mov ax, m
	mov bx, n

	test ax, ax
	jle iesire_err
	
; testare
	test bx, bx
	jg inceput
	
iesire_err:
	.EXIT 1
	
inceput:
; rezervez spatiu pentru matrice
	mul bx

; iesire in caz de revarsare
	jo iesire_err
	
; afisarea
	push ax
	lea si, fmt2
	call printf
	pop ax
	
; cadru nou
	push bp
	mov bp, sp
	
	add ax, ax	; n*m cuvinte
	add ax, 2	; cuvant temporar ce contine valoarea initiala a reg. di
	sub sp, ax	; rezervez spatiu
	
	mov [fmt1 + 2], 0 ; fmt1 <- '%d', 0
	
; algoritm
	mov di, sp
	
; se initializeaza spatiul rezervat cu 0
	xor dx, dx
	call memset
	
	mov cx, m
	
	al_bucla_1:
	; se stocheaza numarul citit in ss:[di]
		push di
		lea si, fmt1
		call scanf
		add sp, 2
		
		mov [bp - 2], di ; inceput
		mov bx, di ; pozitia minimului

		mov dx, n
		add di, 2
		dec dx
		jz al_bucla_1_dec
		
		al_bucla_2:
			push di
			call scanf
			add sp, 2

		; se compare elementul curent cu cel minim
			mov ax, ss:[di]
			cmp ss:[bx], ax
			jle al_bucla_2_dec
			
		; daca ss:[bx] > ss:[di]
			mov bx, di
			
		al_bucla_2_dec:
			add di, 2
			dec dx
			jnz al_bucla_2

	; se schimba cu pozitiile
		mov si, [bp - 2]
		mov dx, ss:[si]
		mov ax, ss:[bx]
		
		mov ss:[bx], dx
		mov ss:[si], ax
		
	al_bucla_1_dec:
		dec cx
		jnz al_bucla_1

; afisare
	lea si, txt2
	call puts

	lea si, fmt1
	mov WORD PTR [si + 2], ' ' ; fmt1 <- '%d ', 0
	
	mov di, sp
	mov cx, m
	
	af_bucla_1:
		mov dx, n
		
		af_bucla_2:
			push ss:[di]
			call printf
			add sp, 2
			
			add di, 2
			dec dx
			jnz af_bucla_2
		
	; linie noua
		putnl
		
		dec cx
		jnz af_bucla_1
	
; sfarsit cadru pentru algoritm
	mov sp, bp
	pop bp

; iesire cu succes
	.EXIT 0
END