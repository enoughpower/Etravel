//
//  TravelLineModel.m
//  Etravel
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelLineModel.h"

@implementation TravelLineModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"description"]) {
        self.lineDescription = value;
    }
    if ([key isEqualToString:@"itineraries"]) {
        NSArray *arr = value;
        self.lineItineraries = [NSMutableArray array];
        for (NSDictionary *d in arr) {
            TravelLineItemModel *m = [[TravelLineItemModel alloc]init];
            [m setValuesForKeysWithDictionary:d];
            [self.lineItineraries addObject:m];
        }
    }
}
@end
