//
//  FirstViewController.m
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

@synthesize lblName = _lblName;
@synthesize lblRole = _lblRole;
@synthesize imgMugshot = _imgMugshot;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *profileURL=[[NSURL alloc] initWithString:@"http://my.thoughtworks.com/api/core/v2/users/username/jaideep"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:profileURL];
    NSHTTPURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&err ];
    if(err == nil) {
        if(response.statusCode == 200) {
            NSString *output = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            output = [output stringByReplacingOccurrencesOfString:@"throw 'allowIllegalResourceCall is false.';" withString:@""];
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[[NSMutableData alloc] initWithBytes:[output UTF8String] length:output.length] options:NSJSONReadingMutableLeaves error:&err] ;
            
            _lblName.text = [data objectForKey:@"name"];
            _lblRole.text = [[data objectForKey:@"profile"] objectForKey:@"title"];
            _imgMugshot.image = [[data objectForKey:@"image"] objectForKey:@"ref"];
        }
    }
    
    NSLog([err description]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
