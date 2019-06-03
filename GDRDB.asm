[section .data]
    layer7 dd 0, ";"
    layer8 dd 0, ";"
    layer9 dd 0, ";"
    calls times 1024 dd 0, 0, " "
    db ";"
            ;call loation, times called.
    callIndex dd 0, ";"

[section .code]

Finish:
    pop eax                 ;the returning point.
    mov [layer7], eax       ;saving the returning point.

    lea edi, [calls]        ;we want to search : is that call already made or not.
    lea esi, [calls]        ;and then just give back the ones that we dont need.
    mov ebx, eax            ;this is what we want

    ;AND NOW PUT THE VALUES AS PARAMETERS FOR GETBYTE CALL;

    push edi
    push esi
    push ebx
    call DBgetByte
    
    pop esi                 ;this is where the call is (if it is called).
    ;AND NOW WE NEED TO CHECK IF IT DOES EVEN EXIST.
    cmp esi, 1024
    jge NewCall             ;if it is brand new function call. then add it.
    ;IF IT IS NOT A NEW FUNCTION CALL THEN INCREASE THE, BEEN VALUE BY 1.
    lea edi, calls[esi]     ;give edi the total offset of the function in calls list.
    inc edi ;and now it is prepesenting the amount that function is called.
    mov eax, dword [edi]    ;give eax, edi to increase the value init by 1.
    add eax, 1              ;like this.
    ;AND NOW WE WANT TO GIVE IT BACK TO THE CALLS LIST.
    mov [edi], eax
    jmp ReturningPoint      ;to avoid the New call from happening because it already exist.

    NewCall:
        ;HERE WE WANT TO ADD THE CORDINATE OF THE NEW FUNCTION CALL.
        mov edi, dword [callIndex]  ;give the offset to new slot to insert the function address.
        mov eax, dword [layer7]     ;give eax the addres of the new function call.
        mov calls[edi], eax         ;put the new function caal to the calls list

    ReturningPoint:
        mov eax, dword [layer7]     ;give the returning point.
        push eax
ret                         ;return


Tell.Process:
    pop eax
    mov[layer8], eax
    push calls
    call gout
    mov eax, dword [layer8]
    push eax
ret

