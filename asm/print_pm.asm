[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_pm:
        pusha
        mov edx, VIDEO_MEMORY

print_string_pm_loop:
        mov al, [ebx]           ;       Store the char at ebx in al
        mov ah, WHITE_ON_BLACK  ;       Store the attributes in ah
        
        cmp al, 0
        je print_string_pm_done

        mov [edx], ax           ;       Sore char and attributes at current character

        add ebx, 1              ;       Increment char in string
        add edx, 2              ;       Increment memory location

        jmp print_string_pm_loop

print_string_pm_done:
        popa
        ret

