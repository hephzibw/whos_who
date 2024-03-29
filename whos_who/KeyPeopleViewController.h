//
//  KeyPeopleViewController.h
//  whos_who
//
//  Created by Rajan on 11/6/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyPeopleViewCell.h"
#import "MyProfileViewController.h"

@interface KeyPeopleViewController : UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>
- (IBAction)signOut:(id)sender;
- (IBAction)handleSegment:(id)sender;

@property (strong, nonatomic) NSArray *people;
@property (strong, nonatomic) NSString *baseUrl;

@end
