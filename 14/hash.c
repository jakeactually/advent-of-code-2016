#include <openssl/md5.h>
#include <stdio.h>
#include <string.h>

void hash(char *in, char *out) {
    char buff[32];
    strcpy(buff, in);

    for (int i = 0; i < 2017; i++) {
        MD5(buff, strlen(buff), out);
        
        for (int j = 0; j < 16; j++)
            sprintf(buff + j * 2, "%02x", (unsigned char)out[j]);
    }
}
