mov ah, 0x0e   ; código hexadecimal para o serviço da BIOS
mov al, 'U'
int 0x10       ; interrupção que chama o serviço da BIOS
mov al, 'n'
int 0x10
mov al, 'i'
int 0x10
mov al, 'm'
int 0x10
mov al, 'a'
int 0x10
mov al, 'r'
int 0x10
mov al, 'i'
int 0x10
mov al, 'x'
int 0x10
; escreva na tela na mesma linha "Unimarix v0.1"
mov al, ' '
int 0x10
mov al, 'v'
int 0x10
mov al, '0'
int 0x10
mov al, '.'
int 0x10
mov al, '1'
int 0x10

jmp $   ; outra forma de fazer um loop infinito

times 510-($-$$) db 0
dw 0xaa55