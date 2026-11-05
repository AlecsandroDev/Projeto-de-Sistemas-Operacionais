; função para leitura de "n" setores no HD/SSD.
; a quantidade de setores a serem lidos devera ser colocada
; antes da chamada da rotina no registrador DH (8 bits mais 
; significativos do DX). o código da unidade a ser lida
; deve também já estar no DL (8 bits menos significativos do DX)
; ao término da função os dados lidos ficarão no endereço
; de memória apontado pelos registradores ES:BX
ler_disco:
    pusha
    push dx
    mov ah, 0x02 ; função 2 da bios (leitura de dados no HD)
    ; a função da BIOS procura em AL a quantidade de stores a ler
    mov al, dh;
    ; número do setor a ser lido (0x01 é o boot sector)
    mov cl, 0x02
    mov ch, 0x00 ; número do cilindro (hd)
    ; em DL colocamos o código (id) da unidade, sendo:
    ; 0x00 A:, 0x01 B:, 0x80 C:, 0x81 D:
    mov dl, 0x80
    mov dh, 0x00 ; número da "cabeça" (no caso de HD)
    int 0x13 ; interrupção 13 hexa: serviços de disco da bios
    ; se houve erro, o carry bit em FLAGS será setado para 1
    jc erro_disco ; pula para o tramtamento do erro_disco

    pop dx ; desempilhamos DX
    cmp al, dh ; comparar se foi lida a quantidade de setores desejada
    jne erro_setor ; JNE (se não for igual, pula para tratamento)
    popa ; se não houve erro, desempilha e encerra
    ret

erro_disco:
    mov bx, MENSAGEM_ERRO_DISCO
    call imprime
    call imprime_quebra
    mov dh, ah ; AH contém o código de erro
    call imprime_hexa ; imprime o código de erro na tela
    jmp loop_disco

erro_setor:
    mov bx, MENSAGEM_ERRO_SETOR
    call imprime

loop_disco: jmp $

MENSAGEM_ERRO_DISCO: db "Erro na leitura", 0
MENSAGEM_ERRO_SETOR: db "Quantidade incorreta de setores lidos", 0