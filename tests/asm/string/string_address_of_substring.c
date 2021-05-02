
#include <criterion/criterion.h>

extern const char * string_address_of_substring(const char * const haystack, char const * const needle);

Test(string_address_of_substring, rejects_null_strings) {
    const char * occurence;

    occurence = string_address_of_substring(0, "foo");
    cr_assert_eq(
        occurence,
        0,
        "Expected to get null when given null haystack, got %p", occurence
    );

    occurence = string_address_of_substring("bar", 0);
    cr_assert_eq(
        occurence,
        0,
        "Expected to get null when given null needle, got %p", occurence
    );
}

Test(string_address_of_substring, null_on_not_found) {
    char * haystack = "foo";
    char * needle = "bar";

    const char * occurence = string_address_of_substring(haystack, needle);

    cr_assert_null(
        occurence,
        "Expected occurence of '%s' in '%s' to be null, got %p", needle, haystack, occurence
    );
}

Test(string_address_of_substring, not_null_on_character_found) {
    char * haystack = "foo";
    char * needle = "o";

    const char * occurence = string_address_of_substring(haystack, needle);

    cr_assert_not_null(
        occurence,
        "Expected to find a valid address for occurence '%s' in '%s', got null", needle, haystack
    );
}

Test(string_address_of_substring, null_on_suite_not_found) {
    char * haystack = "folo";
    char * needle = "oo";

    const char * occurence = string_address_of_substring(haystack, needle);

    cr_assert_null(
        occurence,
        "Expected occurence of '%s' in '%s' to be null, got %p", needle, haystack, occurence
    );
}

Test(string_address_of_substring, not_null_on_suite_found) {
    char * haystack = "assembly";
    char * needle = "semb";

    const char * occurence = string_address_of_substring(haystack, needle);

    cr_assert_not_null(
        occurence,
        "Expected to match '%s' in '%s', got null", needle, haystack
    );
}

Test(string_address_of_substring, null_on_partial_match) {
    char * haystack = "assembly";
    char * needle = "semp";

    const char * occurence = string_address_of_substring(haystack, needle);

    cr_assert_null(
        occurence,
        "Expected to reject partial matching '%s' in '%s', got %p", needle, haystack, occurence
    );
}

Test(string_address_of_substring, substring_is_in_haystack) {
    char * haystack = "babar";
    char * needle = "aba";

    const char * occurence = string_address_of_substring(haystack, needle);

    cr_assert_geq(
        occurence,
        haystack,
        "Expected occurence to be in haystack after address %p, got %p", haystack, occurence
    );

    cr_assert_lt(
        occurence,
        haystack + 5,
        "Expected occurence to be in haystack before address %p, got %p", haystack + 5, occurence
    );
}

Test(string_address_of_substring, first_occurence) {
    char * haystack = "you fool got fooled";
    char * needle = "foo";
    char * expectedSubString = "fool got fooled";

    const char * occurence = string_address_of_substring(haystack, needle);

    // guard since we'll print strings
    cr_assert_not_null(
        occurence,
        "Expected to match '%s' in '%s', got null", needle, haystack
    );

    cr_assert_eq(
        occurence,
        haystack + 4,
        "Expected to find first occurence at offset 4 in '%s' (address %p), got %p", haystack + 4, occurence
    );

    cr_assert_str_eq(
        occurence,
        expectedSubString,
        "Expected to get substring '%s' from '%s' when given needle '%s', got '%s'", expectedSubString, haystack, needle, occurence
    );
}
