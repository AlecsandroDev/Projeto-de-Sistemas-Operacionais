# Projeto de Sistemas Operacionais

Este repositório destina-se ao armazenamento, versionamento e acompanhamento dos códigos práticos, experimentos e rotinas desenvolvidos em sala de aula durante a disciplina de **Projeto de Sistemas Operacionais**.

---

## 👥 Integrantes do Grupo

| Nome | RA |
| :--- | :---: |
| **Alecsandro Costa Santos** | 1986042 |
| **Ana Júlia Pereira Romera** | 1986827 |
| **Gabriela Akemi Rejane Hizukuri Santos** | 2017418 |
| **Miguel da Silva Leite Felipe** | 1999127 |
| **Sophia Mattos** | 2001960 |
| **Thauanny da Cruz** | 2002166 |

---

## 📌 Contexto & Propósito

O repositório funciona como *storage* central para os exercícios e projetos práticos realizados ao longo do curso, contemplando:

- Desenvolvimento e experimentação com rotinas de inicialização (*bootloaders* e código de baixo nível em Assembly).
- Manipulação direta de hardware, leitura de disco e interrupções da BIOS.
- Testes e execução em ambientes emulados e imagens de sistema.

---

## 📂 Estrutura do Repositório

```text
├── boot/       # Rotinas em Assembly (bootloaders, manipulação de disco, I/O)
├── iso/        # Imagens ISO e arquivos de base para testes e emulação
├── .gitignore  # Regras para ignorar binários (.bin) e ISOs
└── README.md   # Documentação e identificação do grupo
```

---

## 🚀 Como Compilar e Executar

### Pré-requisitos

Certifique-se de ter instalado o montador **NASM** e o emulador **QEMU**:

```bash
# No Ubuntu/Debian ou derivados:
sudo apt update
sudo apt install nasm qemu-system-x86
```

---

### 1. Compilação (Gerando o arquivo `.bin`)

Entre na pasta `boot/` e use o **NASM** com formato binário puro (`-f bin`):

```bash
cd boot

# Exemplo para compilar o boot7.asm:
nasm -f bin boot7.asm -o boot7.bin
```

> **Nota:** Certifique-se de estar dentro da pasta `boot/` ao compilar arquivos que utilizam diretivas `%include`, para que os arquivos auxiliares (`imprime.asm`, `imprime_hexa.asm`, `ler_disco.asm`) sejam encontrados corretamente.

---

### 2. Executando no QEMU

Você pode rodar a imagem binária gerada no emulador QEMU de duas formas:

#### Opção A: Como drive de disco rígido (Recomendado para rotinas com leitura de HD como `boot7`)
```bash
qemu-system-x86_64 -drive format=raw,file=boot7.bin
```

#### Opção B: Como disquete (Modo simples)
```bash
qemu-system-x86_64 -fda boot7.bin
```

Para fechar o QEMU, basta fechar a janela da máquina virtual ou pressionar `Ctrl + Alt` para liberar o mouse e finalizar a janela.
