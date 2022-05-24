[bits 16]
switch_to_pm:
	cli				;	Clear interrupts

	lgdt [gdt_descriptor]		;	Load GDT descriptor
	
	mov eax, cr0			;	To switch to protected mode, we set the first bit of cr0 to 1
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_pm

[bits 32]
init_pm:
	mov ax, DATA_SEG		;	Point segments to data selectors defined in GDT
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax	
	mov gs, ax	

	mov ebp, 0x9000			;	Update stack to be at the top of free space
	mov esp, ebp

	call BEGIN_PM			;	Call the label starting protected mode

