//
//  TravelSightsView.m
//  Etravel
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "TravelSightsView.h"

@interface TravelSightsView ()
{
    UILabel *tel;
    UILabel *sta;
    UILabel *pri;
    UILabel *open;
    UILabel *line;
    UILabel *desTitle;
    UILabel *attentionTitle;
}
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *abstractLabel;
@property (nonatomic, strong)UILabel *telephone;
@property (nonatomic, strong)UILabel *star;
@property (nonatomic, strong)UILabel *sightdescription;
@property (nonatomic, strong)UILabel *price;
@property (nonatomic, strong)UILabel *open_time;
@property (nonatomic, strong)UILabel *attention;



@end



@implementation TravelSightsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [self dc_setupView];
        self.bounces = NO;

    }
    return self;
}

- (void)setModel:(TravelSightsModel *)model
{
    _model = model;
    [self p_layout];

}


- (void)dc_setupView
{
    
    self.nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake(10, 40, CGRectGetWidth(self.frame) - 20, 60);
    _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:50];
    //_nameLabel.backgroundColor = [UIColor yellowColor];
    _nameLabel.textColor = [UIColor orangeColor];
    [self addSubview:_nameLabel];
    
    self.abstractLabel = [[UILabel alloc]init];
    _abstractLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame) +5, CGRectGetWidth(self.frame) - 20, [self heightForText:_model.abstract width:CGRectGetWidth(_nameLabel.frame) fontSize:15.f]);
    _abstractLabel.numberOfLines = 0;
    _abstractLabel.font = [UIFont systemFontOfSize:15.f];
    _abstractLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
    //_abstractLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:_abstractLabel];
    
    tel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_abstractLabel.frame), CGRectGetMaxY(_abstractLabel.frame) + 5, 80, 20)];
    tel.text = @"电话";
    tel.textColor = [UIColor orangeColor];
    //tel.backgroundColor = [UIColor yellowColor];
    [self addSubview:tel];
    self.telephone = [[UILabel alloc] init];
    _telephone.frame = CGRectMake(CGRectGetMaxX(tel.frame) + 5, CGRectGetMinY(tel.frame), CGRectGetWidth(self.frame)-25- 80, CGRectGetHeight(tel.frame));
