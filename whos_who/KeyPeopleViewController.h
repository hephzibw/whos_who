//
//  KeyPeopleViewController.h
//  whos_who
//
//  Created by Rajan on 11/6/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyPeopleViewCell.h"

@interface KeyPeopleViewController : UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableData *responseData;
@property (strong, nonatomic) NSDictionary *people;
@end
