//
//  MCDeviceUtilities.h
//  MCDeviceUtilities
//
//  Created by Baglan on 11/13/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCDeviceUtilities : NSObject

+ (id)objectForiPhone4:(id)o1 iPhone5:(id)o2 iPad:(id)o3;
+ (void)executeBlockForiPhone4:(void (^)())iPhone4 iPhone5:(void (^)())iPhone5 iPad:(void (^)())iPad;
+ (BOOL)isIPad;
+ (BOOL)isIPhone5;
+ (BOOL)isRetina;
+ (CGSize)screenSize;
+ (BOOL)appIsEncrypted;

@end
