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
        ; parsed number initial value
        xor rax, rax

        ; leave on null strings
        cmp rdi, 0
        je .Lend
        cmp rsi, 0
        je .Lend

        ; position in base-string
        xor r11, r11

        ; the base (ie., 10, 16)
        xor r9, r9

        .Lcompute_base:
            inc r9
            inc r11
            cmp byte [rsi + r11], 0
            jne .Lcompute_base

        ; initial position in number-string
        xor r10, r10

        ; no number found yet
        xor r13, r13

        .LIterate_number_string:
            ; check end of number-string
            cmp byte [rdi + r10], 0
            je .Lnumber_string_end_reached

            ; rewind position in base-string
            xor r11, r11

            ; didn't find yet a matching digit from base-string
            xor r14, r14

            .Literate_base_string:
                ; check end of base-string
                cmp byte [rsi + r11], 0
                je .Lbase_string_end_reached
                ; compare bytes from the 2 strings
                mov r15b, byte [rdi + r10]
                cmp r15b, byte [rsi + r11]
                jne .Lnext_base_character

                .Lcharacters_match:
                    ; add digit to parsed integer
                    mul r9
                    add rax, r11
                    ; remember we found a number
                    mov r13, 1
                    mov r14, 1
                    jmp .Lbase_string_end_reached

                .Lnext_base_character:
                    inc r11
                    jmp .Literate_base_string

            .Lbase_string_end_reached:
                ; if we already found a number, but no digit during this inner loop, parsing is over
                cmp r14, 0
                je .Lnumber_string_end_reached
                ; next character in number-string
                inc r10
                jmp .LIterate_number_string

        .Lnumber_string_end_reached:
        .Lend:
        ret