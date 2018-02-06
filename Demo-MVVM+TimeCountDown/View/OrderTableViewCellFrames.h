//
//  YLGrabSeatTableViewCellFrames.h
//  Demo-MVVM
//
//  Created by haoyajuan on 16/5/23.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"
#import "OrderInfoUIModel.h"
@interface OrderTableViewCellFrames : NSObject
/**
 *  此处应该使用Model
 */
@property (nonatomic,strong) OrderInfoModel *orderInfoModel;

@property (nonatomic,strong) OrderInfoUIModel *orderInfoUIModel;

/**订单号*/
@property (nonatomic,assign) CGRect orderNOLabelFrame;
/**票价*/
@property (nonatomic,assign) CGRect priceLableFrame;
/**数量*/
@property (nonatomic,assign) CGRect countLableFrame;
/**排号*/
@property (nonatomic,assign) CGRect queueNOLabelFrame;
/**分组*/
@property (nonatomic,assign) CGRect groupNOLabelFrame;
/**抢座状态按钮*/
@property (nonatomic,assign) CGRect seatButtonFrame;

@property (nonatomic,assign) CGRect lineViewFrame;

@property (nonatomic,assign) CGFloat fCellHeight;

@end
