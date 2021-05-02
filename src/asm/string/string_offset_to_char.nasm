
;
; Finds the offset to the a character from a string
;
; Modified flags: rax
;
; -> rdi: haystack: the address of a string to start iterating from
; -> rsi: needle: the character to find
;
; <- rax:
;   - on success, the distance from the string to the character,
;   - on failure: -1 if given null string or if character isn't found
;
global string_offset_to_char

bits 64

section .text

    string_offset_to_char:
        ; check for null haystack
        cmp rdi, 0
        je .Lcharacter_not_found

        ; initial offset
        mov rax, -1

        .Literate_haystack:
            inc rax

            ; check for match at current position
            cmp byte [rdi + rax], sil
            je .Lcharacter_found

            ; if end of haystack reached, needle wasn't found
            cmp byte [rdi + rax], 0
            je .Lcharacter_not_found

            jmp .Literate_haystack

        .Lcharacter_not_found:
            mov rax, -1

        .Lcharacter_found:
        ret