//
//  grabSeatTableViewCell.m
//  Demo-MVVM
//
//  Created by haoyajuan on 16/5/20.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderTableViewCellFrames.h"
#import "OrderInfoModel.h"



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//设置粗体字体
#define FONT_BOLD(size) [UIFont boldSystemFontOfSize:size]

//标题颜色 鲜红色
#define BrightRed_color 0xee4e5c
//<!-- 深灰色 -->
#define DeepGray_color 0x636363
//<!-- 白色 -->
#define White_color 0xffffff


@interface OrderTableViewCell ()
{
    OrderInfoUIModel *model;
}
@property (nonatomic,strong) UILabel *orderNOLabel;
@property (nonatomic,strong) UILabel *priceLable;
@property (nonatomic,strong) UILabel *countLable;
@property (nonatomic,strong) UILabel *queueNOLabel;
@property (nonatomic,strong) UILabel *groupNOLabel;
@property (nonatomic,strong) UIButton *seatButton;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation OrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setSeatFrame:(OrderTableViewCellFrames *)seatFrame{
    _seatFrame = seatFrame;
    /**
     *  数据显示
     */
    model = seatFrame.orderInfoUIModel;
    self.orderNOLabel.text = model.ordersidText;
    self.priceLable.text = model.priceText;
    self.countLable.text = model.numText;
    self.queueNOLabel.text = model.qznumText;
    self.groupNOLabel.text = model.orderText;
    [self.seatButton setTitle:model.seatButtonTitle forState:UIControlStateNormal];
    
    /**
     *  控件布局
     */
    self.orderNOLabel.frame = seatFrame.orderNOLabelFrame;
    self.priceLable.frame = seatFrame.priceLableFrame;
    self.countLable.frame = seatFrame.countLableFrame;
    self.seatButton.frame = seatFrame.seatButtonFrame;
    self.lineView.frame = seatFrame.lineViewFrame;
    self.queueNOLabel.frame = seatFrame.queueNOLabelFrame;
    self.groupNOLabel.frame = seatFrame.groupNOLabelFrame;
    
    
    if (0 == model.seatStatus) {//抢座成功和未开始抢座
        self.orderNOLabel.textColor = UIColorFromRGB(DeepGray_color);
        self.priceLable.textColor = UIColorFromRGB(DeepGray_color);
        self.countLable.textColor = UIColorFromRGB(DeepGray_color);
    }else{
        self.orderNOLabel.textColor = UIColorFromRGB(White_color);
        self.priceLable.textColor = UIColorFromRGB(White_color);
        self.countLable.textColor = UIColorFromRGB(White_color);
    }
    
    if (0 == model.seatStatus) {
        [self.seatButton setTitleColor:UIColorFromRGB(DeepGray_color) forState:UIControlStateNormal];
        [self.seatButton setBackgroundColor:UIColorFromRGB(White_color)];
        [self.seatButton.titleLabel setFont:FONT_BOLD(16)];
        
        [self.seatButton setTitleColor:UIColorFromRGB(DeepGray_color) forState:UIControlStateNormal];
    }else if(1 == model.seatStatus){
        [self.seatButton setTitleColor:UIColorFromRGB(White_color) forState:UIControlStateNormal];
        [self.seatButton setBackgroundColor:UIColorFromRGB(BrightRed_color)];
        [self.seatButton.titleLabel setFont:FONT_BOLD(20)];
    }else{
        [self.seatButton setTitleColor:UIColorFromRGB(BrightRed_color) forState:UIControlStateNormal];
        [self.seatButton setBackgroundColor:UIColorFromRGB(White_color)];
        [self.seatButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    
}

#pragma mark - Lazy Instantiation
- (UILabel *)orderNOLabel{
    if (!_orderNOLabel) {
        _orderNOLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _orderNOLabel.font = FONT_BOLD(15);
        [self addSubview:_orderNOLabel];
    }
    return _orderNOLabel;
}
- (UILabel *)priceLable{
    if (!_priceLable) {
        _priceLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _priceLable.font = FONT_BOLD(15);
        [self addSubview:_priceLable];
    }
    return _priceLable;
}
- (UILabel *)countLable{
    if (!_countLable) {
        _countLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _countLable.font = FONT_BOLD(15);
        [self addSubview:_countLable];
    }
    return _countLable;
}
- (UILabel *)queueNOLabel{
    if (!_queueNOLabel) {
        _queueNOLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _queueNOLabel.textColor = UIColorFromRGB(White_color);
        _queueNOLabel.font = FONT_BOLD(15);
        [self addSubview:_queueNOLabel];
    }
    return _queueNOLabel;
}
- (UILabel *)groupNOLabel{
    if (!_groupNOLabel) {
        _groupNOLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _groupNOLabel.textColor = UIColorFromRGB(White_color);
        _groupNOLabel.font = FONT_BOLD(15);
        [self addSubview:_groupNOLabel];
    }
    return _groupNOLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = UIColorFromRGB(White_color);
        [self addSubview:_lineView];
    }
    return _lineView;
}
- (UIButton *)seatButton{
    if (!_seatButton) {
        _seatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _seatButton.layer.cornerRadius = 5.0f;
        
        [_seatButton addTarget:self action:@selector(seatButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_seatButton];
    }
    return _seatButton;
}

/*按钮的点击事件*/
- (void)seatButtonClick{
    if ((0==model.seatStatus||1== model.seatStatus)&&[self.delegate respondsToSelector:@selector(clickButtonWithOrderInfoModel:)]) {
        [self.delegate clickButtonWithOrderInfoModel:_seatFrame.orderInfoModel];
    }    
}

@end
