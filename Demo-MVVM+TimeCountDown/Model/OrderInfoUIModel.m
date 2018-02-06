//
//  GrabSeatInfoUIModel.m
//  TicketAPP
//
//  Created by haoyajuan on 16/6/1.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import "OrderInfoUIModel.h"
typedef enum {
    GrabOrderStatus_Success = 0 ,
    GrabOrderStatus_Grabing = 1 ,
    GrabOrderStatus_Countdown = 2
}GrabOrderStatus;
@implementation OrderInfoUIModel
- (void)setSeatModel:(OrderInfoModel *)seatModel{
    _seatModel = seatModel;
    
//    self.ordersidText = [NSString stringWithFormat:@"订单号：%@",seatModel.ordersid];
//    self.priceText = [NSString stringWithFormat:@"票价：%@元",seatModel.price];
//    self.numText = [NSString stringWithFormat:@"数量：%@张",seatModel.num];
//    self.qznumText = [NSString stringWithFormat:@"排号：%@号",seatModel.qznum];
//    self.orderText = [NSString stringWithFormat:@"分组：%@组",seatModel.order];
//    
//    if (0 == seatModel.flag.intValue && 2 == seatModel.seatflag.intValue) {
//        self.seatButtonTitle = @"抢座成功";
//        seatModel.seatStatus = GrabOrderStatus_Success;
//        self.seatStatus = GrabOrderStatus_Success;
//    }
//    if ((1==seatModel.flag.intValue&&1==seatModel.seatflag.intValue)||(1==seatModel.flag.intValue&&3==seatModel.seatflag.intValue)) {
//        self.seatButtonTitle = @"立即抢座";
//        seatModel.seatStatus = GrabOrderStatus_Grabing;
//        self.seatStatus = GrabOrderStatus_Grabing;
//    }
//    if (0 == seatModel.flag.intValue && 1 == seatModel.seatflag.intValue) {
//        
//        seatModel.seatStatus = GrabOrderStatus_Countdown;
//        self.seatStatus = GrabOrderStatus_Countdown;
//        
//        self.timeCount = seatModel.timeCount;
//        //seatModel.timeCount = self.timeCount;
//        
//        //NSString *timeFomat = [self getCountDownTimeFormatWithTime:seatModel.timeCount];
//        self.seatButtonTitle = [NSString stringWithFormat:@"距您进场抢座开始还有：%@",timeFomat];
//    }

    
}
@end
