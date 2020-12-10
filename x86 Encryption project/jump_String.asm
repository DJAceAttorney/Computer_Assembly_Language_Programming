
;This program jumps characters within the string. The user chooses how many character jumps they want
;For whatever reason, this function occasionally outputs a random set of characters when showing the jumped string. I talked to the professor about it
;and he said it was fine since we couldn't find any problem within the program that could be causing it. The issue will happen once but if you run the
;program again it will output perfectly fine
	
	
	extern square_Root
	extern scanf
	extern printf
	extern root
	
	
	section .data

invalid:        db      "INVALID JUMP OPTION ", 10
len_i           equ     $-invalid
	
current:        db      "Current message: "
len_c           equ     $-current

jumpE:        	db      "Jump encryption: "
len_je           equ     $-jumpE
	
new_line        db      10

fmt_scan:       db "%d", 0

fmt_num: db "Enter jump interval between 2-%d-> " , 0

	
        section .bss
user_option     resb    4
print_char      resb    4
root_num	resb	4
	
        section .text
global jump_String


jump_String:

	xor r12, r12
	xor r13, r13

	mov r12, [rdi]		;moves string into r12
	mov r14, rsi		;moves length of string into r14

	
	mov rdi, r14		;gets square root 
	call root
	mov [root_num], rax

	mov r13, rax

	
	mov     rdi,fmt_num	;prints root of string length
        mov     rsi,[root_num]
        mov     rax,0
        call    printf
	
			
	mov rdi, fmt_scan	;gets user input
	mov rsi, user_option
	mov rax, 0
	call scanf


	xor r10, r10
	add r10, 2		;min jump value
	

	cmp [user_option], r10b  ;checks if user option is less than 2
        jl invalid_option

        cmp [user_option], r13b  ;check if user option is more than root of length
        jg invalid_option

	
	
	mov rax, 1              ;displays "Current message: "
        mov rdi, 1
        mov rsi, current
        mov rdx, len_c
        syscall

	mov rax, 1              ;displays current message
        mov rdi, 1
        mov rsi, r12
        mov rdx, r14
        syscall

	mov rax, 1              ;displays "Jump encryption: "
        mov rdi, 1
        mov rsi, jumpE
        mov rdx, len_je
        syscall
	

	dec r14
	xor r10, r10
	mov r10, r12
	add r10, r14
	sub r10, 1

	mov r13, r12
	jmp jumpString


invalid_option:

	mov rax, 1              ;displays INVALID
        mov rdi, 1
        mov rsi, invalid
        mov rdx, len_i
        syscall
	
	ret
	
jumpString:

	cmp r14, 0
	je end

	cmp r12, r10
	jg reset

	xor r9, r9
	mov r9b, [r12]
	mov [print_char], r9b

	mov rax, 1              ;displays a character
        mov rdi, 1
        mov rsi, print_char
        mov rdx, 1
        syscall

	dec r14

	
	add r12b, [user_option]

	jmp jumpString


reset:	
	inc r13
	xor r12, r12
	mov r12, r13

	
	jmp jumpString
	
end:

	mov rax, 1              ;prints out new line
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall

	
	ret
