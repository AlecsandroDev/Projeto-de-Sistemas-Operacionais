; "função" de impressão de valores hexadecimais na tela

; o valor a ser impresso deve estar no registrador DX
; para entender os comentários, suponha que DX = 0x1234

imprime_hexa:
    pusha ; empilha os valores de AX, BX, CX e DX
    mov cx, 0 ; CX servirá como um índice ou contador

; algoritmo: obter o último número em DX e convertê-lo para hexa
; na tabela ASCII, '0' é igual a 0x30, e assim sucessivamente até
; '9', que corresponde a 0x39. dessa forma, para valores entre 0
; e 9 basta somar 0x30 para obtermos o caractere equivalente ASC.
; já para os valores alfabéticos (A-F), na tabela ASC 'A' é 0x41
; assim sucessivamente até 'F', que é 0x46. então, nestes casos,
; devemos somar 0x07 além de 0x30.
; em seguida, copiamos o valor resultante para uma posição na
; string destino
hexa_loop:
    cmp cx, 4 ; converteremos apenas 4 digitos hexa (2 bytes) de
; cada vez. por isso, se cx for igual a quatro a conversão acabou
    je fim_hexa
; converte o último digito do valor em DX no seu equivalente ASC
    mov ax, dx ; copiamos o valor de DX para AX
; AND bit a bit em AX, fazendo sobrar apenas o último número
    and ax, 0x000F
; agora em AX só ficou o último digito. somamos 0x30 a ele
    add al, 0x30
; comparamos o valor em AX com 0x39
; se FOR MENOR OU IGUAL a 0x39, o número é de 1 a 9. saltamos
; para o próximo passo
    jle passo2 ; JLE = Jump if Less or Equal
; se não, é porque o valor está entre A e F. nestes casos,
; precisamos somar mais 7 para obter o ASC da letra
    add al, 7

passo2:    
    ; agora precisamos "colocar" o valor na string convertida
    mov bx, STRING_SAIDA + 5
    ; colocamos os valores da direita para a esquerda
    sub bx, cx ; lembre-se que CX contém um contador de caracteres
    mov [bx], al ; copia o valor ASCII em AL para BX
    ror dx, 4 ; rotaciona o valor em DX por quatro bits
    ; antes do ror: DX = 0x1234
    ; depois do primeiro ror: DX = 0x4123
    ; depois do segundo ror: DX = 0x3412
    ; depois do terceiro ror: DX = 0x2341
    ; depois do quarto (e último) ror: DX = 0x123
    add cx, 1 ; acrescentamos 1 no contador
    jmp hexa_loop ; volta o loop

fim_hexa:
    mov bx, STRING_SAIDA
    call imprime
    popa
    ret

STRING_SAIDA:   
    db '0x0000', 0 ; espaço na memória para a string convertida
    