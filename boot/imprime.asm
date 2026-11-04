; "função" de impressão de strings na tela

; ponto de entrada da função
imprime:
    pusha ; "push all" empilha os valores dos registradores

inicio:
    mov al, [bx] ; BX vai conter o endereço da string
    cmp al, 0 ; compara se o valor em AL é zero (fim da string)
    je fim ; se for zero, salta para "fim". se não, continua
    
    mov ah, 0x0e ; código da função da BIOS de impressão
    int 0x10 ; interrupção que chama a BIOS

    add bx, 1 ; incrementa o endereço em BX (ponteiro da string)
    jmp inicio ; volta ao início (loop)

fim:
    popa ; desempilha e devolve os valores aos registradores
    ret  ; termina a "função" e retora ao ponto em que foi chamada

imprime_quebra:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; código do "new line" (nova linha)
    int 0x10

    mov al, 0x0d ; códig do "carriage return" (retorno do carro)
    int 0x10

    popa
    ret
