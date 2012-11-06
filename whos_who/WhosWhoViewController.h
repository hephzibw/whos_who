//
//  SecondViewController.h
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface WhosWhoViewController : UIViewController<ZBarReaderDelegate>
- (UIViewController *)prepareQrCodeReader;
- (NSString *)getScannedCode:(NSDictionary *)info;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)scanAgain:(id)sender;

@end