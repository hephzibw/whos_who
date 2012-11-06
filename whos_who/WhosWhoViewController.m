//
//  SecondViewController.m
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import "WhosWhoViewController.h"
#import "AppDelegate.h"

@interface WhosWhoViewController ()

@end

@implementation WhosWhoViewController
@synthesize imgMugShot = _imgMugShot;
@synthesize lblEmail = _lblEmail;
@synthesize lblName = _lblName;
@synthesize lblPhone = _lblPhone;
@synthesize lblRole = _lblRole;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self scanAgain:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)prepareQrCodeReader
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology: ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    return reader;
}

- (NSString *)getScannedCode:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    

    
    for(symbol in results)
        break;

    return symbol.data;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *scannedCode = [self getScannedCode:info];
   NSString *baseUrl = @"http://my.thoughtworks.com/api/core/v2/users/username/";
    //NSString *baseUrl = @"https://my.thoughtworks.com/people/";
    
    baseUrl= [baseUrl stringByAppendingString:scannedCode];
    NSDictionary *data = [AppDelegate jsonFromUrl:baseUrl];
    
    if(data != nil) {
        _lblName.text = [data objectForKey:@"name"];
        _lblRole.text = [[data objectForKey:@"profile"] objectForKey:@"title"];
        NSString *urlOfImage = @"https://my.thoughtworks.com/5.0.2/images/jive-profile-default-portrait.png";
        NSArray *imageData = [AppDelegate jsonFromUrl:[[[data objectForKey:@"resources"] objectForKey:@"images"] objectForKey:@"ref"]];
        if([imageData count] > 0) {
            urlOfImage = [[imageData objectAtIndex:0] objectForKey:@"ref"];
        }
        NSURL *url = [NSURL URLWithString: urlOfImage];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        [_imgMugShot setImage:image];
        _lblPhone.text = [[data objectForKey:@"profile"] objectForKey:@"mobile"];
        _lblEmail.text = [data objectForKey:@"email"];
    }

    
    
    
    //scannedImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    [picker dismissModalViewControllerAnimated:YES];
    
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:baseUrl]]];
    //[self.webView reload];
}



- (IBAction)scanAgain:(id)sender {
    UIViewController * reader = [self prepareQrCodeReader];
    [self presentModalViewController:reader animated:YES];
}
- (IBAction)btnSaveContact:(id)sender {
    [AppDelegate addContactName:_lblName.text email:_lblEmail.text phone:_lblPhone.text photo:[NSData dataWithData:UIImagePNGRepresentation(_imgMugShot.image)]];
}

- (IBAction)signOut:(id)sender {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://my.thoughtworks.com/api/core/v2/authentication/login"]];
    [request setHTTPMethod:@"DELETE"];
    NSHTTPURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    [response statusCode];

}
@end
