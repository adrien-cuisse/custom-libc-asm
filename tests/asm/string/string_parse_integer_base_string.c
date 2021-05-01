
#include <criterion/criterion.h>

#define OCTAL_BASE "01234567"
#define DECIMAL_BASE "0123456789"
#define HEXA_BASE "0123456789abcdef"

extern long string_parse_integer_base_string(char const * const string, char const * const base);

// Test(string, parse_base_string_rejects_nulls) {
//     int parsedInteger;

//     parsedInteger = string_parse_integer_base_string(0, "test");
//     cr_assert_eq(
//         parsedInteger,
//         0,
//         "Expected to return 0 when given null string, got %d", parsedInteger
//     );

//     parsedInteger = string_parse_integer_base_string("test", 0);
//     cr_assert_eq(
//         parsedInteger,
//         0,
//         "Expected to return 0 when given null string, got %d", parsedInteger
//     );
// }

// Test(string, parse_base_string_hexa_one_digit) {
//     long parsedInteger = string_parse_integer_base_string("c", HEXA_BASE);

//     cr_assert_eq(
//         parsedInteger,
//         0xc,
//         "Expected to parse 0x%x, got 0x%x", 0xc, parsedInteger
//     );
// }

// Test(string, parse_base_string_hexa_several_digits) {
//     long parsedInteger = string_parse_integer_base_string("c0ff33", HEXA_BASE);

//     cr_assert_eq(
//         parsedInteger,
//         0xc0ff33,
//         "Expected to parse 0x%x, got 0x%x", 0xc0ff3, parsedInteger
//     );
// }

Test(string, parse_base_string_hexa_only_first_number) {
    long parsedInteger = string_parse_integer_base_string("dead beef", HEXA_BASE);

    cr_assert_eq(
        parsedInteger,
        0xdead,
        "Expected to parse 0x%x, got 0x%x", 0xdead, parsedInteger
    );
}