//    //_telephone.backgroundColor = [UIColor yellowColor];
    _telephone.textColor = [UIColor purpleColor];
    [self addSubview:_telephone];
    
    sta = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(tel.frame), CGRectGetMaxY(tel.frame) + 5, CGRectGetWidth(tel.frame), CGRectGetHeight(tel.frame))];
    sta.textColor = [UIColor orangeColor];
    sta.text = @"等级";
    //sta.backgroundColor = [UIColor yellowColor];
    [self addSubview:sta];
    self.star = [[UILabel alloc]init];
    _star.frame = CGRectMake(CGRectGetMaxX(sta.frame) + 5, CGRectGetMinY(sta.frame), CGRectGetWidth(_telephone.frame), CGRectGetHeight(sta.frame));
    //_star.backgroundColor = [UIColor yellowColor];
    _star.textColor = [UIColor cyanColor];
    [self addSubview:_star];
    
    pri = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(sta.frame), CGRectGetMaxY(sta.frame) + 5, CGRectGetWidth(sta.frame), CGRectGetHeight(sta.frame))];
    pri.textColor = [UIColor orangeColor];
    pri.text = @"价格";
    //pri.backgroundColor = [UIColor yellowColor];
    [self addSubview:pri];
    self.price = [[UILabel alloc]init];
    if (_model.price == nil) {
        _price.frame = CGRectMake(CGRectGetMaxX(pri.frame) + 5, CGRectGetMinY(pri.frame), CGRectGetWidth(_telephone.frame), 20);
    }else{
        _price.frame = CGRectMake(CGRectGetMaxX(pri.frame) + 5, CGRectGetMinY(pri.frame), CGRectGetWidth(_telephone.frame), [self heightForText:_model.price width:CGRectGetWidth(_telephone.frame) fontSize:17.f]);
    }
    _price.numberOfLines = 0;
    _price.textColor = [UIColor purpleColor];
    //_price.backgroundColor = [UIColor yellowColor];
    [self addSubview:_price];
    
    open = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(pri.frame), CGRectGetMaxY(_price.frame) + 5, CGRectGetWidth(pri.frame), CGRectGetHeight(pri.frame))];
    open.textColor = [UIColor orangeColor];
    open.text = @"开放时间";
    //open.backgroundColor = [UIColor yellowColor];
    [self addSubview:open];
    self.open_time = [[UILabel alloc]init];
    if (_model.open_time == nil) {
        _open_time.frame = CGRectMake(CGRectGetMaxX(open.frame) + 5, CGRectGetMinY(open.frame), CGRectGetWidth(_price.frame), 20);
    }else{
        _open_time.frame = CGRectMake(CGRectGetMaxX(open.frame) + 5, CGRectGetMinY(open.frame), CGRectGetWidth(_price.frame), [self heightForText:_model.open_time width:CGRectGetWidth(_telephone.frame) fontSize:17.f]);
    }
    _open_time.numberOfLines = 0;
    _open_time.textColor = [UIColor purpleColor];
    //_open_time.backgroundColor = [UIColor yellowColor];
    [self addSubview:_open_time];
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_open_time.frame) + 5, CGRectGetWidth(self.frame) - 20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    desTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(line.frame), CGRectGetMaxY(line.frame) + 5, 200, 30)];
    desTitle.text = @"详细介绍";
    desTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    //desTitle.backgroundColor = [UIColor yellowColor];
    desTitle.textColor = [UIColor orangeColor];
    [self addSubview:desTitle];
    self.sightdescription = [[UILabel alloc]init];
    _sightdescription.frame = CGRectMake(CGRectGetMinX(desTitle.frame), CGRectGetMaxY(desTitle.frame) + 5, CGRectGetWidth(self.frame) - 20, [self heightForText:_model.sightdescription width:CGRectGetWidth(self.frame) - 20 fontSize:15.f]);
    _sightdescription.textColor = [UIColor colorWithWhite:0.2 alpha:1];
   // _sightdescription.backgroundColor = [UIColor yellowColor];
    _sightdescription.font = [UIFont systemFontOfSize:15.f];
    _sightdescription.numberOfLines = 0;
    [self addSubview:_sightdescription];
    
    attentionTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_sightdescription.frame), CGRectGetMaxY(_sightdescription.frame) + 10, 200, 30)];
    attentionTitle.text = @"注意事项";
    attentionTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    //attentionTitle.backgroundColor = [UIColor yellowColor];
    attentionTitle.textColor = [UIColor orangeColor];
    [self addSubview:attentionTitle];
    self.attention = [[UILabel alloc]init];
    
    _attention.frame = CGRectMake(CGRectGetMinX(attentionTitle.frame), CGRectGetMaxY(attentionTitle.frame) + 5, CGRectGetWidth(self.frame) - 20, [self heightForText:[self attention:_model.attention] width:CGRectGetWidth(self.frame) - 20 fontSize:15.f]);
    //_attention.backgroundColor = [UIColor yellowColor];
    _attention.textColor = [UIColor colorWithWhite:0.2 alpha:1];
    _attention.font = [UIFont systemFontOfSize:15.f];
    _attention.numberOfLines = 0;
    [self addSubview:_attention];
    
    self.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(_attention.frame) + 20);
 
}

