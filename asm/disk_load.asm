disk_load:			; 	A function to read from the disk
	push dx			;	Store 'dx' on stack for later recall

	mov ah, 0x02		; 	BIOS read sector function
	mov al, dh		;	Read DH sectors
	mov ch, 0x00		; 	Select cylinder 0
	mov dh, 0x00		;	Select head 0
	mov cl, 0x02		;	Start reading from the second sector (After the boot sector)
	
	int 0x13		;	BIOS interrupt

	jc disk_read_error	;	Jump if the carry flag is set (indicates disk error)

	pop dx
	cmp dh, al		;	See if we got as many sectors as expected
	jne disk_sector_error	;	Error if not
	ret

disk_read_error:
	mov bx, DISK_ERROR_MESSAGE
	call print
	jmp $

disk_sector_error:
	mov bx, DISK_SECTOR_MESSAGE
	call print
	jmp $

DISK_ERROR_MESSAGE: db "Disk read failed...",0
DISK_SECTOR_MESSAGE: db "Disk sector mismatch...",0

