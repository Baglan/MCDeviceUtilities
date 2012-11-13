# MCDeviceUtilities

## Installation

1. Copy files from the "Classes" folder to your project.

## Usage

Import the header file:

	#import "MCDeviceUtilities.h"

Currently, there are only 2 methods. One of them can be used to return a different object for different types of devices:

	_deviceLabel.text = [MCDeviceUtilities objectForiPhone4:@"iPhone" iPhone5:@"iPhone 5" iPad:@"iPad"];
	
Another is to execute different blocks on different devices:

	[MCDeviceUtilities executeBlockForiPhone4:^{
        // Code for iPhone 4 or similarly sized devices
    } iPhone5:^{
        // Code for iPhone 5 or similarly sized devices
    } iPad:^{
        // Code for iPad
    }];

## License

Code in this project is available under the MIT license.