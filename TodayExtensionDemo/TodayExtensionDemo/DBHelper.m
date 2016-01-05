//
//  DBHelper.m
//  TodayExtensionDemo
//
//  Created by App on 11/16/15.
//  Copyright © 2015 App. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"
#import "UserModel.h"

static FMDatabase *db;

@implementation DBHelper

//Extension和app共用数据，需要在Capabilities - App Groups 建立一份公共的group使用
+(FMDatabase *)fmdb{
    if (db) return db;
    //获取公共group的路径、
    NSURL *storeUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.blzx.dbshare"];
    storeUrl = [storeUrl URLByAppendingPathComponent:@"mydata.sqlite"];
    db = [FMDatabase databaseWithPath:storeUrl.absoluteString];
    return db;
}

+(BOOL)createTable{
    if (!db) [self fmdb];
    NSString *sql = @"create table user (name text,gender text,age integer)";
    if (![db open]) return NO;
    BOOL result = [db executeUpdate:sql];
    NSString *error = [db lastErrorMessage];
    NSLog(@"%@", error);
    return result;
}

+(BOOL)insertRowWithUserModel:(UserModel *)userModel{
    if(![self open]) return NO;
    if (!db) [self fmdb];
    return [db executeUpdate:@"insert into user values (?,?,?)",userModel.name, userModel.gender, [NSNumber numberWithInt:userModel.age]];
}

+(NSArray *)featchUserdFromDB{
    if(![self open]) return nil;
    if (!db) [self fmdb];
    NSMutableArray *userArray;
    NSString *sql = @"select * from user";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        if(!userArray) userArray = [NSMutableArray array];
        UserModel *userModel = [[UserModel alloc] init];
        userModel.name = [rs stringForColumn:@"name"];
        userModel.gender = [rs stringForColumn:@"gender"];
        userModel.age = [rs intForColumn:@"age"];
        [userArray addObject:userModel];
    }
    return userArray;
}

+(BOOL)deleteUserByName:(NSString *)name{
    if(![self open]) return NO;
    if (!db) [self fmdb];
    return [db executeUpdate:@"delete from user where name = ?",name];
}

+(BOOL)open{
    if (!db) [self fmdb];
    if (![db open]) {
        NSLog(@"Open database failed");
        return NO;
    }
    return YES;
}

+(BOOL)close{
    if (!db) [self fmdb];
    return [db commit] && [db close];
}


@end
