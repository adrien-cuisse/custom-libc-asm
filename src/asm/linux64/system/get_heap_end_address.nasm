;
; Returns the address of the end of the heap
;
; Modified flags: rax, rdi
;
; <- rax: the adress of the end of the heap
;
global get_heap_end_address

bits 64

%include "src/asm/macros/system_call_numbers.inc"

section .text

    get_heap_end_address:
        mov rax, system_call_brk_number
        xor rdi, rdi
        syscall
        ret
