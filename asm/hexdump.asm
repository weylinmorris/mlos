hexdump:			;	A function that will dump the hex value of a memory location
				;	Works with data from 'dx' register
	pusha	
	mov cx, 0		;	Index variable

hex_loop:
	cmp cx, 4		;	Loop 4 times
	je end_hexdump		

				; 1. Convert last char of 'dx' to ascii
	mov ax, dx		;	Use ax as working register
	and ax, 0x000f		;	Mask first 3 to zeroes
	add al, 0x30		;	Convert to ascii
	cmp al, 0x39		;	If > 9, add extra 8 to represent 'A' to 'F'
	jle hex_loop_2
	add al, 7		;	'A' is ascii 65 instead of 58, so account for offset

hex_loop_2:
				; 2. Get the correct position of the string to place the ascii char
	mov bx, HEX_OUT + 5	;	Base + length
	sub bx, cx		;	Our index variable
	mov [bx], al		;	Copy the ascii char on 'al to the position pointed to by 'bx'
	ror dx, 4		;	Rotate bits? Not really sure why this is here yet
	
	add cx, 1		; 	Increment index
	jmp hex_loop		;	Loop	

end_hexdump:
	mov bx, HEX_OUT		; 	Load completed data into bx for printing
	call print	

	popa
	ret

HEX_OUT:
	db '0x0000',0		;	Reserve memory for string

