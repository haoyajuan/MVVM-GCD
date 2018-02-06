//
//  CountDownViewModel.m
//  Demo-MVVM+TimeCountDown
//
//  Created by haoyajuan on 16/6/20.
//  Copyright © 2016年 HYJ. All rights reserved.
//

#import "CountDownViewModel.h"
#import "OrderInfoModel.h"
#import "OrderInfoUIModel.h"
#import "OrderTableViewCellFrames.h"
typedef enum {
    GrabOrderStatus_Success = 0 ,
    GrabOrderStatus_Grabing = 1 ,
    GrabOrderStatus_Countdown = 2
}GrabOrderStatus;


@interface CountDownViewModel ()
{
    NSArray *cellsArray;
    NSInteger time;
    NSString *timeInfo;
    
    NSInteger countdownTime;
    NSDate *sysTime;
    BOOL isCountDown;   //是否倒计时
}
/**原始数据*/
@property (nonatomic,strong) NSArray *orderGroupModelArray;

@property (nonatomic,strong) NSMutableArray *seatFrameModelArray;
@property (nonatomic,strong) NSMutableArray *seatUIModelArray;
@end

@implementation CountDownViewModel

- (void)getData:(resultBlock)resultBlock{
    /**
     *  获取服务器时间  在网络请求成功的block里处理数据
     */
    
    NSString *timestamp = @"2016-06-04 17:11:17";
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    sysTime=[formatter dateFromString:timestamp];
    
    //获取服务器数据和返回时间后,处理数据, 计算倒计时所需时间
    [self translateModelDataWith:self.orderGroupModelArray];
    
    resultBlock([self.seatFrameModelArray copy]);
    [self countDownTimer];
}
- (void)translateModelDataWith:(NSArray*)orderGroupArray{

    for (OrderInfoModel *model in orderGroupArray) {
        
        OrderInfoUIModel *seatUIModel = [[OrderInfoUIModel alloc]init];
        seatUIModel.ordersidText = [NSString stringWithFormat:@"订单号：%@",model.ordersid];
        seatUIModel.priceText = [NSString stringWithFormat:@"票价：%@元",model.price];
        seatUIModel.numText = [NSString stringWithFormat:@"数量：%@张",model.num];
        seatUIModel.qznumText = [NSString stringWithFormat:@"排号：%@号",model.qznum];
        seatUIModel.orderText = [NSString stringWithFormat:@"分组：%@组",model.order];
        
        if (0 == model.flag.intValue && 2 == model.seatflag.intValue) {
            seatUIModel.seatButtonTitle = @"已经成功";
            model.seatStatus = GrabOrderStatus_Success;
            seatUIModel.seatStatus = GrabOrderStatus_Success;
        }
        if ((1==model.flag.intValue&&1==model.seatflag.intValue)||(1==model.flag.intValue&&3==model.seatflag.intValue)) {
            seatUIModel.seatButtonTitle = @"立即开始";
            model.seatStatus = GrabOrderStatus_Grabing;
            seatUIModel.seatStatus = GrabOrderStatus_Grabing;
        }
        if (0 == model.flag.intValue && 1 == model.seatflag.intValue) {
            
            model.seatStatus = GrabOrderStatus_Countdown;
            seatUIModel.seatStatus = GrabOrderStatus_Countdown;
            
            seatUIModel.timeCount = [self getCountDownTimeWith:model];
            model.timeCount = seatUIModel.timeCount;
            
            NSString *timeFomat = [self getCountDownTimeFormatWithTime:model.timeCount];
            seatUIModel.seatButtonTitle = [NSString stringWithFormat:@"距您进场还有：%@",timeFomat];
        }
        [self.seatUIModelArray addObject:seatUIModel];
        OrderTableViewCellFrames *sFrame = [[OrderTableViewCellFrames alloc]init];
        sFrame.orderInfoUIModel = seatUIModel;
        sFrame.orderInfoModel = model;
        [self.seatFrameModelArray addObject:sFrame];
    }
}

/**计算倒计时所需时间*/
- (long long)getCountDownTimeWith:(OrderInfoModel *)model{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    /*计算倒计时 前者 比 后者 早就返回负数*/
    NSDate *startTime = [formatter dateFromString:model.starttime];
    NSTimeInterval interval = [startTime timeIntervalSinceDate:sysTime];
    long long second = interval;
    
    return second;
}
/**计算倒计时时间 格式化*/
- (NSString *)getCountDownTimeFormatWithTime:(long long)second{
    //long leftSecond = 0;
    if (second<=0) {
        return @"";
    }
    NSInteger d = second/(24*60*60);
    second -= d*24*60*60;
    
    NSInteger h = second/(60*60);
    second -= h*60*60;
    
    NSInteger m = second/60;
    NSInteger s = second%60;
    
    NSMutableString *timeFormat = [NSMutableString string];
    if (d>0) {
        [timeFormat appendString:[NSString stringWithFormat:@"%ld天",d]];
    }
    if (h>0) {
        [timeFormat appendString:[NSString stringWithFormat:@"%ld时",h]];
    }
    if (m>0) {
        [timeFormat appendString:[NSString stringWithFormat:@"%ld分",m]];
    }
    if (s>0) {
        [timeFormat appendString:[NSString stringWithFormat:@"%ld秒",s]];
    }
    return timeFormat;
}

