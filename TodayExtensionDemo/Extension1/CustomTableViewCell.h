//
//  CustomTableViewCell.h
//  TodayExtensionDemo
//
//  Created by App on 11/17/15.
//  Copyright © 2015 App. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, strong) UserModel *userModel;

+(instancetype)cellWithTableView:(UITableView *)talbeView;

@end
