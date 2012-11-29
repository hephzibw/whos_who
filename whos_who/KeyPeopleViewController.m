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

@synthesize baseUrl;
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
    if(baseUrl != nil) {
        _people = [AppDelegate jsonFromUrl:baseUrl];
    } else {
        _people = [AppDelegate getSavedPeopleInfo];
    }
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

- (IBAction)signOut:(id)sender {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://my.thoughtworks.com/api/core/v2/authentication/login"]];
    [request setHTTPMethod:@"DELETE"];
    NSHTTPURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    [response statusCode];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"details"]) {
        MyProfileViewController *controller = [segue destinationViewController];
        controller.url = @"http://my.thoughtworks.com/api/core/v2/users/username/ndhall";

    }
}
@end
