;
; Finds the address where the substring occurs for the first time in the first string
;
; rdi -> haystack: address to string to search in
; rsi -> needle: the string to find
;
; Modified registers: rax, rdi, rcx, r8, r9, r10
;
; <- rax:
;   - if found, the address of the first occurence of [rsi] inside [rdi]
;   - if not found or null strings given, 0
;
global string_address_of_substring

bits 64

section .text

    string_address_of_substring:
        ; no matching streak starting address
        mov rax, 0

        ; leave if haystack or needle are null
        cmp rdi, 0
        je .Lend
        cmp rsi, 0
        je .Lend

        ; position in needle
        mov rcx, 0

        ; we're not on a matching streak
        mov r8, 0

        .Literate_haystack:
            ; leave loop if end of haystack or needle is reached
            cmp byte [rsi + rcx], 0
            je .Lneedle_end
            cmp byte [rdi], 0
            je .Lhaystack_end

            ; compare characters
            mov r9b, byte [rdi]
            cmp r9b, byte [rsi + rcx]
            jne .Lcharacters_mismatch

            .Lcharacters_match:
                ; check if it's the begin of a matching streak
                cmp r8, 0
                jne .Lneedle_further_character_match

                .Lmatching_streak_start:
                    ; store the address where streak starts
                    mov rax, rdi
                    ; increment position in both strings
                    inc rdi
                    inc rcx
                    ; begin the matching streak
                    mov r8, 1
                    jmp .Literate_haystack

                .Lneedle_further_character_match:
                    ; increment position in both strings
                    inc rdi
                    inc rcx
                    jmp .Literate_haystack

            .Lcharacters_mismatch:
                ; rewind needle position
                mov rcx, 0
                ; check if we were previously on a streak
                cmp r8, 1
                je .Lmatching_streak_end
                ; we weren't on a matching streak (ie., we're at the beginning of the needle), just go further in haystack
                ;inc rdi
                jmp .Literate_haystack

                .Lmatching_streak_end:
                    ; end the streak and erase the address where it began
                    mov r8, 0
                    mov rax, 0
                    jmp .Literate_haystack

        .Lhaystack_end:
            ; check if we reached end of the needle
            cmp byte [rsi + rcx], 0
            jne .Lneedle_not_found

        .Lneedle_end:
            ; if end of needle was reached on a streak, all of its characters were found
            cmp r8, 1
            je .Lend

        .Lneedle_not_found:
        mov rax, 0

        .Lend:
        ret