
;
; Finds the offset to the a character from a string
;
; Modified flags: rax
;
; -> rdi: the address to start iteration from
; -> rsi: the character to find
;
; <- rax: the distance from the string to the character, or -1 for null string, or -2 if character isn't found
;
global string_offset_to_char

bits 64

section .text

    string_offset_to_char:
        ; check for null string
        cmp rdi, 0
        je .Lstring_offset_to_char_null_string

        ; initial offset
        xor rax, rax

        ; loop until null-terminating byte or first occurence
        .Lstring_offset_to_char_loop:
        ; check for match with character
        cmp byte [rdi + rax], sil
        je .Lstring_offset_to_char_found
        ; check end of string
        cmp byte [rdi + rax], 0
        je .Lstring_offset_to_char_not_found
        ; increment and loop again
        inc rax
        jmp .Lstring_offset_to_char_loop

        ; null string, return -2
        .Lstring_offset_to_char_null_string:
        mov rax, -2
        ret

        ; not found, return -1
        .Lstring_offset_to_char_not_found:
        mov rax, -1

        .Lstring_offset_to_char_found:
        ret