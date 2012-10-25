//
//  LoginViewController.m
//  whos_who
//
//  Created by Rohit Garg on 25/10/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.password setSecureTextEntry:true];
    //self.fieldContainer.layer.cornerRadius = 5.0;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animate:(id) sender {
    [self.spinner startAnimating];
}

- (IBAction)signIn:(id)sender {
    const char *stringData = [[NSString stringWithFormat:@"username=%@&password=%@",self.username.text,self.password.text] UTF8String];
    NSData *data = [[NSData alloc] initWithBytes:stringData length:strlen(stringData)];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://my.thoughtworks.com/api/core/v2/authentication/formlogin"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSHTTPURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if([response statusCode] == 200) {
        [self performSegueWithIdentifier:@"loadApp" sender:[self.username text]];
    } else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Please check username/password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    }
    [self.spinner stopAnimating];
}
@end
