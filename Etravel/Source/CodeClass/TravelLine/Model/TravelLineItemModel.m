//
//  TravelLineItemModel.m
//  Etravel
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelLineItemModel.h"

@implementation TravelLineItemModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"description"]) {
        self.itemDescription = value;
    }
    if ([key isEqualToString:@"itineraries"]) {
        NSArray *arr = value;
        self.itemItineraries = [NSMutableArray array];
        for (NSDictionary *d in arr) {
            TravelLineDayModel *m = [[TravelLineDayModel alloc]init];
            [m setValuesForKeysWithDictionary:d];
            [self.itemItineraries addObject:m];
        }
    }
}
@end
