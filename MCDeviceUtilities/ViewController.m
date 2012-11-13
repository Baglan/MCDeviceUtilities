//
//  ViewController.m
//  MCDeviceUtilities
//
//  Created by Baglan on 11/11/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "ViewController.h"
#import "MCDeviceUtilities.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _deviceLabel.text = [MCDeviceUtilities objectForiPhone4:@"iPhone" iPhone5:@"iPhone 5" iPad:@"iPad"];
    
    [MCDeviceUtilities executeBlockForiPhone4:^{
        // Code for iPhone 4 or similarly sized devices
    } iPhone5:^{
        // Code for iPhone 5 or similarly sized devices
    } iPad:^{
        // Code for iPad
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
