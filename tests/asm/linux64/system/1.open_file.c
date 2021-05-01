
#include <criterion/criterion.h>

// we need absolute path
#define PATH_TO_THIS_FILE "/home/arch/src/c/custom-libc/tests/asm/linux64/system/1.open_file.c"

extern int open_file(char const * const path, int flags);

Test(file, open_existant) {
    int fileDescriptor = open_file(PATH_TO_THIS_FILE, 0);

    cr_assert_gt(
        fileDescriptor,
        // 0, 1 and 2 being STDIN, STDOUT and STDERR
        2,
        "Opening valid file should return its descriptor, got %d", fileDescriptor
    );
}

Test(file, open_inexistant_error_code) {
    int errorCode = open_file("file-not-found", 0);

    cr_assert_eq(
        errorCode,
        -2,
        "Expected to get error code -2 when opening inexistant file, got %d", errorCode
    );
}

Test(file, open_denied_error_code) {
    int errorCode = open_file("/etc/shadow", 0);

    cr_assert_eq(
        errorCode,
        -13,
        "Expected to get error code -13 when opening restricted file, got %d", errorCode
    );
}