- (void)countDownTimer{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    _timer = timer;
    dispatch_source_set_event_handler(_timer, ^{
        
        NSLog(@"线程开启中~~~~");
        
        /*循环修改数据模型中的值*/
        isCountDown = NO;
        for (OrderTableViewCellFrames *frame in self.seatFrameModelArray) {
            OrderInfoUIModel *model = frame.orderInfoUIModel;
            if (model.seatStatus == 2) {
                model.timeCount--;
                NSString *timeFomat = [self getCountDownTimeFormatWithTime:model.timeCount];
                model.seatButtonTitle = [NSString stringWithFormat:@"距您进场还有：%@",timeFomat];
                isCountDown = YES;
                
                if (model.timeCount<=0) {
                    //界面状态值改变 需要修改模型
                    model.seatStatus = 1;
                    model.seatButtonTitle = @"立即开始";
                    frame.orderInfoUIModel = model;
                }
            }
        }
        if(isCountDown){ //倒计时进行中 刷新页面
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_reloadDataBlock) {
                    _reloadDataBlock(self.seatFrameModelArray);
                }
            });
        }else{//所有倒计时结束
            //显示静态页面
            dispatch_source_cancel(_timer);
        }
    });
    dispatch_resume(_timer);
}




#pragma mark - LazyInstantiate

/*模拟数据*/
- (NSArray *)orderGroupModelArray{
    if (_orderGroupModelArray == nil) {
        _orderGroupModelArray = [NSArray array];
        NSMutableArray *array = [NSMutableArray array];
        
        OrderInfoModel *model = [[OrderInfoModel alloc]init];
        model.ordersid = @65465456;
        model.price = @288.00;
        model.num = @2;
        model.flag = @0;
        model.seatflag = @2;
        [array addObject:model];
        
        model = [[OrderInfoModel alloc]init];
        model.ordersid = @4589563;
        model.price = @180;
        model.num = @2;
        model.qznum = @15;
        model.order = @1;
        model.flag = @1;
        model.seatflag = @3;
        [array addObject:model];
        
        model = [[OrderInfoModel alloc]init];
        model.ordersid = @85219;
        model.price = @166.00;
        model.num = @4;
        model.qznum = @23;
        model.order = @1;
        model.flag = @1;
        model.seatflag = @3;
        [array addObject:model];
        
        model = [[OrderInfoModel alloc]init];
        model.ordersid = @99541369259;
        model.price = @380;
        model.num = @2;
        model.qznum = @13;
        model.order = @2;
        model.starttime = @"2016-06-04 17:11:30";
        model.flag = @0;
        model.seatflag = @1;
        [array addObject:model];
        
        model = [[OrderInfoModel alloc]init];
        model.ordersid = @34565465456;
        model.price = @80.00;
        model.num = @6;
        model.qznum = @15;
        model.order = @3;
        model.starttime = @"2016-06-04 17:12:00";
        model.flag = @0;
        model.seatflag = @1;
        [array addObject:model];
        
        model = [[OrderInfoModel alloc]init];
        model.ordersid = @886644522;
        model.price = @380.00;
        model.num = @2;
        model.qznum = @111;
        model.order = @4;
        model.starttime = @"2016-06-04 17:13:00";
        model.flag = @0;
        model.seatflag = @1;
        [array addObject:model];
        
        model = [[OrderInfoModel alloc]init];
        model.ordersid = @56765465456;
        model.price = @66.66;
        model.num = @2;
        model.qznum = @20;
        model.order = @5;
        model.starttime = @"2016-06-04 17:15:00";
        model.flag = @0;
        model.seatflag = @1;
        [array addObject:model];
        
        model = [[OrderInfoModel alloc]init];
        model.ordersid = @56765465456;
        model.price = @688;
        model.num = @2;
        model.qznum = @6;
        model.order = @5;
        model.starttime = @"2016-06-04 17:15:00";
        model.flag = @0;
        model.seatflag = @1;
        
        [array addObject:model];
        model = [[OrderInfoModel alloc]init];
        model.ordersid = @56765465456;
        model.price = @888;
        model.num = @2;
        model.qznum = @2;
        model.order = @5;
        model.starttime = @"2016-06-04 17:17:00";
        model.flag = @0;
        model.seatflag = @1;
        [array addObject:model];
        
        _orderGroupModelArray = [array copy];
    }
    
    return _orderGroupModelArray;
    
}

- (NSMutableArray *)seatUIModelArray {
	if(_seatUIModelArray == nil) {
		_seatUIModelArray = [[NSMutableArray alloc] init];
	}
	return _seatUIModelArray;
}

- (NSMutableArray *)seatFrameModelArray {
	if(_seatFrameModelArray == nil) {
		_seatFrameModelArray = [[NSMutableArray alloc] init];
	}
	return _seatFrameModelArray;
}

@end
