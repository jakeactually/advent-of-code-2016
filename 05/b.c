// gcc b.c -o b -lcrypto && ./b

#include <openssl/md5.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    char prefix[9] = "uqwqemis";    
    char in[33];
    unsigned char outb[16];
    char out[33];
    int i = 0;
    int c = 0;
    char res[9] = "--------";

    for (;;) {
        sprintf(in, "%s%d", prefix, i);

        MD5(in, strlen(in), outb);

        for (int j = 0; j < 16; j++)
            sprintf(out + j * 2, "%02x", outb[j]);            
        
        int valid =
            out[0] == '0' &&
            out[1] == '0' &&
            out[2] == '0' &&
            out[3] == '0' &&
            out[4] == '0' &&

            out[5] >= '0' &&
            out[5] <= '8';

        if (valid) {
            char chr[2] = { out[5] };
            int index = atoi(chr);

            if (res[index] == '-') {
                res[index] = out[6];
                c++;
            }

            printf("%s\n", res);
        }

        if (c > 7)
            break;

        i++;
    }

    printf("%s\n", res);
}
