;
; Extracts the first found base 10 number in a string
;
; Modified registers: rax, rdi, rsi, r8, r9
;
; -> rdi: address of the string to find number from
;
; <- rax: the first found number
;
global string_parse_base10_integer

bits 64

section .text

    string_parse_base10_integer:
        ; initial value
        xor rax, rax

        ; base = 10
        mov rsi, 10

        ; we're not on a number
        mov r8, 0

        ; no negative sign met
        mov r9, 0

        ; check null string
        cmp rdi, 0
        je .Lend

        .Lloop:
        ; check for string end
        cmp byte [rdi], 0
        je .Lreturn

        ; check ascii range
        cmp byte [rdi], '0'
        jl .Lnot_on_digit
        cmp byte [rdi], '9'
        jg .Lnot_on_digit

        ; we're on a number, add current digit and loop again
        mov r8, 1
        mul rsi
        add al, byte [rdi]
        sub rax, '0'
        jmp .Lnext_character

        .Lnot_on_digit:
        ; if we were on number before, parsing is over
        cmp r8, 1
        je .Lreturn

        ; check for negative sign
        cmp byte [rdi], '-'
        je .Lremember_minus
        jne .Lforget_minus

        .Lremember_minus:
        mov r9, 1
        jmp .Lnext_character

        .Lforget_minus:
        mov r9, 0
        jmp .Lnext_character

        .Lnext_character:
        inc rdi
        jmp .Lloop

        ; return positive value, or 2's complement
        .Lreturn:
        cmp r9, 0
        je .Lend
        xor rax, 0xffffffffffffffff
        inc rax

        .Lend:
        ret