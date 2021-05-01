;
; Closes a file
;
; Modified flags: rax
;
; -> rdi: the file descriptor to close
;
; <- rax: 0 on success, negative value on error
;
global close_file

bits 64

%include "src/asm/macros/system_call_numbers.inc"

section .text

    close_file:
        mov rax, system_call_close_number
        syscall
        ret