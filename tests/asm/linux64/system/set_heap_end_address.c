
#include <criterion/criterion.h>

extern void * get_heap_end_address(void);
extern void * set_heap_end_address(void * heapEndAddress);

Test(memory, set_heap_end_address_increases_heap) {
    char * oldHeadEndAddress = get_heap_end_address();
    char * newHeadEndAddress = set_heap_end_address(oldHeadEndAddress + 5);

    cr_assert_gt(
        newHeadEndAddress,
        oldHeadEndAddress,
        "Expected the new heap end address [%p] to be after the old heap end address [%p]", newHeadEndAddress, oldHeadEndAddress
    );
}

Test(memory, set_heap_end_address_increases_heap_by_bytes_count) {
    char * oldHeadEndAddress = get_heap_end_address();
    char * newHeadEndAddress = set_heap_end_address(oldHeadEndAddress + 5);

    cr_assert_eq(
        newHeadEndAddress,
        oldHeadEndAddress + 5,
        "Expected the heap to increase by 5 bytes, it increases of %d bytes instead", newHeadEndAddress - oldHeadEndAddress
    );
}

Test(memory, set_heap_end_address_leads_to_usable_memory) {
    char * oldHeadEndAddress = get_heap_end_address();

    set_heap_end_address(oldHeadEndAddress + 5);

    oldHeadEndAddress[0] = 't';
    oldHeadEndAddress[1] = 'e';
    oldHeadEndAddress[2] = 's';
    oldHeadEndAddress[3] = 't';
    oldHeadEndAddress[4] = '\0';

    cr_assert_str_eq(
        oldHeadEndAddress,
        "test",
        "Memory block between old heap end and new heap end doesn't seem to be usable"
    );
}

Test(memory, set_heap_end_address_has_no_effect_with_invalid_address) {
    char * oldHeadEndAddress = get_heap_end_address();
    char * newHeadEndAddress = set_heap_end_address((void *) -1);

    cr_assert_eq(
        newHeadEndAddress,
        oldHeadEndAddress,
        "Expected to get old heap end address %p when given invalid address, got %p", oldHeadEndAddress, newHeadEndAddress
    );
}
