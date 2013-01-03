//
//  FirstViewController.h
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblRole;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIImageView *imgMugshot;
@property (weak, nonatomic) NSString *url;
- (IBAction)signOut:(id)sender;
- (IBAction)addToContacts:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end
