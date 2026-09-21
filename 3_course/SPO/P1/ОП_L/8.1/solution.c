#include <stdio.h>
#include <getopt.h>

int main(int argc, char *argv[]) {
    int opt;
    int query_present = 0;
    int valid = 1;
    
    struct option long_options[] = {
        {"query", required_argument, 0, 'q'},
        {"longinformationrequest", no_argument, 0, 'i'},
        {"version", no_argument, 0, 'v'},
        {0, 0, 0, 0}
    };
    
    while ((opt = getopt_long(argc, argv, "q:iv", long_options, NULL)) != -1) {
        switch (opt) {
            case 'q':
                query_present = 1;
                break;
            case 'i':
                break;
            case 'v':
                break;
            case '?':
                valid = 0;
                break;
            default:
                valid = 0;
                break;
        }
    }
    
    if (optind != argc) {
        valid = 0;
    }
    
    if (valid && query_present) {
        printf("+\n");
    } else {
        printf("-\n");
    }
    
    return 0;
}
