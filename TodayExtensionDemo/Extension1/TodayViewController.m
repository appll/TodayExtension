//
//  TodayViewController.m
//  Extension1
//
//  Created by App on 11/16/15.
//  Copyright © 2015 App. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "DBHelper.h"
#import "UserModel.h"
#import "CustomTableViewCell.h"

@interface TodayViewController () <NCWidgetProviding, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *userArray;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.preferredContentSize = CGSizeMake(0, 220);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self updateContent];
}

-(void)updateContent{
    //    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.blzx.data"];
    //    NSString *data = [userDefault objectForKey:@"name"];
    self.userArray = [DBHelper featchUserdFromDB];
//    if (!self.userArray || self.userArray.count ==0) {
//        [[NCWidgetController widgetController] setHasContent:NO forWidgetWithBundleIdentifier:@"com.hzblzx.TodayExtensionDemo.Extension1"];
//    }else{
//        [[NCWidgetController widgetController] setHasContent:YES forWidgetWithBundleIdentifier:@"com.hzblzx.TodayExtensionDemo.Extension1"];
//    }
    [self updateHeight];
    [self.tableView reloadData];
}

-(void)updateHeight{
    CGFloat height = self.userArray.count * 44;
    self.preferredContentSize = CGSizeMake(0, height);
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, us Q Qe NCUpdateResultNewData
    [self updateContent];
    //刷新widget数据、这里是每次都刷新，有时需要判断下有无更新然后再确认是否执行刷新
    completionHandler(NCUpdateResultNewData);
}

//设置widget在Toaday中显示无边框
-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsZero;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    NSLog(@"%@", NSStringFromCGSize(size));
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell = [CustomTableViewCell cellWithTableView:tableView];
    cell.userModel = self.userArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //打开app、需要在info中配置URL Types - URL Schemes为myapp
    [self.extensionContext openURL:[NSURL URLWithString:@"myapp://"] completionHandler:nil];
}
@end
