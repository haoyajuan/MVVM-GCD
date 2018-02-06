//
//  GrabSeatInfoModel_TEST.h
//  TicketAPP
//
//  Created by haoyajuan on 16/5/25.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfoModel : NSObject
/**订单号*/
@property (nonatomic,copy) NSNumber *ordersid;
/**票价 Double*/
@property (nonatomic,copy) NSNumber *price;
/**数量*/
@property (nonatomic,copy) NSNumber *num;
/**排号*/
@property (nonatomic,copy) NSNumber *qznum;
/**分组*/
@property (nonatomic,copy) NSNumber *order;

/**标识0-不能抢座，1-能抢座*/
@property (nonatomic,copy) NSNumber *flag;
/**标识0-订单没座位,1-已抢到座位,2-已超过时间且无座位(抢座失败)*/
@property (nonatomic,copy) NSNumber *seatflag;
/**演出日期*/
@property (nonatomic,copy) NSString *playdate;
/**演出时间*/
@property (nonatomic,copy) NSString *time;
/**该组抢座开始时间*/
@property (nonatomic,copy) NSString *starttime;
/**该组抢座结束时间*/
@property (nonatomic,copy) NSString *endtime;
/**系统时间*/
@property (nonatomic,copy) NSString *systime;
/**抢座按钮跳转的地址（可能跳转到个人中心or跳转选座）根据type的不同而跳转不同*/
@property (nonatomic,copy) NSString *path;



/** 抢座状态按钮
 0-抢座成功 1-立即抢座 2-开抢倒计时
 */
@property (nonatomic,assign) NSInteger seatStatus;
/**计算所得倒计时*/
@property (nonatomic,assign) NSInteger timeCount;


@end
/**
 *  
 ordersid	Int     订单号
 price      Double	票价
 num        int     票价数量
 qznum      Int     抢座排号
 playdate	String	演出日期
 time       String	演出时间
 order      Int     组号
 starttime	String	该组抢座开始时间
 endtime	String	该组抢座结束时间
 flag       Int     标识0不能取抢座，1能抢座
 path       String	抢座按钮跳转的地址（可能跳转到个人中心or跳转选座）根据type的不同而跳转不同
 seatflag   Int

  */
