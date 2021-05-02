
#include <criterion/criterion.h>

extern int string_offset_to_char(char const * const haystack, char needle);

Test(string_offset_to_char, null_haystack_error_code) {
    int errorCode = string_offset_to_char(0, 'k');

    cr_assert_eq(
        errorCode,
        -1,
        "Expected to get error code -1 when given null string, got %d", errorCode
    );
}

Test(string_offset_to_char, match_at_starting_position) {
    int characterPosition = string_offset_to_char("string", 's');

    cr_assert_eq(
        characterPosition,
        0,
        "Expected first occurence of 's' in 'string' to be at position 0, got %d", characterPosition
    );
}

Test(string_offset_to_char, match_at_any_position) {
    int characterPosition = string_offset_to_char("string", 'r');

    cr_assert_eq(
        characterPosition,
        2,
        "Expected first occurence of 'r' in 'string' to be at position 2, got %d", characterPosition
    );
}

Test(string_offset_to_char, match_first_occurence) {
    int characterPosition = string_offset_to_char("stress test", 't');

    cr_assert_eq(
        characterPosition,
        1,
        "Expected to get first occurence of 't' in 'test' at position 1, got %d", characterPosition
    );
}

Test(string_offset_to_char, not_found_error_code) {
    int errorCode = string_offset_to_char("test", 'k');

    cr_assert_eq(
        errorCode,
        -1,
        "Expected to get error code -1 when character isn't found, got %d", errorCode
    );
}
