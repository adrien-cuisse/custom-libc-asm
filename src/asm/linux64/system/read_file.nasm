;
; Reads from a file
;
; Modified flags: rax
;
; -> rdi: file descriptor to read from
; -> rsi: buffer to store read text
; -> rdx: how many bytes to read at most
;
; <- rax: the number of read bytes (integer >= 0), or negative integer on error
;
global read_file

bits 64

%include "src/asm/macros/system_call_numbers.inc"

section .text

    read_file:
        mov rax, system_call_read_number
        syscall
        ret