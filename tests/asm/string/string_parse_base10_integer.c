
#include <criterion/criterion.h>

extern int string_parse_base10_integer(char const * const string);

Test(string, parse_decimal_integer) {
    int parsedInteger = string_parse_base10_integer("42");

    cr_assert_eq(
        parsedInteger,
        42,
        "Expected to parse integer 42, got %d", parsedInteger
    );
}

Test(string, parse_decimal_integer_any_position) {
    int parsedInteger = string_parse_base10_integer(";k Hsh) z1664pX g=xN/YW f.[o\n;` >_'");

    cr_assert_eq(
        parsedInteger,
        1664,
        "Expected to parse 1664 in the middle of the string, got %d", parsedInteger
    );
}

Test(string, parse_decimal_integer_only_first_occurence) {
    int parsedInteger = string_parse_base10_integer(" 13 140 xf7");

    cr_assert_eq(
        parsedInteger,
        13,
        "Expected to parse integer 13 only, got %d", parsedInteger
    );
}

Test(string, parse_decimal_negative_integer) {
    int parsedInteger = string_parse_base10_integer("-13");

    cr_assert_eq(
        parsedInteger,
        -13,
        "Expected to parse integer -13, got %d", parsedInteger
    );
}

Test(string, parse_decimal_negative_integer_minus_must_be_stuck) {
    int parsedInteger = string_parse_base10_integer("- 13");

    cr_assert_eq(
        parsedInteger,
        13,
        "Expected to parse integer 13, got %d", parsedInteger
    );
}
