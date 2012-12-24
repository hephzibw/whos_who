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

NSString *fbPageId;
NSString *mailList;
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
        NSDictionary *url_data = [AppDelegate jsonFromUrl:baseUrl];
        fbPageId = [url_data objectForKey:@"fb_page"];
        mailList = [url_data objectForKey:@"mail_list"];
        _people = [[url_data objectForKey:@"key_people"] componentsSeparatedByString:@","];
        NSMutableArray *people = [[NSMutableArray alloc] init];
        for(NSString *username in _people) {
            NSMutableDictionary *data = [AppDelegate jsonFromUrl:[@"http://my.thoughtworks.com/api/core/v2/users/username/" stringByAppendingString:username]];
            NSMutableDictionary *details = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObject:username] forKeys:[NSArray arrayWithObject:@"username"]];
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
        [[[UIAlertView alloc] initWithTitle:@"Info" message:@"Details Saved!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    }
    else if([control selectedSegmentIndex] == 1) {
        NSString *markup = @"";
        for(NSDictionary *values in _people) {
            markup = [markup stringByAppendingString:[NSString stringWithFormat:@"<h2>%@ | %@</h2><h3>%@</h3><h3>%@</h3><br/<br/>",[values objectForKey:@"role"],[values objectForKey:@"name"],[values objectForKey:@"email"],[values objectForKey:@"mobile"]]];
        }
        UIMarkupTextPrintFormatter *formatter = [[UIMarkupTextPrintFormatter alloc] initWithMarkupText:markup];
        UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
        if  (pic) {
            UIPrintInfo *printInfo = [UIPrintInfo printInfo];
            printInfo.outputType = UIPrintInfoOutputGeneral;
            printInfo.jobName = @"Print Office Details";
            printInfo.duplex = UIPrintInfoDuplexLongEdge;
            pic.printInfo = printInfo;
            pic.showsPageRange = YES;
            void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
                ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
                    if (!completed && error)
                        NSLog(@"FAILED! due to error in domain %@ with error code %u",
                              error.domain, error.code);
                };
            [pic setPrintFormatter:formatter];
            [pic presentAnimated:true completionHandler:completionHandler];
        }
    
    }
    else if([control selectedSegmentIndex] == 2) {
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:[@"mailto:" stringByAppendingString:mailList]]];
    }
    else if([control selectedSegmentIndex] == 3) {
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:[@"http://www.facebook.com/" stringByAppendingString:fbPageId]]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"details"]) {
        MyProfileViewController *controller = [segue destinationViewController];
        controller.url = [@"http://my.thoughtworks.com/api/core/v2/users/username/" stringByAppendingString:[sender username]];
    }
}
@end
