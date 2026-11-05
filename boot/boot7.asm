[org 0x7c00]
mov bp, 0x8000 ; endereço da base da pilha
mov sp, bp     ; ponteiro do topo aponta para a base incialmente

mov bx, 0x9000 ; endereço da memória dos dados lidos
mov dh, 2      ; vamos ler dois setores

call ler_disco

mov dx, [0x9000] ; começo dos dados do primeiro setor
call imprime_hexa ; imprimimos o valor no endereço
call imprime_quebra

mov dx, [0x9000 + 512] ; começo do segundo setor
call imprime_hexa
call imprime_quebra

jmp $

%include "imprime.asm"
%include "imprime_hexa.asm"
%include "ler_disco.asm"

times 510-($-$$) db 0
dw 0xaa55

; conteúdo para o primeirio setor a ser lido
times 256 dw 0xcafe
; conteúdo para o segundo setor a ser lido
times 256 dw 0xfada