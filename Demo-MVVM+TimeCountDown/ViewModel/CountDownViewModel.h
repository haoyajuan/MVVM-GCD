//
//  CountDownViewModel.h
//  Demo-MVVM+TimeCountDown
//
//  Created by haoyajuan on 16/6/20.
//  Copyright © 2016年 HYJ. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^resultBlock)(NSArray * modelsArray);
@interface CountDownViewModel : NSObject

@property (nonatomic,copy)resultBlock reloadDataBlock;

@property (nonatomic,strong) dispatch_source_t timer;

- (void)getData:(resultBlock)resultBlock;



@end
