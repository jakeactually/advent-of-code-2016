#ifndef HASH_H
#define HASH_H

#include <stdint.h>

#if defined(_WIN32)
#define HASH_EXPORT __declspec(dllimport)
#else
#define HASH_EXPORT __attribute__((visibility ("default")))
#endif

#ifdef __cplusplus
extern "C" {
#endif

HASH_EXPORT void hash(uint8_t in[], uint32_t in_len, uint8_t * out);

#ifdef __cplusplus
} // extern "C"
#endif


#endif // HASH_H
