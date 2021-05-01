
#include <criterion/criterion.h>
#include <criterion/redirect.h>

#define STANDARD_OUTPUT 1

#define READ_ONLY 0

#define PATH_TO_THIS_FILE "/home/arch/src/c/custom-libc/tests/asm/linux64/system/3.write_file.c"

extern int open_file(char const * const path, int flags);

extern int write_file(int fileDescriptor, char const * const string, int bytesCount);

Test(file, write_returns_writen_bytes) {
    cr_redirect_stdout();

    int writenBytes = write_file(STANDARD_OUTPUT, "string", 6);

    cr_assert_eq(
        writenBytes,
        6,
        "Expected writen bytes count to be 6, got %d", writenBytes
    );
}

Test(file, write_does_not_exceed_bytes_count) {
    cr_redirect_stdout();

    int writenBytes = write_file(STANDARD_OUTPUT, "string", 4);

    cr_assert_eq(
        writenBytes,
        4,
        "Expected to write only 4 bytes, wrote %d instead", writenBytes
    );
}

Test(file, write_prints_correct_bytes) {
    cr_redirect_stdout();

    write_file(STANDARD_OUTPUT, "string", 4);

    cr_assert_stdout_eq_str("stri");
}

Test(file, write_invalid_file) {
    int errorCode = write_file(0xdeadbeef, "string", 4);

    cr_assert_eq(
        errorCode,
        -9,
        "Expected error code to be -9 for inexistant file, got %d", errorCode
    );
}

Test(file, write_in_read_only_file_error_code) {
    int thisFile = open_file(PATH_TO_THIS_FILE, READ_ONLY);

    cr_assert_gt(
        thisFile,
        2,
        "Testing write in read-only file requires file opening, aborting"
    );

    int errorCode = write_file(thisFile, "should not write", 16);

    cr_assert_eq(
        errorCode,
        -9,
        "Expected error code -9 when writing in read-only file, got %d instead", errorCode
    );
}
