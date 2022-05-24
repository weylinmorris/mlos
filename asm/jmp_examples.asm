mov bx, 30		; Initial value for comparisons

cmp bx, 4
jle less_or_equal	; Jump to less_or_equal if less or equal
cmp bx, 40
jl  less		; Jump to less if less
mov al, 'C'
jmp then		; Jump past the two conditional blocks

less_or_equal:
	mov al, 'A'
	jmp then	; Don't forget to skip the other block!	

less:
	mov al, 'B'

then:
	mov ah, 0x0e	; BIOS teletype outupt
	int 0x10	; Interrupt to write al to console
	jmp $		; Loop, because that's what we do


times 510-($-$$) db 0	; Pad to 510
dw 0xaa55		; Magic boot sector bits

