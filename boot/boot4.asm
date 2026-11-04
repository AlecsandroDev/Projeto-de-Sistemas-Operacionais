[org 0x7c00]   ; indica a posição na memória RAM a partir
; da qual o programa será armazenado. o assembler ajustará
; todos os endereços do programa relativamente a ele
mov ah, 0x0e

mov al, '1'
int 0x10            ; imprime o número 1
mov al, [segredo]    
int 0x10            ; o que vai ser impresso?

jmp $

segredo:
    db 'X'

times 510-($-$$) db 0
dw 0xaa55
