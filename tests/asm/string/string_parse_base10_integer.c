
#include <criterion/criterion.h>

extern int string_parse_base10_integer(char const * const string);

Test(string_parse_base10_integer, single_digit) {
    int parsedInteger = string_parse_base10_integer("4");

    cr_assert_eq(
        parsedInteger,
        4,
        "Expected to parse integer 4, got %d", parsedInteger
    );
}

Test(string_parse_base10_integer, several_digits) {
    int parsedInteger = string_parse_base10_integer("42");

    cr_assert_eq(
        parsedInteger,
        42,
        "Expected to parse integer 42, got %d", parsedInteger
    );
}

Test(string_parse_base10_integer, at_any_position) {
    int parsedInteger = string_parse_base10_integer(";k Hsh) z1664pX g=xN/YW f.[o\n;` >_'");

    cr_assert_eq(
        parsedInteger,
        1664,
        "Expected to parse 1664 in the middle of the string, got %d", parsedInteger
    );
}

Test(string_parse_base10_integer, only_first_occurence) {
    int parsedInteger = string_parse_base10_integer(" 13 140 xf7");

    cr_assert_eq(
        parsedInteger,
        13,
        "Expected to parse integer 13 only, got %d", parsedInteger
    );
}

Test(string_parse_base10_integer, negative_integer) {
    int parsedInteger = string_parse_base10_integer("-13");

    cr_assert_eq(
        parsedInteger,
        -13,
        "Expected to parse integer -13, got %d", parsedInteger
    );
}

Test(string_parse_base10_integer, not_negative_if_minus_not_stuck) {
    int parsedInteger = string_parse_base10_integer("- 13");

    cr_assert_eq(
        parsedInteger,
        13,
        "Expected to parse integer 13, got %d", parsedInteger
    );
}
