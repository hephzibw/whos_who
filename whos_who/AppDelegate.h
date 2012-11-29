//
//  AppDelegate.h
//  whos_who
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (id) jsonFromUrl:(NSString *)url;

+ (bool) addContactName:(NSString *)name email:(NSString *)email phone:(NSString *)phone photo:(NSData *)photo;

+ (void) savePeopleInfo:(NSArray *)people;

+ (NSArray *) getSavedPeopleInfo;

@end
