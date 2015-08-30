//
//  TravelSightsModel.m
//  Etravel
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelSightsModel.h"

@implementation TravelSightsModel
- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@\nlocation = %@\ntelephone = %@\nstar = %@\nurl = %@\nabstract = %@\nsightdescription = %@\nprice = %@\nopen_time = %@\nattention = %@\n", _name, _location, _telephone, _star, _url, _abstract,_sightdescription, _price, _open_time, _attention];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"description"]) {
        self.sightdescription = value;
    }
    if ([key isEqualToString:@"ticket_info"]) {
        NSDictionary *dic = value;
        self.price = dic[@"price"];
        self.open_time = dic[@"open_time"];
        self.attention = dic[@"attention"];
    }
}

@end
