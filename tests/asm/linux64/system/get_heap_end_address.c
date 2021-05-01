
#include <criterion/criterion.h>

extern void * get_heap_end_address(void);

Test(memory, get_heap_end_address_returns_correct_address) {
    void * heapEndAddress = get_heap_end_address();

    cr_assert_gt(
        heapEndAddress,
        0x500000000000, // heap end should be after that address
        "Heap end address is %p", heapEndAddress
    );
}
