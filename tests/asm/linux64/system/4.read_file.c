
#include <criterion/criterion.h>

#define WRITE_ONLY 1

#define PATH_TO_THIS_FILE "/home/arch/src/c/custom-libc/tests/asm/linux64/system/4.read_file.c"

extern int open_file(char const * const path, int flags);
extern int read_file(int fileDescriptor, char * buffer, int bytesCount);
extern int close_file(int fileDescriptor);

Test(file, read_returns_read_bytes) {
    char buffer[6];

    int thisFile = open_file(PATH_TO_THIS_FILE, 0);
    cr_assert_gt(
        thisFile,
        2,
        "File reading requires succesful file opening, aborting"
    );

    int readBytes = read_file(thisFile, buffer, 5);

    cr_assert_eq(
        readBytes,
        5,
        "Expected to read 5 bytes, read %d instead", readBytes
    );
}

Test(file, read_a_write_only_file_error_code) {
    char buffer[6];

    int thisFile = open_file(PATH_TO_THIS_FILE, WRITE_ONLY);
    cr_assert_gt(
        thisFile,
        2,
        "File reading requires succesful file opening, aborting"
    );

    int errorCode = read_file(thisFile, buffer, 5);

    cr_assert_eq(
        errorCode,
        -9,
        "Expected error code -9 when reading write-only file, got %d instead", errorCode
    );
}

Test(file, read_invalid_file_error_code) {
    char buffer[6];

    int errorCode = read_file(0xdeadbeef, buffer, 5);

    cr_assert_eq(
        errorCode,
        -9,
        "Expected error code -9 when reading invalid file, got %d instead", errorCode
    );
}
