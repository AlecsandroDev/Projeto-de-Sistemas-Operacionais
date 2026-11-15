; primeira versão do boot sector que evoluirá para 32 bits
[org 0x7c00]
mov bp, 0x9000 ; definição do endereço da base da pilha
mov sp, bp ; o topo (sp: stack pointer) é igual à base no início

; ainda estamos em 16 bits. vamos imprimir uma mensagem
; usando a BIOS (rotina imprime em "imprime.asm")
mov bx, MENSAGEM_EM_MODO_REAL
call imprime

; chamamos agora a rotina para mudar para 32 bits escrita no
; arquivo "modo32.asm"
call mudar_para_modo_protegido

jmp $ ; loop porque ainda não podemos carregar o kernel

; inclusão de rotinas em outros arquivos
%include "imprime.asm" ; imressão em 16 bits pela bios
%include "gdt32.asm" ; definição da Global Descriptor Table
%include "imprime32.asm" ; impressão em 32 bits (memória de vídeo)
%include "modo32.asm" ; rotinas que ativam modo 32 bits do proc.

[bits 32] ; ponto de retorno após entrar em 32 bits
INICIAR_MP:
    mov ebx, MENSAGEM_EM_MODO_PROTEGIDO
    call imprime_mp
    jmp $

MENSAGEM_EM_MODO_REAL db "Iniciando em modo real (16 bits)", 0
MENSAGEM_EM_MODO_PROTEGIDO db "Agora em modo protegido (32 bits)", 0

; restante do boot sector
times 510-($-$$) db 0
dw 0xaa55