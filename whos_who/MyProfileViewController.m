//
//  FirstViewController.m
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import "MyProfileViewController.h"
#import "AppDelegate.h"

@interface MyProfileViewController ()

@end
NSString *username;
@implementation MyProfileViewController

@synthesize lblName = _lblName;
@synthesize lblRole = _lblRole;
@synthesize imgMugshot = _imgMugshot;
@synthesize phone = _phone;
@synthesize email = _email;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSDictionary *data = [AppDelegate jsonFromUrl:@"https://my.thoughtworks.com/api/core/v2/my"];
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
        [_imgMugshot setImage:image];
        _phone.text = [[data objectForKey:@"profile"] objectForKey:@"mobile"];
        _email.text = [data objectForKey:@"email"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signOut:(id)sender {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://my.thoughtworks.com/api/core/v2/authentication/login"]];
    [request setHTTPMethod:@"DELETE"];
    NSHTTPURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    [response statusCode];
}

- (IBAction)addToContacts:(id)sender {
    [AppDelegate addContactName:_lblName.text email:_email.text phone:_phone.text photo:[NSData dataWithData:UIImagePNGRepresentation(_imgMugshot.image)]];
}
@end
