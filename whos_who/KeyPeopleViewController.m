//
//  KeyPeopleViewController.m
//  whos_who
//
//  Created by Rajan on 11/6/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import "KeyPeopleViewController.h"
#import "AppDelegate.h"

@interface KeyPeopleViewController ()

@end

@implementation KeyPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    _people = [AppDelegate jsonFromUrl:@"http://glacial-inlet-5350.herokuapp.com/people"];
    return _people.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KeyPeopleViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"KeyPeopleCell"
                                    forIndexPath:indexPath];
    int row = [indexPath row];
    
    myCell.typeKeyPerson.text = [_people[row] objectForKey:@"role"];
    myCell.nameKeyPerson.text = [_people[row] objectForKey:@"name"];
    myCell.emailKeyPerson.text = [_people[row] objectForKey:@"email"];
    myCell.mobileKeyPerson.text = [_people[row] objectForKey:@"mobile"];
    
    return myCell;
}

@end
