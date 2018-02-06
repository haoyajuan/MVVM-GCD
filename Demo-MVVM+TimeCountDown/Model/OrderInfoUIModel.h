//
//  GrabSeatInfoUIModel.h
//  TicketAPP
//
//  Created by haoyajuan on 16/6/1.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderInfoModel.h"
/**
 *  UIModel用来对接GrabSeatInfoModel的内容,转化为页面显示所需样式
 */

@interface OrderInfoUIModel : NSObject

@property (nonatomic,strong) OrderInfoModel *seatModel;

/**订单号Text*/
@property (nonatomic,copy) NSString *ordersidText;
/**票价Text*/
@property (nonatomic,copy) NSString *priceText;
/**数量Text*/
@property (nonatomic,copy) NSString *numText;
/**排号Text*/
@property (nonatomic,copy) NSString *qznumText;
/**分组Text*/
@property (nonatomic,copy) NSString *orderText;
/**按钮的title*/
@property (nonatomic,copy) NSString *seatButtonTitle;

/** 抢座状态按钮
 0-抢座成功 1-立即抢座 2-开抢倒计时
 */
@property (nonatomic,assign) NSInteger seatStatus;
/**计算所得倒计时*/
@property (nonatomic,assign) NSInteger timeCount;


@end
