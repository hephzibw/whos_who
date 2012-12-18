//
//  SecondViewController.m
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import "WhosWhoViewController.h"
#import "AppDelegate.h"
#import "MyProfileViewController.h"
#import "KeyPeopleViewController.h"

@interface WhosWhoViewController ()

@end

@implementation WhosWhoViewController

@synthesize baseUrl;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self prepareQrCodeReader];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) prepareQrCodeReader
{
    ZBarReaderViewController *reader = self;
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.sourceType = UIImagePickerControllerSourceTypeCamera;
    [scanner setSymbology: ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
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
    
    if([scannedCode hasPrefix:@"/username/"]) {
        baseUrl= [@"http://my.thoughtworks.com/api/core/v2/users" stringByAppendingString:scannedCode];
        [self performSegueWithIdentifier:@"person" sender:self];
    } else if([scannedCode hasPrefix:@"/office/"]) {
        baseUrl = [@"http://office-dm.herokuapp.com" stringByAppendingString:scannedCode];
        [self performSegueWithIdentifier:@"office" sender:self];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid code!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    
}

- (IBAction)signOut:(id)sender {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://my.thoughtworks.com/api/core/v2/authentication/login"]];
    [request setHTTPMethod:@"DELETE"];
    NSHTTPURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    [response statusCode];

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"person"]) {
        MyProfileViewController *controller = [segue destinationViewController];
        [controller setUrl:baseUrl];
    } else {
        KeyPeopleViewController *controller = [segue destinationViewController];
        [controller setBaseUrl:baseUrl];
    }
}
@end
