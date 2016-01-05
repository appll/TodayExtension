//
//  DBHelper.h
//  TodayExtensionDemo
//
//  Created by App on 11/16/15.
//  Copyright © 2015 App. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;

@interface DBHelper : NSObject

+(BOOL)createTable;

+(BOOL)insertRowWithUserModel:(UserModel *)userModel;

+(NSArray *)featchUserdFromDB;

+(BOOL)deleteUserByName:(NSString *)name;

@end
