;
; Computes the lenght of a null-terminated string
;
; Modified flags: rax
;
; -> rdi: to string to get lenght for
;
; <- rax: the lenght of the string from the given address to the null-terminating byte, or -1 for null string
;
global string_length

bits 64

section .text

    string_length:
        ; initial length
        mov rax, -1

        ; leave on null string
        cmp rdi, 0
        je .Lstring_length_end

        ; loop until null terminating-byte
        .Lstring_length_loop:
            inc rax
            cmp byte [rdi + rax], 0
            jne .Lstring_length_loop

        .Lstring_length_end:
            ret