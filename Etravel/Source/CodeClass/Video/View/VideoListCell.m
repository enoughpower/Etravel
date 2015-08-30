//
//  VideoListCell.m
//  movePlayer
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "VideoListCell.h"

@implementation VideoListCell

- (void)awakeFromNib {
    // Initialization code
    _image.contentMode = UIViewContentModeScaleAspectFill;
    _image.clipsToBounds = YES;
    _title.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    
}

@end
