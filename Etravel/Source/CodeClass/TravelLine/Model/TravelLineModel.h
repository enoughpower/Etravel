//
//  TravelLineModel.h
//  Etravel
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelLineItemModel.h"
@interface TravelLineModel : NSObject
@property (nonatomic, copy)NSString *cityname;
@property (nonatomic, copy)NSDictionary *location;
@property (nonatomic, copy)NSString *abstract;
@property (nonatomic, copy)NSString *lineDescription;
@property (nonatomic, strong)NSMutableArray *lineItineraries;
@end
