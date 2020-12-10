;Name: Fardeen Yaqub
;UMBC ID: fyaqub1
;This program allows the user to enter and encrypt strings in two different ways. The user can either split or jump encrypt their string. The program
;allows the user to view current string, read in a new string, split encypt, jump encrypt, or exit the program. The program starts with a default string

;For whatever reason, the jump encryption function will occasionally outputs a random set of characters when showing the jumped string. I talked to the professor about it and he said it was fine since we couldn't find any problem within the program that could be causing it. The issue will happen once but if yourun the program again it will output perfectly fine


	extern splitString
	extern validate
	extern string_mov
	extern split_String
	extern jump_String
	extern square_Root
	extern printf
	
	section .data		
options:	db	"Encryption menu options: ", 10
len_o		equ	$-options

display:	db	"d - display current message ", 10
len_d 		equ	$-display

read:		db	"r - read new message ", 10
len_r		equ	$-read

split:		db 	"s - split encrypt ", 10
len_s		equ	$-split
	
jump:	 	db 	"j - jump encrypt ", 10
len_j		equ 	$-jump

quit:	 	db 	"q - quit program ", 10
len_q 		equ	$-quit

enter:		db	"enter option letter -> "
len_e 		equ	$-enter

current:	db	"Current message: "
len_c 		equ	$-current

defaultM	db	"This is the original message!", 10
len_dm		equ	$-defaultM
	
new:	 	db	"Enter new message: "
len_n		equ	$-new

invalid:	db 	"invalid message, keeping current", 10
len_i		equ	$-invalid

invalidO:	db	"invalid option, try again", 10
len_io		equ	$-invalidO

bye:		db	"Goodbye!", 10
len_b		db	$-bye
	
new_line 	db	10	

fmt:    db "%s", 0

	
	section .bss
string_default 	resb	45
user_option	resb 	2	
string_new 	resb 	45
	
	section .text

	global main

main:
	jmp set_default

set_default:
	
	mov rdi, defaultM	;puts default string into string_default
	mov rdx, len_dm

	push rsi
	call string_mov
	pop rsi

	
	mov [string_default], rsi
	
	mov r15, len_dm		;puts original string length into register

	jmp program
	
program:	
	mov rax, 1		;displays "Encryption menu options"
	mov rdi, 1
	mov rsi, options
	mov rdx, len_o
	syscall

	mov rax, 1              ;displays "d - display current message"
        mov rdi, 1
        mov rsi, display
        mov rdx, len_d
        syscall

	mov rax, 1              ;displays "r - read new message"
        mov rdi, 1
        mov rsi, read
        mov rdx, len_r
        syscall

	mov rax, 1              ;displays "s - split encrypt"
        mov rdi, 1
        mov rsi, split
        mov rdx, len_s
        syscall

	mov rax, 1              ;displays "j - jump encrypt"
        mov rdi, 1
        mov rsi, jump
        mov rdx, len_j
        syscall

	mov rax, 1              ;displays "q - quit program"
        mov rdi, 1
        mov rsi, quit
        mov rdx, len_q
        syscall

	mov rax, 1              ;displays "enter option letter -> "
        mov rdi, 1
        mov rsi, enter
        mov rdx, len_e
        syscall
	
	mov rax, 0		;gets user option
	mov rdi, 0
	mov rsi, user_option
	mov rdx, 2
	syscall 

	xor al, al
	
	mov al ,[user_option] 	;jumps to option_display if user picked it
	cmp al, 100
	je option_display

	mov al ,[user_option]   ;jumps to option_read if user picked it
        cmp al, 114
        je option_read

	mov al ,[user_option]   ;jumps to option_split if user picked it
        cmp al, 115
        je option_split

	mov al ,[user_option]   ;jumps to option_jump if user picked it
        cmp al, 106
        je option_jump

	mov al ,[user_option]   ;jumps to exit if user picked it
        cmp al, 113
        je exit

	jmp option_invalid

	
option_display:

	mov rax, 1              ;displays "Current message: "
        mov rdi, 1
        mov rsi, current
        mov rdx, len_c
        syscall

	
	mov rax, 1              ;displays current message
        mov rdi, 1
        mov rsi, [string_default]
        mov rdx, r15
        syscall


	mov rax, 1              ;prints out new line
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall

	
	jmp program
	
option_read:

	mov rax, 1
	mov rdi, 1
	mov rsi, new
	mov rdx, len_n
	syscall
	
	mov rax, 0              ;gets input
        mov rdi, 0
        mov rsi, string_new
        mov rdx, 45
        syscall

	xor r10, r10
	xor r9, r9
	mov r10, rax
	mov rdi, string_new	

	call validate		;validates the new user string
	
	cmp rax, 1		;user entered a correct string
	je correct


	jmp read_invalid	;invalid option

	
	jmp program

correct:

	xor al, al
	mov r9, r15 		;string defaults old length (CAN PROB DELETE)
	mov r15, r10		;new strings length
	
	jmp string_switch
	
read_invalid:

	mov rax, 1              ;displays "invalid option, try again "
        mov rdi, 1
        mov rsi, invalid
        mov rdx, len_i
        syscall


        mov rax, 1              ;prints out new line
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall


        jmp program

	
string_switch:

	mov rdx, r15
	mov rdi, string_new
	mov rsi, [string_default]

	call string_mov
	
	mov rax, 1              ;prints out new line
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall

	
	jmp program

	
option_split:

	xor r8, r8
	mov rdi, string_default
	mov rsi, r15		;length of string
	call split_String

	mov rax, 1              ;prints out new line
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall

	
	jmp program
	
option_jump:

	xor rdi, rdi
	xor rsi, rsi
	
	mov rdi, string_default
	mov rsi, r15
	call jump_String

	mov rax, 1              ;prints out new line
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall

	
	jmp program
	
option_invalid:

	mov rax, 1              ;displays "invalid option, try again "
        mov rdi, 1
        mov rsi, invalidO
        mov rdx, len_io
        syscall


        mov rax, 1              ;prints out new line
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall

	
	jmp program
	
exit:

	mov     rdi,fmt     ;prints Goodbye!
        mov     rsi,bye
        mov     rax,0
        call    printf

	
	mov rax, 60		;exits program
	mov rdi, rdi
	syscall
