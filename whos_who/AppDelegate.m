//
//  AppDelegate.m
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>

@implementation AppDelegate

NSArray *savedInfo;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (id) jsonFromUrl:(NSString *)url
{
    if([url hasSuffix:@"/office/gurgaon"]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        NSArray *keyContacts = [[NSArray alloc] initWithObjects:
                                [[NSDictionary alloc] initWithObjects:
                                [[NSArray alloc] initWithObjects:@"ndhall", nil] forKeys:[[NSArray alloc] initWithObjects:@"username", nil]],
                                [[NSDictionary alloc] initWithObjects:
                                [[NSArray alloc] initWithObjects:@"mukeshk", nil] forKeys:[[NSArray alloc] initWithObjects:@"username", nil]],
                                [[NSDictionary alloc] initWithObjects:
                                 [[NSArray alloc] initWithObjects:@"damandek", nil] forKeys:[[NSArray alloc] initWithObjects:@"username", nil]],
                                nil];
        [data setObject:keyContacts forKey:@"key-contacts"];
        [data setObject:@"twmailggn@gurgaon.com" forKey:@"maillist"];
        [data setObject:@"230363653644793" forKey:@"fb-page-id"];
        return data;
    }
    NSURL *profileURL=[[NSURL alloc] initWithString:url];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:profileURL];
    NSHTTPURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&err ];
    if(err == nil) {
        if(response.statusCode == 200) {
            NSString *output = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            //strip out useless stuff from json
            output = [output stringByReplacingOccurrencesOfString:@"throw 'allowIllegalResourceCall is false.';" withString:@""];
            return [NSJSONSerialization JSONObjectWithData:[[NSMutableData alloc] initWithBytes:[output UTF8String] length:output.length] options:NSJSONReadingMutableLeaves error:&err] ;
        }
    }
    return nil;
}

+ (bool) addContactName:(NSString *)name email:(NSString *)email phone:(NSString *)phone photo:(NSData *)photo
{
    CFErrorRef err = nil;
    ABAddressBookRef bookRef = ABAddressBookCreateWithOptions(NULL, nil);
    if(err == nil) {
        ABRecordRef person = ABPersonCreate();
        // firstname
        ABRecordSetValue(person, kABPersonFirstNameProperty,(__bridge CFStringRef)name, NULL);
        ABMutableMultiValueRef phoneNumberMultiValue =
        ABMultiValueCreateMutable(kABPersonPhoneProperty);
        ABMultiValueAddValueAndLabel(phoneNumberMultiValue ,(__bridge CFStringRef)phone,kABPersonPhoneMobileLabel, NULL);
        ABPersonSetImageData(person, (__bridge CFDataRef)photo, NULL);
        ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, NULL);
        // email
        ABMutableMultiValueRef emailVal = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(emailVal, (__bridge CFStringRef)email, CFSTR("email"), NULL);
        ABRecordSetValue(person, kABPersonEmailProperty, emailVal, &err);
        CFRelease(emailVal);
        ABAddressBookAddRecord(bookRef, person, &err);
        bool resp = ABAddressBookSave(bookRef, nil); //save the record
        CFRelease(person);
        return resp;
    }
    return false;
}

+ (void) savePeopleInfo:(NSArray *)people {
    savedInfo = people;
}

+ (NSArray *) getSavedPeopleInfo {
    return savedInfo;
}
@end