- (void)p_layout
{
    _nameLabel.text = _model.name;
    
    _abstractLabel.text = _model.abstract;
    _abstractLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame) +5, CGRectGetWidth(self.frame) - 20, [self heightForText:_model.abstract width:CGRectGetWidth(_nameLabel.frame) fontSize:15.f]);
    
    tel.frame = CGRectMake(CGRectGetMinX(_abstractLabel.frame), CGRectGetMaxY(_abstractLabel.frame) + 5, 80, 20);
    _telephone.text = _model.telephone;
    _telephone.frame = CGRectMake(CGRectGetMaxX(tel.frame) + 5, CGRectGetMinY(tel.frame), CGRectGetWidth(self.frame)-25- 80, CGRectGetHeight(tel.frame));
    
    sta.frame = CGRectMake(CGRectGetMinX(tel.frame), CGRectGetMaxY(tel.frame) + 5, CGRectGetWidth(tel.frame), CGRectGetHeight(tel.frame));
    _star.text = [self star:_model.star];
    _star.frame = CGRectMake(CGRectGetMaxX(sta.frame) + 5, CGRectGetMinY(sta.frame), CGRectGetWidth(_telephone.frame), CGRectGetHeight(sta.frame));
    
    pri.frame = CGRectMake(CGRectGetMinX(sta.frame), CGRectGetMaxY(sta.frame) + 5, CGRectGetWidth(sta.frame), CGRectGetHeight(sta.frame));
    _price.text = _model.price;
    if (_model.price == nil) {
        _price.frame = CGRectMake(CGRectGetMaxX(pri.frame) + 5, CGRectGetMinY(pri.frame), CGRectGetWidth(_telephone.frame), 20);
    }else{
        _price.frame = CGRectMake(CGRectGetMaxX(pri.frame) + 5, CGRectGetMinY(pri.frame), CGRectGetWidth(_telephone.frame), [self heightForText:_model.price width:CGRectGetWidth(_telephone.frame) fontSize:17.f]);
    }
    
    open.frame = CGRectMake(CGRectGetMinX(pri.frame), CGRectGetMaxY(_price.frame) + 5, CGRectGetWidth(pri.frame), CGRectGetHeight(pri.frame));
    _open_time.text = _model.open_time;
    if (_model.open_time == nil) {
        _open_time.frame = CGRectMake(CGRectGetMaxX(open.frame) + 5, CGRectGetMinY(open.frame), CGRectGetWidth(_price.frame), 20);
    }else{
        _open_time.frame = CGRectMake(CGRectGetMaxX(open.frame) + 5, CGRectGetMinY(open.frame), CGRectGetWidth(_price.frame), [self heightForText:_model.open_time width:CGRectGetWidth(_telephone.frame) fontSize:17.f]);
    }
    line.frame = CGRectMake(10, CGRectGetMaxY(_open_time.frame) + 5, CGRectGetWidth(self.frame) - 20, 1);
    
    desTitle.frame = CGRectMake(CGRectGetMinX(line.frame), CGRectGetMaxY(line.frame) + 5, 200, 30);
    _sightdescription.text = _model.sightdescription;
    _sightdescription.frame = CGRectMake(CGRectGetMinX(desTitle.frame), CGRectGetMaxY(desTitle.frame) + 5, CGRectGetWidth(self.frame) - 20, [self heightForText:_model.sightdescription width:CGRectGetWidth(self.frame) - 20 fontSize:15.f]);
    
    attentionTitle.frame = CGRectMake(CGRectGetMinX(_sightdescription.frame), CGRectGetMaxY(_sightdescription.frame) + 10, 200, 30);
    _attention.text = [self attention:_model.attention];
    _attention.frame = CGRectMake(CGRectGetMinX(attentionTitle.frame), CGRectGetMaxY(attentionTitle.frame) + 5, CGRectGetWidth(self.frame) - 20, [self heightForText:[self attention:_model.attention] width:CGRectGetWidth(self.frame) - 20 fontSize:15.f]);
    self.contentSize = CGSizeMake(self.frame.size.width, CGRectGetMaxY(_attention.frame) + 20);
    
    
    
    
}



- (NSString *)star:(NSString *)star
{
    NSMutableString *tmp = [NSMutableString string];
    int num = [star intValue];
    for (int i = 0; i < num; i ++) {
        [tmp appendString:@"❤️"];
    }
    return tmp;
}

- (NSString *)attention:(NSArray *)attention
{
    NSMutableString *tmp = [NSMutableString string];
    int num = (int)attention.count;
    for (int i = 0; i < num; i ++) {
        [tmp appendFormat:@"%@\n", attention[i][@"name"]];
        [tmp appendFormat:@"%@\n\n", attention[i][@"description"]];
    }
    return tmp;
}

- (CGFloat)heightForText:(NSString *)string width:(CGFloat)width fontSize:(CGFloat)size
{
    CGRect textframe = [string boundingRectWithSize:CGSizeMake(width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    return textframe.size.height;
}
@end
