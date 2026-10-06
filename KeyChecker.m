#import <Foundation/Foundation.h>
#import "api.h"

__attribute__((constructor)) static void initialize_mod() {
    // Masukkan token V3 Server Key kamu di sini
    apiclient_set_token("F7fgqwpqmMGZdN03UkvyDTjjI+fuA1z0zQ2AcH+umwSNi0nwolEDstMEOrlEsxHyiUUj4M/7hRwYD6VApIf9c3kkgQYy6dWE/B69+eT5F0g=");
    
    // Contoh otomatis memicu login atau validasi saat dylib dimuat
    apiclient_on_login("", 
        ^(const char* json) {
            NSLog(@"API Client Login Success: %s", json);
        }, 
        ^(const char* json) {
            NSLog(@"API Client Login Failed: %s", json);
        }
    );
}
