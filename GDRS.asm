section     .text

[section .data]
    layer4 dd 0, 3h
    layer5 dd 0, 3h
    layer6 dd 0, 3h

[section .code]

copy:
    call Finish
    pop eax
    pop ecx
    pop esi
    pop edi
    repz movsb
    push eax
ret

put:
    call Finish
    pop eax
    mov [layer4], eax
    pop ecx
    pop ebx ;offset
    pop esi ;the array addition
    pop edi ;to add here
    add edi, ebx ;give the main array index to add the offset
    repz movsb
    mov eax, dword [layer4]
    push eax
ret

toChar:
    call Finish
    pop ebx
    pop edi
    pop esi ;source of the string
    FORCHAR:
        mov al, byte [esi]
        add al, 48
        mov [esi], al
        add esi, 1b
        cmp ecx, edi
        inc ecx
        jbe FORCHAR
    push ebx
ret



;LAYER 5 FUNCTIONS

getByte:
    call Finish
    pop eax
    mov [layer5], eax
    pop ebx
    pop esi
    pop edi
    xchg ecx, ecx
    getbit:
        mov al, byte [esi]
        mov [edi], al
        add esi, 1b
        add edi, 1b
        add ecx, 1
        cmp al, ";"
        je ENDOFSTRING
        cmp al, bl
        jne getbit
    ENDOFSTRING:
    push esi
    mov eax, dword [layer5]
    push eax
ret

DBgetByte:
    pop eax
    mov [layer6], eax
    pop ebx
    pop esi
    pop edi
    xchg ecx, ecx
    DBgetbit:
        mov al, byte [esi]
        mov [edi], al
        add esi, 1b
        add edi, 1b
        add ecx, 1
        cmp al, ";"
        je DBENDOFSTRING
        cmp al, bl
        jne DBgetbit
    DBENDOFSTRING:
    push esi
    mov eax, dword [layer6]
    push eax
ret