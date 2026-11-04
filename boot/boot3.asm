mov ah, 0x0e

mov al, '1'
int 0x10            ; imprime o número 1
mov al, [0x7c0d]    
int 0x10            ; o que vai ser impresso?

jmp $

segredo:
    db 'X'

times 510-($-$$) db 0
dw 0xaa55
