//
//  TravelLineDayModel.h
//  Etravel
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelLineDayModel : NSObject
@property (nonatomic, strong)NSArray *path;
@property (nonatomic, copy)NSString *dayDescription;
@property (nonatomic, copy)NSString *dinning;
@property (nonatomic, copy)NSString *accommodation;

@end
