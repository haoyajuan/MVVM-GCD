//
//  CountdownView.h
//  Demo-MVVM+TimeCountDown
//
//  Created by haoyajuan on 16/6/20.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoUIModel.h"
typedef void(^closeBlock)(void);

@protocol CountdownViewDelegate <NSObject>
- (void)clickButtonWithOrderInfoModel:(OrderInfoModel *)oderModel;
@end

@interface CountdownView : UIView

@property (nonatomic,copy) closeBlock killThreadBlock;
@property (nonatomic,weak) id<CountdownViewDelegate>delegate;

- (void)reloadDatasWith:(NSArray*)array;

@end
