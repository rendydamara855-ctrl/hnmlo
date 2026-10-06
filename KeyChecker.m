#import <Foundation/Foundation.h>
#import "api.h"

__attribute__((constructor)) static void initialize_mod(void) {
// Atur token V3 Server Key (kosongkan jika menggunakan konfigurasi default)
apiclient_set_token("F7fgqwpqmMGZdN03UkvyDTjjI+fuA1z0zQ2AcH+umwSNi0nwolEDstMEOrlEsxHyiUUj4M/7hRwYD6VApIf9c3kkgQYy6dWE/B69+eT5F0g=");

// Otomatis mengecek login saat dylib dimuat oleh aplikasi/game
apiclient_on_login("",
^(const char* json) {
NSLog(@"[KeyChecker] Login Berhasil: %s", json);
},
^(const char* json) {
NSLog(@"[KeyChecker] Login Gagal: %s", json);
}
);
}
