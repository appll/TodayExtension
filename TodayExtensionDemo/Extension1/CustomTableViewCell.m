//
//  CustomTableViewCell.m
//  TodayExtensionDemo
//
//  Created by App on 11/17/15.
//  Copyright © 2015 App. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "UserModel.h"

@interface CustomTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)openAction:(id)sender;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)cellWithTableView:(UITableView *)talbeView{
    CustomTableViewCell *cell = [talbeView dequeueReusableCellWithIdentifier:@"CellKey"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)setUserModel:(UserModel *)userModel{
    _userModel = userModel;
    self.nameLabel.text = userModel.name;
}

- (IBAction)openAction:(id)sender {
}
@end
