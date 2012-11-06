//
//  KeyPeopleViewCell.h
//  whos_who
//
//  Created by Rajan on 11/6/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyPeopleViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeKeyPerson;
@property (weak, nonatomic) IBOutlet UILabel *nameKeyPerson;
@property (weak, nonatomic) IBOutlet UILabel *mobileKeyPerson;
@property (weak, nonatomic) IBOutlet UILabel *emailKeyPerson;

@end
