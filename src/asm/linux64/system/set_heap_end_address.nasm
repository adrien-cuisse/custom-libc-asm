;
; Allocates memory
;
; Modified flags: rax
;
; -> rdi: the new heap end address
;
; <- rax:
;   - on success, the new heap end address
;   - on failure, the old break address
;
global set_heap_end_address

bits 64

%include "src/asm/macros/system_call_numbers.inc"

section .text

    set_heap_end_address:
        mov rax, system_call_brk_number
        syscall
        ret