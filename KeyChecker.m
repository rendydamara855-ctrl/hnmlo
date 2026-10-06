#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import "api.h"

// Pointer MSHookFunction dari substrate/substitute
extern void MSHookFunction(void *symbol, void *replace, void **result);

void (*orig_initMenu)(void);

void my_initMenu(void) {
    if (orig_initMenu) {
        orig_initMenu(); // Jalankan menu asli
    }
}

__attribute__((constructor))
static void initialize(void) {
    // 1. Set token V3 Server Key
    apiclient_set_token("F7fgqwpqmMGZdN03UkvyDTjjI+fuA1z0zQ2AcH+umwSNi0nwolEDstMEOrlEsxHyiUUj4M/7hRwYD6VApIf9c3kkgQYy6dWE/B69+eT5F0g=");

    // 2. Jalankan pemeriksaan key
    apiclient_on_login("", 
        ^(const char* json) {
            NSLog(@"[KeyChecker] Validasi Berhasil: %s", json);
            
            // Hook fungsi menu (offset Ghidra) hanya jika key valid
            uintptr_t baseAddr = _dyld_get_image_vmaddr_slide(0);
            uintptr_t targetOffset = 0x2bd10;
            
            MSHookFunction((void *)(baseAddr + targetOffset), (void *)my_initMenu, (void **)&orig_initMenu);
        }, 
        ^(const char* json) {
            NSLog(@"[KeyChecker] Validasi Gagal: %s", json);
        }
    );
}