//
//  TodayExtensionDemoTests.m
//  TodayExtensionDemoTests
//
//  Created by App on 11/16/15.
//  Copyright © 2015 App. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DBHelper.h"
#import "UserModel.h";

@interface TodayExtensionDemoTests : XCTestCase

@end

@implementation TodayExtensionDemoTests

-(void)testCreateTBL{
    XCTAssertTrue([DBHelper createTable]);
}

-(void)testSaveData{
    UserModel *userModel = [[UserModel alloc] init];
    userModel.name = @"app";
    userModel.gender = @"man";
    userModel.age = 11;
    XCTAssertTrue([DBHelper insertRowWithUserModel:userModel]);
}

-(void)testFeatchUserArray{
    XCTAssertNotNil([DBHelper featchUserdFromDB]);
}
@end
