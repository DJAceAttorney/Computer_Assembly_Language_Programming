;This function validates the string that the user enters
;The string must start with a capital letter and end with an !,.,? 


	
section .bss

section .text
global validate


	
validate:	
	xor al, al
	mov al, [rdi]


	cmp al, 'A'
	je end_char
	cmp al, 'B'
        je end_char
	cmp al, 'C'
        je end_char
        cmp al, 'D'
        je end_char
        cmp al, 'E'
        je end_char
        cmp al, 'F'
        je end_char
        cmp al, 'G'
        je end_char
        cmp al, 'H'
        je end_char
        cmp al, 'I'
        je end_char
        cmp al, 'J'
        je end_char
        cmp al, 'K'
        je end_char
        cmp al, 'L'
        je end_char
        cmp al, 'M'
        je end_char
        cmp al, 'N'
        je end_char
        cmp al, 'O'
        je end_char
        cmp al, 'P'
        je end_char
        cmp al, 'Q'
        je end_char
        cmp al, 'R'
        je end_char
        cmp al, 'S'
        je end_char
        cmp al, 'T'
        je end_char
        cmp al, 'U'
        je end_char
        cmp al, 'V'
        je end_char
        cmp al, 'W'
        je end_char
        cmp al, 'X'
        je end_char
        cmp al, 'Y'
        je end_char
	cmp al, 'Z'
        je end_char

	jmp incorrect

correct:
	xor rax, rax
        mov rax, 1
	ret

incorrect:

	xor rax, rax
	ret

	
end_char:

	xor al, al
	add rdi, r10

	dec rdi
	dec rdi
	
	mov al, [rdi]
	
	cmp al, '.'		;correct end values 
        je correct
	cmp al, '?'
        je correct
	cmp al, '!'
        je correct
	
	jmp incorrect
