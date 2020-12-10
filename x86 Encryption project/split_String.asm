
;This function splits the string at a valid index that the user chooses 
	
	extern printf
	extern scanf

	section .data
location:       db      "Enter split value: "
len_l           equ     $-location

invalid:        db      "Split value has to be less than message length. Current Message length is = "
len_i           equ     $-invalid

invalid2:       db      "invalid split value", 10
len_i2          equ     $-invalid2

current:        db      "Current message: "
len_c           equ     $-current

encrypt:        db      "Shift encryption: "
len_e           equ     $-encrypt

	
new_line	db	10

fmt_scan:	db "%d", 0
fmt:	db "%s", 10, 0

fmt_num:    db "%d", 10, 0

	
	section .bss
user_option     resb    4
print_char	resb	2
original_string 	resb 	35
split_max	resb	4	
	
	section .text
global split_String
extern scanf
	
split_String:

	xor r12, r12
	xor r11, r11

	
	mov r12, [rdi]
	mov r14, rsi

	mov r11, r14
	dec r11
	
	mov [split_max], r11

	xor r11, r11
	
	mov r13, r14
	sub r13, 2

	
	mov rax, 1              ;displays where do you want to split at
        mov rdi, 1
        mov rsi, location
        mov rdx, len_l
        syscall
	
	
	mov     rdi,fmt_scan
        mov     rsi, user_option
        mov     rax,0 
        call    scanf

	xor r10, r10
	dec r10

	cmp [user_option], r10b	;checks if user option is less than 0
	jl invalid_option
	
	cmp [user_option], r13b	;check if user option is more than length
	jg invalid_option

	

	jmp splitString
	
splitString:	
	
	mov rax, 1              ;displays "original string"
        mov rdi, 1
        mov rsi, current
        mov rdx, len_c 
        syscall

	
	mov rax, 1              ;displays original string
        mov rdi, 1
        mov rsi, r12
        mov rdx, r15
        syscall
	

	mov rax, 1              ;displays "encrypted string"
        mov rdi, 1
        mov rsi, encrypt
        mov rdx, len_e
        syscall

	
	xor al, al
        xor r11, r11

        mov r11b, [user_option]
        inc r11

        add r12, r11
        mov al, [r12-1]

        mov [print_char], al

	xor r13, r13
        mov r13, r14
        sub r13, r11
        dec r13

	
	mov rax, 1              ;displays "a character"
        mov rdi, 1
        mov rsi, print_char
        mov rdx, 1
        syscall


	
	jmp valid_option
		

invalid_option:

	mov rax, 1              ;displays "INVALID"
        mov rdi, 1
        mov rsi, invalid2
        mov rdx, len_i2
        syscall

	
	
	mov rax, 1              ;displays "INVALID"
        mov rdi, 1
        mov rsi, invalid
        mov rdx, len_i
        syscall


	mov     rdi,fmt_num         
        mov     rsi,[split_max]         
        mov     rax,0           
        call    printf
	
	
	xor rax, rax
	ret

valid_option:
	
	cmp r14, 0
	je done

	cmp r13, 0
	je reset

	dec r14
	dec r13
	add r12, 1

        mov al, [r12-1]
        mov [print_char], al


	mov rax, 1              ;displays "a character"
        mov rdi, 1
        mov rsi, print_char
        mov rdx, 1
        syscall

	
	jmp valid_option

reset:
	
	sub r12, r15
	dec r12

	add r13, r15
	jmp valid_option

done:
	mov rax, 1              ;prints out new line
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall
	
	
	ret
