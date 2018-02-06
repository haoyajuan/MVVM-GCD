//
//  ViewController.m
//  Demo-MVVM+TimeCountDown
//
//  Created by haoyajuan on 16/6/20.
//  Copyright © 2016年 HYJ. All rights reserved.
//

#import "ViewController.h"
#import "CountdownView.h"
#import "CountDownViewModel.h"
@interface ViewController ()<CountdownViewDelegate>
{
    CountdownView *timerView;
    CountDownViewModel *timerViewModel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeUI];
}

- (void)makeUI{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 30)];
    [button setTitle:@"开始倒计时" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}
- (void)buttonClick:(UIButton *)button{
    
    timerView = [[CountdownView alloc]initWithFrame:CGRectMake(0, 20,self.view.frame.size.width, self.view.frame.size.height-20)];
    timerView.delegate = self;
    [self.view addSubview:timerView];
    timerViewModel = [[CountDownViewModel alloc]init];
    
    /*初始化页面*/
    typeof(CountdownView)*weakView = timerView;
    [timerViewModel getData:^(NSArray *modelsArray) {
        [weakView reloadDatasWith:modelsArray];
    }];
    /*每秒刷新页面*/
    timerViewModel.reloadDataBlock  = ^(NSArray *modelsArray) {
        [weakView reloadDatasWith:modelsArray];
    };
    
    /*关闭页面时,杀掉倒计时线程*/
    typeof(CountDownViewModel)*weakViewModel = timerViewModel;
    timerView.killThreadBlock = ^(void) {
        if (weakViewModel.timer) {
            dispatch_source_cancel(weakViewModel.timer);
        }
    };
    
}
#pragma mark - tableViewCell中的按钮点击事件
- (void)clickButtonWithOrderInfoModel:(OrderInfoModel *)oderModel{
    
    //抢座成功按钮
    if (0 == oderModel.seatStatus) {
        
        NSLog(@"抢座成功按钮页面跳转");
    }
    //立即抢座按钮
    if (1 == oderModel.seatStatus) {
        NSLog(@"立即抢座按钮页面跳转");
    }
    if (timerViewModel.timer) {
        dispatch_source_cancel(timerViewModel.timer);
    }
}

@end
