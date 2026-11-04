mov ah, 0x0e ; servico da BIOS de impressao na tela

mov bp, 0x8000 ; a base da nossa pilha ficará neste endereço
mov sp, bp ; no começo, o topo da pilha é a base também

; empilhamos os valores de três caracteres (três bytes)
push 'A'
push 'B'
push 'C'

; vamos começar imprimindo uma letra
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; o que temos no topo da pilha? vamos desempilhar e imprimir
pop bx
mov al, bl
int 0x10

; desempilhe e imprima na tela as outras duas letras
pop cx
mov al, cl
int 0x10

pop dx
mov al, dl
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55

