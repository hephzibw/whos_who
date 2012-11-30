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

-(void) viewWillAppear:(BOOL)animated {
    if(baseUrl == nil) {
        [self.collectionView reloadData];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    if(baseUrl != nil) {
        _people = [[AppDelegate jsonFromUrl:baseUrl] objectForKey:@"key-contacts"];
        NSMutableArray *people = [[NSMutableArray alloc] init];
        for(NSDictionary *object in _people) {
            NSMutableDictionary *data = [AppDelegate jsonFromUrl:[@"http://my.thoughtworks.com/api/core/v2/users/username/" stringByAppendingString:[object objectForKey:@"username"]]];
            NSMutableDictionary *details = [[NSMutableDictionary alloc] initWithDictionary:object];
            if([[data objectForKey:@"profile"] objectForKey:@"title"] != nil)
                [details setObject:[[data objectForKey:@"profile"] objectForKey:@"title"] forKey:@"role"];
            [details setObject:[data objectForKey:@"name"] forKey:@"name"];
            if([data objectForKey:@"email"] != nil)
                [details setObject:[data objectForKey:@"email"] forKey:@"email"];
            if([[data objectForKey:@"profile"] objectForKey:@"mobile"] != nil)
                [details setObject:[[data objectForKey:@"profile"] objectForKey:@"mobile"] forKey:@"mobile"];
            [people addObject:details];
        }
        _people = people;
        return _people.count + 1;
    } else {
        _people = [AppDelegate getSavedPeopleInfo];
        return _people.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(baseUrl != nil && [indexPath row] == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"segments" forIndexPath:indexPath];
        return cell;
    } else {
        int offset = baseUrl == nil? 0 : -1;
        
        KeyPeopleViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"KeyPeopleCell"
                                    forIndexPath:indexPath];
        int row = [indexPath row];
        myCell.username = [_people[row + offset] objectForKey:@"username"];
        myCell.typeKeyPerson.text = [_people[row + offset] objectForKey:@"role"];
        myCell.nameKeyPerson.text = [_people[row + offset] objectForKey:@"name"];
        myCell.emailKeyPerson.text = [_people[row + offset] objectForKey:@"email"];
        myCell.mobileKeyPerson.text = [_people[row + offset] objectForKey:@"mobile"];
        return myCell;
    }
}

- (IBAction)signOut:(id)sender {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://my.thoughtworks.com/api/core/v2/authentication/login"]];
    [request setHTTPMethod:@"DELETE"];
    NSHTTPURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    [response statusCode];

}

- (IBAction)handleSegment:(id)sender {
    UISegmentedControl *control = sender;
    if ([control selectedSegmentIndex] == 0) {
        [AppDelegate savePeopleInfo:_people];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"details"]) {
        MyProfileViewController *controller = [segue destinationViewController];
        controller.url = [@"http://my.thoughtworks.com/api/core/v2/users/username/" stringByAppendingString:[sender username]];
    }
}
@end
