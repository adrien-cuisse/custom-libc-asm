;
; Finds the address where the substring occurs for the first time in the first string
;
; rdi -> haystack: address to string to search in
; rsi -> needle: the string to find
;
; Modified registers: rax, rdx, rcx, r8, r9, r10
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

        ; position in haystack
        mov rdx, 0

        ; position in needle
        mov rcx, 0

        ; we're not on a matching streak
        mov r8, 0

        .Lloop:
            ; check end of strings
            cmp byte [rdi + rdx], 0
            je .Lloop_end
            cmp byte [rsi + rcx], 0
            je .Lloop_end

            ; compare characters
            mov r9b, byte [rdi + rdx]
            cmp r9b, byte [rsi + rcx]
            jne .Lcharacters_mismatch

            .Lcharacters_match:
            ; check if it's the begin of a matching streak
            cmp r8, 0
            jne .Lneedle_further_character_match

            .Lmatching_streak_start:
            ; remember the address where streak starts
            mov rax, rdi
            add rax, rdx
            ; increment both positions
            inc rdx
            inc rcx
            ; begin the matching streak
            mov r8, 1
            jmp .Lloop

            .Lneedle_further_character_match:
            ; increment both positions
            inc rdx
            inc rcx
            jmp .Lloop

            .Lcharacters_mismatch:
            ; rewind needle position
            mov rcx, 0

            ; check if we were previously on a streak
            cmp r8, 1
            je .Lmatching_streak_end

            ; we weren't on a matching streak (ie., we're at the beginning of the needle), just go further in haystack
            inc rdx
            jmp .Lloop

            .Lmatching_streak_end:
            ; end the streak and erase the address where it began
            mov r8, 0
            mov rax, 0
            jmp .Lloop

        .Lloop_end:
        ; if end of needle was reached on a streak, all of its characters were found
        cmp byte [rsi + rcx], 0
        jne .Lsubstring_not_found
        cmp r8, 1
        jne .Lsubstring_not_found
        jmp .Lend

        .Lsubstring_not_found:
        mov rax, 0

        .Lend:
        ret










;        ; initial address
;        mov rax, 0
;
;        ; check null strings
;        cmp rdi, 0
;        je .Lend
;        cmp rsi, 0
;        je .Lend
;
;        ; position in haystack
;        mov rdx, 0
;
;        ; position in needle
;        mov rcx, 0
;
;        ; no characters from needle met yet
;        mov r8, 0
;
;        .Lhaystack_loop:
;            ; check end of haystack
;            cmp byte [rdi + rdx], 0
;            je .Lhaystack_loop_end
;
;            .Lneedle_loop:
;                ; check end of needle, which means ???
;                cmp byte [rsi + rcx], 0
;                je .Lhaystack_loop_end
;
;                ; compare characters at current position
;                mov r8b, byte [rdi + rdx]
;                cmp r8b, byte [rsi + rcx]
;                je .Lcharacters_match
;                jne .Lcharacters_mismatch
;
;                .Lcharacters_match:
;                ; increment both positions
;                inc rdx
;                inc rcx
;                ; check if it's the first match or not
;                cmp r8, 1
;                je .Lfurther_needle_character_matched
;
;                .Lfirst_needle_character_matched:
;                ; store current address in haystack
;                mov rax, rdi
;                add rax, rdx
;                ; remembering we met characters from needle
;                mov r8, 1
;
;                .Lfurther_needle_character_matched:
;                jmp .Lneedle_loop
;
;                .Lcharacters_mismatch:
;                ; reset position in needle
;                mov rcx, 0
;                inc rdx
;                ; erase the address where to started matching
;                ; mov rax, 0
;                ; forget we met characters from needle
;                mov r8, 0
;                jmp .Lneedle_loop
;
;            .Lneedle_loop_end:
;            jmp .Lhaystack_loop
;
;        .Lhaystack_loop_end:
;        ; check if we were on matching streak when needle ended
;        cmp r8, 1
;        jne .Lend
;        mov rax, 0
;
;        .Lend:
;        ret