//
//  VideoModel.m
//  movePlayer
//
//  Created by lanou3g on 15/8/28.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
