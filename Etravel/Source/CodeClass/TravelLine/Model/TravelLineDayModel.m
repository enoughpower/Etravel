//
//  TravelLineDayModel.m
//  Etravel
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelLineDayModel.h"

@implementation TravelLineDayModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"description"]) {
        self.dayDescription = value;
    }
}
@end
