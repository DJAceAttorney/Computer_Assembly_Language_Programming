;This function replaces the old string with the new string

section .text
global string_mov


string_mov:

	xor al, al
	jmp move_string
	
move_string:	


	cmp rdx, 0
	je done

	mov al, [rdi]
	mov [rsi], al

	add rdi, 1
        add rsi, 1
	
	dec rdx
	jmp move_string
	
done:
	ret
	
