//
//  TravelNotesCell.m
//  Etravel
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelNotesCell.h"

@implementation TravelNotesCell



- (void)awakeFromNib {
    // Initialization code
    self.userHeadImage.layer.masksToBounds = YES;
    self.userHeadImage.layer.cornerRadius = 24;
    self.titleLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.3];
    _headImage.contentMode = UIViewContentModeScaleAspectFill;
    _headImage.clipsToBounds = YES;
    _userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}



@end
