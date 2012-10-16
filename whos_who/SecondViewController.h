//
//  SecondViewController.h
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface SecondViewController : UIViewController<ZBarReaderDelegate>
- (IBAction)scanPressed:(id)sender;
- (UIViewController *)prepareQrCodeReader;
- (NSString *)getScannedCode:(NSDictionary *)info;

@end
