;
; Exits the program with given status code
;
; Modified flags: rax
;
; -> rdi: the status code
;
global exit_program

bits 64

%include "src/asm/macros/system_call_numbers.inc"

section .text

    exit_program:
        mov rax, system_call_exit_number,
        syscall
        ret