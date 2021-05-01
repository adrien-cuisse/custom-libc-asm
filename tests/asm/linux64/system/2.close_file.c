
#include <criterion/criterion.h>

#define STANDARD_OUTPUT 1

extern int close_file(int fileDescriptor);

Test(file, close_success) {
    int status = close_file(STANDARD_OUTPUT);

    cr_assert_eq(
        status,
        0,
        "Expected to get status 0 on successful file closing, got %d", status
    );
}

Test(file, close_invalid) {
    int errorCode = close_file(0xdeadbeef);

    cr_assert_eq(
        errorCode,
        -9,
        "Expected to get error code -9 when closing invalid file, got %d", errorCode
    );
}
