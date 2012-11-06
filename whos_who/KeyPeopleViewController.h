//
//  KeyPeopleViewController.h
//  whos_who
//
//  Created by Rajan on 11/6/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyPeopleViewController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UILabel *keyPersonType;
@property (weak, nonatomic) IBOutlet UILabel *keyPersonName;
@property (weak, nonatomic) IBOutlet UILabel *keyPersonEmail;
@property (weak, nonatomic) IBOutlet UILabel *keyPersonMobile;

@end
