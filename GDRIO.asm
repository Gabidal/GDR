section     .text


%macro array 2
    [section .bss]
    %1 resb %2
    [section .data]
        db ";"
%endmacro

[section .bss]
    array input, 128
    array fd_out, 1
    array fd_in, 1
    array buffer, 24
[section .data]
    error db "  Error:: ", ";"
    layer1 dd 0, ";"
    layer2 dd 0, ";"
    layer3 dd 0, ";"
    num dd 0, ";"


section .text

;LAYER 1 FUNCTIONS

gout:
    pop eax
    mov [layer1], eax
    call Finish
    pop edi  ;copy
    push edi ;paste
    call DBgetLenght
    pop edx
    mov ecx, edi
    mov ebx, 1
    mov eax, 4
    int 80h
    mov eax, dword [layer1]
    push eax
ret

gin:
    call Finish
    pop eax
    mov [layer1], eax
    mov eax, 3
    mov ebx, 2
    pop ecx
    mov edx, 128
    int 80h
    mov eax, dword [layer1]
    push eax
ret

getLenght:
    pop eax
    mov [layer2], eax
    call Finish
    pop esi ;get pointer to string
    xchg ecx, ecx
    getLenghtlop:
        mov bl, byte [esi]
        inc esi
        add ecx, 1
        cmp bl, ";"
        jne getLenghtlop
        sub ecx, 1
    push ecx
    mov eax, dword [layer2]
    push eax
ret

DBgetLenght:
    pop eax
    mov [layer3], eax
    pop esi ;get pointer to string
    xchg ecx, ecx
    DBgetLenghtlop:
        mov bl, byte [esi]
        inc esi
        add ecx, 1
        cmp bl, ";"
        jne DBgetLenghtlop
        sub ecx, 1
    push ecx
    mov eax, dword [layer3]
    push eax
ret


nout:
    call Finish
    pop eax
    mov [layer1], eax
    pop edx
    mov [num], edx
    push num
    pop edx
    mov ecx, 4
    mov ebx, 1
    mov eax, 4
    int 80h
    mov eax, dword [layer1]
    push eax
ret

;LAYER 2 FUNCTIONS

createFile:
    pop eax
    mov [layer2], eax
    call Finish
    mov  eax, 8
    pop ebx
    mov  ecx, 0777
    int  0x80
    mov [fd_out], eax ;out
    mov eax, dword [layer2]
    push eax
ret

writeFile:
    pop eax
    mov [layer2], eax
    call Finish
    pop edx
    pop ecx
    mov	ebx, [fd_out]   ;out
    mov	eax,4
    int	0x80
    mov eax, dword [layer2]
    push eax
ret

closeFile:
    call Finish
    mov eax, 6
    mov ebx, [fd_out]  ;out
ret

openFile:
    pop eax
    mov [layer2], eax
    call Finish
    mov eax, 5
    pop ebx
    mov ecx, 0
    mov edx, 0777
    int  0x80
    mov  [fd_in], eax
    mov eax, dword [layer2]
    push eax
ret

readFile:
    pop eax
    mov [layer2], eax
    call Finish
    pop edx
    pop ecx
    mov eax, 3
    mov ebx, [fd_in]
    int 0x80
    mov eax, dword [layer2]
    push eax
ret

;LAYER 3 FUNCTIONS


