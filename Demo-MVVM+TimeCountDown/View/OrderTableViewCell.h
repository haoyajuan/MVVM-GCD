//
//  grabSeatTableViewCell.h
//  Demo-MVVM
//
//  Created by haoyajuan on 16/5/20.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTableViewCellFrames.h"
#import "OrderInfoUIModel.h"
@protocol OrderTableViewCellDelegate <NSObject>
- (void)clickButtonWithOrderInfoModel:(OrderInfoModel*)oderModel;
@end

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic,strong) OrderTableViewCellFrames *seatFrame;
@property (nonatomic,strong) OrderInfoUIModel *seatUIModel;

@property (nonatomic,weak)id<OrderTableViewCellDelegate> delegate;
@end
