//
//  ViewController.m
//  TodayExtensionDemo
//
//  Created by App on 11/16/15.
//  Copyright © 2015 App. All rights reserved.
//

#import "ViewController.h"
#import "DBHelper.h"
#import "UserModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
- (IBAction)addUserAction:(id)sender;
- (IBAction)deleteUserAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.blzx.data"];
    [userDefault setObject:@"mydata" forKey:@"name"];
    [userDefault synchronize];
    [DBHelper createTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)addUserAction:(id)sender {
    UserModel *uModel = [UserModel new];
    uModel.name = self.nameLabel.text;
    uModel.gender = @"boy";
    uModel.age = 20;
    if([DBHelper insertRowWithUserModel:uModel]) NSLog(@"insert success");
    

}

- (IBAction)deleteUserAction:(id)sender {
    if([DBHelper deleteUserByName:self.nameLabel.text]) NSLog(@"delete success");
}
@end
