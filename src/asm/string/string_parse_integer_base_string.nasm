;
; Extracts the first found integer in the number-string which is made of digits from the base-string
;
; Modified registers: rax, r9, r10, r11, r13, r14, r15
;
; -> rdi: address of the number-string to find number from
; -> rsi: address of the base-string
;
; <- rax: the first found number
;
global string_parse_integer_base_string

bits 64

section .text

    string_parse_integer_base_string:
        ; check null strings
        cmp rdi, 0
        je .Lend
        cmp rsi, 0
        je .Lend

        ; parsed number initial value
        mov rax, 0

        ; position in base-string
        mov r11, 0

        ; the base (ie., 10, 16)
        mov r9, 0

        ; no number found yet
        mov r13, 0

        .Lcompute_base:
        cmp byte [rsi + r11], 0
        je .Lcomputing_base_complete
        inc r9
        inc r11
        jmp .Lcompute_base
        .Lcomputing_base_complete:

        ; position in number-string
        mov r10, 0

        .Lloop_number_string:
            ; check end of number-string
            cmp byte [rdi + r10], 0
            je .Lloop_number_string_end

            ; position in base-string
            mov r11, 0

            ; didn't find yet a matching digit from base-string
            mov r14, 0

            .Lloop_base_string:
                ; check end of base-string
                cmp byte [rsi + r11], 0
                je .Lloop_base_string_end

                ; compare bytes from the 2 strings
                mov r15b, byte [rdi + r10]
                cmp r15b, byte [rsi + r11]
                jne .Lnext_base_character

                ; add digit and iterate outer loop, remembering we found a number
                mul r9
                add rax, r11
                mov r13, 1
                mov r14, 1
                jmp .Lloop_base_string_end

                .Lnext_base_character:
                inc r11
                jmp .Lloop_base_string

            .Lloop_base_string_end:
            ; if we already found a number, but no digit during this inner loop, parsing is over
            cmp r14, 0
            je .Lloop_number_string_end
            ; next character in number-string
            inc r10
            jmp .Lloop_number_string

        .Lloop_number_string_end:

        .Lend:
        ret