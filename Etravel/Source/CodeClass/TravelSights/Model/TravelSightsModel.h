//
//  TravelSightsModel.h
//  Etravel
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelSightsModel : NSObject
// 名字
@property (nonatomic, copy)NSString *name;
// 坐标
@property (nonatomic, strong)NSDictionary *location;
// 电话
@property (nonatomic, copy)NSString *telephone;
// 等级
@property (nonatomic, copy)NSString *star;
// 链接
@property (nonatomic, copy)NSString *url;
// 印象摘要
@property (nonatomic, copy)NSString *abstract;
// 介绍
@property (nonatomic, copy)NSString *sightdescription;
// 门票价格
@property (nonatomic, copy)NSString *price;
// 开门时间
@property (nonatomic, copy)NSString *open_time;
// 优惠活动
@property (nonatomic, strong)NSArray *attention;
@end
