
#include <criterion/criterion.h>

extern int string_length(char const * const string);

Test(string_length, null) {
    int errorCode = string_length(0);

    cr_assert_eq(
        errorCode,
        -1,
        "Expected error code to be -1 when given null string, got %d", errorCode
    );
}

Test(string_length, empty) {
    int length = string_length("");

    cr_assert_eq(
        length,
        0,
        "Expected lenght to be 0 for empty string, got %d", length
    );
}

Test(string_length, correct_length) {
    char * string = "Hello, World!\n";
    int length = string_length(string);

    cr_assert_eq(
        length,
        14,
        "Expected lenght to be 14 for string '%s', got %d", string, length
    );
}
