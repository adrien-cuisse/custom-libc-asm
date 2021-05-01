;
; Gets the absolute path to the current directory
;
; Modified flags: rax
;
; -> rdi: buffer no store the path in
;
; <- rax:
;   - how many bytes were writen in the buffer (integer > 0, including null-terminating character),
;   - negative integer on error (eg., buffer not big enough)
;
global get_working_directory

bits 64

%include "src/asm/macros/system_call_numbers.inc"

section .text

    get_working_directory:
        mov rax, system_call_getcwd_number
        syscall
        ret