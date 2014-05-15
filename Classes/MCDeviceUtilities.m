//
//  MCDeviceUtilities.m
//  MCDeviceUtilities
//
//  Created by Baglan on 11/13/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "MCDeviceUtilities.h"

// BEGIN: Piracy check definitions

#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <TargetConditionals.h>

/* The encryption info struct and constants are missing from the iPhoneSimulator SDK, but not from the iPhoneOS or
 * Mac OS X SDKs. Since one doesn't ever ship a Simulator binary, we'll just provide the definitions here. */
#if TARGET_IPHONE_SIMULATOR && !defined(LC_ENCRYPTION_INFO)
#define LC_ENCRYPTION_INFO 0x21
struct encryption_info_command {
    uint32_t cmd;
    uint32_t cmdsize;
    uint32_t cryptoff;
    uint32_t cryptsize;
    uint32_t cryptid;
};
#endif

int main (int argc, char *argv[]);

// END: Piracy check definitions

@implementation MCDeviceUtilities

+ (id)objectForiPhone4:(id)iPhone4 iPhone5:(id)iPhone5 iPad:(id)iPad
{
    id obj = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].bounds.size.height == 568.0) {
            obj = iPhone5;
        } else {
            obj = iPhone4;
        }
    } else {
        obj = iPad;
    }
    
    return obj;
}

+ (void)executeBlockForiPhone4:(void (^)())iPhone4 iPhone5:(void (^)())iPhone5 iPad:(void (^)())iPad
{
    void (^blk)(void) = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].bounds.size.height == 568.0) {
            blk = iPhone5;
        } else {
            blk = iPhone4;
        }
    } else {
        blk = iPad;
    }
    
    blk();
}

+ (BOOL)isIPad
{
    return [[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone;
}

+ (BOOL)isIPhone5
{
    return [MCDeviceUtilities screenSize].height == 568.0;
}

+ (BOOL)isRetina
{
    return [UIScreen mainScreen].scale == 2.0;
}

+ (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+ (BOOL)appIsEncrypted
{
    const struct mach_header *header;
    Dl_info dlinfo;
    
    /* Fetch the dlinfo for main() */
    if (dladdr(main, &dlinfo) == 0 || dlinfo.dli_fbase == NULL) {
        NSLog(@"Could not find main() symbol (very odd)");
        return NO;
    }
    header = dlinfo.dli_fbase;
    
    /* Compute the image size and search for a UUID */
    struct load_command *cmd = (struct load_command *) (header+1);
    
    for (uint32_t i = 0; cmd != NULL && i < header->ncmds; i++) {
        /* Encryption info segment */
        if (cmd->cmd == LC_ENCRYPTION_INFO) {
            struct encryption_info_command *crypt_cmd = (struct encryption_info_command *) cmd;
            /* Check if binary encryption is enabled */
            if (crypt_cmd->cryptid < 1) {
                /* Disabled, probably pirated */
                return NO;
            }
            
            /* Probably not pirated? */
            return YES;
        }
        
        cmd = (struct load_command *) ((uint8_t *) cmd + cmd->cmdsize);
    }
    
    /* Encryption info not found */
    return NO;
}

@end
