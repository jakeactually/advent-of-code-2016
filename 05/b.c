// https://gist.github.com/creationix/4710780

#include "md5.c"

void md5_(char *in, char *out) {
    size_t len = strlen(in);
    md5(in, len);

    uint8_t *p0 = (uint8_t *)&h0;
    uint8_t *p1 = (uint8_t *)&h1;
    uint8_t *p2 = (uint8_t *)&h2;
    uint8_t *p3 = (uint8_t *)&h3;

    sprintf(
        out,
        "%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x%2.2x",
        p0[0], p0[1], p0[2], p0[3],
        p1[0], p1[1], p1[2], p1[3],
        p2[0], p2[1], p2[2], p2[3],
        p3[0], p3[1], p3[2], p3[3]
    );
}

int main(int argc, char **argv) {
    int i, c;
    
    char in[33];
    char out[33];
    char prefix[9] = "uqwqemis";
    char res[9] = "--------";

    for (;;) {
        sprintf(in, "%s%d", prefix, i);
        md5_(in, out);

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
}
