//
//  TravelLineItemModel.h
//  Etravel
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelLineDayModel.h"
@interface TravelLineItemModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *itemDescription;
@property (nonatomic, strong)NSMutableArray *itemItineraries;
@end
