; GDT
gdt_start:

gdt_null:			;	Mandatory null descriptor
	dd 0x0			;	dd means define double word (i.e. 4 bytes)
	dd 0x0	

gdt_code:			;	the code segment descriptor
				;	base=0x0, limit 0xffff
				;	1st flags: (present)1 (privilege)00 (descriptor type)1 			-> 1001b
				;	type flags: (code)1 (conforming)0 (readable)1 (accessed)0 		-> 1010b
				;	2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 	-> 1100b

	dw 0xffff		;	Limit (bits 0-15)
	dw 0x0			;	Base (bits 0-15)
	db 0x0			;	Base (bits 16-23)
	db 10011010b		;	1st flags, type flags
	db 11001111b		;	2nd flags, Limit (bits 16-19)
	db 0x0			;	Base (bits 24-31)

gdt_data:			;	the data segment descriptor
				;	same as the code segment except type flags
				;	type flags: (code)0 (expand down)0 (writable)1 (accessed)0 		-> 0010b
	dw 0xffff		;	Limit (bits 0-15)
	dw 0x0			;	Base (bits 0-15)
	db 0x0			;	Base (bits 16-23)
	db 10010010b		;	1st flags, type flags
	db 11001111b		;	2nd flags, Limit (bits 16-19)
	db 0x0			;	Base (bits 24-31)

gdt_end:			;	The reason for putting a label at the end is so we can have the assembler
				;		caluclate the size of the GDT for the GDT descripter (below)

; GDT Descriptor
gdt_descriptor:
	dw gdt_end - gdt_start - 1	;	Size of our GDT, always less one of the true size
	dd gdt_start			;	Start address of our GDT

; Define some constants for the GDT segment descriptor offsets, which are what segment registers must contain wihen in protected
;	mode. For example, when we set DS = 0x10 in PM, the CPU knows that we mean it to use the segment described at the offset
;	0x10 (i.e. 16 bytes) in our GDT, which in our case is the DATA segment (0x0 -> NULL; 0x08 -> CODE; 0x10 -> Data)
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

