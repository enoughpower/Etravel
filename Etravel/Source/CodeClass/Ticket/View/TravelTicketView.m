//
//  TravelTicketView.m
//  Etravel
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelTicketView.h"
#import <UIImageView+WebCache.h>
@interface TravelTicketView ()
@property (nonatomic, strong)UIScrollView *sv;

@property (nonatomic, strong)UIImageView*imagePic;
@property (nonatomic, strong)UILabel *spotName;
@property (nonatomic, strong)UILabel *spotDescription;
@property (nonatomic, strong)UILabel *addressTitle;
@property (nonatomic, strong)UILabel *address;
@property (nonatomic, strong)UILabel *cityTitle;
@property (nonatomic, strong)UILabel *city;
@property (nonatomic, strong)UILabel *ticketTitle;

@property (nonatomic, assign)CGFloat maxhigh;
@property (nonatomic, strong)NSArray *ticketArray;
@end
@implementation TravelTicketView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1"]];
    }
    return self;
}

- (void)setDetail:(TravelTicketDetail *)detail
{
    _detail = detail;
    self.ticketArray = _detail.priceLists;
    [self dc_setupView];
   
}



- (void)dc_setupView
{
    
    self.imagePic = [[UIImageView alloc]init];
    _imagePic.frame = CGRectMake(0, 64, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)/16*9);
    [_imagePic sd_setImageWithURL:[NSURL URLWithString:_detail.imageUrl] placeholderImage:[UIImage imageNamed:@"weater"]];
    _imagePic.contentMode = UIViewContentModeScaleAspectFill;
    _imagePic.clipsToBounds = YES;
    [self addSubview:_imagePic];
    
    self.sv = [[UIScrollView alloc]init];
    _sv.frame = CGRectMake(0, CGRectGetMaxY(_imagePic.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(_imagePic.frame) - 64);
    _sv.contentSize = CGSizeMake(CGRectGetWidth(self.frame), 1000);
    _sv.bounces = NO;
    _sv.showsVerticalScrollIndicator = NO;
    [self addSubview:_sv];
    
    self.spotName = [[UILabel alloc]init];
    _spotName.frame = CGRectMake(5, 5, CGRectGetWidth(_sv.frame) - 10, 30);
    _spotName.font = [UIFont systemFontOfSize:25.f];
    _spotName.textColor = [UIColor orangeColor];
    _spotName.text = _detail.spotName;
    [_sv addSubview:_spotName];
    
    self.addressTitle = [[UILabel alloc]init];
    _addressTitle.frame = CGRectMake(CGRectGetMinX(_spotName.frame) + 10, CGRectGetMaxY(_spotName.frame)+ 10, 70, 25);
    _addressTitle.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    _addressTitle.text = @"地址";
    [_sv addSubview:_addressTitle];
    
    self.address = [[UILabel alloc]init];
    _address.frame = CGRectMake(CGRectGetMaxX(_addressTitle.frame) + 10, CGRectGetMinY(_addressTitle.frame), CGRectGetWidth(self.frame) - 110, CGRectGetHeight(_addressTitle.frame) * 2);
    _address.textColor = [UIColor darkGrayColor];
    _address.numberOfLines = 0;
    _address.text = _detail.address;
    [_sv addSubview:_address];
    
    self.cityTitle = [[UILabel alloc]init];
    _cityTitle.frame = CGRectMake(CGRectGetMinX(_addressTitle.frame), CGRectGetMaxY(_address.frame) + 5, CGRectGetWidth(_addressTitle.frame), CGRectGetHeight(_addressTitle.frame));
    _cityTitle.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    _cityTitle.text = @"所在地";
    [_sv addSubview:_cityTitle];
    
    self.city = [[UILabel alloc]init];
    _city.frame = CGRectMake(CGRectGetMaxX(_cityTitle.frame) + 10, CGRectGetMinY(_cityTitle.frame), CGRectGetWidth(_address.frame), CGRectGetHeight(_cityTitle.frame));
    _city.textColor = [UIColor darkGrayColor];
    _city.text = [NSString stringWithFormat:@"%@%@", _detail.province, _detail.city];
    [_sv addSubview:_city];
    
    self.spotDescription = [[UILabel alloc]init];
    _spotDescription.frame = CGRectMake(CGRectGetMinX(_spotName.frame), CGRectGetMaxY(_cityTitle.frame) + 10, CGRectGetWidth(self.frame) - 10, [self heightForText:_detail.spotDescription width:CGRectGetWidth(self.frame) - 10 fontSize:15.f]);
    _spotDescription.font = [UIFont systemFontOfSize:15.f];
    _spotDescription.text = _detail.spotDescription;
    _spotDescription.textColor = [UIColor darkTextColor];
    _spotDescription.numberOfLines = 0;
    [_sv addSubview:_spotDescription];
    
    self.ticketTitle = [[UILabel alloc]init];
    _ticketTitle.frame = CGRectMake(CGRectGetMinX(_spotName.frame), CGRectGetMaxY(_spotDescription.frame) + 10, 200, 30);
    _ticketTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.f];
    _ticketTitle.textColor = [UIColor orangeColor];
    _ticketTitle.text = @"票价信息";
    [_sv addSubview:_ticketTitle];
    
    DLog(@"%ld", _ticketArray.count);
    for (int i = 0; i < _ticketArray.count; i ++) {
        UIView *Myview = [[UIView alloc]init];
        Myview.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        Myview.frame = CGRectMake(5, CGRectGetMaxY(_ticketTitle.frame) + 110*i, CGRectGetWidth(self.frame) - 10, 105);
        Myview.layer.masksToBounds = YES;
        Myview.layer.cornerRadius = 10;
        [_sv addSubview:Myview];
        
        UILabel *ticketTitle = [[UILabel alloc]init];
        NSString *text = _ticketArray[i][@"ticketTitle"];
        ticketTitle.frame = CGRectMake(5, 5, CGRectGetWidth(Myview.frame) - 10, [self heightForText:text width:CGRectGetWidth(Myview.frame) - 10 fontSize:17.f]);
        ticketTitle.numberOfLines = 0;
        ticketTitle.text = text;
        ticketTitle.textColor = [UIColor purpleColor];
        [Myview addSubview:ticketTitle];
        
        UILabel *priceTitle = [[UILabel alloc]init];
        priceTitle.frame = CGRectMake(5, CGRectGetMaxY(ticketTitle.frame) + 5, 70, 25);
        priceTitle.textColor = [UIColor grayColor];
        priceTitle.text = @"原价";
        [Myview addSubview:priceTitle];
        
        UILabel *price = [[UILabel alloc]init];
        price.frame = CGRectMake(CGRectGetMaxX(priceTitle.frame) + 5, CGRectGetMinY(priceTitle.frame), 70, 25);
        price.textColor = [UIColor lightGrayColor];
        price.text = [NSString stringWithFormat:@"￥%@", _ticketArray[i][@"normalPrice"]];
        [Myview addSubview:price];

        UILabel *nowpriceTitle = [[UILabel alloc]init];
        nowpriceTitle.frame = CGRectMake(5, CGRectGetMaxY(priceTitle.frame) + 5, 70, 25);
        nowpriceTitle.textColor = [UIColor grayColor];
        nowpriceTitle.text = @"现价";
        [Myview addSubview:nowpriceTitle];
        
        UILabel *nowprice = [[UILabel alloc]init];
        nowprice.frame =CGRectMake(CGRectGetMaxX(nowpriceTitle.frame) + 5, CGRectGetMinY(nowpriceTitle.frame), 70, 25);
        nowprice.textColor = [UIColor redColor];
        nowprice.text = [NSString stringWithFormat:@"￥%@", _ticketArray[i][@"price"]];
        [Myview addSubview:nowprice];
    }
    _maxhigh = CGRectGetMaxY(_ticketTitle.frame) + 110*(_ticketArray.count -1)  + 115;
    _sv.contentSize = CGSizeMake(CGRectGetWidth(self.frame), _maxhigh);
    
    
    
}

- (CGFloat)heightForText:(NSString *)string width:(CGFloat)width fontSize:(CGFloat)size
{
    CGRect textframe = [string boundingRectWithSize:CGSizeMake(width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    return textframe.size.height;
}


@end
