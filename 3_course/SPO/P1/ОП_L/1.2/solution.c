#include <string.h>

int stringStat(const char *string, size_t multiplier, int *count) {
    if (count != NULL) {
        (*count)++;
    }
    return strlen(string) * multiplier;
}
