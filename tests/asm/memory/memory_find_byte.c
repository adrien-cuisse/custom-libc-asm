
#include <criterion/criterion.h>

extern void * memory_find_byte(void const * const haystack, unsigned char needle, unsigned int bytesLimit);

Test(memory_find_byte, rejects_null_block) {
    void * haystack = 0;

    void * occurence = memory_find_byte(haystack, 'e', 42);

    cr_assert_null(
        occurence,
        "Expected to get null when no memory block is given, got %p", occurence
    );
}

Test(memory_find_byte, rejects_invalid_memory) {
    void * occurence = memory_find_byte((void *)-1, 'e', 42);

    cr_assert_null(
        occurence,
        "Expected to get null when invalid memory block is given, got %p", occurence
    );
}

Test(memory_find_byte, matches_at_first_position) {
    char * haystack = "ba";
    char needle = 'b';
    void * occurence = memory_find_byte(haystack, needle, 3);

    cr_assert_not_null(
        occurence,
        "Expected to get valid address when block contains the byte, got null"
    );

    cr_assert_eq(
        occurence,
        haystack,
        "Expected to find byte '\\x%x' at the address %p (\\x%x\\x%x\\x%.2x), got address %p", needle, haystack, haystack[0], haystack[1], haystack[2], occurence
    );
}

Test(memory_find_byte, matches_at_any_position) {
    char * haystack = "bar";
    char needle = 'a';
    void * occurence = memory_find_byte(haystack, needle, 4);

    cr_assert_not_null(
        occurence,
        "Expected to get valid address when block contains the byte, got null"
    );

    cr_assert_eq(
        occurence,
        haystack + 1,
        "Expected to find byte \\x%x at the address %p (\\x%x\\x%x\\x%x\\x%.2x), got address %p", needle, haystack + 1, haystack[0], haystack[1], haystack[2], haystack[3], occurence
    );
}

Test(memory_find_byte, matches_first_occurence) {
    char * haystack = "baa";
    char needle = 'a';
    void * occurence = memory_find_byte(haystack, needle, 4);

    cr_assert_not_null(
        occurence,
        "Expected to get valid address when block contains the byte, got null"
    );

    cr_assert_eq(
        occurence,
        haystack + 1,
        "Expected to find byte \\x%x at the address %p (\\x%x\\x%x\\x%x\\x%.2x), got address %p", needle, haystack + 1, haystack[0], haystack[1], haystack[2], haystack[3], occurence
    );
}

Test(memory_find_byte, null_if_byte_not_in_range) {
    char * haystack = "bar";
    char needle = 'r';
    unsigned int bytesLimit = 2;
    void * occurence = memory_find_byte(haystack, needle, bytesLimit);

    cr_assert_null(
        occurence,
        "Didn't expect to find value \\x%x in first %u bytes of \\x%x\\x%x\\x%x\\x%.2x, got address %p", needle, bytesLimit, haystack[0], haystack[1], haystack[2], haystack[3], occurence
    );
}
