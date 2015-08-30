//
//  TravelSightsView.h
//  Etravel
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelSightsModel.h"
@interface TravelSightsView : UIScrollView
@property (nonatomic, strong)TravelSightsModel *model;
- (void)setModel:(TravelSightsModel *)model;
@end
