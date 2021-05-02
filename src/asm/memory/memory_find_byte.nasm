;
; Finds a byte in a block
;
; Modified registers: rdi, rdx
;
; -> rdi: haystack, the memory block to scan
; -> rsi: needle: the byte to find
; -> rdx: bytes limit, how many bytes in the block to check at most
;
; <- rax:
;   - on success: the address of the first occurence of the byte in the block
;   - on failure: null (got null block or byte not found)
;
global memory_find_byte

bits 64

section .text

memory_find_byte:

    cmp rdi, 0
    jle .Lbyte_not_found

    .Literate_haystack:
        ; leave on bytes limit reached
        cmp rdx, 0
        je .Lbyte_not_found

        ; leave on byte found
        cmp byte [rdi], sil
        je .Lbyte_found

        ; go to next character and decrement limit
        inc rdi
        dec rdx

        jmp .Literate_haystack

    .Lbyte_found:
        mov rax, rdi
        je .Lend

    .Lbyte_not_found:
        xor rax, rax

    .Lend
    ret
