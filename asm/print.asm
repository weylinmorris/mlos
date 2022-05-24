print:				; 	A funciton, using the bx register as its single parameter
	pusha			; 	Push all of the current register values to the stack
	mov ah, 0x0e		; 	BIOS teletype routine
	
start:
	mov al, [bx]		; 	Move the value at bx to al to print
	int 0x10		;	Print the value at al
	add bx, 0x1		; 	Increment the memory pointer by 1
	
	cmp al, 0x0		; 	Check for the null terminator
	jne start		;	Loop if not null

end:
	mov al, 0x0d		;	Carriage return
	int 0x10
	mov al, 0x0a		;	Newline
	int 0x10

	popa			;	Pop all of the original register values back into place
	ret			; 	Return to the calling point of the function


