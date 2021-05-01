;
; Writes to the given file
; Doesn't check if asked to write more bytes than the text contains
;
; Modified flags: rax
;
; -> rdi: the file descriptor where to write
; -> rsi: the text to write
; -> rdx: how many bytes to write
;
; <- rax: how many bytes were read (integer >= 0), or negative integer on error
;
global write_file

bits 64

%include "src/asm/macros/system_call_numbers.inc"

section .text

    write_file:
        mov rax, system_call_write_number
        syscall
        ret

