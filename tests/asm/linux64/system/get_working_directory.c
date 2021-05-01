
#include <criterion/criterion.h>

#define CURRENT_WORKING_DIRECTORY "/home/arch/src/c/custom-libc"
#define CURRENT_WORKING_DIRECTORY_LENGTH 28

extern int get_working_directory(char * buffer, unsigned int bufferSize);

Test(system, get_working_directory) {
    char buffer[2048];

    get_working_directory(buffer, 2047);

    cr_assert_str_eq(
        buffer,
        CURRENT_WORKING_DIRECTORY,
        "Expected absolute path %s, got %s", CURRENT_WORKING_DIRECTORY, buffer
    );
}

Test(system, get_working_directory_returns_writen_bytes) {
    char buffer[2048];

    int writenBytes = get_working_directory(buffer, 2047);
    int expectedWritenBytesCount = CURRENT_WORKING_DIRECTORY_LENGTH + 1; // + null terminating char

    cr_assert_eq(
        writenBytes,
        expectedWritenBytesCount, // + null-terminating character
        "Expected to write %d bytes in the buffer, got %d", expectedWritenBytesCount + 1, writenBytes
    );
}


Test(system, get_working_directory_with_buffer_too_small_error_code) {
    char buffer[2];

    int errorCode = get_working_directory(buffer, 1);

    cr_assert_eq(
        errorCode,
        -34,
        "Expected to return -34 error code when buffer is too small, got %d", errorCode
    );
}
