				;	A simple boot sector program


[org 0x7c00]			; 	Directive to instruct the program where we expect the code to be loaded into memory

main:
	mov bx, BOOT_MESSAGE	; 	Move the boot message into the bx register, which we use as the parameter for our print function
	call print		;	Call the print function

	mov bp, 0x9000		;	Set the stack
	mov sp, bp

	mov bx, REAL_MODE_MESSAGE
	call print

	call switch_to_pm	;	We never return from this file, so the below *should* be skipped until BEGIN_PM

	jmp $			; 	Jump to the current address, looping forever

%include "print.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "print_pm.asm"

BEGIN_PM:
	mov ebx, PROT_MODE_MESSAGE
	call print_pm

	jmp $

BOOT_MESSAGE: db "Booting MLOS",0
REAL_MODE_MESSAGE: db "IN REAL MODE",0
PROT_MODE_MESSAGE: db "IN PROT MODE",0

times 510-($-$$) db 0		; 	Boot sector program must fit into 512 bytes, with the last 2 bytes being aa55
				;		This line pads the boot sector to 510 bytes, allowing the final two 
dw 0xaa55			;		bytes to be written as required

