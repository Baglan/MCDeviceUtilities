//
//  MCDeviceUtilities.m
//  MCDeviceUtilities
//
//  Created by Baglan on 11/13/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "MCDeviceUtilities.h"

@implementation MCDeviceUtilities

+ (id)objectForiPhone4:(id)iPhone4 iPhone5:(id)iPhone5 iPad:(id)iPad
{
    id obj = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].applicationFrame.size.height == 568.0) {
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
        if ([UIScreen mainScreen].applicationFrame.size.height == 568.0) {
            blk = iPhone5;
        } else {
            blk = iPhone4;
        }
    } else {
        blk = iPad;
    }
    
    blk();
}

@end
