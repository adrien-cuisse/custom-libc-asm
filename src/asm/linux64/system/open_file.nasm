;
; Opens a file
;
; Modified flags: rax
;
; -> rdi: the path to the file
; -> rsi: flags, 0 for read, 1 for write
;
; <- rax: a file descriptor (integer > 0) on success, negative value on error
;
global open_file

bits 64

%include "src/asm/macros/system_call_numbers.inc"

section .text

    open_file:
        mov rax, system_call_open_number
        syscall
        ret