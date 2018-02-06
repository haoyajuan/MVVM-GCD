//
//  YLGrabSeatTableViewCellFrames.m
//  Demo-MVVM
//
//  Created by haoyajuan on 16/5/23.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import "OrderTableViewCellFrames.h"

//动态获取设备高度和宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kMarginSpace 20.0f
#define kCellWidth IPHONE_WIDTH-2*kMarginSpace
#define kLabelHeight 20.0f
#define kLabelWidth kCellWidth/2.0
@implementation OrderTableViewCellFrames

//- (void)setGrabSeatInfoModel:(GrabSeatInfoModel *)grabSeatInfoModel{
//    _grabSeatInfoModel = grabSeatInfoModel;
//
//}
- (void)setOrderInfoUIModel:(OrderInfoUIModel *)seatUIModel{
    _orderInfoUIModel = seatUIModel;
    /**
     *  开始计算各个控件的frame 同时根据状态判断按钮的样式
     */
    CGFloat fHeight = 0.0f;
    _lineViewFrame = CGRectMake(kMarginSpace, fHeight, kCellWidth, 1);
    fHeight += 1;
    
    _orderNOLabelFrame = CGRectMake(kMarginSpace, fHeight, kCellWidth, kLabelHeight);
    fHeight += kLabelHeight;
    
    fHeight += 5.0f;
    _priceLableFrame = CGRectMake(kMarginSpace, fHeight, kLabelWidth, kLabelHeight);
    _countLableFrame = CGRectMake(IPHONE_WIDTH/2.0, fHeight, kLabelWidth, kLabelHeight);
    
    if (0 != self.orderInfoUIModel.seatStatus) {
        /**
         *  抢座成功以外的情况
         */
        fHeight += kLabelHeight;
        _queueNOLabelFrame = CGRectMake(kMarginSpace, fHeight, kLabelWidth, kLabelHeight);
        _groupNOLabelFrame = CGRectMake(IPHONE_WIDTH/2.0, fHeight, kLabelWidth, kLabelHeight);
    }
    
    
    fHeight += kLabelHeight;
    fHeight += 5.0f;
    
    if (1 == self.orderInfoUIModel.seatStatus) {
        /**
         *  正在抢座
         */
        _seatButtonFrame = CGRectMake(kMarginSpace, fHeight, kCellWidth, 80);
        fHeight += 80;
    }else{
        _seatButtonFrame = CGRectMake(kMarginSpace, fHeight, kCellWidth, 40);
        fHeight += 40;
    }
    fHeight += 10;
    
    
    /**整个表格的高度*/
    self.fCellHeight = fHeight;
    
    
}
@end
