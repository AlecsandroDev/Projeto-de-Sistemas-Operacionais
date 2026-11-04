[org 0x7c00] ; endereço na memória onde este setor de boot será
             ; carregado

mov bx, mensagem1
call imprime ; chama a funlçao "pulando" para o rótulo
call imprime_quebra

mov bx, mensagem2
call imprime
call imprime_quebra

mov bx, mensagem3
call imprime

mov dx, 0xCAFE
call imprime_hexa

jmp $

%include "imprime.asm"
%include "imprime_hexa.asm"

mensagem1:
    db "Bem-vindo(a) ao UNImariX 0.1!", 0

mensagem2:
    db "Sistema Operacional da Computacao 6B", 0

mensagem3:
    db "Carregando o kernel do sistema...", 0

times 510-($-$$) db 0
dw 0xaa55
