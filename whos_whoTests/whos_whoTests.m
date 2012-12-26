//
//  whos_whoTests.m
//  whos_whoTests
//
//  Created by Hephzibah on 10/16/12.
//  Copyright (c) 2012 Hephzibah. All rights reserved.
//

#import "whos_whoTests.h"

@implementation whos_whoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testSaveInfoShouldSaveData
{
    NSArray *array = [NSArray new];
    [AppDelegate savePeopleInfo:array];
    assert([AppDelegate getSavedPeopleInfo] == array);
}

@end
