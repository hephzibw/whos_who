//
//  LoginViewController.h
//  whos_who
//
//  Created by Rohit Garg on 25/10/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *borderLabel;
- (IBAction)signIn:(id)sender;
- (IBAction)animate:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
