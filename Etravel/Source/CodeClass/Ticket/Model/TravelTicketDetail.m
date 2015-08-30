//
//  TravelTicketDetail.m
//  Etravel
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelTicketDetail.h"

@implementation TravelTicketDetail
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"description"]) {
        self.spotDescription = value;
    }
    if ([key isEqualToString:@"priceList"]) {
        BOOL isDIc = [value isKindOfClass:[NSDictionary class]];
        if (isDIc) {
            NSDictionary *dic = value;
            self.priceLists = [NSMutableArray array];
            [self.priceLists addObject:dic];
        }else{
            self.priceLists = value;
        }
    }
}
@end
